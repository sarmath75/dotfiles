(use-package css-mode
  :config
  (progn
    (add-hook 'css-mode-hook 'auto-highlight-symbol-mode)
    (add-hook 'css-mode-hook 'company-mode)
    (add-hook 'css-mode-hook 'linum-mode)
    (add-hook 'css-mode-hook 'show-smartparens-mode)
    (add-hook 'css-mode-hook 'smartparens-strict-mode)))
