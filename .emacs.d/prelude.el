(defconst my/emacs-tmp-dir (format "%s%s-%s" temporary-file-directory "emacs" (user-login-name)))

(defun my/insert-space (p)
  (interactive "d")
  (save-excursion
    (insert " ")))

(defun my/move-beginning-of-line (arg)
  "Move point back to indentation of beginning of line.

   Move point to the first non-whitespace character on this line.
   If point is already there, move to the beginning of the line.
   Effectively toggle between the first non-whitespace character and
   the beginning of the line.

   If ARG is not nil or 1, move forward ARG - 1 lines first.  If
   point reaches the beginning or end of the buffer, stop there."
  (interactive "^p")
  (setq arg (or arg 1))
  (when (/= arg 1)
    (let ((line-move-visual nil))
      (forward-line (1- arg))))
  (let ((orig-point (point)))
    (back-to-indentation)
    (when (= orig-point (point))
      (move-beginning-of-line 1))))

(defun my/next-word (p)
  "Moves point to beginning of next word."
  (interactive "d")
  (forward-word)
  (forward-word)
  (backward-word))

(defun my/query-replace-in-open-buffers (arg1 arg2)
  "query-replace in open files"
  (interactive "sQuery Replace in open Buffers: \nsquery with: ")
  (mapcar
   (lambda (x)
     (find-file x)
     (save-excursion
       (beginning-of-buffer)
       (query-replace arg1 arg2)))
   (delq
    nil
    (mapcar
     (lambda (x)
       (buffer-file-name x))
     (buffer-list)))))

(defun my/kill-grep-windows ()
  (destructuring-bind (window major-mode)
      (with-selected-window (next-window (selected-window))
        (list (selected-window) major-mode))
    (when (eq major-mode 'grep-mode)
      (delete-window window))))

(defun my/toggle-window-dedicated ()
  "Toggle whether the current active window is dedicated or not"
  (interactive)
  (message
   (if (let (window (get-buffer-window (current-buffer)))
         (set-window-dedicated-p window (not (window-dedicated-p window))))
       "Window '%s' is dedicated"
     "Window '%s' is normal")
   (current-buffer)))

(defun my/toggle-truncate-lines (&optional arg)
  "See 'toggle-truncate-lines' for details."
  (interactive "P")
  (setq truncate-lines
        (if (null arg)
            (not truncate-lines)
          (> (prefix-numeric-value arg) 0)))
  (force-mode-line-update)
  (unless truncate-lines
    (let ((buffer (current-buffer)))
      (walk-windows (lambda (window)
                      (if (eq buffer (window-buffer window))
                          (set-window-hscroll window 0)))
                    nil t))))

(defun my/erase-buffer ()
  "Erases read-only buffer."
  (interactive)
  (let ((inhibit-read-only t))
    (erase-buffer)
    (message "buffer erased.")))

(defun my/newline-and-indent-relative ()
  (interactive)
  (newline)
  (indent-relative))

(defun my/open-line-and-indent ()
  (interactive)
  (save-excursion
    (newline-and-indent)))

(defun my/open-line-and-indent-relative ()
  (interactive)
  (save-excursion
    (my/newline-and-indent-relative)))

(defvar my/window-configuration nil)

(defun my/push-window-configuration ()
  (interactive)
  (push (current-window-configuration) my/window-configuration))

(defun my/pop-window-configuration ()
  (interactive)
  (set-window-configuration (pop my/window-configuration)))
