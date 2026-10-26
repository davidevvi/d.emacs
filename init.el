;;; init.el -*- lexical-binding: t; -*-
;;; NOTE: Generated from config.org — do not edit directly.

(doom!
 :completion
 (vertico
  +childframe
  +icons)
 (corfu
  +orderless
  )  ; complete with cap(f), cape and a flying feather!
 
 :ui
 hl-todo           ; highlight TODO/FIXME/NOTE/DEPRECATED/HACK/REVIEW
 (vc-gutter
  +pretty) ; vcs diff in the fringe
 vi-tilde-fringe   ; fringe tildes to mark beyond EOB
 doom              ; what makes DOOM look the way it does
 doom-quit         ; DOOM quit-message prompts when you quit Emacs 
 (popup
  +all
  +defaults)   ; tame sudden yet inevitable temporary windows
 (window-select
  +numbers)                              ; visually switch windows
 treemacs          ; a project drawer, like neotree but cooler
 workspaces        ; tab emulation, persistence & separate workspaces
 modeline   
 dashboard  
 nav-flash          
 ophints            
 (emoji +unicode)  ; 🙂
 (ligatures +extra)         ; ligatures and symbols to make your code pretty again
 unicode           ; extended unicode support for various languages
 
 :editor
 fold              ; (nigh) universal code folding
 (format +onsave)  ; automated prettiness
 word-wrap         ; soft wrapping with language-aware indent
 (evil +everywhere)
 file-templates    ; auto-snippets for empty files
 snippets
 
 :emacs
 electric          ; smarter, keyword-based electric-indent
 eww               ; the internet is gross
 vc                ; version-control and Emacs, sitting in a tree
 (ibuffer           ; interactive buffer management
  +icons)
 (dired             ; making dired pretty [functional]
  +icons
  +dirvish)
 (undo +tree)
 
 :term
 vterm   
 
 :checkers
 grammar           ; tasing grammar mistake every you make
 (syntax +childframe +flymake +icons); tasing you for every semicolon you forget
 
 :tools
 biblio            ; Writes a PhD for you (citation needed)
 ;;collab            ; buffers with friends
 ;;debugger          ; FIXME stepping through code, to help you add bugs
 ;;direnv
 ;;docker
 ;;ein               ; tame Jupyter notebooks with emacs
 (eval +overlay)     ; run code, run (also, repls)
 (lookup              ; navigate your code and its documentation
  +dictionary
  +docsets)
 (lsp +peek)               ; M-x vscode
 magit             ; a git porcelain for Emacs
 ;;make              ; run make tasks from Emacs
 ;;pass              ; password manager for nerds
 pdf               ; pdf enhancements
 ;;prodigy           ; FIXME managing external services & code builders
 ;;terraform         ; infrastructure as code
 ;;tmux              ; an API for interacting with tmux
 tree-sitter       ; syntax and parsing, sitting in a tree...
 ;;upload            ; map local to remote projects via ssh/ftp
 editorconfig
 
 :os
 (:if (featurep :system 'macos) macos)  ; improve compatibility with macOS
 ;;tty               ; improve the terminal Emacs experience
 
 :lang
 emacs-lisp   
 (python           
  +lsp
  +pyright
  +cython)
 (haskell +lsp)    ; a language that's lazier than I am
 sh
 (org
  +pretty
  +dragndrop
  +hugo
  +roam
 )
 (latex              ; writing papers in Emacs has never been so fun
  +latexmk
  +fold
  +lsp
  +cdlatex)           
 markdown  
 
 
 :app
 ;;calendar
 ;;emms
 ;;everywhere        ; *leave* Emacs!? You must be joking
 ;;irc               ; how neckbeards socialize
 (rss +org)        ; emacs as an RSS reader
 
 :config
 (default +bindings +smartparens)
 )
