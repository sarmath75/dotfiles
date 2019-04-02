(use-package restclient
  :ensure t
  :pin melpa
  :mode
  ("\\.restclient\\'" . restclient-mode)
  :config
  (progn
    (add-hook 'restclient-mode-hook 'linum-mode)
    (add-hook 'restclient-mode-hook 'smartparens-strict-mode)
    (add-hook 'restclient-mode-hook 'subword-mode)
    (add-hook 'restclient-mode-hook 'company-mode))
  :bind
  (:map restclient-mode-map
        ("M-n" . restclient-jump-next)
        ("M-p" . restclient-jump-prev)))

(use-package company-restclient
  :ensure t
  :pin melpa-stable
  :after (:all company restclient)
  :config
  (progn
    (add-hook 'restclient-mode-hook
              (lambda ()
                (add-to-list (make-local-variable 'company-backends)
                             'company-restclient)))))
