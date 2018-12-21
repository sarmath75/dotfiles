(use-package helm
  :pin melpa-stable
  :ensure t
  :demand t
  :init
  (progn
    (require 'helm-config))
  :config
  (progn
    (setq helm-split-window-in-side-p t)
    ;; (setq helm-move-to-line-cycle-in-source t)
    (setq helm-ff-search-library-in-sexp t)
    (setq helm-scroll-amount 8)
    (setq helm-ff-file-name-history-use-recentf t)
    (setq helm-apropos-fuzzy-match t)
    (setq helm-buffers-fuzzy-matching t)
    (setq helm-locate-fuzzy-match t)
    (setq helm-recentf-fuzzy-match t)
    (setq helm-M-x-fuzzy-match t)
    (setq helm-semantic-fuzzy-match t)
    (setq helm-imenu-fuzzy-match t)
    (setq helm-lisp-fuzzy-completion t)

    (setq helm-mini-default-sources
          '(helm-source-buffers-list
            helm-source-bookmarks
            helm-source-recentf
            helm-source-buffer-not-found))

    (setq helm-grep-default-command "grep --color=never -a -d skip %e -n%cH -e %p %f %c")
    (setq helm-grep-default-recurse-command "grep --color=never -a -d skip %e -n%cH -e %p %f %c")

    ;; (global-set-key (kbd "C-c h") 'helm-command-prefix)
    ;; (global-set-key (kbd "C-c h g") 'helm-google-suggest)
    ;; (global-set-key (kbd "C-c h o") 'helm-occur)
    ;; (global-set-key (kbd "C-c h x") 'helm-register)
    (global-set-key (kbd "C-h SPC") 'helm-all-mark-rings)
    (global-set-key (kbd "C-h C-r") 'helm-resume)
    (global-set-key (kbd "C-x C-b") 'helm-buffers-list)
    (global-set-key (kbd "C-x b") 'helm-buffers-list)
    (global-set-key (kbd "C-x f") 'helm-mini)
    (global-set-key (kbd "C-x C-f") 'helm-find-files)
    (global-set-key (kbd "C-x M-f") 'helm-projectile-find-file)
    ;; (global-set-key (kbd "C-x M-f") 'helm-projectile-find-file-dwim)
    (global-set-key (kbd "M-v") 'helm-show-kill-ring)
    (global-set-key (kbd "M-x") 'helm-M-x)
    (global-set-key (kbd "C-c C-h c") 'helm-flycheck)

    ;; rebind tab to run persistent action
    (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)
    (define-key helm-map (kbd "C-i") 'helm-execute-persistent-action)
    ;; list actions using C-z
    (define-key helm-map (kbd "C-z") 'helm-select-action)
    (define-key helm-map (kbd "C-v") 'cua-paste)
    (define-key helm-map (kbd "M-v") 'helm-show-kill-ring)

    ;; (define-key company-mode-map (kbd "C-SPC") 'helm-company)
    ;; (define-key company-active-map (kbd "C-SPC") 'helm-company)
    (helm-mode 1)))

(use-package helm-ag
  :pin melpa-stable
  :ensure t
  :after (:all helm))

(use-package helm-descbinds
  :pin melpa-stable
  :ensure t
  :after (:all helm)
  :bind
  (("C-h b" . helm-descbinds)
   ("C-h w" . helm-descbinds)))

(use-package helm-swoop
  :pin melpa-stable
  :ensure t
  :after (:all helm)
  :config
  (progn
    (setq helm-swoop-split-with-multiple-windows t)
    (setq helm-swoop-split-direction 'split-window-vertically)
    (setq helm-swoop-move-to-line-cycle t))
  :bind
  (("M-i" . helm-swoop)))
