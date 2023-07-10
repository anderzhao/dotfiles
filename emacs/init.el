;;; init.el --- Summary
;;; Commentary:
;;; Code:

;; Default Encoding
(setq default-file-name-coding-system 'utf-8-unix)
(setq default-sendmail-coding-system  'utf-8-unix)
(setq default-terminal-coding-system  'utf-8-unix)
(setq keyboard-coding-system          'utf-8-unix)
(setq buffer-file-coding-system       'utf-8-unix)
(setq selection-coding-system         'utf-8-unix)
(setq save-buffer-coding-system       'utf-8-unix)

;; Quiet Startup
(setq gc-cons-threshold (* 64 1024 1024))
(setq frame-inhibit-implied-resize t)
(setq inhibit-startup-screen t)
(setq inhibit-startup-message t)
(setq inhibit-startup-echo-area-message t)
(setq initial-scratch-message nil)
(setq frame-title-format nil)
(setq frame-resize-pixelwise t)
(setq package-enable-at-startup nil)

(setq make-backup-files nil)
(setq auto-save-default nil)
(setq delete-by-moving-to-trash t)

(setq comment-style 'indent)
(setq ring-bell-function 'ignore)
(setq initial-major-mode 'fundamental-mode)

(setq-default fill-column 80)
(add-hook 'text-mode-hook 'turn-on-auto-fill)
(add-hook 'prog-mode-hook 'turn-on-auto-fill)
(add-hook 'org-mode-hook 'turn-on-auto-fill)

(scroll-bar-mode -1)
(menu-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(column-number-mode 1)
(transient-mark-mode 1)
(global-subword-mode 1)

(dolist (mode '(text-mode-hook
                prog-mode-hook
                conf-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 1))))
(dolist (mode '(org-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(set-frame-parameter (selected-frame) 'fullscreen 'maximized)
(add-to-list 'initial-frame-alist '(fullscreen . maximized))
(add-to-list 'default-frame-alist '(fullscreen . maximized))


(set-face-attribute 'default nil
		    :font "JetBrains Mono"
		    :weight 'light
		    :height 150)
(set-face-attribute 'fixed-pitch nil
		    :font "JetBrains Mono"
		    :weight 'light
		    :height 150)
(set-face-attribute 'variable-pitch nil
		    :font "Iosevka Aile"
		    :weight 'light
		    :height 150)

(eval-when-compile
  (defvar emacs-root-dir (file-truename "~/.config/emacs/"))
  (defvar emacs-config-dir (concat emacs-root-dir "config/"))
  (defvar emacs-extension-dir (concat emacs-root-dir "extensions/"))
  (push (expand-file-name "use-package/" emacs-extension-dir) load-path))

(require 'use-package)

(use-package async
  :load-path "~/.config/emacs/extensions/async")

(use-package avy
  :load-path "~/.config/emacs/extensions/avy"
  :bind (("C-'" . avy-goto-char-timer)
         ("C-c C-j" . avy-resume))
  :config
  (setq avy-background t
        avy-all-windows t
        avy-timeout-seconds 0.3))

(use-package compat
  :load-path "~/.config/emacs/extensions/compat/")
(use-package dash
  :load-path "~/.config/emacs/extensions/dash/")
(use-package s
  :load-path "~/.config/emacs/extensions/s")
(use-package f
  :load-path "~/.config/emacs/extensions/f")
(use-package hl-todo
  :load-path "~/.config/emacs/extensions/hl-todo")
(use-package with-editor
  :load-path "~/.config/emacs/extensions/with-editor/lisp/")
(use-package pcre2el
  :load-path "~/.config/emacs/extensions/pcre2el")

(use-package dracula-theme
  :load-path "~/.config/emacs/extensions/dracula-theme/"
  :config (load-theme 'dracula t))

(use-package magit
  :load-path "~/.config/emacs/extensions/magit/lisp/"
  :after
  (setq magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1)
  :bind ("C-M-;" . magit-status))

(use-package magit-todos
  :load-path "~/.config/emacs/extensions/magit-todos")

(use-package ivy
  :load-path "~/.config/emacs/extensions/swiper"
  :hook (after-init . ivy-mode)
  :config (ivy-mode 1)
  (setq ivy-use-virtual-buffers t
        ivy-initial-inputs-alist nil
	enable-recursive-minibuffers t
        ivy-count-format "%d/%d "
        ivy-re-builders-alist '((t . ivy--regex-ignore-order))))

(use-package counsel
  :load-path "~/.config/emacs/extensions/swiper"
  :after (ivy)
  :bind (("M-x"     . counsel-M-x)
         ("C-x C-f" . counsel-find-file)
         ("C-c f"   . counsel-recentf)
         ("C-c g"   . counsel-git)))

(use-package swiper
  :load-path "~/.config/emacs/extensions/swiper"
  :after (ivy)
  :bind (("C-s" . swiper)
         ("C-r" . swiper-isearch-backward))
  :config
  (setq swiper-action-recenter t
        swiper-include-line-number-in-search t))

(use-package company
  :load-path "~/.config/emacs/extensions/company-mode"
  :hook (after-init . global-company-mode)
  :config
  (setq company-tooltip-align-annotations t
        company-tooltip-limit 20
        company-idle-delay 0.2
        company-minimum-prefix-length 1
        company-show-quick-access t))

(use-package ace-window
  :load-path "~/.config/emacs/extensions/ace-window"
  :hook (prog-mode . ace-window-display-mode)
  :bind ("M-o" . ace-window)
  :custom
  (aw-scope 'frame)
  (aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
  (aw-minibuffer-flag t))

(use-package default-text-scale
  :load-path "~/.config/emacs/extensions/default-text-scale"
  :custom
  (default-text-scale-mode)
  :bind (("C-M-=" . default-text-scale-increase)
         ("C-M--" . default-text-scale-decrease)))

(use-package move-dup
  :load-path "~/.config/emacs/extensions/move-dup"
  :hook (prog-mode . global-move-dup-mode))

(use-package evil-nerd-commenter
  :load-path "~/.config/emacs/extensions/evil-nerd-commenter"
  :bind ("M-/" . evilnc-comment-or-uncomment-lines))

(use-package ws-butler
  :load-path "~/.config/emacs/extensions/ws-butler"
  :hook
  (text-mode . ws-butler-mode)
  (prog-mode . ws-butler-mode))

(use-package yaml-mode
  :load-path "~/.config/emacs/extensions/yaml-mode"
  :mode ("\\.yml\\'" . yaml-mode))

(use-package which-key
  :load-path "~/.config/emacs/extensions/which-key"
  :commands (which-key-mode)
  :config (which-key-mode 1)
  (setq which-key-idle-delay 0.3))

(use-package projectile
  :load-path "~/.config/emacs/extensions/projectile"
  :commands (projectile-mode)
  :config
  (setq projectile-cache-file (expand-file-name "~/.cache/projectile.cache" user-emacs-directory))
  (projectile-mode 1)
  (define-key projectile-mode-map (kbd "C-c C-p") 'projectile-command-map))

;; Templates
(use-package yasnippet
  :load-path "~/.config/emacs/extensions/yasnippet"
  :commands (yas-global-mode)
  :config (yas-global-mode 1))

(use-package yasnippet-snippets
  :load-path "~/.config/emacs/extensions/yasnippet-snippets"
  :after (yasnippet))

(use-package auto-yasnippet
  :load-path "~/.config/emacs/extensions/auto-yasnippet"
  :bind (("C-c & w" . aya-create)
	 ("C-c & y" . aya-expand))
  :config
  (setq aya-persist-snippets-dir (concat user-emacs-directory "/snippets")))

(use-package multiple-cursors
  :load-path "~/.config/emacs/extensions/multiple-cursors"
  :bind (("C-S-c" . mc/edit-lines)
         ("C->" . mc/mark-next-like-this-symbol)
         ("C-M->" . mc/skip-to-next-like-this)
         ("C-<" . mc/mark-previous-like-this-symbol)
         ("C-M-<" . mc/skip-to-previous-like-this)
         ("C-c C->" . mc/mark-all-symbols-like-this)))

;;; init.el ends here
