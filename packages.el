;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el
;;; NOTE: Generated from config.org — do not edit directly.

(package! rainbow-delimiters)

(package! highlight-indent-guides)

(package! let-completion
  :recipe (:host github
           :repo "gggion/let-completion.el"
           :files ("*.el")))

(package! winpulse
  :recipe (:host github
           :repo "xenodium/winpulse")
  )

(package! mixed-pitch)

(package! emacs-materialized-theme 
  :recipe (:host github
           :repo "xenodium/emacs-materialized-theme"))

(package! embr
  :recipe (:host github
           :repo "emacs-os/embr.el"
           :files ("*.el" "*.py" "*.sh" "native/*.c" "native/Makefile")
           ))

(package! gt
  :recipe (:host github
           :repo "lorniu/gt.el"))

(package! jinx
  :recipe (:host github :repo "minad/jinx" :files (:defaults "jinx-mod.c" "emacs-module.h"))
  )

(package! yasnippet-capf)

(package! aas)

(package! emacs-manim
  :recipe (:host github
           :repo "d-matsui/emacs-manim"))

(package! org-modern)

(package! org-appear)

(package! latex-extra)

(package! org-padding
  :recipe (:host github
           :repo "TonCherAmi/org-padding"))

(package! ox-hugo)

(package! olivetti)

(package! laas)
