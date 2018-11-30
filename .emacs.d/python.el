(use-package python-mode
  :ensure t
  :pin melpa-stable
  :after (:all lsp-mode projectile)
  :config
  (lsp-define-stdio-client lsp-python "python"
                           #'projectile-project-root
                           '("pyls"))

  (add-hook 'python-mode-hook
            (lambda ()
              (lsp-python-enable))))
