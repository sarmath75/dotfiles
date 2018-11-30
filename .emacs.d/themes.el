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
    (setq circadian-themes '(("6:00" . solarized-light)
                             ("17:00" . solarized-dark)))
    (circadian-setup)))
