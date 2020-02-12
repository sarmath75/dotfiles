(use-package haskell-mode
  :pin melpa-stable
  :defer t
  :ensure t
  :bind
  (:map haskell-mode-map
        ("M-g i" . haskell-navigate-imports)
        ("M-g M-i" . haskell-navigate-imports))
  :config
  (progn
    (define-key haskell-mode-map (kbd "C-h d") #'hoogle)
    ;; (setq haskell-compile-cabal-build-alt-command
    ;;       "cd %s && stack clean && stack build --ghc-options -ferror-spans"
    ;;       haskell-compile-cabal-build-command
    ;;       "cd %s && stack build --ghc-options -ferror-spans"
    ;;       haskell-compile-command
    ;;       "stack ghc -- -Wall -ferror-spans -fforce-recomp -c %s")
    (add-hook 'haskell-mode-hook 'auto-highlight-symbol-mode)
    (add-hook 'haskell-mode-hook 'eldoc-mode)
    (add-hook 'haskell-mode-hook 'flycheck-mode)
    (add-hook 'haskell-mode-hook 'flyspell-prog-mode)
    (add-hook 'haskell-mode-hook 'haskell-decl-scan-mode)
    ;; (add-hook 'haskell-mode-hook 'haskell-indent-mode)
    (add-hook 'haskell-mode-hook 'haskell-indentation-mode)
    (add-hook 'haskell-mode-hook 'hl-line-mode)
    (add-hook 'haskell-mode-hook 'linum-mode)
    (add-hook 'haskell-mode-hook 'my/toggle-truncate-lines)
    (add-hook 'haskell-mode-hook 'show-paren-mode)
    (add-hook 'haskell-mode-hook 'smartparens-strict-mode)
    ;; (add-hook 'haskell-mode-hook 'structured-haskell-mode)
    (add-hook 'haskell-mode-hook 'subword-mode)

    (add-hook 'haskell-cabal-mode-hook 'auto-highlight-symbol-mode)
    (add-hook 'haskell-cabal-mode-hook 'flyspell-prog-mode)
    (add-hook 'haskell-cabal-mode-hook 'hl-line-mode)
    (add-hook 'haskell-cabal-mode-hook 'linum-mode)
    (add-hook 'haskell-cabal-mode-hook 'my/toggle-truncate-lines)
    (add-hook 'haskell-cabal-mode-hook 'show-paren-mode)
    (add-hook 'haskell-cabal-mode-hook 'smartparens-strict-mode)
    (add-hook 'haskell-cabal-mode-hook 'subword-mode)

    (with-eval-after-load 'smartparens
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
      (add-to-list 'sp-no-reindent-after-kill-modes 'haskell-mode))))

(use-package intero
  :pin melpa-stable
  ;; :defer t
  :ensure t
  :after (:all haskell-mode)
  :bind
  (:map intero-mode-map
        ("M-." . my/intero-goto-definition))
  ;; :init
  ;; (progn
  ;;   (intero-global-mode 1))
  :config
  (progn
    ;; (defun my/intero-enable ()
    ;;   "Enable Intero unless visiting a cached dependency."
    ;;   (if (and buffer-file-name (string-match ".+/\\.\\(stack\\|stack-work\\)/.+" buffer-file-name))
    ;;       (progn
    ;;         (eldoc-mode -1)
    ;;         (flycheck-mode -1)
    ;;         (flyspell-prog-mode -1)
    ;;         (structured-haskell-mode -1))
    ;;     (intero-mode)))
    (defun my/intero-goto-definition ()
      "Jump to the definition of the thing at point using Intero or etags."
      (interactive)
      (or (intero-goto-definition)
          (xref-find-definitions (find-tag-default))))

    ;; (add-to-list 'intero-blacklist (expand-file-name "/"))
    ;; (add-to-list 'intero-whitelist (expand-file-name "~/Projects/MISC/solo"))
    ;; (add-hook 'haskell-mode-hook #'my/intero-enable)
    (add-hook 'haskell-mode-hook 'intero-mode)
    (flycheck-add-next-checker 'intero '(warning . haskell-hlint))
    (add-hook 'intero-mode-hook
              (lambda ()
                (add-to-list (make-local-variable 'company-backends)
                             '(intero-company :with company-dabbrev-code))))))

(use-package shm
  :pin melpa-stable
  :defer t
  :ensure t
  :config
  (progn
    (set-face-background 'shm-current-face "#eee8d5")
    (set-face-background 'shm-quarantine-face "lemonchiffon")))

(use-package haskell-snippets
  :pin melpa-stable
  :defer t
  :ensure t)
