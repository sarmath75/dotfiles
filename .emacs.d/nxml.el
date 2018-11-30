(use-package nxml-mode
  :after (:all auto-highlight-symbol company linum smartparens sgml-mode)
  :mode
  ("\\.xml$" . nxml-mode)
  ("\\.xsd$" . nxml-mode)
  :config
  (progn
    (setq nxml-slash-auto-complete-flag nil)
    (add-hook 'nxml-mode-hook 'auto-highlight-symbol-mode)
    (add-hook 'nxml-mode-hook 'company-mode)
    (add-hook 'nxml-mode-hook 'linum-mode)
    (add-hook 'nxml-mode-hook 'show-smartparens-mode)
    (add-hook 'nxml-mode-hook 'smartparens-strict-mode)
    (add-hook 'nxml-mode-hook
              (lambda ()
                (sgml-guess-indent)
                (setq-local nxml-child-indent sgml-basic-offset)))))
