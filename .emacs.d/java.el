(defun my/javadoc-completing-read ()
  "Query the user for a class name."
  (unless (jdl/core-indexed-p)
    (ignore-errors
      (jdl/web "http://docs.oracle.com/javase/8/docs/api/")))
  (let* ((default (thing-at-point 'symbol))
         (default (if (s-ends-with? "." default)
                      (s-left (- (length default) 1) default)
                    default))
         (classes (jdl/get-class-list)))
    (funcall javadoc-lookup-completing-read-function "Class: "
             classes nil nil nil nil
             (and default (cl-find default classes :test #'string-match)))))

(defun my/javadoc-lookup (name)
  "Lookup based on class name."
  (interactive (list (my/javadoc-completing-read)))
  (let ((file (apply #'concat (reverse (gethash name jdl/index)))))
    (when file (browse-url file))))

;; (use-package meghanada
;;   :ensure t
;;   :config
;;   (add-hook 'java-mode-hook 'meghanada-mode)
;;   (add-hook 'before-save-hook 'meghanada-code-beautify-before-save)
;;   ;; (add-to-list 'completion-styles 'substring nil)
;;   ;; (add-to-list 'completion-styles 'initials nil)
;;   )

;; eclim
;; (add-to-list 'load-path (expand-file-name "~/.opt/emacs-eclim"))
;; (require 'eclim)
;; (with-eval-after-load "eclim"
;;   (add-to-list 'eclim-eclipse-dirs (expand-file-name "~/.opt/eclipse"))
;;   (setq eclim-executable (expand-file-name "~/.opt/eclipse/eclim"))

;;   (defun my/eclim-problems-open-current-same-window ()
;;     (interactive)
;;     (eclim-problems-open-current t))

;;   (define-key eclim-mode-map (kbd "M-.") 'eclim-java-find-declaration)
;;   (define-key eclim-mode-map (kbd "M-n") 'eclim-problems-next-same-file)
;;   (define-key eclim-mode-map (kbd "M-p") 'eclim-problems-prev-same-file)
;;   (define-key eclim-mode-map (kbd "C-c C-x") 'eclim-java-run-run)
;;   (define-key eclim-mode-map (kbd "C-c C-f") 'eclim-problems-correct)
;;   (define-key eclim-problems-mode-map (kbd "RET") 'my/eclim-problems-open-current-same-window)

;;   (global-eclim-mode t)

;;   (require 'eclimd)

;;   (require 'company-emacs-eclim)
;;   (company-emacs-eclim-setup))

;; (with-eval-after-load "eclimd"
;;   (setq eclimd-executable (expand-file-name "~/.opt/eclipse/eclimd")))

;; (add-hook 'before-save-hook
;;           (lambda ()
;;             (when (bound-and-true-p eclim-mode)
;;               (progn
;;                 (setq eclim-auto-save nil)
;;                 (eclim-java-import-organize)
;;                 (eclim-java-format)
;;                 (setq eclim-auto-save t)))))

(with-eval-after-load "cc-mode"
  (add-hook 'java-mode-hook
            (lambda ()
              (progn
                (my/toggle-truncate-lines 1)
                (linum-mode 1)
                (auto-highlight-symbol-mode 1)
                (subword-mode 1)
                (smartparens-strict-mode 1)
                (show-paren-mode 1)
                (eldoc-mode 1)
                (company-mode 1)
                (flyspell-prog-mode)))))

;; (require 'javadoc-lookup)
(use-package javadoc-lookup
  :pin melpa
  :ensure t
  :config
  (javadoc-add-roots (expand-file-name "/usr/lib/jvm/default-java/docs/api/")
                     ;; (expand-file-name "~/.opt/docs.datomic.com/javadoc/")
                     )

  (javadoc-add-artifacts [org.springframework spring-aop "4.3.2.RELEASE"]
                         [org.springframework spring-aspects "4.3.2.RELEASE"]
                         [org.springframework spring-beans "4.3.2.RELEASE"]
                         [org.springframework spring-context "4.3.2.RELEASE"]
                         [org.springframework spring-core "4.3.2.RELEASE"]
                         [org.springframework spring-expression "4.3.2.RELEASE"]
                         [org.springframework spring-jdbc "4.3.2.RELEASE"]
                         [org.springframework spring-orm "4.3.2.RELEASE"]
                         [org.springframework spring-test "4.3.2.RELEASE"]
                         [org.springframework spring-tx "4.3.2.RELEASE"]
                         [org.springframework spring-web "4.3.2.RELEASE"]
                         [org.springframework spring-webmvc "4.3.2.RELEASE"])

  (javadoc-add-artifacts [org.springframework.boot spring-boot "1.4.0.RELEASE"]
                         [org.springframework.boot spring-boot-test "1.4.0.RELEASE"])

  (javadoc-add-artifacts [org.springframework.data spring-data-jpa "1.5.2.RELEASE"])

  (javadoc-add-artifacts [com.cognitect transit-java "0.8.313"] ;
                         [com.google.guava guava "19.0"]
                         [com.mchange c3p0 "0.9.5-pre4"]
                         [commons-io commons-io "2.5"]
                         [org.slf4j slf4j-api "1.7.20"])


  (javadoc-add-artifacts [org.clojure clojure "1.9.0-alpha13"])

  (global-set-key (kbd "C-h j") 'my/javadoc-lookup))




;; https://www.reddit.com/r/emacs/comments/9xofz6/does_emacs_is_suitable_for_working_with/e9v55b9
;; (use-package lsp-mode
;;   :defer t
;;   :ensure t
;;   :init (setq lsp-inhibit-message t
;;               lsp-eldoc-render-all nil
;;               lsp-highlight-symbol-at-point nil))

;; (use-package company-lsp
;;   :after  lsp-mode
;;   :ensure t
;;   :config
;;   (add-hook 'java-mode-hook
;;             (lambda () (push 'company-lsp company-backends)))
;;   (setq company-lsp-enable-snippet t
;;         company-lsp-cache-candidates t))

;; (use-package lsp-ui
;;   :ensure t
;;   :after lsp-mode
;;   :preface
;;   (defun lsp-ui-display-doc ()
;;     "A command to issue document view requests."
;;     (interactive)
;;     (require 'markdown-mode)
;;     (lsp--send-request-async
;;      (lsp--make-request "textDocument/hover" (lsp--text-document-position-params))
;;      (lambda (hover)
;;        (popup-tip (replace-regexp-in-string markdown-regex-link-inline
;;                                             "\\3"
;;                                             (lsp-ui-doc--extract (gethash "contents" hover))
;;                                             t
;;                                             nil)
;;                   :nostrip t
;;                   :height 100))))
;;   :config
;;   (setq lsp-ui-sideline-enable nil
;;         lsp-ui-sideline-show-symbol nil
;;         lsp-ui-sideline-show-hover nil
;;         lsp-ui-sideline-show-code-actions nil
;;         lsp-ui-sideline-update-mode 'point))

;; (use-package lsp-java
;;   :after lsp-mode
;;   :ensure t
;;   :commands lsp-java-enable
;;   :init
;;   (add-hook 'java-mode-hook (lambda ()
;;                               (flycheck-mode +1)
;;                               (lsp-java-enable)
;;                               (lsp-ui-flycheck-enable t)
;;                               (lsp-ui-sideline-mode)))
;;   :config
;;   (setq lsp-java-server-install-dir
;;         (expand-file-name "~/.local/eclips.jdt.ls/server/")
;;         lsp-java-workspace-dir
;;         (expand-file-name "~/code/eclipse.jdt.ls/"))

;;   ;; Do not organize imports on file save
;;   (setq lsp-java-save-action-organize-imports nil)

;;   (when (not (file-exists-p lsp-java-server-install-dir))
;;     ;; Install Eclipse JDT server
;;     (message "Installing JDT server for emacs!")
;;     (async-shell-command
;;      (format (concat "mkdir -p %s;"
;;                      "wget http://download.eclipse.org/jdtls/snapshots/jdt-language-server-latest.tar.gz -O /tmp/jdt-latest.tar;"
;;                      "tar xf /tmp/jdt-latest.tar -C %s;")
;;              lsp-java-server-install-dir
;;              lsp-java-server-install-dir))))
