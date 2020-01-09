;; (require 'python-mode)
(add-hook 'python-mode-hook (lambda ()
                              (python-black-on-save-mode)
                              ))
