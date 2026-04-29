;; Install essential packages
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(use-package evil
  :ensure
  :preface
  (customize-set-variable 'evil-want-keybinding nil) ;; if using `evil-collection'
  (customize-set-variable 'evil-want-integration t) ;; if using `evil-collection'
  (customize-set-variable 'evil-undo-system 'undo-redo)
  (customize-set-variable 'evil-want-C-u-scroll t) ;; move universal arg to <leader> u
  (customize-set-variable 'evil-want-C-u-delete t) ;; delete back to indentation in insert state
      (customize-set-variable 'evil-want-C-g-bindings t)
  :config
  (evil-mode 1)
  ;; disable this when using `general.el'
  (evil-set-leader '(normal visual) (kbd "SPC"))
  (evil-set-leader '(normal visual) (kbd "C-c SPC") t))

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

(use-package evil-surround
  :ensure t
  :config
  (global-evil-surround-mode 1))

(use-package evil-commentary
  :ensure t)
(require 'evil-commentary)
(evil-commentary-mode)

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
