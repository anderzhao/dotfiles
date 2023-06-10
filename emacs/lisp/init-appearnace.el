(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(tooltip-mode -1)
(set-fringe-mode 10)
(setq inhibit-startup-screen t)

(set-face-attribute 'default nil
                    :family "Monospace"
                    :height 160
                    :width 'normal)

;; Set Solarized theme
(add-to-list 'custom-theme-load-path (concat themes-dir "solarized"))
(load-theme 'solarized-dark t)

(provide 'init-appearnace)
