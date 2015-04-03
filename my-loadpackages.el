(require 'cl)

;; install and load those packages
(defvar required-packages
  '(
    ido-vertical-mode
    zoom-frm
    magit 
    org-fstree 
    org-journal 
    org-mac-iCal 
    org-mac-link 
    org-magit 
    org-page 
    org-pandoc 
    ox-html5slide 
    ox-textile org
    org-fstree
    org-download
    web-mode
    zencoding-mode
    ac-html
    ac-html-bootstrap
    ac-html-csswatcher
    )  "a list of packages to ensure are installed at launch.")


;; method to check if all packages are installed
(defun packages-installed-p ()
  (loop for p in required-packages
        when (not (package-installed-p p)) do (return nil)
        finally (return t)))

;; if not all packages are installed, check one by one and install the missing ones.
(unless (packages-installed-p)
  ; check for new packages (package versions)
  (message "%s" "Emacs is now refreshing its package database...")
  (package-refresh-contents)
  (message "%s" " done.")
  ; install the missing packages
  (dolist (p required-packages)
    (when (not (package-installed-p p))
      (package-install p))))


;; ido vertical mode
(require 'ido-vertical-mode)
(ido-mode 1)
(ido-vertical-mode 1)

;; zoom-frm to scale the whole frame for the session
(require 'zoom-frm)
(define-key ctl-x-map [(control ?+)] 'zoom-in/out)
(define-key ctl-x-map [(control ?-)] 'zoom-in/out)
(define-key ctl-x-map [(control ?=)] 'zoom-in/out)
(define-key ctl-x-map [(control ?0)] 'zoom-in/out)
(global-set-key (if (boundp 'mouse-wheel-down-event) ; Emacs 22+
		    (vector (list 'control
				  mouse-wheel-down-event))
		  [C-mouse-wheel])    ; Emacs 20, 21
		'zoom-in)
(when (boundp 'mouse-wheel-up-event) ; Emacs 22+
  (global-set-key (vector (list 'control mouse-wheel-up-event))
		  'zoom-out))
(global-set-key [S-mouse-1]    'zoom-in)
(global-set-key [C-S-mouse-1]  'zoom-out)
;; Get rid of `mouse-set-font' or `mouse-appearance-menu':
(global-set-key [S-down-mouse-1] nil)

;; auto-fill-mode
;; do not use, use visual-line-break from Options menu instead
;;(add-hook 'org-mode-hook 'turn-on-auto-fill)



;; org v8! instead of built-in 7.9x
;; need to install newer org from package-list manually!
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

;; org-journal
;; use C-c j to create a new journal entry
(require 'org-journal)

;; org-magit
(require 'org-magit)

;; org-mac-ical
(add-to-list 'org-modules 'org-mac-iCal)
(setq org-agenda-include-diary t)

;; org-mac-ical command in the agenda dispatcher to import iCal.app events and then display the agenda
(setq org-agenda-custom-commands
      '(("I" "Import diary from iCal" agenda ""
         ((org-agenda-mode-hook
           (lambda ()
             (org-mac-iCal)))))))

;; org-mac-ical clean up all day events
(add-hook 'org-agenda-cleanup-fancy-diary-hook
          (lambda ()
            (goto-char (point-min))
            (save-excursion
              (while (re-search-forward "^[a-z]" nil t)
                (goto-char (match-beginning 0))
                (insert "0:00-24:00 ")))
            (while (re-search-forward "^ [a-z]" nil t)
              (goto-char (match-beginning 0))
              (save-excursion
                (re-search-backward "^[0-9]+:[0-9]+-[0-9]+:[0-9]+ " nil t))
              (insert (match-string 0)))))

;;  org-mac-link 
;;  Activate the grabber by typing C-c g or type M-x org-mac-grab-link
;;  RET. This will give you a menu in the modeline allowing you to
;;  select an application. The current selection in that application
;;  will be inserted at point as a hyperlink in your org-mode
;;  document.
(if (eq system-type 'darwin)
    (add-hook 'org-mode-hook (lambda () 
       (define-key org-mode-map (kbd "C-c g") 'org-mac-grab-link)))
)
;; set PATH to latex executables for OSX
(if (eq system-type 'darwin)
    (progn
      (setenv "PATH" (concat (getenv "PATH") ":/usr/texbin"))
      (setq exec-path (append exec-path '("/usr/texbin")))
    )
)


;; webmode configuration
(require 'web-mode) 
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode)) 
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode)) 
(add-to-list 'auto-mode-alist '("\\.[gj]sp\\'" . web-mode)) 
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode)) 
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode)) 
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode)) 
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))


(defun my-web-mode-hook () 
  "Hooks for Web mode." 
  (setq web-mode-markup-indent-offset 2) 
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-style-padding 1)
  (setq web-mode-script-padding 1)
  (setq web-mode-block-padding 0)
  (setq web-mode-enable-auto-pairing t)
  (setq web-mode-enable-css-colorization t)
  (setq web-mode-enable-heredoc-fontification t)
) 

(add-hook 'web-mode-hook 'my-web-mode-hook)

;; html autocomplete
(add-hook 'html-mode-hook 'ac-html-enable)

;; integrate ac-html with webmode
(add-to-list 'web-mode-ac-sources-alist
             '("html" . (ac-source-html-attribute-value
                         ac-source-html-tag
                         ac-source-html-attribute)))


;; css color highlighting
(defun xah-syntax-color-hex ()
"Syntax color hex color spec such as 「#ff1100」 in current buffer."
  (interactive)
  (font-lock-add-keywords
   nil
   '(("#[abcdef[:digit:]]\\{6\\}"
      (0 (put-text-property
          (match-beginning 0)
          (match-end 0)
          'face (list :background (match-string-no-properties 0)))))))

  (font-lock-fontify-buffer)
  )

(add-hook 'css-mode-hook 'xah-syntax-color-hex)
(add-hook 'php-mode-hook 'xah-syntax-color-hex)
(add-hook 'html-mode-hook 'xah-syntax-color-hex)
(add-hook 'web-mode-hook 'xah-syntax-color-hex)


;; set some snippets for various modes
;; (setq web-mode-extra-snippets 
;;  '(("erb" . (("name" . ("beg" . "end")))) 
;;    ("php" . (("name" . ("beg" . "end")) 
;;             ("name" . ("beg" . "end")))) 
;;  ))
