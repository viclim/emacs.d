(setenv "PATH" (concat (getenv "HOME") "/.rbenv/shims:" (getenv "HOME") "/.rbenv/bin:" (getenv "PATH")))
(setq exec-path (cons (concat (getenv "HOME") "/.rbenv/shims") (cons (concat (getenv "HOME") "/.rbenv/bin") exec-path)))

(add-to-list 'auto-mode-alist '("\\.rb$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rake$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("\\.erb$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("\\.html.erb$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.js.erb$" . web-mode))
(add-to-list 'auto-mode-alist '("Gemfile" . enh-ruby-mode))


(projectile-rails-global-mode)

(dolist (hook (list
               'enh-ruby-mode-hook
               ))
  (add-hook hook (lambda ()
                   (flycheck-mode)
                   (lsp-ui-mode)
                   )))
