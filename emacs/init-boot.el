(defconst emacs-dir "~/.config/emacs/")
(defconst lisp-dir (concat emacs-dir "lisp/"))
(defconst packages-dir (concat emacs-dir "packages/"))
(defconst themes-dir (concat emacs-dir "themes/"))

(defconst auto-save-dir (concat emacs-dir "emacs_auto_save/"))
(defconst backup-dir (concat emacs-dir "emacs_backup/"))

(add-to-list 'load-path lisp-dir)

;; Load packages path
(add-to-list 'load-path packages-dir)
(add-to-list 'load-path (concat packages-dir "dash"))
(add-to-list 'load-path (concat packages-dir "compat"))
(add-to-list 'load-path (concat packages-dir "transient/lisp"))
(add-to-list 'load-path (concat packages-dir "with-editor/lisp"))
(add-to-list 'load-path (concat packages-dir "forge/lisp"))
(add-to-list 'load-path (concat packages-dir "magit/lisp"))
(add-to-list 'load-path (concat packages-dir "org-mode/lisp"))

;; Load themes path
(add-to-list 'load-path themes-dir)
(add-to-list 'load-path (concat themes-dir "solarized"))

(defun create-directory-if-not-exists (directory)
    (unless (file-directory-p directory)
            (message "Create DIRECTORY")
            (make-directory directory t)))

;; Set auto save directory and backup directory
(create-directory-if-not-exists auto-save-dir)
(create-directory-if-not-exists backup-dir)
(setq backup-directory-alist `((".*" . , backup-dir)))
(setq auto-save-list-file-prefix (expand-file-name (concat auto-save-dir ".save-")))
(message "Deleting old backup files...")
(let ((week (* 60 60 24 7))
      (current (float-time (current-time))))
  (dolist (file (directory-files backup-dir t))
    (when (and (backup-file-name-p file)
               (> (- current (float-time (nth 5 (file-attributes file))))
                  week))
      (message "Deleting file: %s" file)
      (delete-file file))))
(message "Old backup files deleted.")

;; Set proxy
(setq url-proxy-services
      '(("http" .  "127.0.0.1:7890")
        ("https" . "127.0.0.1:7890")))
(setq magit-http-proxy-explicit t)


(provide 'init-boot)
