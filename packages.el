;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el
;;; NOTE: Generated from config.org — do not edit directly.

(package! org-modern)

(package! org-appear)

(package! yasnippet-capf)

(package! let-completion
  :recipe (:host github
           :repo "gggion/let-completion.el"
           :files ("*.el")))

(package! jinx
  :recipe (:host github :repo "minad/jinx" :files (:defaults "jinx-mod.c" "emacs-module.h"))
  )

(package! latex-extra)

(package! highlight-indent-guides)

(package! org-padding
  :recipe (:host github
           :repo "TonCherAmi/org-padding"))


(package! laas)

(package! ox-hugo)

(package! emacs-manim
  :recipe (:host github
           :repo "d-matsui/emacs-manim"))


(package! embr
  :recipe (:host github
           :repo "emacs-os/embr.el"
           :files ("*.el" "*.py" "*.sh" "native/*.c" "native/Makefile")
           ))

;; translator 
(package! gt
  :recipe (:host github
           :repo "lorniu/gt.el"))

(package! emacs-materialized-theme 
  :recipe (:host github
           :repo "xenodium/emacs-materialized-theme"))

(package! rainbow-delimiters)

(package! winpulse
  :recipe (:host github
           :repo "xenodium/winpulse"))
