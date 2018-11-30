(use-package gnus
  :config
  (add-hook 'gnus-summary-mode
            '(lambda ()
               (progn
                 (my/toggle-truncate-lines 1))))
  (add-hook 'gnus-article-mode-hook
            '(lambda ()
               (progn
                 (set-fill-column 120)
                 (toggle-truncate-lines 0)
                 (gnus-article-fill-cited-article)))))
