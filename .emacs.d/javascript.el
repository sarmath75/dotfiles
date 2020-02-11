(use-package js
  :config
  (progn
    (defun my/setup-js-mode ()
      ;; (setq-local js-indent-level 2)
      ;; (setq-local require-final-newline nil)

      (linum-mode +1)
      (my/toggle-truncate-lines +1)

      (auto-highlight-symbol-mode +1)
      (hl-line-mode +1)

      (show-paren-mode +1)
      (smartparens-strict-mode +1)
      (subword-mode +1)

      (flyspell-prog-mode +1))

    (add-hook 'js-mode-hook #'my/setup-js-mode)))

(use-package json-mode
  :pin melpa-stable
  :ensure t)

(use-package typescript-mode
  :pin melpa-stable
  :ensure t
  :defer t
  :config
  (progn
    (defun my/setup-typescript-mode ()
      (linum-mode +1)
      (my/toggle-truncate-lines +1)

      (auto-highlight-symbol-mode +1)
      (hl-line-mode +1)

      (show-paren-mode +1)
      (smartparens-strict-mode +1)
      (subword-mode +1)

      (flyspell-prog-mode +1))

    (add-hook 'typescript-mode-hook #'my/setup-typescript-mode)))

(use-package tide
  :pin melpa-stable
  :ensure t
  ;; :diminish tide-mode
  :config
  (progn
    (defun my/setup-tide-mode ()
      (if (or (eq major-mode 'js-mode)
              (eq major-mode 'typescript-mode))
          (progn
            (interactive)
            (tide-setup)
            (company-mode +1)
            (eldoc-mode +1)
            (flycheck-mode +1)
            (tide-hl-identifier-mode +1))))

    (add-hook 'typescript-mode-hook #'my/setup-tide-mode)
    (add-hook 'js-mode-hook #'my/setup-tide-mode)))
