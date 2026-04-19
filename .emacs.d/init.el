;; Install essential packages
;; Try M-x list-packages to see what's available.
(require 'package)
(add-to-list 'package-archives '(("melpa" . "https://melpa.org/packages/")
                                 ("elpa" . "https://elpa.gnu.org/packages/"))
                                 t)

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; The packages you want installed. You can also install these
;; manually with M-x package-install
(defvar my-packages
  '(
    monokai-pro-theme          ;; monokai theme
    evil                 ;; vim motions!!!
    evil-collection
    )
  )

;; install the packages
(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

;; enable evil mode :|
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


;; add my customization directory to path
(add-to-list 'load-path "~/.emacs.d/settings")

(load "ui.el")         ;; change emacs ui
