;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Fang"
      user-mail-address "dfs@berkeley.edu")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-gruvbox
      doom-gruvbox-dark-variant "soft"
      doom-gruvbox-brighter-comments nil)
;; (setq doom-theme 'doom-vibrant)
;; (setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; Copied from https://gist.github.com/jordangarrison/8720cf98126a1a64890b2f18c1bc69f5
(use-package! python-black
  :demand t
  :after python)
(add-hook! 'python-mode-hook #'python-black-on-save-mode)
;; Feel free to throw your own personal keybindings here
(map! :leader :desc "Blacken Buffer" "m b b" #'python-black-buffer)
(map! :leader :desc "Blacken Region" "m b r" #'python-black-region)
(map! :leader :desc "Blacken Statement" "m b s" #'python-black-statement)

;; enable clipboard copying
;; (use-package simpleclip :ensure t
;;   :config
;;   (setq simpleclip-mode 1) )

;; TODO(DFS): this throws some error if there's no region to copy
(map! :leader :desc "Copy using to Clipboard (simpleclip)" "y c" #'simpleclip-copy)

;; Autosave attempt
(setq auto-save-visited-mode t)
(setq auto-save-default t)

;; Company Autocomplete
(setq company-dabbrev-downcase 0)
(setq company-idle-delay 0)

;; Disable global flycheck mode
(setq global-flycheck-mode 0)

;; highlight-symbol
;; Copied from https://xenodium.com/emacs-highlight-symbol-mode/
;; (use-package highlight-symbol :ensure t
;;   :config
;;   (set-face-attribute 'highlight-symbol-face nil
;;                       :background "#3A3A3A" ;; "default"
;;                       :foreground "#FDB008") ;; "#FA009A"
;;   (setq highlight-symbol-idle-delay 0)
;;   (setq highlight-symbol-on-navigation-p t)
;;   (add-hook 'prog-mode-hook #'highlight-symbol-mode)
;;   (add-hook 'prog-mode-hook #'highlight-symbol-nav-mode) )

;; Load additional packages
(load! "+functions")
