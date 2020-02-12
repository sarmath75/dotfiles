(defun my/comment-or-uncomment-clojure-sexp ()
  (interactive)
  (save-excursion
    (sp-forward-sexp)
    (sp-backward-sexp)
    (insert "#_")))

(defun my/insert-spyscope-debug ()
  (interactive)
  (save-excursion
    (sp-forward-sexp)
    (sp-backward-sexp)
    (insert "#spy/p ")))

(defun my/lein-cljx-auto ()
  "Runs 'lein cljx auto' from project's root"
  (interactive)
  (projectile-with-default-dir (projectile-project-root)
    (let ((buffer-name "*lein cljx auto*"))
      (shell buffer-name)
      (switch-to-buffer buffer-name)
      (process-send-string (current-buffer) "lein cljx auto\n"))))

(defun my/lein-cljsbuild-auto ()
  "Run 'lein cljsbuild auto' from project's root"
  (interactive)
  (projectile-with-default-dir (projectile-project-root)
    (let ((buffer-name "*lein cljsbuild auto*"))
      (shell buffer-name)
      (switch-to-buffer buffer-name)
      (process-send-string (current-buffer) "lein cljsbuild auto\n"))))

(defun my/lein-figwheel ()
  "Run 'lein figwheel' from project's root"
  (interactive)
  (projectile-with-default-dir (projectile-project-root)
    (let ((buffer-name "*lein figwheel*"))
      (shell buffer-name)
      (switch-to-buffer buffer-name)
      (process-send-string (current-buffer) "lein figwheel\n"))))

(defun my/lein-garden-auto ()
  "Runs 'lein garden auto' from project's root"
  (interactive)
  (projectile-with-default-dir (projectile-project-root)
    (let ((buffer-name "*lein garden auto*"))
      (shell buffer-name)
      (switch-to-buffer buffer-name)
      (process-send-string (current-buffer) "lein garden auto\n"))))

(defun my/lein-pdo ()
  "Runs 'lein cljx once; lein pdo cljx auto, figwheel' from project's root"
  (interactive)
  (projectile-with-default-dir (projectile-project-root)
    (let ((buffer-name "*lein figwheel*"))
      (shell buffer-name)
      (switch-to-buffer buffer-name)
      (process-send-string (current-buffer) "lein cljx once; lein pdo cljx auto, figwheel\n"))))

(defun my/lein-test-refresh ()
  "Runs 'lein test-refresh' from project's root"
  (interactive)
  (projectile-with-default-dir (projectile-project-root)
    (let ((buffer-name "*lein test-refresh*"))
      (shell buffer-name)
      (switch-to-buffer buffer-name)
      (process-send-string (current-buffer) "lein test-refresh\n"))))

