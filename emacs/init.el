;; Default Encoding
(setq prefer-coding-system       'utf-8-unix)
(setq default-coding-systems     'utf-8-unix)
(setq keyboard-coding-system     'utf-8-unix)
(setq terminal-coding-system     'utf-8-unix)
(setq clipboard-coding-system    'utf-8-unix)
(setq selection-coding-system    'utf-8-unix)
(setq buffer-file-coding-system  'utf-8-unix)
(setq save-buffer-coding-system  'utf-8-unix)

(setq gc-cons-threshold (* 50 1000 1000))

;; Quiet Startup
(setq inhibit-startup-screen t)
(setq inhibit-startup-message t)
(setq initial-scratch-message nil)
(setq inhibit-startup-echo-area-message t)

(setq package-enable-at-startup nil)
(setq package--init-file-ensured t)
(setq package-load-list nil)

(setq frame-inhibit-implied-resize t)
(setq frame-title-format nil)
(setq frame-resize-pixelwise t)

(setq make-backup-files nil)           ; Forbide to make backup files
(setq auto-save-default nil)           ; Disable auto save
(setq delete-by-moving-to-trash t)     ; Deleting files go to OS's trash folder

(setq indent-tabs-mode nil)
(setq comment-style 'indent)
(setq x-select-enable-clipboard t)
(setq ring-bell-function 'ignore)
(setq visible-bell t)
(setq initial-major-mode 'fundamental-mode)

(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(tooltip-mode -1)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(transient-mark-mode 1)
(global-subword-mode 1)

(setq-default tab-width 2)
(setq-default indent-tabs-mode nil)

(set-fringe-mode 8)

;; (set-frame-parameter (selected-frame) 'alpha '(90 . 90))
;; (add-to-list 'default-frame-alist '(alpha . (90 . 90)))
(set-frame-parameter (selected-frame) 'fullscreen 'maximized)
(add-to-list 'default-frame-alist '(fullscreen . maximized))


(column-number-mode)
;; Enable line numbers for some modes
(dolist (mode '(text-mode-hook
                prog-mode-hook
                conf-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 1))))

;; Override some modes which derive from the above
(dolist (mode '(org-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))


;; Don’t warn for large files (shows up when launching videos)
(setq large-file-warning-threshold nil)
;; Don’t warn for following symlinked files
(setq vc-follow-symlinks t)
;; Don’t warn when advice is added for functions
(setq ad-redefinition-action 'accept)


;; Set the font face
(set-face-attribute 'default nil :font "JetBrains Mono" :weight 'light :height 150)
;; Set the fixed pitch face
(set-face-attribute 'fixed-pitch nil :font "JetBrains Mono" :weight 'light :height 150)
;; Set the variable pitch face
(set-face-attribute 'variable-pitch nil :font "Iosevka Aile" :weight 'light :height 150)


(defvar emacs-root-dir (file-truename "~/.config/emacs/"))
(defvar emacs-config-dir (concat emacs-root-dir "config/"))
(defvar emacs-extension-dir (concat emacs-root-dir "extensions/"))

(add-to-list 'load-path (concat emacs-extension-dir "use-package/"))
(require 'use-package)

(use-package benchmark-init
  :load-path "~/.config/emacs/extensions/benchmark-init"
  :init
  (require 'benchmark-init-loaddefs)
  (benchmark-init/activate)
  :hook (after-init . benchmark-init/deactivate))

(use-package async
  :load-path "~/.config/emacs/extensions/async")
(use-package avy
  :load-path "~/.config/emacs/extensions/avy")
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
  :config
  (use-package magit-todos
    :load-path "~/.config/emacs/extensions/magit-todos")
  (setq magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1)
  :bind ("C-M-;" . magit-status))

(use-package org
  :load-path "~/.config/emacs/extensions/org-mode/lisp/")

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
  (setq company-minimum-prefix-length 1
        company-show-quick-access t))
(use-package flymake
  :hook (prog-mode . flymake-mode)
  :config
  (global-set-key (kbd "M-n") #'flymake-goto-next-error)
  (global-set-key (kbd "M-p") #'flymake-goto-prev-error))

(use-package ace-window
  :load-path "~/.config/emacs/extensions/ace-window"
  :after (avy)
  :bind ("M-o" . ace-window)
  :custom
  (aw-scope 'frame)
  (aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
  (aw-minibuffer-flag t)
  :config
  (ace-window-display-mode 1))
(use-package default-text-scale
  :load-path "~/.config/emacs/extensions/default-text-scale"
  :config
  (default-text-scale-mode)
  :bind (("C-M-=" . default-text-scale-increase)
         ("C-M--" . default-text-scale-decrease)))
(use-package move-dup
  :load-path "~/.config/emacs/extensions/move-dup"
  :config (move-dup-mode t))
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
(use-package origami
  :load-path "~/.config/emacs/extensions/origami"
  :hook ((yaml-mode . origami-mode)))


(use-package which-key
  :load-path "~/.config/emacs/extensions/which-key"
  :config (which-key-mode)
  (setq which-key-idle-delay 0.3))

(use-package alert
  :load-path "~/.config/emacs/extensions/alert"
  :config
  (setq alert-default-style 'notifications))
