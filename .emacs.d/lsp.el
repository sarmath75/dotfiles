(use-package lsp-mode
  :ensure t
  :pin melpa-stable
  :config
  (progn
    (require 'lsp-imenu)
    (add-hook 'lsp-after-open-hook 'lsp-enable-imenu)

    ;; NB: only required if you prefer flake8 instead of the default
    ;; send pyls config via lsp-after-initialize-hook -- harmless for
    ;; other servers due to pyls key, but would prefer only sending this
    ;; when pyls gets initialised (:initialize function in
    ;; lsp-define-stdio-client is invoked too early (before server
    ;; start)) -- cpbotha
    ;; (defun lsp-set-cfg ()
    ;;   (let ((lsp-cfg `(:pyls (:configurationSources ("flake8")))))
    ;;     ;; TODO: check lsp--cur-workspace here to decide per server / project
    ;;     (lsp--set-configuration lsp-cfg)))

    (add-hook 'lsp-after-initialize-hook 'lsp-set-cfg)))

(use-package lsp-ui
  :ensure t
  :pin melpa
  :after (:all lsp-mode)
  :config
  (progn
    (setq lsp-ui-sideline-ignore-duplicate t)
    (add-hook 'lsp-mode-hook 'lsp-ui-mode)))

(use-package company-lsp
  :ensure t
  :pin melpa-stable
  :after (:all company lsp-mode)
  :config
  (progn
    ;; (add-hook 'lsp-mode-hook
    ;;           (lambda ()
    ;;             (add-to-list (make-local-variable 'company-backends)
    ;;                          '(company-lsp company-dabbrev-code))))
    ))
