(use-package dired
  :config
  (progn
    (put 'dired-find-alternate-file 'disabled nil)
    (cond ((eq system-type 'darwin)
           (progn
             (setq insert-directory-program "gls")
             (setq dired-use-ls-dired t)
             (setq dired-listing-switches "-ahlv --group-directories-first")))
          ((eq system-type 'windows-nt)
           (progn
             (setq ls-lisp-use-insert-directory-program t)
             (setq insert-directory-program (expand-file-name "~/.local/opt/cygwin/bin/ls.exe"))
             ;; (setq dired-listing-switches "-ADhlv --group-directories-first --dereference --time-style=long-iso")
             (setq dired-listing-switches "-ADhlv --time-style=long-iso")))
          (t
           (progn
             (setq ls-lisp-use-insert-directory-program t)
             ;; (setq dired-listing-switches "-ahlv --group-directories-first")
             (setq dired-listing-switches "-ADhlv --time-style=long-iso"))))
    (setq dired-dwim-target t)

    (defun my/dired-find-alternate-file ()
      "Opens directories in same buffer and files in new buffer."
      (interactive)
      (let ((filename (dired-get-filename t t)))
        (if (file-directory-p filename)
            (dired-find-alternate-file)
          (dired-find-file))))

    (defun my/dired-up-directory ()
      "Opens parent directory in same buffer."
      (interactive)
      (find-alternate-file ".."))

    (add-hook 'dired-mode-hook 'subword-mode))
  :bind
  (:map dired-mode-map
        ("RET" . my/dired-find-alternate-file)
        ("^" . my/dired-up-directory)))

(use-package dired-aux
  :after (:all dired))

(use-package dired-quick-sort
  :pin melpa-stable
  :ensure t
  :after (:all dired)
  :config
  (progn
    (dired-quick-sort-setup)))

(use-package dired-x
  :after (:all dired)
  :config
  (progn
    (setq dired-omit-files (concat dired-omit-files "\\|^\\..+$"))

    (defvar my/dired-omit-flag nil)

    (defun my/dired-omit-mode ()
      (if (eq my/dired-omit-flag t)
          (setq dired-omit-mode t)
        (setq dired-omit-mode nil)))

    (defun my/toggle-dired-omit ()
      "This function is a small enhancement for `dired-omit-mode', which will
      \"remember\" omit state across Dired buffers."
      (interactive)
      (if (eq my/dired-omit-flag t)
          (setq my/dired-omit-flag nil)
        (setq my/dired-omit-flag t))
      (my/dired-omit-mode)
      (revert-buffer))

    (add-hook 'dired-mode-hook 'auto-revert-mode)
    (add-hook 'dired-mode-hook 'my/dired-omit-mode))
  :bind
  (:map dired-mode-map
        ("M-m M-o" . my/toggle-dired-omit)))
