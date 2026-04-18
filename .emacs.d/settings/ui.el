;; change the way emacs looks and disable/enable some user interface elements
;; Turn off the menu bar & scrollbar at the top of each frame because it's distracting
(menu-bar-mode -1)
(scroll-bar-mode -1)

;; remove graphical toolbar at the top
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))

;; add some spaces on the edges
(set-fringe-mode 10)

;; increase font size for better readability
(set-face-attribute 'default nil :font "JetBrainsMono Nerd Font" :height 160)

;; Monokai Colorscheme - No brainer!!
(load-theme 'monokai-pro-classic t)

;; No cursor blinking, it's distracting
(blink-cursor-mode 0)

;; Highlight current line
(global-hl-line-mode 1)

;; show line numbers
(global-display-line-numbers-mode 1)
;; but not everywhere
(dolist (mode '(term-mode-hook
                shell-mode-hook
                eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;; TODO: figure out how to show relative linenumbers?
(setq display-line-numbers-type 'relative)
;;(global-display-line-numbers-mode +1)

;; disable bi-directional text scanning
(setq-default bidi-display-reordering 'left-to-right
              bidi-paragraph-direction 'left-to-right)
(setq bidi-inhibit-bpa t)
