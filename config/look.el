(require 'powerline)
(require 'moe-theme)
(moe-dark)
(powerline-moe-theme)

(show-paren-mode 1)
(menu-bar-mode -1)
(global-linum-mode 1)
(column-number-mode 1)
(setq linum-format "%d ")

;; Shutup
(setq visible-bell nil)
(setq ring-bell-function 'ignore)

;; ivy-mode theme customization
;;(set-face-attribute )
;; (set-face-attribute 'ivy-confirm-face nil :foreground "blue" :background "black" :weight 'bold)
;; (ivy-confirm-face ((,class (:foreground ,green-4 :background ,green-00 :bold t))))
;; (ivy-subdir ((,class (:foreground ,blue-1 :bold t))))
;; (set-face-attribute 'ivy-virtual nil :background "#ffff87")

;; (ivy-minibuffer-match-face-1 ((,class (:background ,blue-1 :foreground ,white-0))))
;; (ivy-minibuffer-match-face-2 ((,class (:bold t :background ,green-2 :foreground ,white-0))))
;; (ivy-minibuffer-match-face-3 ((,class (:bold t :background ,magenta-2 :foreground ,white-0))))
;; (ivy-minibuffer-match-face-4 ((,class (:bold t :background ,cyan-3 :foreground ,red-3))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(isearch ((t (:foreground "#FFF" :background "#000"))))
 '(swiper-match-face-2 ((t (:foreground "#87ffff" :background "#ff5d17"))))
 '(swiper-background-match-face-2 ((t (:foreground "#6c6c6c" :background "#ffd7af"))))
 '(ivy-minibuffer-match-face-2 ((t (:foreground "#000" :background "#fce94f"))))
 '(ivy-current-match ((t (:foreground "#000000" :background "#ff5d17"))))
 '(region ((t (:foreground "#000000" :background "#FFF"))))
 )
