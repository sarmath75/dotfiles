(use-package markdown-mode
  :pin melpa-stable
  :ensure t)

(use-package grip-mode
  :pin melpa-stable
  :ensure t
  :after (:all markdown-mode)
  :bind
  (:map markdown-mode-command-map
        ("g" . grip-mode)))
