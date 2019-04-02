(use-package solarized-theme
  :pin melpa-stable
  :ensure t
  :config
  (progn
    (setq solarized-distinct-fringe-background t)
    (setq solarized-high-contrast-mode-line nil)
    (setq solarized-emphasize-indicators t)))

(use-package zenburn-theme
  :pin melpa-stable
  :defer t
  :ensure f)

(use-package circadian
  :pin melpa-stable
  :ensure t
  :config
  (progn
    (if (eq system-type 'windows-nt)
        (setq circadian-themes '(("11:00" . solarized-light)
                                 ("23:00" . solarized-dark)))
      (setq circadian-themes '(("6:00" . solarized-light)
                               ("17:00" . solarized-dark))))
    (circadian-setup)))

(use-package spaceline
  :pin melpa-stable
  :ensure t
  :demand t
  :init
  (progn
    ;; (setq powerline-default-separator 'arrow-fade)
    )
  :config
  (progn
    (require 'spaceline-config)
    (spaceline-spacemacs-theme)))

(use-package spaceline-all-the-icons
  :pin melpa-stable
  :ensure t
  :demand t
  :after (:all spaceline)
  :config
  (progn
    ;; (spaceline-all-the-icons-theme)
    ))
