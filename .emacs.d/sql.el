(use-package sql
  :config
  (progn
    (load-file (expand-file-name "~/.emacs.d/sql-custom.el"))

    (add-hook 'sql-mode-hook 'company-mode)
    (add-hook 'sql-mode-hook 'smartparens-mode)
    (add-hook 'sql-interactive-mode-hook
              (lambda ()
                (toggle-truncate-lines t)))))
