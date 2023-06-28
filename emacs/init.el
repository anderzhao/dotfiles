;; Default Encoding
(setq prefer-coding-system       'utf-8-unix)
(setq default-coding-systems     'utf-8-unix)
(setq keyboard-coding-system     'utf-8-unix)
(setq terminal-coding-system     'utf-8-unix)
(setq clipboard-coding-system    'utf-8-unix)
(setq selection-coding-system    'utf-8-unix)
(setq buffer-file-coding-system  'utf-8-unix)
(setq save-buffer-coding-system  'utf-8-unix)

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
(setq initial-major-mode 'fundamental-mode)

(tooltip-mode -1)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(transient-mark-mode 1)
(global-subword-mode 1)

(defun set-fonts ()
  (interactive)
  (cond
   ;; Windows
   ((eq system-type 'windows-nt)
    (set-face-attribute 'default nil :family "Consolas" :height 140)
    (dolist (charset '(kana han symbol cjk-misc bopomofo))
      (set-fontset-font t charset (font-spec :family "Microsoft YaHei" :size 16))))
   ;; macOS
   ((eq system-type 'darwin)
    (set-face-attribute 'default nil :family "Menlo" :height 140)
    (dolist (charset '(kana han symbol cjk-misc bopomofo))
      (set-fontset-font t charset (font-spec :family "PingFang SC" :size 16))))
   ;; Linux
   ((eq system-type 'gnu/linux)
    (set-face-attribute 'default nil :family "Monospace" :height 140)
    (dolist (charset '(kana han symbol cjk-misc bopomofo))
      (set-fontset-font t charset (font-spec :family "Noto Sans CJK SC" :size 16))))))

(set-fonts)

(defvar emacs-root-dir (file-truename "~/.config/emacs/"))
(defvar emacs-config-dir (concat emacs-root-dir "config/"))
(defvar emacs-extension-dir (concat emacs-root-dir "extensions/"))

(add-to-list 'load-path (concat emacs-extension-dir "use-package/"))
(require 'use-package)

(use-package compat
  :load-path "~/.config/emacs/extensions/compat/")
(use-package dash
  :load-path "~/.config/emacs/extensions/dash/")
(use-package with-editor
  :load-path "~/.config/emacs/extensions/with-editor/lisp/")

(use-package magit
  :load-path "~/.config/emacs/extensions/magit/lisp/")
(use-package org
  :load-path "~/.config/emacs/extensions/org-mode/lisp/")

(use-package ivy
  :load-path "~/.config/emacs/extensions/swiper"
  :config (ivy-mode))
(use-package counsel
  :load-path "~/.config/emacs/extensions/swiper"
  :config (counsel-mode))
(use-package swiper
  :load-path "~/.config/emacs/extensions/swiper")

(use-package company
  :load-path "~/.config/emacs/extensions/company-mode"
  :config (global-company-mode))
