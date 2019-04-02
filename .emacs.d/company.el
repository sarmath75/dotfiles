(use-package company
  :pin melpa-stable
  :ensure t
  :diminish company-mode
  :config
  (progn
    (setq company-minimum-prefix-length 1)
    (setq company-idle-delay 0.25)
    (setq completion-ignore-case 1)
    (setq company-dabbrev-ignore-case 1)
    (setq company-dabbrev-code-ignore-case 1)
    (setq company-dabbrev-downcase nil)
    (setq pcomplete-ignore-case 1)
    (setq company-etags-ignore-case 1)
    ;; (setq company-transformers '(company-sort-by-occurrence))
    (setq company-transformers '(company-sort-prefer-same-case-prefix)))
  :bind
  (:map company-active-map
        ("\C-n" . company-select-next)
        ("\C-p" . company-select-previous)
        ("<tab>" . company-complete)))

(use-package company-flx
  :pin melpa
  :ensure t
  :after (:all company)
  :config
  (progn
    (setq company-flx-limit 24)
    (company-flx-mode 1)))
