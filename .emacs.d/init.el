;;; init.el --- Summary
;; Author: Oleg Grushenkov <ogrushenkov@gmail.com>

;;; Commentary:

;;; Code:
(require 'cl)
(package-initialize)

(setq package-archives
      '(("gnu-elpa"     . "https://elpa.gnu.org/packages/")
        ;; ("marmalade" . "http://marmalade-repo.org/packages/")
        ("melpa-stable" . "https://stable.melpa.org/packages/")
        ("melpa"        . "https://melpa.org/packages/"))
      package-archive-priorities
      '(("melpa-stable" . 10)
        ("gnu-elpa"     . 5)
        ;; ("marmalade"     . 4)
        ("MELPA"        . 0)))

(let* ((ps '(use-package)))
  (dolist (p ps)
    (when (not (package-installed-p p))
      (package-refresh-contents)
      (package-install p)))
  ;; (when (not package-archive-contents)
  ;;   (package-refresh-contents))
  )

(require 'use-package)

(load-file (expand-file-name "~/.emacs.d/prelude.el"))

(progn
  (setq-default inhibit-startup-screen t)
  (setq-default frame-title-format '("%b - Emacs"))
  (add-to-list 'default-frame-alist '(width . 124))
  (add-to-list 'default-frame-alist '(height . 32))
  (set-face-attribute 'default nil :height 100)
  (fset 'yes-or-no-p 'y-or-n-p)
  (column-number-mode t)
  (scroll-bar-mode -1)
  (tool-bar-mode -1))

(progn
  (setq-default cursor-type 'bar)
  (setq-default sentence-end-double-space nil)
  (setq-default indent-tabs-mode nil)
  (setq-default tab-width 4)
  (setq-default select-enable-clipboard t)
  (setq-default select-enable-primary nil)
  (setq-default interprogram-paste-function 'x-selection-value)
  (setq-default save-interprogram-paste-before-kill t)
  (delete-selection-mode 1)
  (transient-mark-mode 1))

(progn
  ;; save backup~ and #auto-save# files to $TMPDIR/emacs-$USER
  (when (not (file-exists-p my/emacs-tmp-dir))
    (make-directory my/emacs-tmp-dir))
  (setq-default auto-save-list-file-prefix my/emacs-tmp-dir)
  (setq-default auto-save-file-name-transforms `((".*" ,my/emacs-tmp-dir t)))
  (setq-default backup-directory-alist `((".*" . ,my/emacs-tmp-dir)))
  (setq-default create-lockfiles nil)
  (add-hook 'before-save-hook
            (lambda ()
              (progn
                (delete-trailing-whitespace))))
  (savehist-mode t)
  (save-place-mode 1))

(progn
  (global-set-key (kbd "M-m") ctl-x-map)
  (global-set-key (kbd "<escape>") 'keyboard-escape-quit)
  (define-key ctl-x-map (kbd "k") 'kill-this-buffer)
  ;; (global-set-key (kbd "C-w") 'delete-window)
  (global-unset-key (kbd "C-x C-z"))
  ;; (define-key key-translation-map (kbd "<escape>") (kbd "C-g"))
  ;; (global-set-key (kbd "C-SPC") 'complete-symbol)
  ;; (global-set-key (kbd "C-M-i") 'company-complete)
  (define-key global-map (kbd "S-SPC") 'my/insert-space)
  (global-set-key [remap move-beginning-of-line] 'my/move-beginning-of-line)
  ;; (global-set-key (kbd "M-,") 'pop-tag-mark)
  ;; (global-set-key (kbd "M-*") 'pop-tag-mark)
  (global-set-key (kbd "<pause>") 'my/toggle-window-dedicated))

(use-package autorevert
  :config
  (progn
    (global-auto-revert-mode t)
    (setq auto-revert-verbose nil)))

(use-package cua-base
  :init
  (progn
    (cua-mode 1))
  :config
  (progn
    (global-unset-key (kbd "C-z"))
    (global-unset-key (kbd "M-w"))
    (global-unset-key (kbd "C-w"))
    (global-unset-key (kbd "C-y"))
    (global-unset-key (kbd "M-y"))
    (global-unset-key (kbd "C-v"))
    (global-unset-key (kbd "M-v"))

    ;; (setq cua-keep-region-after-copy t)
    (setq-default cua-auto-tabify-rectangles nil))
  :bind
  (:map cua--cua-keys-keymap
        ("M-v" . nil)))

(use-package compile
  :defer t
  :config
  (progn
    (require 'ansi-color)
    (setq mode-compile-always-save-buffer-p t)
    ;; (setq compilation-window-height 18)
    (setq compilation-scroll-output 'first-error)

    (defun my/colorize-compilation-buffer ()
      (let ((buffer-read-only nil))
        (ansi-color-apply-on-region (point-min) (point-max))))
    (defun my/compilation-finish-function (buffer string)
      (select-window (get-buffer-window buffer))
      (unless (string-match "exited abnormally" string)
        ;;no errors, make the compilation window go away in a few seconds
        (run-at-time "2 sec" nil 'delete-windows-on (get-buffer-create "*compilation*"))
        (message "No Compilation Errors!")))
    (defun my/compile-goto-error-delete-window ()
      (interactive)
      (let ((w (selected-window)))
        (compile-goto-error)
        (delete-window w)))

    (add-hook 'compilation-filter-hook 'my/colorize-compilation-buffer)
    (add-to-list 'compilation-finish-functions #'my/compilation-finish-function)

    (define-key compilation-mode-map [remap compile-goto-error] 'my/compile-goto-error-delete-window)))

(use-package desktop
  :config
  (progn
    (setq desktop-load-locked-desktop t)
    (setq desktop-save nil)
    (setq desktop-auto-save-timeout nil)
    (desktop-save-mode 1)))

(use-package eldoc
  :diminish eldoc-mode)

(use-package etags
  :config
  (progn
    (defun my/find-tag-without-ns (next-p)
      (interactive "P")
      ;; (find-tag (first (last (split-string (symbol-name (symbol-at-point)) "/")))
      ;;           next-p)
      (xref-find-definitions (first (last (split-string (symbol-name (symbol-at-point)) "/")))))))

(use-package files
  :config
  (progn
    (add-to-list 'revert-without-query "*/Documents/OGTEK/*")
    (add-to-list 'revert-without-query "*/Documents/COF/*")
    (add-to-list 'revert-without-query "*/Documents/PENFED/*")))

(use-package ispell
  :config
  (progn
    (when (eq system-type 'windows-nt)
      (setq-default ispell-program-name (expand-file-name "~/.local/opt/cygwin/bin/aspell.exe")))))

(use-package flyspell
  :diminish flyspell-mode
  :bind
  (:map flyspell-mode-map
        ("C-," . nil)
        ("C-." . nil)
        ("C-;" . nil)
        ("M-$" . nil)
        ("C-M-i" . nil)))

(use-package help-at-pt
  :config
  (progn
    (setq help-at-pt-display-when-idle t)
    (setq help-at-pt-timer-delay 0.5)
    (help-at-pt-set-timer)))

(use-package hippie-exp
  :config
  (progn
    (defun my/hippie-expand-completions (&optional hippie-expand-function)
      "Returns the full list of possible completions generated by `hippie-expand'.
       The optional argument can be generated with `make-hippie-expand-function'."
      (let ((this-command 'my/hippie-expand-completions)
            (last-command last-command)
            (buffer-modified (buffer-modified-p))
            (hippie-expand-function (or hippie-expand-function 'hippie-expand)))
        (cl-flet ((ding)) ; avoid the (ding) when hippie-expand exhausts its options.
          (while (progn
                   (funcall hippie-expand-function nil)
                   (setq last-command 'my/hippie-expand-completions)
                   (not (equal he-num -1)))))
        ;; Evaluating the completions modifies the buffer, however we will finish
        ;; up in the same state that we began.
        (set-buffer-modified-p buffer-modified)
        ;; Provide the options in the order in which they are normally generated.
        (delete he-search-string (reverse he-tried-table))))

    (defmacro my/ido-hippie-expand-with (hippie-expand-function)
      "Generate an interactively-callable function that offers ido-based completion
       using the specified hippie-expand function."
      `(call-interactively
        (lambda (&optional selection)
          (interactive
           (let ((options (my/hippie-expand-completions , hippie-expand-function)))
             (if options
                 (list (helm-comp-read "Completions: " options)))))
          (if selection
              (he-substitute-string selection t)
            (message "No expansion found")))))

    (defun my/ido-hippie-expand ()
      "Offer ido-based completion for the word at point."
      (interactive)
      (my/ido-hippie-expand-with 'hippie-expand))

    (setq hippie-expand-try-functions-list '(try-expand-dabbrev
                                             try-expand-dabbrev-all-buffers
                                             try-expand-dabbrev-from-kill
                                             try-complete-file-name-partially
                                             try-complete-file-name
                                             try-expand-all-abbrevs
                                             try-expand-list
                                             try-expand-line
                                             try-complete-lisp-symbol-partially
                                             try-complete-lisp-symbol)))
  :bind
  (("M-/" . my/ido-hippie-expand)))

(use-package imenu
  :bind
  (("M-o" . imenu)))

(use-package isearch
  :bind
  (:map isearch-mode-map
        ("C-v" . isearch-yank-kill)))

(use-package man
  :config
  (progn
    (setq-default Man-notify-method 'pushy)))

(use-package midnight
  :config
  (progn
    (setq midnight-period (* 60 60))))

(use-package minibuffer
  :config
  (progn
    (setq max-mini-window-height .80)
    (add-hook 'minibuffer-setup-hook 'subword-mode)))

(use-package recentf
  :init
  (progn
    (recentf-mode 1)))

(use-package speedbar
  :config
  (progn
    (setq speedbar-update-flag nil)
    (setq speedbar-show-unknown-files t)
    (setq speedbar-frame-parameters '((minibuffer)
                                      (width . 40)
                                      (border-width . 0)
                                      (menu-bar-lines . 0)
                                      (tool-bar-lines . 0)
                                      (unsplittable . t)
                                      (left-fringe . 0)))))

(use-package subword
  :diminish subword-mode)

(use-package "window"
  :config
  (progn
    (add-to-list 'same-window-buffer-names "*Help*")
    (add-to-list 'same-window-buffer-names "*Backtrace*")
    (add-to-list 'same-window-buffer-names "*Compile-Log*")
    (add-to-list 'same-window-buffer-names "*grep*")
    (add-to-list 'same-window-buffer-names "*cider-doc*")
    (add-to-list 'same-window-buffer-names "*cider-src*")
    (add-to-list 'same-window-buffer-names "*cider-macroexpansion*")
    (add-to-list 'same-window-buffer-names "*cider-result*")
    (add-to-list 'same-window-buffer-names "*cider-test-report*")
    (add-to-list 'same-window-buffer-names "*my/cider-result*")))

(use-package xref
  :init
  (progn
    (defun my/xref-goto-xref ()
      "Jump to the xref on the current line, select its window and quit xref window."
      (interactive)
      (let ((xref (or (xref--item-at-point)
                      (user-error "No reference at point"))))
        (xref--show-location (xref-item-location xref))
        (quit-window t))))
  :bind
  (:map xref--button-map
        ("RET" . my/xref-goto-xref)))

(use-package uniquify
  :config
  (progn
    (setq uniquify-buffer-name-style 'forward)))

(use-package diminish
  :pin melpa-stable
  :ensure t
  :demand t
  :config
  (progn
    (require 'diminish)))

(use-package ace-jump-mode
  :pin melpa-stable
  :ensure t
  :config
  (progn
    (setq ace-jump-mode-case-fold t)
    (setq ace-jump-mode-move-keys (loop for i from ?a to ?z collect i)))
  :bind
  (:map global-map
        ("M-j" . ace-jump-mode)))

(use-package ace-window
  :pin melpa-stable
  :ensure t
  :config
  (progn
    (setq-default aw-keys '(?a ?b ?c ?d ?e ?f ?g ?h ?i ?j))
    (global-set-key (kbd "C-x o") 'ace-window)))

(use-package aggressive-indent
  :pin melpa-stable
  :ensure t
  :diminish aggressive-indent-mode)

(use-package auto-highlight-symbol
  :pin melpa
  :ensure t
  :diminish auto-highlight-symbol-mode)

(use-package expand-region
  :pin melpa-stable
  :ensure t
  :bind
  (:map global-map
        ("C-," . er/expand-region)
        ("C-." . er/contract-region)))

(use-package flycheck
  :pin melpa-stable
  :ensure t
  :config
  (progn
    ;; (setq flycheck-display-errors-function #'flycheck-display-error-messages)
    ;; (setq flycheck-display-errors-function #'flycheck-pos-tip-error-messages)
    (define-key flycheck-mode-map (kbd "C-c f") 'helm-flycheck)
    (define-key flycheck-mode-map (kbd "M-p") 'flycheck-previous-error)
    (define-key flycheck-mode-map (kbd "M-n") 'flycheck-next-error)
    ;; (flycheck-clojure-setup)
    ;; (flycheck-haskell-setup)
    ;; (add-hook 'after-init-hook #'global-flycheck-mode)
    (defun my/flycheck-may-enable-mode-advice (f)
      "Disallow flycheck in special buffers."
      (interactive)
      (and (not (string-prefix-p "*" (buffer-name)))
           (apply (list f))))

    (advice-add 'flycheck-may-enable-mode :around
                #'my/flycheck-may-enable-mode-advice)))

;; (use-package golden-ratio
;;   :pin melpa-stable
;;   :ensure t
;;   :after (:all ace-window ediff)
;;   :config
;;   (progn
;;     (defun my/ediff-comparison-buffer-p ()
;;       (and (boundp 'ediff-this-buffer-ediff-sessions)
;;            ediff-this-buffer-ediff-sessions))

;;     (setq golden-ratio-auto-scale t)
;;     (add-to-list 'golden-ratio-extra-commands 'ace-window)
;;     (add-to-list 'golden-ratio-exclude-modes "ediff-mode")
;;     (add-to-list 'golden-ratio-inhibit-functions 'my/ediff-comparison-buffer-p)
;;     (golden-ratio-mode 1)))

(use-package htmlize
  :pin melpa-stable
  :ensure t)

(use-package hydra
  :pin melpa-stable
  :ensure t)

(use-package multiple-cursors
  :pin melpa-stable
  :ensure t
  :after (:all hydra)
  :config
  (progn
    (defhydra multiple-cursors-hydra (:hint nil)
      "
^Up^            ^Down^          ^Other^
----------------------------------------------
[_p_]   Prev    [_n_]   Next    [_l_] Edit lines
[_P_]   Skip    [_N_]   Skip    [_a_] Mark all
[_M-p_] Unmark  [_M-n_] Unmark  [_r_] Mark by regexp
^ ^             ^ ^             [_q_] Quit
"
      ("l" mc/edit-lines :exit t)
      ("a" mc/mark-all-like-this :exit t)
      ("n" mc/mark-next-like-this)
      ("N" mc/skip-to-next-like-this)
      ("M-n" mc/unmark-next-like-this)
      ("p" mc/mark-previous-like-this)
      ("P" mc/skip-to-previous-like-this)
      ("M-p" mc/unmark-previous-like-this)
      ("r" mc/mark-all-in-region-regexp :exit t)
      ("q" nil)))
  :bind
  (:map global-map
        ("C-c C-h m" . multiple-cursors-hydra/body)))

(use-package smartparens
  :pin melpa-stable
  :ensure t
  :diminish smartparens-mode
  :config
  (progn
    (setq sp-navigate-consider-sgml-tags '(html-mode
                                           nxml-mode
                                           web-mode
                                           xml-mode))

    (defun sp--indent-region (start end &optional column)
      "Call `indent-region' unless `aggressive-indent-mode' is enabled.

START, END and COLUMN are the same as in `indent-region'."
      (unless (or (bound-and-true-p aggressive-indent-mode) (not (bound-and-true-p haskell-mode)) (not (bound-and-true-p purescript-mode)))
        ;; Don't issue "Indenting region..." message.
        (cl-letf (((symbol-function 'message) #'ignore))
          (indent-region start end column))))

    (defun my/sp-wrap-with-parens (&optional arg)
      (interactive "P")
      (sp-wrap-with-pair "("))

    (defun my/sp-wrap-with-squares (&optional arg)
      (interactive "P")
      (sp-wrap-with-pair "["))

    (defun my/sp-wrap-with-braces (&optional arg)
      (interactive "P")
      (sp-wrap-with-pair "{"))

    (defun my/sp-wrap-with-chevrons (&optional arg)
      (interactive "P")
      (sp-wrap-with-pair "<"))

    (sp-with-modes sp-lisp-modes
      (sp-local-pair "'" nil :actions nil)
      (sp-local-pair "`" "'" :when '(sp-in-string-p sp-in-comment-p))
      (sp-local-pair "`" nil
                     :skip-match (lambda (ms mb me)
                                   (cond
                                    ((equal ms "'")
                                     (or (sp--org-skip-markup ms mb me)
                                         (not (sp-point-in-string-or-comment))))
                                    (t (not (sp-point-in-string-or-comment))))))))
  :bind
  (:map smartparens-mode-map
        ("C-M-w" . sp-backward-unwrap-sexp)
        ("C-M-f" . sp-forward-sexp)
        ("C-M-b" . sp-backward-sexp)
        ("C-M-a" . sp-beginning-of-sexp)
        ("C-M-e" . sp-end-of-sexp)
        ("C-M-d" . sp-down-sexp)
        ("C-M-p" . sp-backward-down-sexp)
        ("C-M-n" . sp-up-sexp)
        ("C-M-u" . sp-backward-up-sexp)
        ("C-M-c" . sp-copy-sexp)
        ("C-M-j" . sp-join-sexp)
        ("C-k" . sp-kill-hybrid-sexp)
        ("C-M-k" . sp-kill-sexp)
        ("C-M-S-k" . sp-backward-kill-sexp)
        ("C-M-s" . sp-splice-sexp)
        ("C-M-t" . sp-transpose-sexp)
        ("C-M-w" . sp-unwrap-sexp)
        ("C-M-S-w" . sp-backward-unwrap-sexp)
        ("C-)" . sp-forward-slurp-sexp)
        ("C-(" . sp-backward-slurp-sexp)
        ("C-}" . sp-forward-barf-sexp)
        ("C-{" . sp-backward-barf-sexp)
        ("M-(" . my/sp-wrap-with-parens)
        ("M-[" . my/sp-wrap-with-squares)
        ("M-{" . my/sp-wrap-with-braces)
        ("M-q" . sp-indent-defun)
        ("C-]" . sp-select-next-thing-exchange)
        ("C-<left_bracket>" . sp-select-previous-thing)
        ("C-M-]" . sp-select-next-thing)))

(use-package undo-tree
  :pin gnu-elpa
  :ensure t
  :diminish undo-tree-mode
  :init
  (progn
    (global-undo-tree-mode 1))
  :config
  (progn
    (setq-default undo-outer-limit (* 64 1024 1024))
    (global-unset-key (kbd "C-x u"))
    (global-unset-key (kbd "M-m u"))
    (defadvice undo-tree-visualize (around undo-tree-split-side-by-side activate)
      "Split undo-tree side-by-side"
      (let ((split-height-threshold 20)
            (split-width-threshold nil))
        ad-do-it)))
  :bind
  (:map undo-tree-map
        ("C-x u" . undo-tree-visualize)
        ("M-m u" . undo-tree-visualize)
        ("C-z" . undo-tree-undo)
        ("C-S-z" . undo-tree-redo)))

(use-package uuid
  :pin melpa
  :ensure t
  :config
  (progn
    (defun my/insert-uuid ()
      (interactive)
      (require 'uuid)
      (insert (uuid-string)))))

(use-package which-key
  :pin melpa-stable
  :ensure t
  :diminish which-key-mode
  :config
  (progn
    (which-key-mode 1)))

(use-package yasnippet
  :pin melpa-stable
  :ensure t
  :diminish (yas-minor-mode yas-global-mode)
  :config
  (progn
    (yas-reload-all)
    (yas-global-mode 1))
  ;; :bind
  ;; (:map yas-minor-mode-map
  ;;       ("\C-c y" . yas-insert-snippet)
  ;;       ("C-c & C-s" . nil)
  ;;       ("C-c & C-n" . nil)
  ;;       ("C-c & C-v" . nil))
  )

(use-package yasnippet-snippets
  :pin melpa-stable
  :ensure t)

;; (use-package repl-toggle
;;   :pin melpa-stable
;;   :ensure t)

(load-file (expand-file-name "~/.emacs.d/themes.el"))
(load-file (expand-file-name "~/.emacs.d/helm.el"))
;; (load-file (expand-file-name "~/.emacs.d/cedet.el"))
(load-file (expand-file-name "~/.emacs.d/company.el"))
(load-file (expand-file-name "~/.emacs.d/projectile.el"))
(load-file (expand-file-name "~/.emacs.d/lsp.el"))

(load-file (expand-file-name "~/.emacs.d/dired.el"))
(load-file (expand-file-name "~/.emacs.d/ediff.el"))
(load-file (expand-file-name "~/.emacs.d/elisp.el"))
;; (load-file (expand-file-name "~/.emacs.d/clojure.el"))
(load-file (expand-file-name "~/.emacs.d/css.el"))
(load-file (expand-file-name "~/.emacs.d/elfeed.el"))
;; (load-file (expand-file-name "~/.emacs.d/gnus.el"))
(load-file (expand-file-name "~/.emacs.d/haskell.el"))
;; (load-file (expand-file-name "~/.emacs.d/java.el"))
(load-file (expand-file-name "~/.emacs.d/javascript.el"))
(load-file (expand-file-name "~/.emacs.d/lua.el"))
(load-file (expand-file-name "~/.emacs.d/magit.el"))
(load-file (expand-file-name "~/.emacs.d/nxml.el"))
(load-file (expand-file-name "~/.emacs.d/org.el"))
(load-file (expand-file-name "~/.emacs.d/purescript.el"))
(load-file (expand-file-name "~/.emacs.d/python.el"))
(load-file (expand-file-name "~/.emacs.d/psvn.el"))
(load-file (expand-file-name "~/.emacs.d/restclient.el"))
(load-file (expand-file-name "~/.emacs.d/scala.el"))
(load-file (expand-file-name "~/.emacs.d/shell.el"))
(load-file (expand-file-name "~/.emacs.d/sql.el"))
(load-file (expand-file-name "~/.emacs.d/term.el"))
(load-file (expand-file-name "~/.emacs.d/web.el"))
(load-file (expand-file-name "~/.emacs.d/yaml.el"))

(provide 'init)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#073642" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#657b83"])
 '(compilation-message-face (quote default))
 '(cua-global-mark-cursor-color "#2aa198")
 '(cua-normal-cursor-color "#839496")
 '(cua-overwrite-cursor-color "#b58900")
 '(cua-read-only-cursor-color "#859900")
 '(custom-safe-themes
   (quote
    ("8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" default)))
 '(fci-rule-color "#073642")
 '(highlight-changes-colors (quote ("#d33682" "#6c71c4")))
 '(highlight-symbol-colors
   (--map
    (solarized-color-blend it "#002b36" 0.25)
    (quote
     ("#b58900" "#2aa198" "#dc322f" "#6c71c4" "#859900" "#cb4b16" "#268bd2"))))
 '(highlight-symbol-foreground-color "#93a1a1")
 '(highlight-tail-colors
   (quote
    (("#073642" . 0)
     ("#546E00" . 20)
     ("#00736F" . 30)
     ("#00629D" . 50)
     ("#7B6000" . 60)
     ("#8B2C02" . 70)
     ("#93115C" . 85)
     ("#073642" . 100))))
 '(hl-bg-colors
   (quote
    ("#7B6000" "#8B2C02" "#990A1B" "#93115C" "#3F4D91" "#00629D" "#00736F" "#546E00")))
 '(hl-fg-colors
   (quote
    ("#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36")))
 '(magit-diff-use-overlays nil)
 '(package-selected-packages
   (quote
    (dired-narrow dired-subtree company-anaconda flycheck-mypy pyimpsort importmagic pyimport anaconda-mode lua-mode htmlize exec-path-from-shell diminish spaceline spaceline-all-the-icons dired-quick-sort dsvn f elfeed purescript-mode magit yasnippet-snippets psc-ide clojure-snippets cider clojure-mode company-lsp company-nginx nginx-mode python-mode lsp-ui lsp-mode ensime sbt-mode scala-mode yasnippet restclient projectile intero haskell-mode flycheck company markdown-mode yaml-mode which-key web-mode uuid use-package undo-tree solarized-theme smartparens shm psvn multiple-cursors json-mode javadoc-lookup hydra helm helm-swoop helm-projectile helm-descbinds helm-ag haskell-snippets expand-region company-restclient company-flx circadian auto-highlight-symbol aggressive-indent ace-window ace-jump-mode)))
 '(pos-tip-background-color "#073642")
 '(pos-tip-foreground-color "#93a1a1")
 '(pulse-delay 0.02)
 '(pulse-iterations 2)
 '(safe-local-variable-values
   (quote
    ((projectile-enable-caching)
     (projectile-indexing-method quote alien)
     (projectile-use-git-grep . 1)
     (psc-ide-source-globs "src/**/*.purs" ".psc-package/psc-0.12.0/*/*/src/**/*.purs")
     (projectile-project-compilation-cmd . "npm run build")
     (projectile-project-compilation-cmd . "stack build --fast")
     (projectile-project-run-cmd . "npm run main")
     (eval setq projectile-project-test-cmd
           (lambda nil
             (projectile-run-compilation "npm run test")))
     (eval setq projectile-project-test-cmd
           (lambda nil
             (projectile-run-compilation "stack build --fast --test")))
     (projectile-tags-command . "codex update")
     (psc-ide-use-npm-bin . t)
     (projectile-use-git-grep . t))))
 '(smartrep-mode-line-active-bg (solarized-color-blend "#859900" "#073642" 0.2))
 '(term-default-bg-color "#002b36")
 '(term-default-fg-color "#839496")
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#dc322f")
     (40 . "#c85d17")
     (60 . "#be730b")
     (80 . "#b58900")
     (100 . "#a58e00")
     (120 . "#9d9100")
     (140 . "#959300")
     (160 . "#8d9600")
     (180 . "#859900")
     (200 . "#669b32")
     (220 . "#579d4c")
     (240 . "#489e65")
     (260 . "#399f7e")
     (280 . "#2aa198")
     (300 . "#2898af")
     (320 . "#2793ba")
     (340 . "#268fc6")
     (360 . "#268bd2"))))
 '(vc-annotate-very-old-color nil)
 '(weechat-color-list
   (quote
    (unspecified "#002b36" "#073642" "#990A1B" "#dc322f" "#546E00" "#859900" "#7B6000" "#b58900" "#00629D" "#268bd2" "#93115C" "#d33682" "#00736F" "#2aa198" "#839496" "#657b83"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
