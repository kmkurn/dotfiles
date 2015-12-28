;; --------------------------------------------------
;; Package initialization
;; --------------------------------------------------

;; Initialize Emacs package manager
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-initialize)

;; Function to install package if not installed yet
(defun install-package-if-not-exist (pkg)
  "Install PKG if not installed yet"
  (when (not (package-installed-p pkg))
    (package-refresh-contents)
    (package-install pkg)))

;; --------------------------------------------------
;; General settings
;; --------------------------------------------------

;; Copy shell $PATH to emacs $PATH and exec-path
(install-package-if-not-exist 'exec-path-from-shell)
;; Shut the annoying warning up
(setq exec-path-from-shell-check-startup-files nil)
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))


;; Auto-complete for emacs
(install-package-if-not-exist 'company)
(add-hook 'after-init-hook 'global-company-mode)
(with-eval-after-load 'company
  (define-key company-active-map (kbd "TAB") 'company-complete-common-or-cycle)
  (define-key company-active-map (kbd "<tab>") 'company-complete-common-or-cycle)
  (define-key company-active-map (kbd "S-TAB") 'company-select-previous)
  (define-key company-active-map (kbd "<backtab>") 'company-select-previous))


;; Project management
(install-package-if-not-exist 'projectile)
(projectile-global-mode)
(setq projectile-completion-system 'helm)
(setq projectile-switch-project-action 'helm-projectile)
(setq projectile-enable-caching t)


;; Emacs incremental and narrowing framework; better than ido-mode
(install-package-if-not-exist 'helm)
(require 'helm)
(require 'helm-config)
;; The default "C-x c" is quite close to "C-x C-c", which quits Emacs.
;; Changed to "C-c h". Note: We must set "C-c h" globally, because we
;; cannot change `helm-command-prefix-key' once `helm-config' is loaded.
(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action)
(define-key helm-map (kbd "C-z") 'helm-select-action)

(when (executable-find "curl")
  (setq helm-google-suggest-use-curl-p t))

(setq helm-split-window-in-side-p t
      helm-move-to-line-cycle-in-source t
      helm-ff-search-library-in-sexp t
      helm-scroll-amount 8
      helm-ff-file-name-history-use-recentf t)

(helm-mode 1)

(helm-autoresize-mode t)

(global-set-key (kbd "M-x") 'helm-M-x)
(setq helm-M-x-fuzzy-match t)

(global-set-key (kbd "M-y") 'helm-show-kill-ring)

(global-set-key (kbd "C-x b") 'helm-mini)
(setq helm-buffers-fuzzy-matching t
      helm-recentf-fuzzy-match t)

(global-set-key (kbd "C-x C-f") 'helm-find-files)

(setq helm-semantic-fuzzy-match t
      helm-imenu-fuzzy-match t)

(global-set-key (kbd "C-c h o") 'helm-occur)

(setq helm-apropos-fuzzy-match t)

(global-set-key (kbd "C-c h SPC") 'helm-all-mark-rings)


;; Integrate projectile and helm
(install-package-if-not-exist 'helm-projectile)
(helm-projectile-on)


;; Enhance `describe-bindings' with helm
(install-package-if-not-exist 'helm-descbinds)
(require 'helm-descbinds)
(helm-descbinds-mode)


;; Major mode for editing web templates
(install-package-if-not-exist 'web-mode)
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.jsx\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.hbs\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
;; Make web-mode and smartparens work nicely
(add-hook 'web-mode-hook (lambda ()
                           (setq web-mode-enable-auto-pairing nil)))
(defun sp-web-mode-is-code-context (id action context)
  (and (eq action 'insert)
       (not (or (get-text-property (point) 'part-side)
                (get-text-property (point) 'block-side)))))
(with-eval-after-load 'smartparens
  (sp-local-pair 'web-mode "<" nil :when '(sp-web-mode-is-code-context)))


;; Deal with parentheses (or pairs) easily
(install-package-if-not-exist 'smartparens)
(require 'smartparens-config)
(smartparens-global-mode)
(sp-use-smartparens-bindings)


;; On-the-fly syntax checking
(install-package-if-not-exist 'flycheck)
(add-hook 'after-init-hook #'global-flycheck-mode)
(with-eval-after-load 'flycheck
  (setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc)))


;; Better mode-line
(install-package-if-not-exist 'powerline)
(require 'powerline)
(powerline-default-theme)


;; Colorize mode-line according to flycheck status
(install-package-if-not-exist 'flycheck-color-mode-line)
(require 'flycheck-color-mode-line)
(with-eval-after-load 'flycheck
  (add-hook 'flycheck-mode-hook 'flycheck-color-mode-line-mode))


;; Display flycheck errors on popups
(install-package-if-not-exist 'flycheck-pos-tip)
(with-eval-after-load 'flycheck
  (flycheck-pos-tip-mode))


;; editorconfig support
(install-package-if-not-exist 'editorconfig)
(require 'editorconfig)
(editorconfig-mode 1)


;; Vim emulation
(install-package-if-not-exist 'evil)
(require 'evil)
(evil-mode 1)
(define-key evil-normal-state-map (kbd "C-u") 'evil-scroll-up)
(define-key evil-visual-state-map (kbd "C-u") 'evil-scroll-up)
(define-key evil-insert-state-map (kbd "jk") 'evil-normal-state)


;; Better powerline for evil
(install-package-if-not-exist 'powerline-evil)
(require 'powerline-evil)
(powerline-evil-vim-color-theme)

;; --------------------------------------------------
;; Python
;; --------------------------------------------------

;; Code navigation, documentation lookup, and completion
(install-package-if-not-exist 'anaconda-mode)
(add-hook 'python-mode-hook 'anaconda-mode)
(add-hook 'python-mode-hook 'eldoc-mode)


;; Anaconda backend for company
(install-package-if-not-exist 'company-anaconda)
(with-eval-after-load 'company
  (add-to-list 'company-backends 'company-anaconda))


;; Use `pyenv' inside emacs
(install-package-if-not-exist 'pyenv-mode)
(require 'pyenv-mode)
(pyenv-mode)

(defun projectile-pyenv-mode-set ()
  "Set pyenv version matching project name."
  (let ((project (projectile-project-name)))
    (if (member project (pyenv-mode-versions))
        (pyenv-mode-set project)
      (pyenv-mode-unset))))

(defun projectile-pyenv-hook ()
  "Set pyenv version if .python-version file exists."
  (f-traverse-upwards
   (lambda (path)
     (let ((pyenv-version-path (f-expand ".python-version" path)))
       (if (f-exists? pyenv-version-path)
           (pyenv-mode-set (s-trim (f-read-text pyenv-version-path 'utf-8))))))))

(add-hook 'projectile-after-switch-project-hook 'projectile-pyenv-mode-set)
(add-hook 'projectile-after-switch-project-hook 'projectile-pyenv-hook)


;; --------------------------------------------------
;; Haskell
;; --------------------------------------------------

(install-package-if-not-exist 'haskell-mode)
(add-hook 'haskell-mode-hook 'haskell-indentation-mode)
(require 'haskell-interactive-mode)
(require 'haskell-process)
(add-hook 'haskell-mode-hook 'interactive-haskell-mode)

(install-package-if-not-exist 'ghc)
(autoload 'ghc-init "ghc" nil t)
(autoload 'ghc-debug "ghc" nil t)
(add-hook 'haskell-mode-hook 'ghc-init)

(install-package-if-not-exist 'company-ghc)
(add-hook 'haskell-mode-hook
          (lambda () (add-to-list 'company-backends 'company-ghc)))


;; --------------------------------------------------
;; JavaScript/NodeJS
;; --------------------------------------------------

;; Better mode for JavaScript
(install-package-if-not-exist 'js2-mode)
(add-hook 'js-mode-hook 'js2-minor-mode)
(setq js2-include-node-externs t  ; NodeJS
      js2-global-externs (list "define")  ; RequireJS
      js2-highlight-level 3)


;; Emacs integration with Tern
(install-package-if-not-exist 'tern)
(add-hook 'js-mode-hook 'tern-mode)
(add-hook 'web-mode-hook (lambda ()
                           (if (equal web-mode-content-type "jsx")
                               (tern-mode))))


;; Tern backend for company
(install-package-if-not-exist 'company-tern)
(with-eval-after-load 'tern
  (add-to-list 'company-backends 'company-tern))


;; Use `nvm' inside emacs
(install-package-if-not-exist 'nvm)
(require 'nvm)
;; Make nvm-use interactive. This is copied and modified from
;; https://github.com/redguardtoo/js-comint/blob/master/js-comint.el
(defun list-nvm-versions (prompt)
  "List all available node versions from nvm prompting the user with PROMPT.
Return a string representing the node version."
  (let ((candidates (sort (mapcar 'car (nvm--installed-versions)) 'string<)))
    (completing-read prompt
                     candidates nil t nil
                     nil
                     (car candidates))))
(defun do-nvm-use ()
  "Do `nvm-use` interactively."
  (interactive)
  (nvm-use
   (list-nvm-versions
    (if nvm-current-version
        (format "Node version (current %s): " (car nvm-current-version))
      "Node version: ")))
  (setq exec-path (split-string (getenv "PATH") path-separator)))


;; Better NodeJS REPL inside emacs
(install-package-if-not-exist 'nodejs-repl)
(require 'nodejs-repl)
;; Taken from http://williambert.online/2014/02/using-a-node-repl-with-emacs/
(defun nodejs-repl-from-dir (cwd)
  "Run Node.js REPL from a directory."
  (interactive "DDirectory: ")
  (let ((default-directory cwd))
    (nodejs-repl)))

;; Set indentation for JavaScript and JSX files
(add-hook 'js-mode-hook (lambda () (setq-local js-indent-level 2)))
(add-hook 'web-mode-hook (lambda ()
                           (if (equal web-mode-content-type "jsx")
                               (progn
                                 (setq-local web-mode-code-indent-offset 2)
                                 (setq-local web-mode-markup-indent-offset 2)))))

;; --------------------------------------------------
;; LESS/CSS
;; --------------------------------------------------

(install-package-if-not-exist 'less-css-mode)
(require 'less-css-mode)

;; --------------------------------------------------
;; Colorscheme
;; --------------------------------------------------

(install-package-if-not-exist 'gruvbox-theme)
(defun load-gruvbox-theme (frame)
  (select-frame frame)
  (load-theme 'gruvbox t))
(if (daemonp)
    (add-hook 'after-make-frame-functions #'load-gruvbox-theme)
  (load-theme 'gruvbox t))

;; --------------------------------------------------
;; Font
;; --------------------------------------------------

(when (member "Inconsolata" (font-family-list))
  (let
      ((my-font-spec "-*-Inconsolata-normal-normal-normal-*-14-*-*-*-m-0-iso10646-1"))
    (set-frame-font my-font-spec nil t)
    (set-face-attribute 'default nil :font my-font-spec)
    (set-face-font 'default my-font-spec nil)))

;; --------------------------------------------------
;; Basic settings
;; --------------------------------------------------

;; Display line numbers
(global-linum-mode 1)

;; Indent only using spaces (no tabs)
(setq-default indent-tabs-mode nil)

;; Display tabs as 4 spaces
(setq-default tab-width 4)

;; Make tab key do indentation first then completion
(setq-default tab-always-indent 'complete)

;; Highlight matching bracket
(show-paren-mode 1)

;; Enable semantic mode
(semantic-mode 1)

;; --------------------------------------------------
;; Custom keybindings
;; --------------------------------------------------

(global-set-key (kbd "RET") 'newline-and-indent)
(global-set-key (kbd "C-c i") (lambda () (interactive)
                                (find-file "~/.emacs")))

;; --------------------------------------------------
;; Miscellaneous
;; --------------------------------------------------

;; Kill toolbar and scrollbar
(tool-bar-mode -1)
(scroll-bar-mode -1)
(unless (display-graphic-p) (menu-bar-mode -1))

;; Kill annoying welcome screen
(setq inhibit-startup-message t)
(setq inhibit-startup-echo-area-message t)

;; Always maximize frame
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; Disable backup and auto-save
(setq backup-inhibited t)
(setq auto-save-default nil)

;; Replace yes no prompt
(fset 'yes-or-no-p 'y-or-n-p)

;; Customize
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
