(defvar elpaca-installer-version 0.7)
(defvar elpaca-directory (expand-file-name "elpaca/" user-emacs-directory))
(defvar elpaca-builds-directory (expand-file-name "builds/" elpaca-directory))
(defvar elpaca-repos-directory (expand-file-name "repos/" elpaca-directory))
(defvar elpaca-order '(elpaca :repo "https://github.com/progfolio/elpaca.git"
                              :ref nil :depth 1
                              :files (:defaults "elpaca-test.el" (:exclude "extensions"))
                              :build (:not elpaca--activate-package)))
(let* ((repo  (expand-file-name "elpaca/" elpaca-repos-directory))
       (build (expand-file-name "elpaca/" elpaca-builds-directory))
       (order (cdr elpaca-order))
       (default-directory repo))
  (add-to-list 'load-path (if (file-exists-p build) build repo))
  (unless (file-exists-p repo)
    (make-directory repo t)
    (when (< emacs-major-version 28) (require 'subr-x))
    (condition-case-unless-debug err
        (if-let ((buffer (pop-to-buffer-same-window "*elpaca-bootstrap*"))
                 ((zerop (apply #'call-process `("git" nil ,buffer t "clone"
                                                 ,@(when-let ((depth (plist-get order :depth)))
                                                     (list (format "--depth=%d" depth) "--no-single-branch"))
                                                 ,(plist-get order :repo) ,repo))))
                 ((zerop (call-process "git" nil buffer t "checkout"
                                       (or (plist-get order :ref) "--"))))
                 (emacs (concat invocation-directory invocation-name))
                 ((zerop (call-process emacs nil buffer nil "-Q" "-L" "." "--batch"
                                       "--eval" "(byte-recompile-directory \".\" 0 'force)")))
                 ((require 'elpaca))
                 ((elpaca-generate-autoloads "elpaca" repo)))
            (progn (message "%s" (buffer-string)) (kill-buffer buffer))
          (error "%s" (with-current-buffer buffer (buffer-string))))
      ((error) (warn "%s" err) (delete-directory repo 'recursive))))
  (unless (require 'elpaca-autoloads nil t)
    (require 'elpaca)
    (elpaca-generate-autoloads "elpaca" repo)
    (load "./elpaca-autoloads")))
(add-hook 'after-init-hook #'elpaca-process-queues)
(elpaca `(,@elpaca-order))

;; Install use-package support
(elpaca elpaca-use-package
  ;; Enable use-package :ensure support for Elpaca.
  (elpaca-use-package-mode))

;; (elpaca (eglot-booster :host github :repo "jdtsmith/eglot-booster" :branch "main"))


(add-to-list 'default-frame-alist '(undecorated-round . t))
(add-to-list 'default-frame-alist '(menu-bar-lines 0))

;; (use-package benchmark-init
;;   :config
;;   ;; To disable collection of benchmark data after init is done.
;;   (add-hook 'after-init-hook 'benchmark-init/deactivate))

(elpaca tree-sitter-langs)

(use-package diminish
  :ensure t)

(use-package emacs
  :init
  (global-display-line-numbers-mode t)
  (setq-default indent-tabs-mode nil)
  (setq completion-category-overrides '((eglot (styles orderless))
                                        (eglot-capf (styles orderless))))
  (when (string= system-type "darwin")
    (setq dired-use-ls-dired nil))

  ;; Emacs 28 and newer: Hide commands in M-x which do not apply to the current
  ;; mode.  Corfu commands are hidden, since they are not used via M-x. This
  ;; setting is useful beyond Corfu.
  (setq read-extended-command-predicate #'command-completion-default-include-p)

  ;; Enable indentation+completion using the TAB key.
  ;; `completion-at-point' is often bound to M-TAB.
  (setq tab-always-indent 'complete)

  :hook (before-save . delete-trailing-whitespace)
  :custom
  (make-backup-files nil))

(use-package hl-line
  :hook
  (prog-mode . hl-line-mode))

(use-package so-long
  :config (global-so-long-mode))

;; (use-package dired-x)

(use-package corfu
  :ensure t
  :init
  ;; Enable auto completion and configure quitting
  (setq corfu-auto t
        corfu-quit-no-match 'separator) ;; or t
  (global-corfu-mode t))

;; Use Dabbrev with Corfu!
(use-package dabbrev
  ;; Swap M-/ and C-M-/
  :bind (("M-/" . dabbrev-completion)
         ("C-M-/" . dabbrev-expand))
  :config
  (add-to-list 'dabbrev-ignored-buffer-regexps "\\` ")
  ;; Since 29.1, use `dabbrev-ignored-buffer-regexps' on older.
  (add-to-list 'dabbrev-ignored-buffer-modes 'doc-view-mode)
  (add-to-list 'dabbrev-ignored-buffer-modes 'pdf-view-mode)
  (add-to-list 'dabbrev-ignored-buffer-modes 'tags-table-mode))

;; Add extensions
(use-package cape
  :ensure t
  ;; Bind dedicated completion commands
  ;; Alternative prefix keys: C-c p, M-p, M-+, ...
  :bind (("C-c p p" . completion-at-point) ;; capf
         ("C-c p t" . complete-tag)        ;; etags
         ("C-c p d" . cape-dabbrev)        ;; or dabbrev-completion
         ("C-c p h" . cape-history)
         ("C-c p f" . cape-file)
         ("C-c p k" . cape-keyword)
         ("C-c p s" . cape-elisp-symbol)
         ("C-c p e" . cape-elisp-block)
         ("C-c p a" . cape-abbrev)
         ("C-c p l" . cape-line)
         ("C-c p w" . cape-dict)
         ("C-c p :" . cape-emoji)
         ("C-c p \\" . cape-tex)
         ("C-c p _" . cape-tex)
         ("C-c p ^" . cape-tex)
         ("C-c p &" . cape-sgml)
         ("C-c p r" . cape-rfc1345))
  :init
  ;; Add to the global default value of `completion-at-point-functions' which is
  ;; used by `completion-at-point'.  The order of the functions matters, the
  ;; first function returning a result wins.  Note that the list of buffer-local
  ;; completion functions takes precedence over the global list.
  (add-hook 'completion-at-point-functions #'cape-dabbrev)
  (add-hook 'completion-at-point-functions #'cape-file)
  (add-hook 'completion-at-point-functions #'cape-elisp-block)
  ;;(add-hook 'completion-at-point-functions #'cape-history)
  ;;(add-hook 'completion-at-point-functions #'cape-keyword)
  ;;(add-hook 'completion-at-point-functions #'cape-tex)
  ;;(add-hook 'completion-at-point-functions #'cape-sgml)
  ;;(add-hook 'completion-at-point-functions #'cape-rfc1345)
  ;;(add-hook 'completion-at-point-functions #'cape-abbrev)
  ;;(add-hook 'completion-at-point-functions #'cape-dict)
  ;;(add-hook 'completion-at-point-functions #'cape-elisp-symbol)
  ;;(add-hook 'completion-at-point-functions #'cape-line)
  )

(use-package corfu-terminal
  :ensure t
  :config
  (corfu-terminal-mode t))

(use-package dumb-jump
  :ensure t
  :init
  (setq dummoeb-jump-force-searcher 'rg)
  :config
  (add-hook 'xref-backend-functions #' dumb-jump-xref-activate))

;; (use-package exec-path-from-shell
;;   :ensure t
;;   :config
;;   (exec-path-from-shell-initialize))

(use-package moe-theme
  :ensure t
  :config
  (load-theme 'moe-dark t))

(use-package ace-window
  :config
  (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
  :bind (("M-p" . ace-window)))

(use-package crystal-mode
  :defer t)

(use-package dockerfile-mode
  :defer t
  :ensure t)

(use-package jenkinsfile-mode
  :defer t
  :ensure t)

(use-package elixir-mode
  :defer t
  :ensure t)

(use-package consult
  :ensure t
  :bind (("C-s" . 'consult-line)))

(use-package consult-eglot
  :ensure t)

(use-package vertico
  :ensure t
  :init
  (vertico-mode))

(use-package vertico-directory
  :after vertico
  :ensure nil)

(use-package savehist
  :init
  (savehist-mode))

(use-package smartparens
  :defer t
  :diminish smartparens-mode
  :ensure t
  :init
  (require 'smartparens-config)
  (smartparens-global-mode))

(use-package flycheck
  :diminish flycheck-mode
  :ensure t
  :hook (ruby-mode . flycheck-mode))

;; (use-package eglot-booster
;;   :after eglot
;;   :config (eglot-booster-mode))

(use-package go-mode
  :ensure t
  :hook ((go-mode . yas-minor-mode)
         (go-mode . eglot-ensure)))

(use-package js2-mode
  :ensure t
  :mode "\\.js\\'")

(use-package json-mode
  :ensure t
  :mode "\\.json\\'"
  :config
  (setq js-indent-level 2))

;; (use-package rust-mode
;;   :defer t
;;   :ensure t
;;   :config
;;   (setq rust-format-on-save t)
;;   :hook ((rust-mode . eglot-ensure)
;;          (rust-mode . company-mode)))

;; (use-package ledger-mode
;;   :defer t
;;   :ensure t)

(use-package magit
  :defer t
  :ensure t)

(use-package marginalia
  :ensure t
  :init
  (marginalia-mode))

(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles basic partial-completion)))))

(use-package powerline
  :ensure t
  :hook (after-init . powerline-default-theme))

(use-package ruby-mode
  :defer t
  :config
  (setq ruby-insert-encoding-magic-comment nil)
  :hook
  (ruby-mode . smartparens-mode))

(use-package yasnippet
  :ensure t)
