(use-package nginx-mode
  :pin melpa-stable
  :ensure t
  :pin melpa-stable)

(use-package company-nginx
  :pin melpa
  :ensure t
  :after (:all company nginx-mode)
  :config
  (progn
    (add-hook 'nginx-mode-hook #'company-nginx-keywords)))
