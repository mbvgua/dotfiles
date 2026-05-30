;; -*- lexical-binding: t; -*-

(defun start/org-babel-tangle-config ()
  "Automatically tangle our init.org config file and refresh package-quickstart when we save it. Credit to Emacs From Scratch for this one!"
  (interactive)
  (when (string-equal (file-name-directory (buffer-file-name))
                      (expand-file-name user-emacs-directory))
    ;; Dynamic scoping to the rescue
    (let ((org-confirm-babel-evaluate nil))
      (org-babel-tangle)
      (package-quickstart-refresh)
      )))

(add-hook 'org-mode-hook (lambda () (add-hook 'after-save-hook #'start/org-babel-tangle-config)))

(defun start/display-startup-time ()
  (interactive)
  (message "Emacs loaded in %s with %d garbage collections."
           (format "%.2f seconds"
                   (float-time
                    (time-subtract after-init-time before-init-time)))
           gcs-done))

(add-hook 'emacs-startup-hook #'start/display-startup-time)

(require 'use-package-ensure) ;; Load use-package-always-ensure
(setq use-package-always-ensure t) ;; Always ensures that a package is installed

(setq package-archives '(("melpa" . "https://melpa.org/packages/") ;; Sets default package repositories
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(setq package-quickstart t) ;; For blazingly fast startup times, this line makes startup miles faster

(use-package async
  :defer
  :custom
  (dired-async-mode t)
  (async-bytecomp-package-mode t)
  (async-bytecomp-allowed-packages '(all))
  (async-package-do-action t))

(use-package emacs
  :custom
  ;; Still needed for terminals
  (menu-bar-mode nil)         ;; Disable the menu bar
  (scroll-bar-mode nil)       ;; Disable the scroll bar
  (tool-bar-mode nil)         ;; Disable the tool bar
  (fringe-mode nil)            ;; add space on left edge, prevent mvmt by relative numbers

  (delete-selection-mode t)   ;; Enable replacing selected text with typed text
  (electric-indent-mode nil)  ;; Turn off the weird indenting that Emacs does by default.
  (electric-pair-mode t)      ;; Turns on automatic parens pairing

  (blink-cursor-mode nil)     ;; Don't blink cursor
  (global-auto-revert-mode t) ;; Automatically reload file and show changes if the file has changed
  (use-short-answers t)   ;; Since Emacs 29, `yes-or-no-p' will use `y-or-n-p'

  (dired-kill-when-opening-new-dired-buffer t) ;; Dired don't create new buffer
  (recentf-mode t) ;; Enable recent file mode
  ;;(context-menu-mode t) ;; Right-click menu

  ;;(global-visual-line-mode t)           ;; Enable line wrapping (NOTE: breaks vundo)
  (global-display-line-numbers-mode t)  ;; Display line numbers
  (display-line-numbers-type 'relative) ;; Relative line numbers
  (global-hl-line-mode t)               ;; Highlight current line
  (save-place-mode 1)          ;; Enable saving the place in files for easier return.

  (native-comp-async-report-warnings-errors 'silent) ;; Don't show native comp errors
  (warning-minimum-level :error) ;; Only show errors in warnings buffer

  (mouse-wheel-progressive-speed nil) ;; Disable progressive speed when scrolling
  (scroll-conservatively 10) ;; Smooth scrolling
  (scroll-margin 8)    ;; how many rows to retain at top and bottom of screen always

  (pixel-scroll-precision-mode t) ;; Precise pixel scrolling. i.e. smooth scrolling (GUI only)
  (pixel-scroll-precision-use-momentum nil)

  (indent-tabs-mode 1) ;;Use spaces & tabs for indentation
  (tab-width 4)
  (sgml-basic-offset 4) ;; Set Html mode indentation to 4
  (c-ts-mode-indent-offset 4) ;; Fix weird indentation in c-ts (C, C++)
  (go-ts-mode-indent-offset 4) ;; Fix weird indentation in go-ts
  (modify-coding-system-alist 'file "" 'utf-8)    ;; Set the default coding system for files to UTF-8.

  (display-fill-column-indicator-column 80) ;; Set line length indicator to 80 characters
  (whitespace-style '(face tabs tab-mark trailing))

  (make-backup-files nil) ;; Stop creating ~ backup files
  (auto-save-default nil)  ;; Stop creating # auto save files
  (create-lockfiles nil)   ;; stop creating lock files
  (delete-by-moving-to-trash t)  ;; move to Trash folder instead of permanently deleting them

  (inhibit-startup-screen t)   ;; Disable welcome screen
  (inhibit-startup-message t)                     ;; Disable the startup message when Emacs launches.
  (initial-scratch-message "")                    ;; Clear the initial message in the *scratch* buffer.

  (treesit-font-lock-level 4)                     ;; Use advanced font locking for Treesit mode.
  (truncate-lines t)                              ;; Enable line truncation to avoid wrapping long lines.
  (use-dialog-box nil)                            ;; Disable dialog boxes in favor of minibuffer prompts.
  (use-short-answers t)                           ;; Use short answers in prompts for quicker responses (y instead of yes)
  :hook
  (prog-mode . hs-minor-mode) ;; Enable folding hide/show globally
  ;; (prog-mode . display-fill-column-indicator-mode) ;; Display line length indicator
  (prog-mode . whitespace-mode)
  (prog-mode . display-line-numbers-mode)  ;; display line numbers in most progrmming modes
  ((term-mode shell-mode eshell-mode org-mode) . (lambda () (display-line-numbers-mode 0))) ;; Disable line numbers in terminal modes & org-mode

  ;; Add a hook to run code after Emacs has fully initialized.
  (after-init . (lambda ()
                  (message "Emacs has fully loaded. This code runs after startup.")
                  (with-current-buffer (get-buffer-create "*scratch*")
                      (insert (format
                              ";;    Welcome to Emacs!\n;;    Don't let this darkness fool you...\n;;\n;;    Loading time : %s\n;;    Packages     : %d\n"
				    (emacs-init-time)
                              (length package-activated-list))))))
  :config
  ;; Move customization variables to a separate file and load it, avoid filling up init.el with unnecessary variables
  (setq custom-file (locate-user-emacs-file "custom-vars.el"))
  (load custom-file 'noerror 'nomessage)   ;; Load the custom file quietly, ignoring errors.

  ;; By default emacs gives you access to a lot of *special* buffers, while navigating with [b and ]b,
  ;; this might be confusing for newcomers. This settings make sure ]b and [b will always load a
  ;; file buffer. To see all buffers use M-x ibuffer, or <leader> b s
  (defun skip-these-buffers (_window buffer _bury-or-kill)
      "Function for `switch-to-prev-buffer-skip'."
      (string-match "\\*[^*]+\\*" (buffer-name buffer)))
  (setq switch-to-prev-buffer-skip 'skip-these-buffers)

  :bind (
         ([escape] . keyboard-escape-quit) ;; Makes Escape quit prompts (Minibuffer Escape)
         ;; Zooming In/Out
         ("C-+" . text-scale-increase)
         ("C-=" . text-scale-increase)
         ("C--" . text-scale-decrease)
         ("<C-wheel-up>" . text-scale-increase)
         ("<C-wheel-down>" . text-scale-decrease)
         ))

(use-package dired
  :ensure nil                                                ;; This is built-in, no need to fetch it.
  :custom
  (dired-listing-switches "-lah --group-directories-first")  ;; Display files in a human-readable format and group directories first.
  (dired-dwim-target t)                                      ;; Enable "do what I mean" for target directories.
  (dired-guess-shell-alist-user
   '(("\\.\\(png\\|jpe?g\\|tiff\\)" "feh" "xdg-open" "open") ;; Open image files with `feh' or the default viewer.
     ("\\.\\(mp[34]\\|m4a\\|ogg\\|flac\\|webm\\|mkv\\)" "mpv" "xdg-open" "open") ;; Open audio and video files with `mpv'.
     (".*" "open" "xdg-open")))                              ;; Default opening command for other files.
  (dired-kill-when-opening-new-dired-buffer t))               ;; Close the previous buffer when opening a new `dired' instance.

(use-package evil
  :hook (after-init . evil-mode)
  :init
  (evil-mode)
  :custom
  (evil-want-keybinding nil)    ;; Disable evil bindings in other modes (It's not consistent and not good)
  (evil-want-C-u-scroll t)      ;; Set C-u to scroll up
  (evil-want-C-i-jump nil)      ;; Disables C-i jump
  (evil-undo-system 'undo-fu)   ;; C-r to redo, using 'undo-fu'
  (evil-want-fine-undo t)
  ;; (evil-respect-visual-line-mode t) ;; Move in wrap lines
  ;; Unmap keys in 'evil-maps. If not done, org-return-follows-link will not work
  :bind (:map evil-motion-state-map
              ("SPC" . nil)
              ("RET" . nil)
              ("TAB" . nil)))

(use-package evil-collection
  :after evil
  :config
  ;; Setting where to use evil-collection)
  (setq evil-collection-mode-list '(dired ibuffer magit corfu consult info (package-menu package) bookmark))
  (evil-collection-init))

(use-package evil-surround
    :config
    (global-evil-surround-mode 1))

;; (use-package evil-commentary
;;     :config
;;     (evil-commentary-mode))

(use-package evil-tutor)

(defun start/open-init-file ()
              "Open init.org configuration file"
              (interactive)
              (find-file "~/.config/emacs/init.org"))

            (defun start/reload-config()
              "Reload Emacs config"
              (interactive)
              (load-file "~/.config/emacs/init.el"))

            (use-package general
              :after (evil) ;; <- evil
              :config
              (general-evil-setup) ;; <- evil

              ;; Set up 'SPC' as the leader key
              (general-create-definer start/leader-keys
                :states '(normal insert visual motion emacs) ;; <- evil
                :keymaps 'override
                :prefix "SPC"
                :global-prefix "M-SPC") ;; Set global leader key so we can access our keybindings from any state

              (start/leader-keys
               ;; buffers
                "b" '(:ignore t :wk "buffers")
                "n" '(next-buffer :wk "buffer [n]ext")
                "p" '(previous-buffer :wk "buffer [p]revious")
                "w" '(save-buffer :wk "buffer [w]rite")
                "b s" '(consult-buffer :wk "[b]uffer [s]witch")
                "b k" '(kill-current-buffer :wk "[b]uffer [k]ill")
                "b x" '(kill-current-buffer :wk "[b]uffer [k]ill")
                "b r" '(revert-buffer :wk "[b]uffer [r]eload")

                ;; files
                "f" '(:ignore t :wk "files")
                "f c" '((lambda () (interactive) (find-file "~/.dotfiles/.config/emacs/init.org")) :wk "[f]ind emacs [c]onfig")
                "f f" '(find-file :wk "[f]ind [f]ile")    ;; telescope PTSD
                "f r" '(consult-recent-file :wk "[f]ind [r]ecent file")
                "f h" '(consult-imenu :wk "[f]ind by [h]eadings in buffer")
                "f p" '(project-find-file :wk "find [f]ile in [p]roject")
                "f w" '(consult-line :wk "[f]ind [w]ord by grep in file")  ;; equal to '/' using evil
                "f g" '(consult-grep :wk "[f]ind file by [g]rep in directory")
                "f s" '(sudo-edit :wk "edit current [f]ile with [s]udo priviledges")
                "f S" '(sudo-edit-find-file :wk "[f]ind file to edit with [s]udo priviledges")

                ;; windows
                ;; navigate windows with basic C-w h/j/k/l keys
                "-" '(evil-window-split :wk "[-] split window horizontally")
                "\\" '(evil-window-vsplit :wk "[|] split window vertically")
                "x" '(evil-window-delete :wk "close window")

                ;; magit
                "g" '(:ignore t :wk "git")
                "g g" '(magit-status :wk "ma[g]it [g]it status")
                "g s" '(magit-diff-buffer-file :wk "current file [g]it [s]tatus")

                ;; dired
                "d" '(:ignore t :wk "dired")
                "d d" '(dired :wk "[d]ire[d] open")
                "d j" '(dired-jump :wk "[d]ired [j]ump to current") ;; open current file in dired

                ;; Evaluate
                "e" '(:ignore t :wk "Evaluate")
                "e b" '(eval-buffer :wk "[e]valuate elisp in [b]uffer")
                "e e" '(eval-expression :wk "[e]valuate elisp [e]xpression")
                "e r" '(eval-region :wk "[e]valuate elisp [r]egion")
                "e d" '(eval-defun :wk "[e]valuate [d]efun containing/after point")
                "e l" '(eval-last-sexp :wk "[e]valuate elisp expression before point")

                ;; better help with helpful
                "h" '(:ignore t :wk "help")
                "h f" '(helpful-callable :wk "[h]elp [f]unction")
                "h v" '(helpful-variable :wk "[h]elp [v]ariable")
                "h k" '(helpful-key :wk "[h]elp [k]eymap")
                "h c" '(helpful-command :wk "[h]elp [c]ommand")
                "h m" '(describe-mode :wk "[h]elp current [m]ode")

                ;; misc
                "." '(ansi-term :wk "open terminal[.]")
                "/" '(display-line-numbers-mode :wk "toggle line numbers")
                "u" '(vundo :wk "toggle [line numbers")

                ;; ;; Org mode
                ;; "m" '(:ignore t :wk "Org")
                ;; "m a" '(org-agenda :wk "Org agenda")
                ;; "m e" '(org-export-dispatch :wk "Org export dispatch")
                ;; "m i" '(org-toggle-item :wk "Org toggle item")
                ;; "m t" '(org-todo :wk "Org todo")
                ;; "m B" '(org-babel-tangle :wk "Org babel tangle")
                ;; "m T" '(org-todo-list :wk "Org todo list")
                ;; "m b" '(:ignore t :wk "Tables")
                ;; "m b -" '(org-table-insert-hline :wk "Insert hline in table")
                ;; "m d" '(:ignore t :wk "Date/deadline")
                ;; "m d t" '(org-time-stamp :wk "Org time stamp")


                ;; ;; Projectile
                ;; "p" '(projectile-command-map :wk "Projectile")
                ;; "s p" '(projectile-discover-projects-in-search-path :wk "Search for projects")

                ;; "q" '(flymake-show-buffer-diagnostics :wk "Flymake buffer diagnostic")

                ;; ;; Registers
                ;; "m" '(:ignore t :wk "Bookmarks & Registers")
                ;; "m s" '(consult-register :wk "Consult register")
                ;; "m k" '(jump-to-register :wk "Jump to register")
                ;; "m e" '(point-to-register :wk "Point to register")
                ;; ;; Bookmarks
                ;; "m a" '(bookmark-set :wk "Bookmark Set")
                ;; "m d" '(bookmark-jump :wk "Bookmark Jump")
                ;; "m r" '(bookmark-delete :wk "Bookmark Delete")
                ;; "m R" '(bookmark-delete-all :wk "Bookmark Delete All")
                ;; "m l" '(bookmark-bmenu-list :wk "Bookmark bmenu list")
                ;; "m c" '(consult-bookmark :wk "Consult Bookmark")


                ;; ;; eglot
                ;; "e" '(:ignore t :wk "Languages")
                ;; "e e" '(eglot-reconnect :wk "Eglot Reconnect")
                ;; "e d" '(eldoc-doc-buffer :wk "Eldoc Buffer")
                ;; "e f" '(eglot-format :wk "Eglot Format")

                ;; "e l" '(consult-flymake :wk "Consult Flymake")
                ;; "e n" '(flymake-goto-next-error :wk "Flymake next error")
                ;; "e p" '(flymake-goto-prev-error :wk "Flymake previous error")

                ;; "e a" '(eglot-code-actions :wk "Eglot code actions")
                ;; "e r" '(eglot-rename :wk "Eglot Rename")
                ;; "e i" '(xref-find-definitions :wk "Find definition")
                ;; "e s" '(xref-find-references :wk "Find references")

                ;; "e v" '(:ignore t :wk "Elisp")
                ;; "e v b" '(eval-buffer :wk "Evaluate elisp in buffer")
                ;; "e v r" '(eval-region :wk "Evaluate elisp in region")


                ;; ;; mason
                ;; "r" '(:ignore t :wk "Reload & Packages") ;; To get more help use C-h commands (describe variable, function, etc.)
                ;; ;; Mason.el
                ;; "r m" '(mason-manager :wk "Mason manager")
                ;; "r i" '(mason-install :wk "Mason install")
                ;; ;; Package-menu-mode
                ;; "r p" '(list-packages :wk "List packages")
                ;; "r c" '(package-menu-clear-filter :wk "Package clear filters")
                ;; "r n" '(package-menu-filter-by-name :wk "Package filter by name")
                ;; "r N" '(package-menu-filter-by-name-or-description :wk "Package filter by name or descriptions")
                ;; "r s" '(package-menu-filter-by-status :wk "Package filter by status")
                ;; "r u" '(package-menu-filter-upgradable :wk "Package filter by upgradable")
))

      ;; Fix general.el leader key not working instantly in messages buffer with evil mode
      ;; (use-package emacs
      ;;  :after (evil general)
      ;;  :ghook ('after-init-hook
      ;;          (lambda (&rest _)
      ;;            (when-let ((messages-buffer (get-buffer "*Messages*")))
      ;;              (with-current-buffer messages-buffer
      ;;                (evil-normalize-keymaps))))
      ;;          nil nil t))

;; (define-key KEYMAP KEY DEF)
;; (global-set-key KEY COMMAND)
;; (use-package :bind (  ))

(evil-define-key 'normal 'global (kbd "] d") 'flymake-goto-next-error) ;; Go to next Flymake error
(evil-define-key 'normal 'global (kbd "[ d") 'flymake-goto-prev-error) ;; Go to previous Flymake error

;; Diff-HL navigation for version control
(evil-define-key 'normal 'global (kbd "] g") 'diff-hl-next-hunk) ;; Next diff hunk
(evil-define-key 'normal 'global (kbd "[ g") 'diff-hl-previous-hunk) ;; Previous diff hunk

;; Buffer management keybindings
(evil-define-key 'normal 'global (kbd "] b") 'next-buffer) ;; Switch to next buffer
(evil-define-key 'normal 'global (kbd "[ b") 'previous-buffer) ;; Switch to previous buffer

;; Tab navigation
(evil-define-key 'normal 'global (kbd "] t") 'tab-next) ;; Go to next tab
(evil-define-key 'normal 'global (kbd "[ t") 'tab-previous) ;; Go to previous tab

;; todo navigation
(evil-define-key 'normal 'global (kbd "] T") 'hl-todo-next) ;; Go to next todo
(evil-define-key 'normal 'global (kbd "[ T") 'hl-todo-previous) ;; Go to previous todo

;; ;; LSP commands keybindings
;; TODO: make this work? moreso the 'K' and 'gd'
;; (evil-define-key 'normal lsp-mode-map
;;                  ;; (kbd "gd") 'lsp-find-definition                ;; evil-collection already provides gd
;;                  (kbd "gr") 'lsp-find-references                   ;; Finds LSP references
;;                  (kbd "<leader> c a") 'lsp-execute-code-action     ;; Execute code actions
;;                  (kbd "<leader> r n") 'lsp-rename                  ;; Rename symbol
;;                  (kbd "gI") 'lsp-find-implementation               ;; Find implementation
;;                  (kbd "<leader> l f") 'lsp-format-buffer)          ;; Format buffer via lsp


;; (defun ek/lsp-describe-and-jump ()
;;   "Show hover documentation and jump to *lsp-help* buffer."
;;   (interactive)
;;   (lsp-describe-thing-at-point)
;;   (let ((help-buffer "*lsp-help*"))
;;     (when (get-buffer help-buffer)
;;       (switch-to-buffer-other-window help-buffer))))

;; Commenting functionality for single and multiple lines
;; this eliminates need for evil-commentary
(evil-define-key 'normal 'global (kbd "gcc")
                 (lambda ()
                   (interactive)
                   (if (not (use-region-p))
                       (comment-or-uncomment-region (line-beginning-position) (line-end-position)))))

(evil-define-key 'visual 'global (kbd "gc")
                 (lambda ()
                   (interactive)
                   (if (use-region-p)
                       (comment-or-uncomment-region (region-beginning) (region-end)))))

(use-package undo-fu
:defer
:config
;; Increase undo history limits to reduce likelihood of data loss
(setq undo-limit (* 1024 1024 64)          ;; 64mb  (default is 160kb)
    undo-strong-limit (* 1024 1024 96)   ;; 96mb  (default is 240kb)
    undo-outer-limit (* 1024 1024 960))) ;; 960mb (default is 24mb)

(use-package undo-fu-session
    :hook (after-init . undo-fu-session-global-mode)
    :custom (undo-fu-session-incompatible-files '("\\.gpg$" "/COMMIT_EDITMSG\\'" "/git-rebase-todo\\'"))
    :config
    (when (executable-find "zstd")
    ;; There are other algorithms available, but zstd is the fastest, and speed
    ;; is our priority within Emacs
    (setq undo-fu-session-compression 'zst)))

(use-package vundo
    :defer
    :custom
    (vundo-glyph-alist vundo-unicode-symbols)
    (vundo-compact-display t))

;; NOTE: best monokai look-alike imo. abit outdated though
;; (use-package monokai-pro-theme
;;     :config
;;     (load-theme 'monokai-pro-classic t))

(use-package doom-themes
:config
(setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
          doom-themes-enable-italic t) ; if nil, italics is universally disabled
    (load-theme 'doom-monokai-classic t)   ;; Sets the default theme to load!!!
    (doom-themes-org-config))

;; (add-to-list 'default-frame-alist '(alpha-background . 90)) ;; For all new frames henceforth

 ;; Transparency in terminal
;; (defun start/tui-enable-transparency ()
;;    (unless (display-graphic-p (selected-frame))
;;      (set-face-background 'default "unspecified-bg" (selected-frame))))

;;  (add-hook 'window-setup-hook 'start/tui-enable-transparency)

(use-package doom-modeline
  :custom
  (doom-modeline-buffer-file-name-style 'buffer-name)  ;; Set the buffer file name style to just the buffer name (without path).
  (doom-modeline-project-detection 'project)           ;; Enable project detection for displaying the project name.
  (doom-modeline-buffer-name t)                        ;; Show the buffer name in the mode line.
  (doom-modeline-vcs-max-length 25)                    ;; Limit the version control system (VCS) branch name length to 25 characters.
  :hook
  (after-init . doom-modeline-mode))

(use-package nerd-icons :defer)

(use-package nerd-icons-dired
  :hook (dired-mode . nerd-icons-dired-mode))

(use-package nerd-icons-ibuffer
  :hook (ibuffer-mode . nerd-icons-ibuffer-mode))

(use-package eglot
  :ensure nil ;; Don't install eglot because it's now built-in
  :hook ((c-mode
		 c++-mode ;; Autostart lsp servers for a given mode
         python-base-mode                             ;; Enable LSP for Python
		 lua-mode ;; Lua-mode needs to be installed
         js-mode                                      ;; Enable LSP for JavaScript
         typescript-ts-base-mode                      ;; Enable LSP for TypeScript
         ;; css-mode                                     ;; Enable LSP for CSS
         ;; go-ts-mode                                   ;; Enable LSP for Go
         ;; js-ts-mode                                   ;; Enable LSP for JavaScript (TS mode)
         ;; prisma-mode                                  ;; Enable LSP for Prisma
         ;; tsx-ts-mode                                  ;; Enable LSP for TSX
         ;; ruby-base-mode                               ;; Enable LSP for Ruby
         ;; rust-ts-mode                                 ;; Enable LSP for Rust
         web-mode) . eglot-ensure)
  :custom
  ;; Good default
  (eglot-events-buffer-size 0) ;; No event buffers (LSP server logs)
  (eglot-autoshutdown t);; Shutdown unused servers.
  (eglot-report-progress nil) ;; Disable LSP server logs (Don't show lsp messages at the bottom, java)
  )

(use-package mason
      :hook (after-init . mason-ensure)
	  :config
    (mason-setup))

(mason-setup
  (dolist (pkg '("basedpyright"
                "jdtls"
                "clangd"
                "cpptools"
                "json-lsp"
                "yaml-language-server"
                "typescript-language-server"
                "bash-language-server"
                "docker-compose-language-service"))
    (unless (mason-installed-p pkg)
      (ignore-errors (mason-install pkg)))))

(use-package sideline-flymake
  :hook ((flymake-mode . sideline-mode)
			 (prog-mode . flymake-mode))
  :custom
  (sideline-flymake-display-mode 'line) ;; Show errors on the current line
  (sideline-backends-right '(sideline-flymake)))

(use-package yasnippet
  :hook (prog-mode . yas-minor-mode))

(use-package yasnippet-snippets :defer)

(defun start/corfu-yas-tab-handler ()
  "Prioritize corfu over yasnippet when yasnippet is active"
  (interactive)
  ;; There is no direct way to get if corfu is currently displayed so we watch the completion index
  (if (> corfu--index -1)
      (corfu-complete)
    (yas-next-field-or-maybe-expand)
    ))
(use-package emacs
  :after (yasnippet corfu)
  :bind
  (:map yas-keymap
        ("TAB" . start/corfu-yas-tab-handler)))

(setq treesit-language-source-alist
          '((bash "https://github.com/tree-sitter/tree-sitter-bash")
            (cmake "https://github.com/uyha/tree-sitter-cmake")
            (make "https://github.com/alemuller/tree-sitter-make")
            (c "https://github.com/tree-sitter/tree-sitter-c")
            (cpp "https://github.com/tree-sitter/tree-sitter-cpp")
            (elisp "https://github.com/Wilfred/tree-sitter-elisp")
            (python "https://github.com/tree-sitter/tree-sitter-python")
            (javascript "https://github.com/tree-sitter/tree-sitter-javascript" "master" "src")
            (typescript "https://github.com/tree-sitter/tree-sitter-typescript" "master" "typescript/src")
            ;; (json "https://github.com/tree-sitter/tree-sitter-json")
            ;; (markdown "https://github.com/ikatyang/tree-sitter-markdown")
            ;; (rust "https://github.com/tree-sitter/tree-sitter-rust")
            ;; (toml "https://github.com/tree-sitter/tree-sitter-toml")
            ;; (tsx "https://github.com/tree-sitter/tree-sitter-typescript" "master" "tsx/src")
            ;; (gdscript "https://github.com/PrestonKnopp/tree-sitter-gdscript")
            ;; (go "https://github.com/tree-sitter/tree-sitter-go")
            ;; (gomod "https://github.com/camdencheek/tree-sitter-go-mod")
            ;; (html "https://github.com/tree-sitter/tree-sitter-html")
            ;; (hyprlang "https://github.com/tree-sitter-grammars/tree-sitter-hyprlang")
            ;; (vue "https://github.com/ikatyang/tree-sitter-vue")
            ;; (css "https://github.com/tree-sitter/tree-sitter-css")
            ;; (yaml "https://github.com/ikatyang/tree-sitter-yaml")
))

    (defun start/install-treesit-grammars ()
      "Install missing treesitter grammars"
      (interactive)
      (dolist (grammar treesit-language-source-alist)
        (let ((lang (car grammar)))
          (unless (treesit-language-available-p lang)
            (treesit-install-language-grammar lang)))))

    ;; Call this function to install missing grammars
    (add-hook 'after-init-hook #'start/install-treesit-grammars)

    ;; Optionally, add any additional mode remappings not covered by defaults
    (setq major-mode-remap-alist
          '((yaml-mode . yaml-ts-mode)
            (sh-mode . bash-ts-mode)
            (c-mode . c-ts-mode)
            (c++-mode . c++-ts-mode)
            (css-mode . css-ts-mode)
            (python-mode . python-ts-mode)
            (mhtml-mode . html-ts-mode)
            (javascript-mode . js-ts-mode)
            (js-json-mode . json-ts-mode)
            (typescript-mode . typescript-ts-mode)
            ;; (conf-toml-mode . toml-ts-mode)
            ;; (gdscript-mode . gdscript-ts-mode)
            ))
    (setq treesit-font-lock-level 3)

(use-package lua-mode
  :mode "\\.lua\\'") ;; Only start in a lua file

(use-package org
  :ensure nil
  :defer t
  :custom
  ;; (org -edit-src-content-indentation 4) ;; Set src block automatic indent to 4 instead of 2.
  (org-return-follows-link t)   ;; Sets RETURN key in org-mode to follow links
  :hook
  (org-mode . org-indent-mode) ;; Indent text
  )

(use-package toc-org
  :commands toc-org-enable
  :hook (org-mode . toc-org-mode))

(use-package org-superstar
  :after org
  :hook (org-mode . org-superstar-mode))

(use-package exec-path-from-shell
  :hook (after-init . exec-path-from-shell-initialize))

(use-package sudo-edit)

(use-package dotenv-mode
  :defer t)

;; (add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

;; (require 'start-multiFileExample)

;; (start/hello)

(use-package transient
  :defer
  :config
  (define-key transient-map (kbd "<escape>") 'transient-quit-one)) ;; Make escape quit magit prompts

(use-package magit
  :defer
  :custom (magit-diff-refine-hunk (quote all)) ;; Shows inline diff
  :config
  (setopt magit-format-file-function #'magit-format-file-nerd-icons) ;; Magit nerd icons
  )

(use-package diff-hl
  :hook ((dired-mode         . diff-hl-dired-mode-unless-remote)
         (magit-post-refresh . diff-hl-magit-post-refresh)
         (after-init . global-diff-hl-mode)))

(use-package corfu
  ;; Optional customizations
  :custom
  (corfu-cycle t)                ;; Enable cycling for `corfu-next/previous'
  (corfu-auto t)                 ;; Enable auto completion
  (corfu-auto-prefix 2)          ;; Minimum length of prefix for auto completion.
  (corfu-quit-no-match t)        ;; Quit if there is no match
  (corfu-popupinfo-mode t)       ;; Enable popup information
  (corfu-popupinfo-delay 0.5)    ;; Lower popup info delay to 0.5 seconds from 2 seconds
  (corfu-separator ?\s)          ;; Orderless field separator, Use M-SPC to enter separator
  ;; (corfu-quit-at-boundary nil)   ;; Never quit at completion boundary
  ;; (corfu-preview-current nil)    ;; Disable current candidate preview
  ;; (corfu-preselect 'prompt)      ;; Preselect the prompt
  ;; (corfu-on-exact-match nil)     ;; Configure handling of exact matches
  ;; (corfu-scroll-margin 5)        ;; Use scroll margin
  (completion-ignore-case t)

  ;; Emacs 30 and newer: Disable Ispell completion function.
  ;; Try `cape-dict' as an alternative.
  (text-mode-ispell-word-completion nil)

  ;; Enable indentation+completion using the TAB key.
  ;; `completion-at-point' is often bound to M-TAB.
  (tab-always-indent 'complete)

  (corfu-preview-current nil) ;; Don't insert completion without confirmation
  ;; Recommended: Enable Corfu globally.  This is recommended since Dabbrev can
  ;; be used globally (M-/).  See also the customization variable
  ;; `global-corfu-modes' to exclude certain modes.
  :init
  (global-corfu-mode))

(use-package nerd-icons-corfu
  :after corfu
  :init (add-to-list 'corfu-margin-formatters #'nerd-icons-corfu-formatter))

(use-package yasnippet-capf :defer)

(defun start/setup-capfs ()
  "Configure completion backends"
  ;; Take care when adding Capfs to the list since each of the Capfs adds a small runtime cost.
  (let ((merge-backends (list
                         #'cape-keyword      ;; Keyword completion
                         ;; #'cape-abbrev       ;; Complete abbreviation
                         #'cape-dabbrev      ;; Complete word from current buffers
                         ;; #'cape-line         ;; Complete entire line from current buffer
                         ;; #'cape-history      ;; Complete from Eshell, Comint or minibuffer history
                         ;; #'cape-dict         ;; Dictionary completion (Needs Dictionary file installed)
                         ;; #'cape-tex          ;; Complete Unicode char from TeX command, e.g. \hbar
                         ;; #'cape-sgml         ;; Complete Unicode char from SGML entity, e.g., &alpha
                         ;; #'cape-rfc1345      ;; Complete Unicode char using RFC 1345 mnemonics
                         ;; #'snippy-capf       ;; Vscode Snippets (Snippy needs to be installed)
                         #'yasnippet-capf    ;; Yasnippet snippets
                         ))
        (seperate-backends (list
                            #'cape-file ;; Path completion
                            #'cape-elisp-block ;; Complete elisp in Org or Markdown mode
                            )))
    ;; Remove keyword completion in git commits
    (when (derived-mode-p 'git-commit-mode)
      (setq merge-backends (remq #'cape-keyword merge-backends)))

    ;; Add Elisp symbols only in Elisp modes
    (when (derived-mode-p 'emacs-lisp-mode 'ielm-mode)
      (setq merge-backends (cons #'cape-elisp-symbol merge-backends))) ;; Emacs Lisp code (functions, variables)

    ;; Add Eglot to the front of the list if it's active
    (when (bound-and-true-p eglot--managed-mode)
      (setq merge-backends (cons #'eglot-completion-at-point merge-backends)))

    ;; Create the super-capf and set it buffer-locally
    (setq-local completion-at-point-functions
                (append
                 seperate-backends
                 (list (apply #'cape-capf-super merge-backends)))
                )))

(use-package cape
  :after (corfu)
  :init
  ;; Add to the global default value of `completion-at-point-functions' which is
  ;; used by `completion-at-point'.  The order of the functions matters, the
  ;; first function returning a result wins.  Note that the list of buffer-local
  ;; completion functions takes precedence over the global list.

  ;; Seperate function needed, because we use setq-local (everything is replaced)
  (add-hook 'eglot-managed-mode-hook #'start/setup-capfs)
  (add-hook 'prog-mode-hook #'start/setup-capfs)
  (add-hook 'text-mode-hook #'start/setup-capfs))

(use-package orderless
  :defer    ;; load on demand
  :after vertico    ;; load after vertico
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

(use-package vertico
  :hook (after-init . vertico-mode)
  ;; Vim keybinds. uses C-n/p by default
  :bind (:map vertico-map
             ("C-j" . vertico-next)
             ("C-k" . vertico-previous)
             ("C-u" . vertico-scroll-down)
             ("C-d" . vertico-scroll-up))
  :custom
  (vertico-cycle t) ;; Enable cycling for `vertico-next/previous'
  ;; :config
  ;; ;; Customize the display of the current candidate in the completion list.
  ;; ;; This will prefix the current candidate with “» ” to make it stand out.
  ;; ;; Reference: https://github.com/minad/vertico/wiki#prefix-current-candidate-with-arrow
  ;; (advice-add #'vertico--format-candidate :around
  ;;             (lambda (orig cand prefix suffix index _start)
  ;;                 (setq cand (funcall orig cand prefix suffix index _start))
  ;;                 (concat
  ;;                 (if (= vertico--index index)
  ;;                     (propertize "» " 'face '(:foreground "#80adf0" :weight bold))
  ;;                 "  ")
  ;;                 cand)))
  )

(savehist-mode) ;; Enables save history mode

(use-package marginalia
  :after vertico
  :config
  (marginalia-mode))

(use-package nerd-icons-completion
  :after marginalia
  :config
  (nerd-icons-completion-mode)
  :hook
  (marginalia-mode . nerd-icons-completion-marginalia-setup))

(use-package consult
  ;; Enable automatic preview at point in the *Completions* buffer. This is
  ;; relevant when you use the default completion UI.
  :hook (completion-list-mode . consult-preview-at-point-mode)
  :init
  ;; Optionally configure the register formatting. This improves the register
  ;; preview for `consult-register', `consult-register-load',
  ;; `consult-register-store' and the Emacs built-ins.
  (setq register-preview-delay 0.5
        register-preview-function #'consult-register-format)

  ;; Optionally tweak the register preview window.
  ;; This adds thin lines, sorting and hides the mode line of the window.
  (advice-add #'register-preview :override #'consult-register-window)

  ;; Use Consult to select xref locations with preview
  (setq xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref)
  :config
  ;; Optionally configure preview. The default value
  ;; is 'any, such that any key triggers the preview.
  (setq consult-preview-key 'any)
  (setq consult-preview-key "M-.")
  (setq consult-preview-key '("S-<down>" "S-<up>"))

  ;; For some commands and buffer sources it is useful to configure the
  ;; :preview-key on a per-command basis using the `consult-customize' macro.
  ;; (consult-customize
  ;; consult-theme :preview-key '(:debounce 0.2 any)
  ;; consult-ripgrep consult-git-grep consult-grep
  ;; consult-bookmark consult-recent-file consult-xref
  ;; consult--source-bookmark consult--source-file-register
  ;; consult--source-recent-file consult--source-project-recent-file
  ;; :preview-key "M-."
  ;; :preview-key '(:debounce 0.4 any))

  ;; By default `consult-project-function' uses `project-root' from project.el.
  ;; Optionally configure a different project root function.
   ;;;; 1. project.el (the default)
  ;; (setq consult-project-function #'consult--default-project--function)
   ;;;; 2. vc.el (vc-root-dir)
  ;; (setq consult-project-function (lambda (_) (vc-root-dir)))
   ;;;; 3. locate-dominating-file
  ;; (setq consult-project-function (lambda (_) (locate-dominating-file "." ".git")))
   ;;;; 4. projectile.el (projectile-project-root)
  (autoload 'projectile-project-root "projectile")
  (setq consult-project-function (lambda (_) (projectile-project-root)))
   ;;;; 5. No project support
  ;; (setq consult-project-function nil)
  )

;; Note that the built-in `describe-function' includes both functions
  ;; and macros. `helpful-function' is functions only, so we provide
  ;; `helpful-callable' as a drop-in replacement.
(use-package helpful)

(use-package diminish :defer)

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package rainbow-mode
  :hook (prog-mode org-mode))

(use-package hl-todo
  :hook
  ((prog-mode yaml-ts-mode) . hl-todo-mode)
  :config
  ;; From doom emacs
  (setq hl-todo-highlight-punctuation ":"
        hl-todo-keyword-faces
        '(;; For reminders to change or add something at a later date.
          ("TODO" warning bold)
          ;; For code (or code paths) that are broken, unimplemented, or slow,
          ;; and may become bigger problems later.
          ("FIXME" error bold)
          ;; For code that needs to be revisited later, either to upstream it,
          ;; improve it, or address non-critical issues.
          ("REVIEW" font-lock-keyword-face bold)
          ;; For code smells where questionable practices are used
          ;; intentionally, and/or is likely to break in a future update.
          ("HACK" font-lock-constant-face bold)
          ;; For sections of code that just gotta go, and will be gone soon.
          ;; Specifically, this means the code is deprecated, not necessarily
          ;; the feature it enables.
          ("DEPRECATED" font-lock-doc-face bold)
          ;; Extra keywords commonly found in the wild, whose meaning may vary
          ;; from project to project.
          ("NOTE" success bold)
          ("BUG" error bold)))
  )

(use-package indent-guide
  :hook
  (prog-mode . indent-guide-mode)
  :config
  (setq indent-guide-char "│")) ;; Set the character used for the indent guide.

(use-package which-key
  :ensure nil ;; Don't install which-key because it's now built-in
  :hook (after-init . which-key-mode)
  :diminish
  :custom
  (which-key-side-window-location 'bottom)
  (which-key-sort-order #'which-key-key-order-alpha) ;; Same as default, except single characters are sorted alphabetically
  (which-key-sort-uppercase-first nil)
  (which-key-add-column-padding 1) ;; Number of spaces to add to the left of each column
  (which-key-separator "  ")
  (which-key-min-display-lines 6)  ;; Increase the minimum lines to display because the default is only 1
  (which-key-idle-delay 0.5)       ;; Set the time delay (in seconds) for the which-key popup to appear
  (which-key-max-description-length 70)
  (which-key-allow-imprecise-window-fit nil)) ;; Fixes which-key window slipping out in Emacs Daemon

(use-package ws-butler
  :hook (after-init . ws-butler-global-mode))
