(defun my/sbt ()
  "Runs 'sbt' from project's root"
  (interactive)
  (projectile-with-default-dir (projectile-project-root)
    (let ((buffer-name "*sbt*"))
      (shell buffer-name)
      (switch-to-buffer buffer-name)
      (process-send-string (current-buffer) "sbt\n"))))

(use-package "scala-mode"
  :pin melpa-stable
  :ensure t
  :config
  ;; (setq scala-indent:default-run-on-strategy scala-indent:eager-strategy)
  (setq scala-indent:default-run-on-strategy scala-indent:reluctant-strategy)
  ;; (setq scala-indent:align-forms t)
  (setq scala-indent:align-parameters t)
  (add-hook 'scala-mode-hook 'linum-mode)
  (add-hook 'scala-mode-hook 'hl-line-mode)
  (add-hook 'scala-mode-hook 'my/toggle-truncate-lines)
  (add-hook 'scala-mode-hook 'auto-highlight-symbol-mode)
  (add-hook 'scala-mode-hook 'subword-mode)
  (add-hook 'scala-mode-hook 'smartparens-strict-mode)
  (add-hook 'scala-mode-hook 'show-paren-mode)
  (add-hook 'scala-mode-hook 'eldoc-mode)
  (add-hook 'scala-mode-hook
            (lambda ()
              (progn
                (setq-local company-minimum-prefix-length 0)
                (company-mode 1))))
  (add-hook 'scala-mode-hook 'flyspell-mode))

(use-package sbt-mode
  :pin melpa-stable
  :ensure t)
