(use-package web-mode
  :pin melpa-stable
  :ensure t
  :mode
  ("\\.as[cp]x\\'" . web-mode)
  ("\\.[agj]sp\\'" . web-mode)
  ("\\.djhtml\\'" . web-mode)
  ("\\.erb\\'" . web-mode)
  ("\\.html?\\'" . web-mode)
  ("\\.mustache\\'" . web-mode)
  ("\\.phtml\\'" . web-mode)
  ("\\.tpl\\.php\\'" . web-mode)
  :config
  (progn
    (setq-default web-mode-block-padding 2)
    (setq-default web-mode-css-indent-offset 2)
    (setq-default web-mode-style-padding 2)
    (setq-default web-mode-code-indent-offset 4)
    (setq-default web-mode-script-padding 2)
    (setq-default web-mode-markup-indent-offset 2)
    (add-hook 'web-mode-hook
              (lambda ()
                (sgml-guess-indent)
                (setq-local web-mode-block-padding sgml-basic-offset)
                (setq-local web-mode-css-indent-offset sgml-basic-offset)
                (setq-local web-mode-style-padding sgml-basic-offset)
                (setq-local web-mode-script-padding sgml-basic-offset)
                (setq-local web-mode-markup-indent-offset sgml-basic-offset)))
    (add-hook 'web-mode-hook 'auto-highlight-symbol-mode)
    (add-hook 'web-mode-hook 'company-mode)
    (add-hook 'web-mode-hook 'linum-mode)
    (add-hook 'web-mode-hook 'show-smartparens-mode)
    (add-hook 'web-mode-hook 'smartparens-strict-mode)))
