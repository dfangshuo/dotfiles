(defun abx-browse-path ()
  (interactive)
  (let ((file-name (concat "https://abnormal.phacility.com/diffusion/SRC/browse/master"
                           (substring (buffer-file-name) 24 ))))
    (if file-name
        (progn
          (message file-name)
          (kill-new file-name))
      (error "Buffer not visiting a file"))))

(defun abx-browse-path-line ()
  (interactive)
  (let ((file-name (concat "https://abnormal.phacility.com/diffusion/SRC/browse/master/src/py"
                           (substring (buffer-file-name) 24 ) "$" (number-to-string (line-number-at-pos)))))
    (if file-name
        (progn
          (message file-name)
          (kill-new file-name))
      (error "Buffer not visiting a file"))))

(map! :leader :desc "Get phacility path for current line" "y u" #'abx-browse-path-line)

(defun copy-filepath-clipboard ()
  "Copy the current buffer file name to the clipboard."
  (interactive)
  (let ((filename (if (equal major-mode 'dired-mode)
                      default-directory
                    (buffer-file-name))))
    (when filename
      (kill-new filename))
    (message filename)))

(map! :leader :desc "Yank filepath" "y p" #'copy-filepath-clipboard)

(defun copy-file-name-to-clipboard ()
  "Copy the current buffer file name to the clipboard."
  (interactive)
  (let ((filename (if (equal major-mode 'dired-mode)
                      default-directory
                    (buffer-name))))
    (when filename
      (kill-new filename))
    (message filename)))
;; (defun abn-py-hook ()
;;   (setq python-black-command (concat (file-name-as-directory (getenv "WORKON_HOME")) "abnormal/bin/black"))
;;   (setq python-black-extra-args (list "--config" (concat (file-name-as-directory (getenv "SOURCE")) "pyproject.toml")))
;;   (python-black-on-save-mode)
;;   (setq indent-tabs-mode nil tab-width 2)
;; )

;; (add-hook 'python-mode-hook 'abn-py-hook)

;; (defun abn-rsync-pike () (interactive) (async-shell-command "~/scripts/rsync-pike.sh"))
;; (defun abn-rsync-perch () (interactive) (async-shell-command "~/scripts/rsync-perch.sh"))

;; Key bindings
;; (map! :leader :desc "Rsync abn pike" "r p" #'abn-rsync-pike)
;; (map! :leader :desc "Rsync abn perch" "r P" #'abn-rsync-perch)
