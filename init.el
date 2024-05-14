(require 'package)
(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'default-frame-alist '(undecorated-round . t))
(add-to-list 'default-frame-alist '(menu-bar-lines 0))

(use-package benchmark-init
  :config
  ;; To disable collection of benchmark data after init is done.
  (add-hook 'after-init-hook 'benchmark-init/deactivate))

(use-package diminish)

(use-package emacs
  :init
  (global-display-line-numbers-mode t)
  (setq-default indent-tabs-mode nil)
  (when (string= system-type "darwin")
    (setq dired-use-ls-dired nil))
  :hook (before-save . delete-trailing-whitespace)
  :custom
  (make-backup-files nil))

(use-package hl-line
  :hook
  (prog-mode . hl-line-mode))

(use-package so-long
  :config (global-so-long-mode))

;; (use-package dired-x)

(use-package dumb-jump
  :init
  (setq dumb-jump-force-searcher 'rg)
  :config
  (add-hook 'xref-backend-functions #' dumb-jump-xref-activate))

;; (use-package exec-path-from-shell
;;   :ensure t
;;   :config
;;   (exec-path-from-shell-initialize))

(use-package moe-theme
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
  :hook ((go-mode ruby-mode) . flycheck-mode))

;; (use-package go-mode
;;   :ensure t
;;   :hook ((go-mode . yas-minor-mode)))

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

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(rubocopfmt cue-mode fish-mode @ zenburn-theme yasnippet yaml-mode web-mode vertico use-package tree-sitter-langs svelte-mode string-inflection solarized-theme solaire-mode smartparens slim-mode shrink-path selectrum rust-mode ripgrep rich-minority rg powerline popon orderless nyan-mode nord-theme nerd-icons moe-theme meson-mode marginalia magit lsp-ui ledger-mode json-mode js2-mode jenkinsfile-mode go-mode flycheck-rust exec-path-from-shell elixir-mode eglot dumb-jump dockerfile-mode diminish ctrlf crystal-mode consult-flycheck consult-dash company-box benchmark-init all-the-icons ag affe ace-window)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
