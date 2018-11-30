(use-package magit
  :pin melpa-stable
  :ensure t
  :config
  (progn
    (setq-default magit-commit-show-diff nil)
    ;; (setq-default magit-diff-section-arguments '("--ignore-all-space" "--no-ext-diff"))
    ;; (setq magit-display-buffer-function 'magit-display-buffer-traditional)
    ;; (setq magit-display-buffer-function 'magit-display-buffer-same-window-except-diff-v1)
    )
  :bind
  (:map ctl-x-map
        ("v" . magit-status)))

;; (use-package magit-popup
;;   :pin melpa-stable
;;   :after (:all magit))

;; (use-package git-commit
;;   :pin melpa-stable
;;   :ensure t
;;   :after (:all magit))

;; (use-package git-gutter
;;   :pin melpa-stable
;;   :ensure t
;;   :after (:all magit)
;;   :config
;;   (progn
;;     (global-git-gutter-mode t)
;;     (git-gutter:linum-setup)
;;     (setq git-gutter:update-interval 2)
;;     (setq git-gutter:visual-line t)))

;; (use-package magithub
;;   :pin melpa-stable
;;   :ensure t
;;   :after (:all magit)
;;   :config
;;   (progn
;;     (magithub-feature-autoinject t)))
