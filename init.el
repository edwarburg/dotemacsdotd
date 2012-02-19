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

;; line numbers
(require 'linum)
(setq linum-format "%5d ")
(global-linum-mode t)

;;; Keyboard shortcuts
(global-set-key (kbd "<C-tab>") 'anything)

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
(add-to-list 'auto-mode-alist '("\\.jr$" . java-mode))
(add-to-list 'auto-mode-alist '("\\.jrs$" . java-mode))

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

;; Window resizing
(defun win-resize-top-or-bot ()
  "Figure out if the current window is on top, bottom or in the
middle"
  (let* ((win-edges (window-edges))
	 (this-window-y-min (nth 1 win-edges))
	 (this-window-y-max (nth 3 win-edges))
	 (fr-height (frame-height)))
    (cond
     ((eq 0 this-window-y-min) "top")
     ((eq (- fr-height 1) this-window-y-max) "bot")
     (t "mid"))))

(defun win-resize-left-or-right ()
  "Figure out if the current window is to the left, right or in the
middle"
  (let* ((win-edges (window-edges))
	 (this-window-x-min (nth 0 win-edges))
	 (this-window-x-max (nth 2 win-edges))
	 (fr-width (frame-width)))
    (cond
     ((eq 0 this-window-x-min) "left")
     ((eq (+ fr-width 4) this-window-x-max) "right")
     (t "mid"))))

(defun win-resize-enlarge-horiz ()
  (interactive)
  (cond
   ((equal "top" (win-resize-top-or-bot)) (enlarge-window -1))
   ((equal "bot" (win-resize-top-or-bot)) (enlarge-window 1))
   ((equal "mid" (win-resize-top-or-bot)) (enlarge-window -1))
   (t (message "nil"))))

(defun win-resize-minimize-horiz ()
  (interactive)
  (cond
   ((equal "top" (win-resize-top-or-bot)) (enlarge-window 1))
   ((equal "bot" (win-resize-top-or-bot)) (enlarge-window -1))
   ((equal "mid" (win-resize-top-or-bot)) (enlarge-window 1))
   (t (message "nil"))))

(defun win-resize-enlarge-vert ()
  (interactive)
  (cond
   ((equal "left" (win-resize-left-or-right)) (enlarge-window-horizontally -1))
   ((equal "right" (win-resize-left-or-right)) (enlarge-window-horizontally 1))
   ((equal "mid" (win-resize-left-or-right)) (enlarge-window-horizontally -1))))

(defun win-resize-minimize-vert ()
  (interactive)
  (cond
   ((equal "left" (win-resize-left-or-right)) (enlarge-window-horizontally 1))
   ((equal "right" (win-resize-left-or-right)) (enlarge-window-horizontally -1))
   ((equal "mid" (win-resize-left-or-right)) (enlarge-window-horizontally 1))))

(global-set-key (kbd "C-M-l") 'win-resize-minimize-vert)  ; right
(global-set-key (kbd "C-M-h") 'win-resize-enlarge-vert)   ; left
(global-set-key (kbd "C-M-j") 'win-resize-minimize-horiz) ; down
(global-set-key (kbd "C-M-k") 'win-resize-enlarge-horiz)  ; up



