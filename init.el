(add-to-list 'load-path "~/.emacs.d/")
(add-to-list 'load-path "~/.emacs.d/plugins/")

;; package.el
;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.
(when
    (load
     (expand-file-name "~/.emacs.d/elpa/package.el"))
  (package-initialize)
  (add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/")))

;;; Theme
(require 'color-theme)
;;(color-theme-initialize)
(color-theme-molokai)

;;; Misc settings

;; indentation
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

(display-time)
(menu-bar-mode nil)
(column-number-mode 1)

;; parentheses
(show-paren-mode 1)
(setq show-paren-delay 0)

;; "y" or "n" instead of "yes" or "no"
(fset 'yes-or-no-p 'y-or-n-p)

;; last line must be a newline
(setq require-final-newline t)

(setq-default delete-key-deletes-forward t)

;; line numbers
(require 'linum)
(setq linum-format "%5d ")
(global-linum-mode t)

;;
(setq inhibit-startup-message t)

(defalias 'qrr 'query-replace-regexp)

;; hightlight during qrr
(setq query-replace-highlight t)

;; highlight during incremental search
(setq search-highlight t)

;; make text-mode default
(setq default-major-mode 'text-mode)

;; enable follow-mode
(follow-mode t) 

;;; Keyboard shortcuts
(global-set-key (kbd "<C-tab>") 'anything)
(global-set-key "\M-;" 'goto-line)
(global-set-key [f1] 'compile)
(global-set-key [f2] 'next-error)
(global-set-key [S-f2] 'previous-error)
(global-set-key [f3] 'other-window)

(global-set-key [C-delete]    'kill-word)
(global-set-key [C-backspace] 'backward-kill-word)


;;; Language specific modes

;; clojure-mode
(require 'clojure-mode)
(setq auto-mode-alist
  (cons (cons "\\.clj" 'clojure-mode)
     auto-mode-alist))

;; erlang
(setq auto-mode-alist
  (cons (cons "\\.erl" 'erlang-mode)
     auto-mode-alist))


;; haskell
(add-to-list 'load-path "~/.emacs.d/plugins/haskell-mode")
(load "~/.emacs.d/plugins/haskell-mode/haskell-site-file")
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)

;; lua
(autoload 'lua-mode "lua-mode" "Lua editing mode." t)
(add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))
(add-to-list 'interpreter-mode-alist '("lua" . lua-mode))

;; JR
(require 'jr-mode)
(add-to-list 'auto-mode-alist '("\\.jr$" . jr-mode))
(add-to-list 'auto-mode-alist '("\\.jrs$" . jr-mode))
(add-to-list 'auto-mode-alist '("\\.ccr$" . jr-mode))
(add-to-list 'auto-mode-alist '("\\.jsp$" . jr-mode))


;; prolog
(autoload 'run-prolog "prolog" "Start a Prolog sub-process." t)
(autoload 'prolog-mode "prolog" "Major mode for editing Prolog programs." t)
(autoload 'mercury-mode "prolog" "Major mode for editing Mercury programs." t)
(setq prolog-system 'swi)
(setq auto-mode-alist (append '(("\\.pl$" . prolog-mode)
								("\\.m$" . mercury-mode))
							  auto-mode-alist))
(add-hook 'prolog-mode-hook
		  (lambda ()
			(local-set-key "\C-c\C-k" 'prolog-compile-file)))


;; ruby
(setq ruby-indent-level 4)

;; slime
(add-to-list 'load-path "~/.emacs.d/plugins/slime/")
(require 'slime-autoloads)
(setq slime-lisp-implementations
      `((sbcl ("/opt/local/bin/sbcl"))
		(clisp ("/opt/local/bin/clisp"))))
(add-hook 'lisp-mode-hook
	  (lambda ()
	    (cond ((not (featurep 'slime))
		   (require 'slime) 
		   (normal-mode)))))
(eval-after-load "slime"
  '(slime-setup '(slime-fancy slime-banner)))


(require 'window-move)
(require 'buffer-move)
(global-set-key (kbd "<C-S-up>")     'buf-move-up)
(global-set-key (kbd "<C-S-down>")   'buf-move-down)
(global-set-key (kbd "<C-S-left>")   'buf-move-left)
(global-set-key (kbd "<C-S-right>")  'buf-move-right)
