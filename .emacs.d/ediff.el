(use-package ediff
  :config
  (progn
    (setq ediff-window-setup-function 'ediff-setup-windows-plain)
    (setq ediff-diff-options "-w")
    (setq-default ediff-ignore-similar-regions t)
    (setq-default ediff-highlight-all-diffs nil)
    (setq ediff-split-window-function 'split-window-horizontally)
    (setq ediff-merge-split-window-function 'split-window-horizontally)

    (defun my/ediff-before-setup-cb ()
      (my/push-window-configuration))

    (defun my/ediff-quit-cb ()
      (ediff-cleanup-mess)
      (my/pop-window-configuration))

    (defun my/ediff-startup-hook-cb ()
      (ediff-toggle-wide-display))

    (defun my/ediff-cleanup-hook-cb ()
      (when ediff-wide-display-p
        (ediff-toggle-wide-display)))

    (add-hook 'ediff-before-setup-hook #'my/ediff-before-setup-cb)
    (add-hook 'ediff-quit-hook #'my/ediff-quit-cb)
    (add-hook 'ediff-cleanup-hook 'my/ediff-cleanup-hook-cb)
    (add-hook 'ediff-startup-hook 'my/ediff-startup-hook-cb)))
