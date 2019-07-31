(use-package python-mode
  :ensure t
  :pin melpa-stable
  ;; :after (:all lsp-mode projectile)
  :after (:all helm projectile)
  :config
  (progn
    ;; (lsp-define-stdio-client lsp-python "python"
    ;;                          #'projectile-project-root
    ;;                          '("pyls"))
    ;; (add-hook 'python-mode-hook
    ;;           (lambda ()
    ;;             (lsp-python-enable)))
    (add-hook 'python-mode-hook 'linum-mode)
    (add-hook 'python-mode-hook 'hl-line-mode)
    (add-hook 'python-mode-hook 'auto-highlight-symbol-mode)
    (add-hook 'python-mode-hook 'subword-mode)
    (add-hook 'python-mode-hook 'company-mode)
    (add-hook 'python-mode-hook 'flycheck-mode)
    ;; (set (make-local-variable 'compile-command)
    ;;      (concat "python3 " (buffer-name)))
    ))

(use-package anaconda-mode
  :ensure t
  :pin melpa-stable
  :after (:all python-mode)
  :config
  (progn
    (add-hook 'python-mode-hook 'anaconda-mode)
    (add-hook 'python-mode-hook 'anaconda-eldoc-mode)
    (define-key anaconda-mode-map (kbd "C-h d") 'anaconda-mode-show-doc)))

(use-package pyimport
  :ensure t
  :pin melpa-stable
  :after (:all python-mode))

(use-package importmagic
  :ensure t
  :pin melpa-stable
  :after (:all python-mode)
  :config
  (progn
    (add-hook 'python-mode-hook 'importmagic-mode)))

(use-package pyimpsort
  :ensure t
  :pin melpa
  :after (:all python-mode))

(use-package company-anaconda
  :ensure t
  :pin melpa-stable
  :after (:all anaconda-mode company)
  :config
  (progn
    (add-hook 'python-mode-hook
              (lambda ()
                (add-to-list (make-local-variable 'company-backends)
                             'company-anaconda)))))

(use-package flycheck-mypy
  :ensure t
  :pin melpa
  :after (:all flycheck-mode python-mode))
