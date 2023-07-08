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

(use-package benchmark-init
  :load-path "~/.config/emacs/extensions/benchmark-init"
  :after
  (require 'benchmark-init-loaddefs)
  (benchmark-init/activate)
  :hook (after-init . benchmark-init/deactivate))

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
  (setq company-tooltip-align-annotations t
        company-tooltip-limit 20
        company-idle-delay 0.2
        company-minimum-prefix-length 1
        company-show-quick-access t))
(use-package flymake
  :hook (prog-mode . flymake-mode))
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

(use-package alert
  :load-path "~/.config/emacs/extensions/alert"
  :config
  (setq alert-default-style 'notifications))

(use-package projectile
  :load-path "~/.config/emacs/extensions/projectile"
  :commands (projectile-mode)
  :config
  (setq projectile-cache-file (expand-file-name "~/.cache/projectile.cache" user-emacs-directory))
  (projectile-mode 1)
  (define-key projectile-mode-map (kbd "C-c C-p") 'projectile-command-map))

(use-package lsp-mode
  :load-path "~/.config/emacs/extensions/lsp-mode"
  :commands (lsp lsp-deferred)
  :init
  (setq lsp-keymap-prefix "c-c 1")
  :config
  (1sp-enable-which-key-integration t))

(use-package lsp-ui
  :load-path "~/.config/emacs/extensions/lsp-ui"
  :after (lsp-mode)
  :commands (lsp-ui-mode)
  :hook (lsp-mode . lsp-ui-mode))

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


(use-package anzu
  :load-path "~/.config/emacs/extensions/anzu")

(use-package multiple-cursors
  :load-path "~/.config/emacs/extensions/multiple-cursors"
  :bind (("C-S-c" . mc/edit-lines) ;; 每行一个光标
         ("C->" . mc/mark-next-like-this-symbol) ;; 全选光标所在单词并在下一个单词增加一个光标。通常用来启动一个流程
         ("C-M->" . mc/skip-to-next-like-this) ;; 跳过当前单词并跳到下一个单词，和上面在同一个流程里。
         ("C-<" . mc/mark-previous-like-this-symbol) ;; 同样是开启一个多光标流程，但是是「向上找」而不是向下找。
         ("C-M-<" . mc/skip-to-previous-like-this) ;; 跳过当前单词并跳到上一个单词，和上面在同一个流程里。
         ("C-c C->" . mc/mark-all-symbols-like-this))) ;; 直接多选本 buffer 所有这个单词

(use-package vterm
  :load-path "~/.config/emacs/extensions/emacs-libvterm"
  :config
  (setq vterm-kill-buffer-on-exit t))

(use-package edwina
  :load-path "~/.config/emacs/extensions/edwina"
  :commands (edwina-setup-dwm-keys edwina-mode)
  :config
  ;; 让所有 display-buffer 动作都新增一个 window （而不是复用已经打开此 buffer 的 window）
  (setq display-buffer-base-action '(display-buffer-below-selected))
  ;; 以下定义会被 (edwina-setup-dwm-keys) 增加 'M-' 修饰。
  ;; 我自定义了一套按键，因为原版会把我很常用的 M-d 覆盖掉。
  (setq edwina-dwm-key-alist
        '(("r" edwina-arrange)
          ("j" edwina-select-next-window)
          ("k" edwina-select-previous-window)
          ("J" edwina-swap-next-window)
          ("K" edwina-swap-previous-window)
          ("h" edwina-dec-mfact)    ;; 主窗口缩窄
          ("l" edwina-inc-mfact)    ;; 主窗口拉宽
          ("D" edwina-dec-nmaster)  ;; 减少主窗口的数量
          ("I" edwina-inc-nmaster)  ;; 增加主窗口的数量
          ("C" edwina-delete-window) ;; 关闭窗口
          ("RET" edwina-zoom t)     ;; 交换「主窗口」和「副窗口」
          ("return" edwina-zoom t)
          ("S-RET" edwina-clone-window t) ;; 复制一个本窗口
          ("S-return" edwina-clone-window t)))
  (edwina-setup-dwm-keys)
  (edwina-mode 1))

;;; init.el ends here
