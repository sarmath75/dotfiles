(use-package purescript-mode
  :pin melpa
  :ensure t
  :after (:all smartparens)
  :defer t
  :config
  (progn
    (add-hook 'purescript-mode-hook 'auto-highlight-symbol-mode)
    (add-hook 'purescript-mode-hook 'hl-line-mode)
    (add-hook 'purescript-mode-hook 'linum-mode)
    (add-hook 'purescript-mode-hook 'my/toggle-truncate-lines)
    (add-hook 'purescript-mode-hook 'show-paren-mode)
    (add-hook 'purescript-mode-hook 'smartparens-strict-mode)
    (add-hook 'purescript-mode-hook 'subword-mode)
    (add-hook 'purescript-mode-hook 'flyspell-prog-mode)
    (add-hook 'purescript-mode-hook 'turn-on-purescript-decl-scan)
    (add-hook 'purescript-mode-hook 'turn-on-purescript-simple-indent)
    ;; (progn
    ;;   ;; (setq purescript-indent-offset 2)
    ;;   ;; (setq purescript-indent-rpurs-align-column 2)
    ;;   ;; (setq purescript-indent-look-past-empty-line nil)
    ;;   (add-hook 'purescript-mode-hook 'turn-on-purescript-indent))
    ;; (progn
    ;;   (setq purescript-indentation-delete-backward-jump-line t)
    ;;   ;; (setq purescript-indentation-starter-offset 2)
    ;;   (add-hook 'purescript-mode-hook 'turn-on-purescript-indentation))
    (add-hook 'purescript-mode-hook
              (lambda ()
                (electric-indent-local-mode -1)))
    ;; (add-hook 'purescript-mode-hook
    ;;           (lambda ()
    ;;             (setq (make-local-variable 'compilation-read-command) nil)))

    (sp-with-modes '(purescript-mode)
      (sp-local-pair "'" nil :actions nil)
      (sp-local-pair "`" "'" :when '(sp-in-string-p sp-in-comment-p))
      (sp-local-pair "`"
                     nil
                     :skip-match (lambda (ms mb me)
                                   (cond
                                    ((equal ms "'")
                                     (or (sp--org-skip-markup ms mb me)
                                         (not (sp-point-in-string-or-comment))))
                                    (t (not (sp-point-in-string-or-comment)))))))
    (add-to-list 'sp-no-reindent-after-kill-modes 'purescript-mode))
  :bind
  (:map purescript-mode-map
        ("RET" . my/newline-and-indent-relative)
        ("C-o" . my/open-line-and-indent-relative)
        ("C-S-i" . purescript-simple-indent-backtab)
        ("C-c C-c" . purescript-compile)))

(use-package psc-ide
  :pin melpa
  :ensure t
  :after (:all purescript-mode)
  :defer t
  :config
  (progn
    (defun my/psc-ide-rebuild ()
      (interactive)
      (psc-ide-rebuild)
      (pop-to-buffer (get-buffer "*psc-ide-rebuild*")))

    (add-hook 'purescript-mode-hook 'psc-ide-mode)
    (add-hook 'purescript-mode-hook 'company-mode)
    (add-hook 'purescript-mode-hook 'eldoc-mode)
    (add-hook 'purescript-mode-hook 'flycheck-mode)
    (add-hook 'purescript-mode-hook
              (lambda ()
                (add-to-list (make-local-variable 'company-backends)
                             '(company-psc-ide-backend :with company-dabbrev)))))
  :bind
  (:map psc-ide-mode-map
        ("C-c M-j" . psc-ide-server-start)
        ("C-c C-k" . psc-ide-load-module)
        ([remap psc-ide-rebuild] . my/psc-ide-rebuild)))
