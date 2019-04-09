(use-package org
  :config
  (progn
    (setq org-src-fontify-natively t)
    (setq org-time-clocksum-format '(:hours "%d" :require-hours t :minutes ":%02d" :require-minutes t))
    (setq org-adapt-indentation nil)
    (setq org-html-validation-link nil)
    (setq org-todo-keywords '((sequence "TODO" "WIP" "|" "DONE")))
    (define-key org-mode-map (kbd "C-,") nil)

    (add-hook 'org-mode-hook #'toggle-truncate-lines)
    (add-hook 'org-mode-hook #'company-mode)
    (add-hook 'org-mode-hook #'flyspell-mode)
    (add-hook 'org-mode-hook #'hl-line-mode)
    (add-hook 'org-mode-hook #'subword-mode)))

;; (use-package org-bullets
;;   :pin melpa-stable
;;   :ensure t
;;   :defer t
;;   :init
;;   (progn
;;     (add-hook 'org-mode-hook #'org-bullets-mode)))

;; (use-package org-cua-dwim
;;   :pin melpa
;;   :ensure t
;;   :config
;;   (org-cua-dwim-activate))
