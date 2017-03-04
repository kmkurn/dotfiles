;; -*- mode: emacs-lisp -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

(defun dotspacemacs/layers ()
  "Configuration Layers declaration.
You should not put any user code in this function besides modifying the variable
values."
  (setq-default
   ;; Base distribution to use. This is a layer contained in the directory
   ;; `+distribution'. For now available distributions are `spacemacs-base'
   ;; or `spacemacs'. (default 'spacemacs)
   dotspacemacs-distribution 'spacemacs
   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (i.e. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '()
   ;; List of configuration layers to load. If it is the symbol `all' instead
   ;; of a list then all discovered layers will be installed.
   dotspacemacs-configuration-layers
   '(
     ;; ----------------------------------------------------------------
     ;; Example of useful layers you may want to use right away.
     ;; Uncomment some layer names and press <SPC f e R> (Vim style) or
     ;; <M-m f e R> (Emacs style) to install them.
     ;; ----------------------------------------------------------------
     ansible
     (auto-completion :variables
                      auto-completion-enable-snippets-in-popup t
                      auto-completion-enable-sort-by-usage t)
     better-defaults
     bibtex
     csv
     emacs-lisp
     git
     (haskell :variables
              haskell-enable-hindent-style "johan-tibell")
     html
     javascript
     latex
     markdown
     org
     osx
     pandoc
     (python :variables
             python-test-runner 'pytest)
     (ranger :variables
             ranger-show-preview t)
     react
     restclient
     ruby
     search-engine
     (shell :variables
            shell-default-shell 'ansi-term
            shell-default-term-shell "/usr/local/bin/bash"
            shell-default-height 30
            shell-default-position 'bottom)
     syntax-checking
     themes-megapack
     vimscript
     xkcd
     yaml
     )
   ;; List of additional packages that will be installed without being
   ;; wrapped in a layer. If you need some configuration for these
   ;; packages then consider to create a layer, you can also put the
   ;; configuration in `dotspacemacs/config'.
   dotspacemacs-additional-packages '(nvm
                                      nodejs-repl
                                      editorconfig
                                      shakespeare-mode
                                      company-restclient)
   ;; A list of packages and/or extensions that will not be install and loaded.
   dotspacemacs-excluded-packages '()
   ;; If non-nil spacemacs will delete any orphan packages, i.e. packages that
   ;; are declared in a layer which is not a member of
   ;; the list `dotspacemacs-configuration-layers'. (default t)
   dotspacemacs-delete-orphan-packages t))

(defun dotspacemacs/init ()
  "Initialization function.
This function is called at the very startup of Spacemacs initialization
before layers configuration.
You should not put any user code in there besides modifying the variable
values."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   ;; One of `vim', `emacs' or `hybrid'. Evil is always enabled but if the
   ;; variable is `emacs' then the `holy-mode' is enabled at startup. `hybrid'
   ;; uses emacs key bindings for vim's insert mode, but otherwise leaves evil
   ;; unchanged. (default 'vim)
   dotspacemacs-editing-style 'vim
   ;; If non nil output loading progress in `*Messages*' buffer. (default nil)
   dotspacemacs-verbose-loading nil
   ;; Specify the startup banner. Default value is `official', it displays
   ;; the official spacemacs logo. An integer value is the index of text
   ;; banner, `random' chooses a random text banner in `core/banners'
   ;; directory. A string value must be a path to an image format supported
   ;; by your Emacs build.
   ;; If the value is nil then no banner is displayed. (default 'official)
   dotspacemacs-startup-banner 'official
   ;; List of items to show in the startup buffer. If nil it is disabled.
   ;; Possible values are: `recents' `bookmarks' `projects'.
   ;; (default '(recents projects))
   dotspacemacs-startup-lists '(recents projects)
   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press <SPC> T n to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(sanityinc-solarized-dark
                         gruvbox)
   ;; If non nil the cursor color matches the state color.
   dotspacemacs-colorize-cursor-according-to-state t
   ;; Default font. `powerline-scale' allows to quickly tweak the mode-line
   ;; size to make separators look not too crappy.
   dotspacemacs-default-font '("Meslo LG M for Powerline"
                               :size 12
                               :weight normal
                               :width normal
                               :powerline-scale 1.1)
   ;; The leader key
   dotspacemacs-leader-key "SPC"
   ;; The leader key accessible in `emacs state' and `insert state'
   ;; (default "M-m")
   dotspacemacs-emacs-leader-key "M-m"
   ;; Major mode leader key is a shortcut key which is the equivalent of
   ;; pressing `<leader> m`. Set it to `nil` to disable it. (default ",")
   dotspacemacs-major-mode-leader-key ","
   ;; Major mode leader key accessible in `emacs state' and `insert state'.
   ;; (default "C-M-m)
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"
   ;; The command key used for Evil commands (ex-commands) and
   ;; Emacs commands (M-x).
   ;; By default the command key is `:' so ex-commands are executed like in Vim
   ;; with `:' and Emacs commands are executed with `<leader> :'.
   dotspacemacs-command-key ":"
   ;; If non nil `Y' is remapped to `y$'. (default t)
   dotspacemacs-remap-Y-to-y$ t
   ;; Location where to auto-save files. Possible values are `original' to
   ;; auto-save the file in-place, `cache' to auto-save the file to another
   ;; file stored in the cache directory and `nil' to disable auto-saving.
   ;; (default 'cache)
   dotspacemacs-auto-save-file-location 'cache
   ;; If non nil then `ido' replaces `helm' for some commands. For now only
   ;; `find-files' (SPC f f), `find-spacemacs-file' (SPC f e s), and
   ;; `find-contrib-file' (SPC f e c) are replaced. (default nil)
   dotspacemacs-use-ido nil
   ;; If non nil, `helm' will try to miminimize the space it uses. (default nil)
   dotspacemacs-helm-resize nil
   ;; if non nil, the helm header is hidden when there is only one source.
   ;; (default nil)
   dotspacemacs-helm-no-header nil
   ;; define the position to display `helm', options are `bottom', `top',
   ;; `left', or `right'. (default 'bottom)
   dotspacemacs-helm-position 'bottom
   ;; If non nil the paste micro-state is enabled. When enabled pressing `p`
   ;; several times cycle between the kill ring content. (default nil)
   dotspacemacs-enable-paste-micro-state nil
   ;; Which-key delay in seconds. The which-key buffer is the popup listing
   ;; the commands bound to the current keystroke sequence. (default 0.4)
   dotspacemacs-which-key-delay 0.4
   ;; Which-key frame position. Possible values are `right', `bottom' and
   ;; `right-then-bottom'. right-then-bottom tries to display the frame to the
   ;; right; if there is insufficient space it displays it at the bottom.
   ;; (default 'bottom)
   dotspacemacs-which-key-position 'bottom
   ;; If non nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil to boost the loading time. (default t)
   dotspacemacs-loading-progress-bar t
   ;; If non nil the frame is fullscreen when Emacs starts up. (default nil)
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup nil
   ;; If non nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX. (default nil)
   dotspacemacs-fullscreen-use-non-native nil
   ;; If non nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (default nil) (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup t
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-active-transparency 90
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-inactive-transparency 90
   ;; If non nil unicode symbols are displayed in the mode line. (default t)
   dotspacemacs-mode-line-unicode-symbols t
   ;; If non nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters the
   ;; point when it reaches the top or bottom of the screen. (default t)
   dotspacemacs-smooth-scrolling t
   ;; If non-nil smartparens-strict-mode will be enabled in programming modes.
   ;; (default nil)
   dotspacemacs-smartparens-strict-mode nil
   ;; Select a scope to highlight delimiters. Possible values are `any',
   ;; `current', `all' or `nil'. Default is `all' (highlight any scope and
   ;; emphasis the current one). (default 'all)
   dotspacemacs-highlight-delimiters 'all
   ;; If non nil advises quit functions to keep server open when quitting.
   ;; (default nil)
   dotspacemacs-persistent-server nil
   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `ag', `pt', `ack' and `grep'.
   ;; (default '("ag" "pt" "ack" "grep"))
   dotspacemacs-search-tools '("ack" "pt" "ag" "grep")
   ;; The default package repository used if no explicit repository has been
   ;; specified with an installed package.
   ;; Not used for now. (default nil)
   dotspacemacs-default-package-repository nil
   ))

(defun dotspacemacs/user-init ()
  "Initialization function for user code.
It is called immediately after `dotspacemacs/init'.  You are free to put any
user code."
  ;; Turn off exec-path-from-shell warning
  (setq-default exec-path-from-shell-check-startup-files nil)

  ;; Show ruler for Python
  (setq python-fill-column 95)

  ;; Display some operators as unicode symbol for Haskell
  (setq haskell-font-lock-symbols t)
  )

(defun dotspacemacs/user-config ()
  "Configuration function for user code.
 This function is called at the very end of Spacemacs initialization after
layers configuration. You are free to put any user code."
  ;; Show line numbers
  (global-linum-mode)

  ;; Show indent guide
  (indent-guide-global-mode)

  ;; Editorconfig support
  (editorconfig-mode 1)

  ;; Better powerline separator
  (setq-default powerline-default-separator 'wave)

  ;; Some handy Vim keybindings I am used to
  (setq-default evil-escape-key-sequence "jk")
  (define-key evil-normal-state-map (kbd "j") 'evil-next-visual-line)
  (define-key evil-normal-state-map (kbd "k") 'evil-previous-visual-line)
  (define-key evil-normal-state-map (kbd "H") 'evil-first-non-blank-of-visual-line)
  (define-key evil-normal-state-map (kbd "L") 'evil-end-of-visual-line)
  (define-key evil-visual-state-map (kbd "H") 'evil-first-non-blank-of-visual-line)
  (define-key evil-visual-state-map (kbd "L") 'evil-end-of-visual-line)

  ;; Enable auto completion globally
  (global-company-mode)

  ;; Use spacemacs to edit git commit messages
  (global-git-commit-mode t)

  ;; Auto-activate virtualenv if there's a virtualenv with the project name
  (defun kemskems/projectile-pyenv-mode-set-virtualenv ()
    "Set pyenv version matching project name."
    (let ((project (projectile-project-name)))
      (if (member project (pyenv-mode-versions))
          (pyenv-mode-set project))))
  (add-hook 'projectile-after-switch-project-hook 'kemskems/projectile-pyenv-mode-set-virtualenv)

  ;; Auto-set Python version if .python-version file exists on project switch
  (setq python-auto-set-local-pyenv-version 'on-project-switch)

  ;; Append `node_modules/.bin' to `exec-path'
  (defun kemskems/projectile-append-node-modules-local-bin ()
    "Append `node_modules/.bin' to `exec-path' for NodeJS project"
    (let ((local-bin (concat (projectile-project-root) "node_modules/.bin")))
      (if (file-exists-p local-bin)
          (add-to-list 'exec-path local-bin))))
  (add-hook 'projectile-after-switch-project-hook 'kemskems/projectile-append-node-modules-local-bin)

  ;; JavaScript/JSON/ReactJS/CSS indent and globals
  (setq js2-basic-offset 2
        js-indent-level 2
        web-mode-css-indent-offset 2
        web-mode-markup-indent-offset 2
        web-mode-code-indent-offset 2
        js2-include-node-externs t)  ; NodeJS

  ;; Interactive `nvm-use'
  (require 'nvm)
  (defun kemskems/list-nvm-versions (prompt)
    "List all available node versions from nvm prompting the user with PROMPT.
Return a string representing the node version."
    (let ((candidates (sort (mapcar 'car (nvm--installed-versions)) 'string<)))
      (completing-read prompt
                       candidates nil t nil
                       nil
                       (car candidates))))
  (defun kemskems/nvm-use ()
    "Do `nvm-use` interactively."
    (interactive)
    (nvm-use
     (kemskems/list-nvm-versions
      (if nvm-current-version
          (format "Node version (current %s): " (car nvm-current-version))
        "Node version: ")))
    (setq exec-path (split-string (getenv "PATH") path-separator)))

  ;; Run a NodeJS REPL from a directory
  (require 'nodejs-repl)
  ;; Taken from http://williambert.online/2014/02/using-a-node-repl-with-emacs/
  (defun kemskems/nodejs-repl-from-dir (cwd)
    "Run Node.js REPL from a directory."
    (interactive "DDirectory: ")
    (let ((default-directory cwd))
      (nodejs-repl)))

  ;; Setup Haskell indentation
  (setq haskell-indentation-layout-offset 4
        haskell-indentation-starter-offset 4
        haskell-indentation-left-offset 4
        haskell-indentation-ifte-offset 4
        haskell-indentation-where-pre-offset 2
        haskell-indentation-where-post-offset 2)

  ;; NeoTree do not show hidden files
  (setq-default neo-show-hidden-files nil)

  ;; NeoTree hidden regexp list
  (setq-default neo-hidden-regexp-list
                '("^\\.git"
                  "TAGS"
                  "\\.pyc$"
                  "~$"
                  "^#.*#$"
                  "\\.elc$"
                  "\\.o$"
                  "\\.hi$"
                  "^__pycache__$"
                  "^\\.stack-work"))

  ;; Restclient autocomplete
  (add-to-list 'company-backends 'company-restclient)
  )

(defun dotspacemacs/emacs-custom-settings ()
  "Emacs custom settings.
This is an auto-generated function, do not modify its content directly, use
Emacs customize menu instead.
This function is called at the very end of Spacemacs initialization."
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (unfill org-ref key-chord ivy mwim helm-bibtex parsebib biblio biblio-core rvm ruby-tools ruby-test-mode rubocop rspec-mode robe rbenv rake minitest chruby bundler inf-ruby spinner ht org log4e gntp json-snatcher json-reformat multiple-cursors parent-mode window-purpose imenu-list gitignore-mode pos-tip anzu web-completion-data dash-functional restclient know-your-http-well ghc anaconda-mode pythonic f s auto-complete winum iedit alert haml-mode autothemer company-ansible bind-key auctex tern smartparens highlight flycheck request zenburn-theme which-key web-mode tao-theme spacemacs-theme spaceline smeargle seti-theme pug-mode phoenix-dark-pink-theme persp-mode osx-dictionary org-projectile org-plus-contrib open-junk-file ob-http neotree monokai-theme markdown-toc live-py-mode intero info+ indent-guide htmlize helm-projectile google-translate git-link evil-mc eshell-z editorconfig darktooth-theme company-statistics clues-theme apropospriate-theme ample-theme ace-link bind-map haskell-mode company projectile yasnippet skewer-mode js2-mode magit magit-popup git-commit hydra helm helm-core zonokai-theme zen-and-art-theme yapfify yaml-mode xterm-color xkcd ws-butler with-editor window-numbering web-beautify volatile-highlights vimrc-mode vi-tilde-fringe uuidgen use-package underwater-theme ujelly-theme twilight-theme twilight-bright-theme twilight-anti-bright-theme tronesque-theme toxi-theme toc-org tangotango-theme tango-plus-theme tango-2-theme tagedit sunny-day-theme sublime-themes subatomic256-theme subatomic-theme spacegray-theme sourcerer-theme soothe-theme soft-stone-theme soft-morning-theme soft-charcoal-theme smyx-theme slim-mode simple-httpd shell-pop shakespeare-mode scss-mode sass-mode reverse-theme reveal-in-osx-finder restclient-helm restart-emacs ranger rainbow-delimiters railscasts-theme quelpa pyvenv pytest pyenv-mode py-isort purple-haze-theme professional-theme powerline popwin planet-theme pip-requirements phoenix-dark-mono-theme pcre2el pbcopy pastels-on-dark-theme paradox pandoc-mode ox-pandoc osx-trash orgit organic-green-theme org-present org-pomodoro org-download org-bullets omtose-phellack-theme oldlace-theme occidental-theme obsidian-theme ob-restclient nvm nodejs-repl noctilux-theme niflheim-theme naquadah-theme mustang-theme multi-term move-text monochrome-theme molokai-theme moe-theme mmm-mode minimal-theme material-theme markdown-mode majapahit-theme magit-gitflow macrostep lush-theme lorem-ipsum livid-mode linum-relative link-hint light-soap-theme less-css-mode launchctl json-mode js2-refactor js-doc jinja2-mode jbeans-theme jazz-theme ir-black-theme inkpot-theme ido-vertical-mode hy-mode hungry-delete hlint-refactor hl-todo hindent highlight-parentheses highlight-numbers highlight-indentation hide-comnt heroku-theme hemisu-theme help-fns+ helm-themes helm-swoop helm-pydoc helm-purpose helm-mode-manager helm-make helm-hoogle helm-gitignore helm-flx helm-descbinds helm-css-scss helm-company helm-c-yasnippet helm-ag hc-zenburn-theme haskell-snippets gruvbox-theme gruber-darker-theme grandshell-theme gotham-theme golden-ratio gnuplot gitconfig-mode gitattributes-mode git-timemachine git-messenger gh-md gandalf-theme flycheck-pos-tip flycheck-haskell flx-ido flatui-theme flatland-theme firebelly-theme fill-column-indicator farmhouse-theme fancy-battery eyebrowse expand-region exec-path-from-shell evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-surround evil-search-highlight-persist evil-numbers evil-nerd-commenter evil-matchit evil-magit evil-lisp-state evil-indent-plus evil-iedit-state evil-exchange evil-escape evil-ediff evil-args evil-anzu eval-sexp-fu espresso-theme eshell-prompt-extras esh-help engine-mode emmet-mode elisp-slime-nav dumb-jump dracula-theme django-theme darkokai-theme darkmine-theme darkburn-theme dakrone-theme dactyl-mode cython-mode cyberpunk-theme csv-mode company-web company-tern company-restclient company-ghci company-ghc company-cabal company-auctex company-anaconda column-enforce-mode color-theme-sanityinc-tomorrow color-theme-sanityinc-solarized coffee-mode cmm-mode clean-aindent-mode cherry-blossom-theme busybee-theme bubbleberry-theme birds-of-paradise-plus-theme badwolf-theme auto-yasnippet auto-highlight-symbol auto-compile auctex-latexmk anti-zenburn-theme ansible-doc ansible ample-zen-theme alect-themes aggressive-indent afternoon-theme adaptive-wrap ace-window ace-jump-helm-line ac-ispell))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
)