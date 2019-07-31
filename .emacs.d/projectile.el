(use-package projectile
  :pin melpa-stable
  :ensure t
  :demand t
  :init
  (progn
    (setq projectile-keymap-prefix (kbd "M-m p"))
    (projectile-global-mode)
    :config
    (setq projectile-enable-idle-timer t)
    ;; follow symlinks
    ;; (setq projectile-generic-command "find -L . -type f -print0")
    ;; (setq projectile-indexing-method 'native)
    ;; (setq projectile-enable-caching nil)
    ;; (add-to-list 'projectile-ignored-projects (expand-file-name "~/.stack"))
    ;; (setq projectile-tags-command "/usr/bin/ctags-exuberant -Re -f \"%s\" %s")

    (setq projectile-test-suffix-function
          (lambda (project-type)
            (cond
             ((member project-type '(haskell-cabal haskell-stack)) "Test")
             ((member project-type '(purescript)) "Spec")
             ((member project-type '(sbt)) "Spec")
             (t (projectile-test-suffix project-type))))))
  :bind
  (:map projectile-mode-map
        ("M-m M-%" . projectile-replace-regexp)
        ("M-g t" . projectile-toggle-between-implementation-and-test)
        ("M-m x". projectile-test-project)
        ("M-m C-x". projectile-test-project)
        ("M-m M-x". projectile-test-project)))

(use-package helm-projectile
  :pin melpa-stable
  :ensure t
  :after (:all helm projectile)
  :demand t
  :config
  (progn
    (helm-projectile-on)

    (define-key projectile-mode-map (kbd "M-g e") 'helm-projectile-recentf)
    (cond ((eq system-type 'darwin)
           (define-key projectile-mode-map (kbd "M-m g") 'helm-projectile-grep))
          ((eq system-type 'windows-nt)
           (define-key projectile-mode-map (kbd "M-m g") 'helm-projectile-grep))
          (t
           (define-key projectile-mode-map (kbd "M-m g") 'helm-projectile-ag)))))
