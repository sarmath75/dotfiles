(use-package sql
  :config
  (progn
    (let* ((file-name (expand-file-name "~/.emacs.d/sql-custom.el")))
      (when (file-exists-p file-name)
        (load-file file-name)))

    (add-hook 'sql-mode-hook 'company-mode)
    (add-hook 'sql-mode-hook 'smartparens-mode)
    (add-hook 'sql-interactive-mode-hook
              (lambda ()
                (toggle-truncate-lines t)))))
