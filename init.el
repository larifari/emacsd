;; do these first to ensure a save workenvironemt in case of errors in
;; later configuration parts

;; mac keyboard sanity for international keyboards
;; sanity for system switchers
(if (eq system-type 'darwin)
 (progn
   (setq mac-command-modifier 'meta)
   (setq mac-option-modifier nil)
  )
)



;; readable-fonts please!
;; height is given in 10*pt-size
(set-face-attribute 'default nil :height 160)

;; default start folder
(setq default-directory "~/")

;; sensible line wrap
(global-visual-line-mode t)

;; load default theme light
(load-theme 'tango t)
;; load default dark-theme
;;(load-theme 'tango-dark t)


(require 'package)
(add-to-list 'package-archives             
	     '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives             
	     '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-initialize)

;; load configuration for built-in tools
(load "~/.emacs.d/my-no-externals.el")

;; load and/or install default add-on packages and configuration
(load "~/.emacs.d/my-loadpackages.el")

