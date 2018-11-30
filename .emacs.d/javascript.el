(use-package js
  :config
  (add-hook 'js-mode-hook 'linum-mode)
  (add-hook 'js-mode-hook 'smartparens-mode)
  (add-hook 'js-mode-hook 'subword-mode)
  (add-hook 'js-mode-hook 'company-mode))

(use-package json-mode
  :pin melpa-stable
  :ensure t
  :config
  (add-hook 'json-mode-hook
            (lambda ()
              (make-local-variable 'js-indent-level)
              (setq js-indent-level 2)
              (setq require-final-newline nil))))
