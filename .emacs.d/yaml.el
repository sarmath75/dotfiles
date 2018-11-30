(use-package yaml-mode
  :pin melpa-stable
  :ensure t
  :defer t
  :mode
  ("\\.yml$" . yaml-mode)
  :config
  (progn
    (add-hook 'yaml-mode-hook 'subword-mode)
    (add-hook 'yaml-mode-hook 'linum-mode)))