(defun my/cider-jack-in ()
  "Display nREPL buffer in the bottom left window."
  (interactive)
  (let ((target-window (window-at 0 (- (frame-height) 4))))
    (let ((new-window (split-window target-window -16 'below)))
      (select-window new-window)
      (cider-jack-in))))

(defun my/cider-pprint-eval-last-sexp ()
  "Evaluate the sexp preceding point and pprint its value in a popup buffer."
  (interactive)
  (let* ((sexp (cider-last-sexp)))
    (switch-to-buffer cider-result-buffer)
    (cider--pprint-eval-form sexp)))

(defun my/cider-eval-lint ()
  (interactive)
  (switch-to-buffer cider-result-buffer)
  (let* ((form "(do (clojure.core/require 'repl) (repl/lint))")
         (result-buffer (cider-popup-buffer cider-result-buffer nil 'compilation-mode))
         (handler (cider-popup-eval-out-handler result-buffer))
         (right-margin (max fill-column
                            (1- (window-width (get-buffer-window result-buffer))))))
    (cider-interactive-pprint-eval form handler right-margin)))

(defun my/cider-eval-refresh ()
  (interactive)
  (nrepl-request:eval
   "(do (clojure.core/require 'repl) (repl/refresh))"
   (cider-interactive-eval-handler)
   (cider-current-connection)))

(defun my/cider-eval-restart ()
  (interactive)
  (nrepl-request:eval
   "(do (clojure.core/require 'repl) (repl/restart))"
   (cider-interactive-eval-handler)
   (cider-current-connection)))

(defun my/cider-eval-run-tests ()
  (interactive)
  ;; (switch-to-buffer cider-result-buffer)
  (cider--pprint-eval-form "(do (clojure.core/require 'repl) (repl/run-tests))"))

(defun my/cider-eval-run-current-mini-buffer ()
  (interactive)
  (cider-eval
   "(do (clojure.core/require 'repl) (repl/run-current))"
   (cider-interactive-eval-handler)))

(defun my/cider-eval-run-current-temp-buffer ()
  (interactive)
  (switch-to-buffer cider-result-buffer)
  (cider--pprint-eval-form "(do (clojure.core/require 'repl) (repl/run-current))"))

(use-package clojure-mode
  :pin melpa-stable
  :ensure t
  :config
  (progn
    (define-clojure-indent
      ;; clojure, clojurescript
      (defrecord 'defun)
      (this-as 'defun)
      (try-let 'defun)
      ;; clojure.core.match
      (match 'defun)
      ;; clojure.spec
      (fdef 'defun)
      ;; com.palletops.leaven
      (start 'defun)
      (stop 'defun)
      ;; prismatic.plumbing
      (fnk 'defun)
      (letk 'defun)
      ;; pallet.thread-expr
      (when-> 'defun)
      ;; clojure.jdbc
      (db-do-commands 'defun)
      (query 'defun)
      (execute! 'defun)
      (insert! 'defun)
      (select 'defun)
      (update! 'defun)
      (delete! 'defun)
      ;; sqlingvo
      (insert 'defun)
      (select 'defun)
      (update 'defun)
      (delete 'defun)
      ;; om
      (init-state 'defun)
      (will-mount 'defun)
      (did-mount 'defun)
      (should-update 'defun)
      (render 'defun)
      (render-state 'defun)
      ;; dom
      (header 'defun)
      (footer 'defun)
      (article 'defun)
      (section 'defun)
      (div 'defun)
      (p 'defun)
      (span 'defun)
      (ul 'defun)
      (li 'defun)
      (table 'defun)
      (tr 'defun)
      (td 'defun)
      (form 'defun)
      (button 'defun)
      ;; bootstrap
      (navbar 'defun)
      (nav 'defun)
      (nav-item 'defun)
      (dropdown 'defun)
      (dropdown-button 'defun)
      (menu-item 'defun))

    (font-lock-add-keywords 'clojure-mode
                            '(("try-let" . font-lock-keyword-face)))

    (add-hook 'clojure-mode-hook 'linum-mode)
    (add-hook 'clojure-mode-hook 'auto-highlight-symbol-mode)
    (add-hook 'clojure-mode-hook 'toggle-truncate-lines)
    (add-hook 'clojure-mode-hook 'smartparens-strict-mode)
    (add-hook 'clojure-mode-hook 'show-paren-mode)
    (add-hook 'clojure-mode-hook 'eldoc-mode)
    (add-hook 'clojure-mode-hook 'company-mode)
    (add-hook 'clojure-mode-hook 'aggressive-indent-mode)
    (add-hook 'clojure-mode-hook 'flyspell-prog-mode)
    (add-hook 'clojure-mode-hook 'subword-mode))
  :bind
  (:map clojure-mode-map
        ("M-." . my/find-tag-without-ns)
        ("C-M-;" . my/comment-or-uncomment-clojure-sexp)
        ("C-M-'" . my/insert-spyscope-debug)
        ("C-c r'" . cljr-helm)))

;; (use-package clj-refactor
;;   :pin melpa-stable
;;   :ensure t
;;   :config
;;   (progn
;;     (cljr-add-keybindings-with-prefix "M-m r")
;;     (add-hook 'clojure-mode-hook 'clj-refactor-mode)))

;; cider
(use-package cider
  :pin melpa-stable
  :ensure t
  :config
  ;; (setq nrepl-hide-special-buffers t)
  (setq cider-show-error-buffer nil)
  (setq cider-repl-history-file (expand-file-name "~/.emacs.d/cider-repl-history"))
  (setq cider-auto-select-error-buffer t)
  (setq cider-repl-display-in-current-window t)
  (setq nrepl-buffer-name-show-port t)
  (setq cider-prompt-for-symbol nil)
  (setq cider-prompt-save-file-on-load nil)
  (setq nrepl-log-messages t)
  (setq cider-cljs-lein-repl "(do (use 'figwheel-sidecar.repl-api) (start-figwheel!) (cljs-repl))")

  (add-hook 'cider-mode-hook
            '(lambda ()
               (eldoc-mode t)))

  (add-hook 'cider-repl-mode-hook
            '(lambda ()
               (toggle-truncate-lines 0)
               (show-paren-mode 1)
               (subword-mode 1)))

  (add-hook 'cider-docview-mode-hook
            '(lambda ()
               (my/toggle-truncate-lines -1)))

  (add-hook 'cider-test-report-mode-hook
            '(lambda ()
               (my/toggle-truncate-lines -1)))

  (add-hook 'cider-popup-buffer-mode-hook
            '(lambda ()
               (my/toggle-truncate-lines -1)))
  :bind
  ((:map cider-mode-map
         ("C-c C-p" . my/cider-pprint-eval-last-sexp)
         ("C-c C-p" . cider-pprint-eval-last-sexp)
         ;; ([?\C-.] . cider-jump-to-compilation-error)
         ("<f11>" . my/cider-eval-refresh)
         ("<C-f11>" . my/cider-eval-run-tests)
         ("<M-f11>" . my/cider-eval-run-current-temp-buffer)
         ("<S-f11>" . my/cider-eval-restart)
         ("M-m x" . my/cider-eval-run-tests)
         ;; ("C-c M-x" . my/cider-eval-run-current-temp-buffer)
         ;; ("<M-S-f11>" . my/cider-eval-run-current-mini-buffer)
         ;; ("C-c C-m" . my/cider-eval-lint)
         ("C-c C-m" . cider-macroexpand-1))
   (:map cider-repl-mode-map
         ([?\C-.] . cider-jump-to-compilation-error)
         ("<f11>" . my/cider-eval-refresh)
         ("<C-f11>" . my/cider-eval-run-tests)
         ("<M-f11>" . my/cider-eval-run-current-temp-buffer)
         ("<S-f11>" . my/cider-eval-restart)
         ;; ("<M-S-f11>" . my/cider-eval-run-current-mini-buffer)
         ;; ("C-c C-m" . my/cider-eval-lint)
         ("C-c C-m" 'cider-macroexpand-1))))

(use-package clojure-snippets
  :pin melpa-stable
  :ensure t)
