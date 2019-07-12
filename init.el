(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))

(menu-bar-mode -1)
(global-linum-mode 1)
(column-number-mode 1)
(setq linum-format "%d ")
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

(setq visible-bell nil)
(setq ring-bell-function 'ignore)

(setq system-uses-terminfo nil)
(prefer-coding-system 'utf-8)

(package-initialize)
(require 'python)

(add-to-list 'load-path (expand-file-name "config" "~/.emacs.d"))
(load "common.el")
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
 '(css-indent-offset 2)
 '(custom-safe-themes
   (quote
    ("8e5dd88c42089566d5f8e1a23d3017c213eeccd94a7b9e1a58a2dc3e08cb26d5" default)))
 '(enh-ruby-deep-indent-paren nil)
 '(flycheck-disabled-checkers (quote (ruby-reek)))
 '(flycheck-temp-prefix ".flycheck")
 '(jdee-key-bindings
   (quote
    (quote
     (("[? ? ?]" . jdee-run-menu-run-applet)
      ("[? ? ?]" . jdee-build)
      ("[? ? ?]" . jdee-compile)
      ("[? ? ?]" . jdee-test-unittest)
      ("[? ? ?]" . jdee-debug)
      ("[? ? ?]" . jdee-find)
      ("[? ? ?]" . jdee-open-class-at-point)
      ("[? ? ?*]" . jdee-parse-fqn-to-kill-ring)
      ("[? ? ?#]" . jdee-stacktrace-buffer)
      ("[? ? ?w]" . jdee-archive-which)
      ("[? ? ?]" . jdee-backend-run)
      ("[? ? ?]" . jdee-gen-println)
      ("[? ? ?]" . jdee-help-browse-jdk-doc)
      ("[? ? ?]" . jdee-save-project)
      ("[? ? ?]" . jdee-project-update-class-list)
      ("[? ? ?]" . jdee-run)
      ("[? ? ?]" . speedbar-frame-mode)
      ("[? ? ?]" . jdee-jdb-menu-debug-applet)
      ("[? ? ?]" . jdee-help-symbol)
      ("[? ? ?]" . jdee-show-superclass-source)
      ("[? ? ?]" . jdee-open-class-at-point)
      ("[? ? ?]" . jdee-import-find-and-import)
      ("[? ? ?e]" . jdee-wiz-extend-abstract-class)
      ("[? ? ?f]" . jdee-gen-try-finally-wrapper)
      ("[? ? ?i]" . jdee-wiz-implement-interface)
      ("[? ? ?j]" . jdee-javadoc-autodoc-at-line)
      ("[? ? ?o]" . jdee-wiz-override-method)
      ("[? ? ?t]" . jdee-gen-try-catch-wrapper)
      ("[? ? ?z]" . jdee-import-all)
      ("[? ? ?]" . jdee-run-etrace-prev)
      ("[? ? ?]" . jdee-run-etrace-next)
      ("[(control c) (control v) ?,]" . jdee-complete)
      ("[(control c) (control v) ?.]" . jdee-complete-in-line)))))
 '(jdee-server-dir "~/work/viclim/jdee-server/target")
 '(js2-strict-trailing-comma-warning nil)
 '(org-journal-dir "~/.journal/2019")
 '(org-journal-enable-encryption t)
 '(package-selected-packages
   (quote
    (protobuf-mode cargo racer hledger-mode ruby-electric powerline docker-compose-mode org-journal haskell-mode flycheck-rust rust-mode jdee slim-mode lua-mode indium prettier-js format-sql coffee-mode company-go go-mode php-mode vue-mode feature-mode flycheck-flow flow-minor-mode folding js2-mode seeing-is-believing expand-region rjsx-mode go-autocomplete company-anaconda anaconda-mode typescript-mode tern tern-context-coloring dockerfile-mode yaml-mode web-mode virtualenv smartparens scss-mode rubocop rspec-mode robe python-mode python projectile-rails popup moe-theme markdown-mode magit json-mode handlebars-mode haml-mode go-errcheck github-browse-file flx-ido exec-path-from-shell enh-ruby-mode emmet-mode csv-mode counsel-projectile avy-flycheck alchemist ag ace-window)))
 '(projectile-globally-ignored-directories
   (quote
    (".idea" ".eunit" ".git" ".hg" ".fslckout" ".bzr" "_darcs" ".tox" ".svn" ".stack-work" "node_modules")))
 '(require-final-newline t)
 '(rust-format-on-save t)
 '(safe-local-variable-values (quote ((whitespace-line-column . 80))))
 '(web-mode-code-indent-offset 2)
 '(web-mode-css-indent-offset 2)
 '(web-mode-markup-indent-offset 2))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
