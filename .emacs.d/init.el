;; Install essential packages
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(use-package evil
  :ensure t
  :init
  (setq evil-want-integration t) ;; This is optional since it's already set to t by default.
  (setq evil-want-keybinding nil)
  :config
  (evil-mode 1))

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

(use-package monokai-pro-theme
  :ensure t
  :config
  (load-theme 'monokai-pro-classic t))

;; any customize-based settings should live in custom.el, not here.
(setq custom-file "~/.dotfiles/.emacs.d/config/custom.el")
(load custom-file 'noerror)

;; add my customization directory to path
(add-to-list 'load-path "~/.emacs.d/config")

(defvar addons
  '("ui.el"
    ))

(dolist (x addons)
  (load x))

;; Make garbage collection pauses faster by decreasing the threshold.
(setq gc-cons-threshold (* 2 1000 1000))
