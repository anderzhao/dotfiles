(add-to-list 'load-path "~/.config/emacs/lisp")

(set-face-attribute 'default nil :height 140)

(require 'init-const)
(require 'init-boot)
(require 'init-kdb)
(require 'init-package)
(require 'init-ui)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(yasnippet restart-emacs use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


