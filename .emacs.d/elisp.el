(use-package elisp-mode
  :config
  (progn
    (setq emacs-lisp-docstring-fill-column 120)

    (add-hook 'emacs-lisp-mode-hook 'aggressive-indent-mode)
    (add-hook 'emacs-lisp-mode-hook 'auto-highlight-symbol-mode)
    (add-hook 'emacs-lisp-mode-hook 'company-mode)
    (add-hook 'emacs-lisp-mode-hook 'eldoc-mode)
    (add-hook 'emacs-lisp-mode-hook 'flyspell-prog-mode)
    (add-hook 'emacs-lisp-mode-hook 'linum-mode)
    (add-hook 'emacs-lisp-mode-hook 'show-smartparens-mode)
    (add-hook 'emacs-lisp-mode-hook 'smartparens-strict-mode)
    (add-hook 'emacs-lisp-mode-hook 'toggle-truncate-lines)
    (add-hook 'emacs-lisp-mode-hook 'hl-line-mode)

    (add-hook 'lisp-interaction-mode-hook 'aggressive-indent-mode)
    (add-hook 'lisp-interaction-mode-hook 'auto-highlight-symbol-mode)
    (add-hook 'lisp-interaction-mode-hook 'company-mode)
    (add-hook 'lisp-interaction-mode-hook 'eldoc-mode)
    (add-hook 'lisp-interaction-mode-hook 'flyspell-prog-mode)
    (add-hook 'lisp-interaction-mode-hook 'linum-mode)
    (add-hook 'lisp-interaction-mode-hook 'show-smartparens-mode)
    (add-hook 'lisp-interaction-mode-hook 'smartparens-strict-mode)
    (add-hook 'lisp-interaction-mode-hook 'toggle-truncate-lines)
    (add-hook 'lisp-interaction-mode-hook 'hl-line-mode)))
