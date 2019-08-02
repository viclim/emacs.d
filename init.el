(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))

(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))

(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

(setq-default indent-tabs-mode nil)

(setq tab-width 2)
(setq js-indent-level 2)
(setq js2-basic-offset 2)

(setq system-uses-terminfo nil)
(prefer-coding-system 'utf-8)

(package-initialize)

(add-to-list 'load-path (expand-file-name "config" "~/.emacs.d"))
(load "common.el")
(load "look.el")
(load "ruby.el")
(load "javascript.el")
(load "go.el")
(load "python.el")
(load "rust.el")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("8e5dd88c42089566d5f8e1a23d3017c213eeccd94a7b9e1a58a2dc3e08cb26d5" default)))
 '(org-journal-dir "~/.journal/2019")
 '(org-journal-enable-encryption t)
 '(package-selected-packages
   (quote
    (rainbow-mode dumb-jump protobuf-mode cargo racer hledger-mode powerline docker-compose-mode org-journal flycheck-rust rust-mode slim-mode lua-mode indium prettier-js format-sql company-go go-mode vue-mode flycheck-flow flow-minor-mode folding js2-mode seeing-is-believing expand-region rjsx-mode go-autocomplete company-anaconda anaconda-mode typescript-mode dockerfile-mode yaml-mode web-mode virtualenv smartparens scss-mode rubocop rspec-mode python-mode python projectile-rails popup moe-theme markdown-mode magit json-mode haml-mode go-errcheck github-browse-file exec-path-from-shell enh-ruby-mode emmet-mode csv-mode counsel-projectile alchemist ag ace-window)))
 '(projectile-globally-ignored-directories
   (quote
    (".idea" ".eunit" ".git" ".hg" ".fslckout" ".bzr" "_darcs" ".tox" ".svn" ".stack-work" "node_modules")))
 '(require-final-newline t)
 '(safe-local-variable-values (quote ((whitespace-line-column . 80))))
)
