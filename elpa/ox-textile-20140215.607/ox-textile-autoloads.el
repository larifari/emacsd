;;; ox-textile-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (org-textile-export-to-textile org-textile-export-as-textile)
;;;;;;  "ox-textile" "ox-textile.el" (21271 3833 0 0))
;;; Generated autoloads from ox-textile.el

(autoload 'org-textile-export-as-textile "ox-textile" "\
Export current buffer to a buffer in Textile format.

If narrowing is active in the current buffer, only export its
narrowed part.

If a region is active, export that region.

A non-nil optional argument ASYNC means the process should happen
asynchronously.  The resulting buffer should be accessible
through the `org-export-stack' interface.

When optional argument SUBTREEP is non-nil, export the sub-tree
at point, extracting information from the headline properties
first.

When optional argument VISIBLE-ONLY is non-nil, don't export
contents of hidden elements.

Export is done in a buffer named \"*Org TEXTILE Export*\", which
will be displayed when `org-export-show-temporary-export-buffer'
is non-nil.

\(fn &optional ASYNC SUBTREEP VISIBLE-ONLY)" t nil)

(autoload 'org-textile-export-to-textile "ox-textile" "\
Export current buffer to a Textile file.

If narrowing is active in the current buffer, only export its
narrowed part.

If a region is active, export that region.

A non-nil optional argument ASYNC means the process should happen
asynchronously.  The resulting file should be accessible through
the `org-export-stack' interface.

When optional argument SUBTREEP is non-nil, export the sub-tree
at point, extracting information from the headline properties
first.

When optional argument VISIBLE-ONLY is non-nil, don't export
contents of hidden elements.

Return output file name.

\(fn &optional ASYNC SUBTREEP VISIBLE-ONLY)" t nil)

;;;***

;;;### (autoloads nil nil ("ox-textile-pkg.el") (21271 3833 270134
;;;;;;  0))

;;;***

(provide 'ox-textile-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; ox-textile-autoloads.el ends here
