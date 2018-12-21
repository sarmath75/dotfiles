(use-package shell
  :after (:all helm projectile)
  :config
  (progn
    (defun my/shell-at-arbitrary-dir (dir)
      (interactive "DDirectory:")
      (let ((default-directory dir))
        (call-interactively 'shell)))

    (defun my/shell-at-project-dir ()
      "Run shell from project's root directory."
      (interactive)
      (projectile-with-default-dir (projectile-project-root)
        (call-interactively 'shell)))

    (if (eq system-type 'windows-nt)
        (progn
          ;; (defun my/cygwin-shell-setup ()
          ;;   "For Cygwin bash under Emacs 20"
          ;;   (setq comint-scroll-show-maximum-output 'this)
          ;;   (make-variable-buffer-local 'comint-completion-addsuffix))

          ;; (setq comint-completion-addsuffix t)
          ;; (setq comint-eol-on-send t)
          ;; (setq w32-quote-process-args ?\")

          ;; (add-hook 'shell-mode-hook 'my-shell-setup)

          (setq shell-file-name (expand-file-name "~/.local/opt/cygwin/bin/bash.exe"))
          (setq explicit-shell-file-name shell-file-name)
          (setq explicit-bash-args '("--noediting" "-i"))

          ;; (setenv "PATH"
          ;; 	      (concat ""
          ;; 		      (replace-regexp-in-string " "
          ;; 						"\\\\ "
          ;; 						(replace-regexp-in-string "\\\\"
          ;; 									  "/"
          ;; 									  (replace-regexp-in-string "\\([A-Za-z]\\):"
          ;; 												    "/\\1"
          ;; 												    (getenv "PATH"))))))
          ;; "--noediting" option prevents interference with the GNU readline library
          ;; "-i" option specifies that the shell is interactive
          ;; (setq find-program (expand-file-name "~/.opt/cygwin/bin/find.exe"))
          ))
    (setq comint-prompt-read-only t)
    (setq comint-scroll-to-bottom-on-input t)
    (setq comint-scroll-to-bottom-on-output nil)
    (setq comint-scroll-show-maximum-output t)
    (setq comint-input-ignoredups t)
    (setq comint-buffer-maximum-size 256)
    (setq comint-get-old-input
          (lambda () ""))

    (let* ((dir-name (expand-file-name "~/.local/opt/helm-shell-history")))
      (when (file-directory-p dir-name)
        (add-to-list 'load-path dir-name)
        (require 'helm-shell-history)
        (setq-default helm-shell-history-file (expand-file-name "~/.bash_history"))))

    (add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
    (add-hook 'shell-mode-hook 'linum-mode)
    (add-hook 'shell-mode-hook 'compilation-shell-minor-mode)
    (add-hook 'shell-mode-hook 'hl-line-mode)
    (add-hook 'shell-mode-hook 'shell-dirtrack-mode)
    (add-hook 'shell-mode-hook 'subword-mode)
    (add-hook 'shell-mode-hook 'buffer-disable-undo)

    (global-set-key (kbd "M-m t") 'my/shell-at-arbitrary-dir))
  :bind
  (:map shell-mode-map
        ("M-r" . helm-shell-history)))

(use-package sh-script
  :config
  (progn
    (add-hook 'sh-mode-hook 'ansi-color-for-comint-mode-on)
    (add-hook 'sh-mode-hook 'linum-mode)
    (add-hook 'sh-mode-hook 'hl-line-mode)
    (add-hook 'sh-mode-hook 'subword-mode)))
