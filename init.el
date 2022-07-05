(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/") t)

(use-package benchmark-init
  :ensure t
  :config
  ;; To disable collection of benchmark data after init is done.
  (add-hook 'after-init-hook 'benchmark-init/deactivate))

(use-package diminish
  :ensure t)

(use-package emacs
  :init
  (electric-pair-mode +1)
  (global-display-line-numbers-mode +1)
  (setq-default indent-tabs-mode nil)
  :custom
  (make-backup-files nil)
  (default-frame-alist '((menu-bar-lines 0))))

(use-package files
  :hook (before-save . delete-trailing-whitespace))

(use-package hl-line
  :hook
  (prog-mode . hl-line-mode))

(use-package so-long
  :config (global-so-long-mode))

(use-package paren
  :config
  (show-paren-mode +1))

(use-package dired-x)

(use-package dumb-jump
  :ensure t
  :config
  (add-hook 'xref-backend-functions #' dumb-jump-xref-activate))

(use-package exec-path-from-shell
  :ensure t
  :config
  (exec-path-from-shell-initialize))

(use-package moe-theme
  :ensure t
  :hook
  (after-init . moe-dark))

(use-package ace-window
  :ensure t
  :config
  (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
  :bind (("M-p" . ace-window)))

(use-package dockerfile-mode
  :defer t
  :ensure t)

(use-package jenkinsfile-mode
  :defer t
  :ensure t)

(use-package elixir-mode
  :defer t
  :ensure t)

(use-package ivy
  :defer t
  :ensure t)

(use-package projectile
  :diminish projectile-mode
  :ensure t
  :init
  (setq projectile-completion-system 'ivy)
  (projectile-mode +1)
  :bind (:map projectile-mode-map
	     ("C-c p" . projectile-command-map)))

(use-package selectrum
  :defer t
  :ensure t
  :config (selectrum-mode +1))

(use-package ctrlf
  :ensure t
  :config (ctrlf-mode +1))

(use-package consult
  :ensure t
  :bind (;; C-c bindings (mode-specific-map)
         ("C-c h" . consult-history)
         ("C-c m" . consult-mode-command)
         ("C-c k" . consult-kmacro)
         ;; C-x bindings (ctl-x-map)
         ("C-x M-:" . consult-complex-command)     ;; orig. repeat-complex-command
         ("C-x b" . consult-buffer)                ;; orig. switch-to-buffer
         ("C-x 4 b" . consult-buffer-other-window) ;; orig. switch-to-buffer-other-window
         ("C-x 5 b" . consult-buffer-other-frame)  ;; orig. switch-to-buffer-other-frame
         ("C-x r b" . consult-bookmark)            ;; orig. bookmark-jump
         ;; Custom M-# bindings for fast register access
         ("M-#" . consult-register-load)
         ("M-'" . consult-register-store)          ;; orig. abbrev-prefix-mark (unrelated)
         ("C-M-#" . consult-register)
         ;; Other custom bindings
         ("M-y" . consult-yank-pop)                ;; orig. yank-pop
         ("<help> a" . consult-apropos)            ;; orig. apropos-command
         ;; M-g bindings (goto-map)
         ("M-g e" . consult-compile-error)
         ("M-g f" . consult-flycheck)               ;; Alternative: consult-flycheck
         ("M-g g" . consult-goto-line)             ;; orig. goto-line
         ("M-g M-g" . consult-goto-line)           ;; orig. goto-line
         ("M-g o" . consult-outline)               ;; Alternative: consult-org-heading
         ("M-g m" . consult-mark)
         ("M-g k" . consult-global-mark)
         ("M-g i" . consult-imenu)
         ("M-g I" . consult-imenu-multi)
         ;; M-s bindings (search-map)
         ("M-s d" . consult-find)
         ("M-s D" . consult-locate)
         ("M-s g" . consult-grep)
         ("M-s G" . consult-git-grep)
         ("M-s r" . consult-ripgrep)
         ("M-s l" . consult-line)
         ("M-s L" . consult-line-multi)
         ("M-s m" . consult-multi-occur)
         ("M-s k" . consult-keep-lines)
         ("M-s u" . consult-focus-lines)
         ;; Isearch integration
         ("M-s e" . consult-isearch-history)
         :map isearch-mode-map
         ("M-e" . consult-isearch-history)         ;; orig. isearch-edit-string
         ("M-s e" . consult-isearch-history)       ;; orig. isearch-edit-string
         ("M-s l" . consult-line)                  ;; needed by consult-line to detect isearch
         ("M-s L" . consult-line-multi))           ;; needed by consult-line to detect isearch

  :hook (completion-list-mode . consult-preview-at-point-mode)
  :config

  ;; Optionally configure preview. The default value
  ;; is 'any, such that any key triggers the preview.
  ;; (setq consult-preview-key 'any)
  ;; (setq consult-preview-key (kbd "M-."))
  ;; (setq consult-preview-key (list (kbd "<S-down>") (kbd "<S-up>")))
  ;; For some commands and buffer sources it is useful to configure the
  ;; :preview-key on a per-command basis using the `consult-customize' macro.
  (setq consult-project-root-function
	(lambda ()
	  (when-let (project (project-current))
	    (car (project-roots project)))))

  (consult-customize
   consult-theme
   :preview-key '(:debounce 0.2 any)
   consult-ripgrep consult-git-grep consult-grep
   consult-bookmark consult-recent-file consult-xref
   consult--source-recent-file consult--source-project-recent-file consult--source-bookmark
   :preview-key (kbd "M-."))
  )

(use-package company
  :defer t
  :diminish company-mode
  :ensure t)

(use-package company-box
  :ensure t
  :hook (company-mode . company-box-mode))

(use-package flycheck
  :diminish flycheck-mode
  :ensure t
  :hook ((go-mode ruby-mode) . flycheck-mode)
  )

(use-package cc-mode
  :config
  (defun lsp-cc-install-save-hooks ()
    (add-hook 'before-save-hook #'lsp-format-buffer t t))
  :hook ((c++-mode . flycheck-mode)
         (c++-mode . lsp-deferred)
	 (c++-mode . lsp-cc-install-save-hooks)
	 (c++-mode . yas-minor-mode)))

(use-package go-mode
  :ensure t
  :config
  (defun lsp-go-install-save-hooks ()
    (add-hook 'before-save-hook #'lsp-format-buffer t t)
    (add-hook 'before-save-hook #'lsp-organize-imports t t))
  :hook ((go-mode . lsp-deferred)
	 (go-mode . lsp-go-install-save-hooks)
	 (go-mode . yas-minor-mode)))

(use-package js2-mode
  :ensure t
  :mode "\\.js\\'")

(use-package json-mode
  :ensure t
  :mode "\\.json\\'"
	:config
	(setq js-indent-level 2))

(use-package ledger-mode
  :defer t
  :ensure t)

(use-package lsp-mode
  :ensure t
  :commands lsp
  :config
  (setq lsp-auto-guess-root t))

(use-package lsp-ui
  :defer t
  :ensure t
  :config
  (setq lsp-ui-sidelinw-show-hover t))

(use-package magit
  :defer t
  :ensure t)

(use-package marginalia
  :ensure t
  :init
  (marginalia-mode))

(use-package meson-mode
  :defer t
  :ensure t)

(use-package powerline
  :ensure t
  :hook (after-init . powerline-default-theme))

(use-package ruby-mode
  :defer t
  :config
  (setq ruby-insert-encoding-magic-comment nil))

(use-package slim-mode
  :defer t
  :ensure t)

(use-package ruby-electric
  :ensure t
  :hook (ruby-mode . ruby-electric-mode))

(use-package svelte-mode
  :ensure t
  :mode "\\.svelte\\'")

(use-package tree-sitter
  :diminish tree-sitter-mode
  :ensure t
  :config
  (global-tree-sitter-mode +1)
  :hook
  (tree-sitter-after-on . tree-sitter-hl-mode))

(use-package tree-sitter-langs
  :defer t
  :ensure t)

(use-package vertico
  :ensure t
  :init (vertico-mode))

(use-package web-mode
  :defer t
  :ensure t
  :config
  (setq web-mode-markup-indent-offset 2))

(use-package yaml-mode
  :ensure t
  :mode "\\.yaml\\'" "\\.yml\\'")

(use-package yasnippet
  :defer t
  :diminish yas-minor-mode
  :ensure t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(css-indent-offset 2)
 '(custom-safe-themes
   '("fee7287586b17efbfda432f05539b58e86e059e78006ce9237b8732fde991b4c" "88deeaaab5a631834e6f83e8359b571cfcbf5a18b04990288c8569cc16ee0798" "37768a79b479684b0756dec7c0fc7652082910c37d8863c35b702db3f16000f8" default))
 '(electric-pair-mode t)
 '(js-indent-level 2)
 '(package-selected-packages
   '(string-inflection dockerfile-mode solarized-theme zenburn-theme ledger-mode svelte-mode web-mode json-mode magit meson-mode dumb-jump yaml-mode slim-mode ruby-electric exec-path-from-shell consult-flycheck diminish company-box go-mode ctrlf selectrum use-package moe-theme))
 '(sgml-basic-offset 2))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
