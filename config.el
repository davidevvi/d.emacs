;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
;;; NOTE: Generated from config.org — do not edit directly.

(setq-default display-line-numbers-type 'relative)

(setq-default auto-save-default t)

(setq-default truncate-string-ellipsis "...")

(setq-default password-cache t
              password-cache-expiry nil
              )

(setq-default display-time-default-load-average nil)

(setq-default x-stretch-cursor t)

(setq-default scroll-margin 5)

(setq-default scroll-preserve-screen-position 'always)

(setq-default indent-tabs-mode nil)

(editorconfig-mode 1)

(setq-default
 window-combination-resize t
 )

(setq evil-vsplit-window-right t
      evil-split-window-below t
      )
(defadvice! prompt-for-buffer (&rest _)
  :after '(evil-window-split evil-window-vsplit)
  (consult-buffer)
  )

(use-package! highlight-indent-guides
  :hook ((prog-mode text-mode LaTeX-mode) . highlight-indent-guides-mode)
  :config
  (setq highlight-indent-guides-method 'bitmap
        highlight-indent-guides-bitmap-function 'highlight-indent-guides--bitmap-line
        highlight-indent-guides-responsive 'stack
        highlight-indent-guides-auto-character-face-perc 50 
        highlight-indent-guides-auto-top-character-face-perc 125
        highlight-indent-guides-auto-stack-character-face-perc 80
        highlight-indent-guides-delay 0
        )
  )

(display-time-mode 1)     ; clock in the modeline
;; If non-nil, a word count will be added to the selection-info modeline segment.
(setq doom-modeline-enable-word-count nil)

(setq fancy-splash-image "~/.config/doom/sad-jester.jpg")

(after! consult
  (set-face-attribute 'consult-file nil :inherit 'consult-buffer)
  (setf (plist-get (alist-get 'perl consult-async-split-styles-alist) :initial) ";"))

(after! marginalia
  (setq marginalia-censor-variables nil)
  (defadvice! +marginalia--anotate-local-file-colorful (cand)
    "Just a more colourful version of `marginalia--annotate-local-file'."
    :override #'marginalia--annotate-local-file
    (when-let (attrs (file-attributes (substitute-in-file-name
                                       (marginalia--full-candidate cand))
                                      'integer))
      (marginalia--fields
       ((marginalia--file-owner attrs)
        :width 12 :face 'marginalia-file-owner)
       ((marginalia--file-modes attrs))
       ((+marginalia-file-size-colorful (file-attribute-size attrs))
        :width 7)
       ((+marginalia--time-colorful (file-attribute-modification-time attrs))
        :width 12))))
  (defun +marginalia--time-colorful (time)
    (let* ((seconds (float-time (time-subtract (current-time) time)))
           (color (doom-blend
                   (face-attribute 'marginalia-date :foreground nil t)
                   (face-attribute 'marginalia-documentation :foreground nil t)
                   (/ 1.0 (log (+ 3 (/ (+ 1 seconds) 345600.0)))))))
      (propertize (marginalia--time time) 'face (list :foreground color))))
  (defun +marginalia-file-size-colorful (size)
    (let* ((size-index (/ (log (+ 1 size)) 7.0))
           (color (if (< size-index 10000000)
                      (doom-blend 'orange 'green size-index)
                    (doom-blend 'red 'orange (- size-index 1)))))
      (propertize (file-size-human-readable size) 'face (list :foreground color)))))

(global-set-key [remap dabbrev-expand] #'hippie-expand)

(use-package! winpulse
  :config
  (winpulse-mode +1)
  )

(setq
 doom-font (font-spec :family "JetBrains Mono" :size 18)
 doom-big-font (font-spec :family "JetBrains Mono" :size 30)
 doom-variable-pitch-font (font-spec :family "Overpass" :size 20)
 doom-symbol-font (font-spec :family "JuliaMono")
 doom-serif-font (font-spec :family "IBM Plex Mono" :size 16 :weight 'light)
 )

(defvar mixed-pitch-modes '(org-mode LaTeX-mode markdown-mode gfm-mode Info-mode)
  "Modes that `mixed-pitch-mode' should be enabled in, but only after UI initialisation.")
(defun init-mixed-pitch-h ()
  "Hook `mixed-pitch-mode' into each mode in `mixed-pitch-modes'.
Also immediately enables `mixed-pitch-modes' if currently in one of the modes."
  (when (memq major-mode mixed-pitch-modes)
    (mixed-pitch-mode 1))
  (dolist (hook mixed-pitch-modes)
    (add-hook (intern (concat (symbol-name hook) "-hook")) #'mixed-pitch-mode)))
(add-hook 'doom-init-ui-hook #'init-mixed-pitch-h)

(autoload #'mixed-pitch-serif-mode "mixed-pitch"
  "Change the default face of the current buffer to a serifed variable pitch, while keeping some faces fixed pitch." t)

(setq! variable-pitch-serif-font (font-spec :family "Alegreya" :size 27))

(after! mixed-pitch
  (setq mixed-pitch-set-height t)
  (set-face-attribute 'variable-pitch-serif nil :font variable-pitch-serif-font)
  (defun mixed-pitch-serif-mode (&optional arg)
    "Change the default face of the current buffer to a serifed variable pitch, while keeping some faces fixed pitch."
    (interactive)
    (let ((mixed-pitch-face 'variable-pitch-serif))
      (mixed-pitch-mode (or arg 'toggle)))))

(set-char-table-range composition-function-table ?f '(["\\(?:ff?[fijlt]\\)" 0 font-shape-gstring]))
(set-char-table-range composition-function-table ?T '(["\\(?:Th\\)" 0 font-shape-gstring]))
(defface variable-pitch-serif
  '((t (:family "serif")))
  "A variable-pitch face with serifs."
  :group 'basic-faces)

(defcustom variable-pitch-serif-font (font-spec :family "serif")
  "The font face used for `variable-pitch-serif'."
  :group 'basic-faces
  :type '(restricted-sexp :tag "font-spec" :match-alternatives (fontp))
  :set (lambda (symbol value)
         (set-face-attribute 'variable-pitch-serif nil :font value)
         (set-default-toplevel-value symbol value)))

(setq doom-theme 'materialized)

(setq which-key-allow-multiple-replacements t)
(after! which-key
  (pushnew!
   which-key-replacement-alist
   '(("" . "\\`+?evil[-:]?\\(?:a-\\)?\\(.*\\)") . (nil . "\\1"))
   '(("\\`g s" . "\\`evilem--?motion-\\(.*\\)") . (nil . "\\1"))
   ))

;; (after! dirvish (dirvish-override-dired-mode))

(after! eww
  (set-popup-rule! "^\\*eww\\*" :ignore t))

(use-package! elfeed
  :commands elfeed
  :config
  (setq elfeed-search-filter "@1-week-ago +unread"))

(use-package! elfeed-org
  :after elfeed
  :config
  (setq rmh-elfeed-org-files
        (list "~/Documents/Org/feed.org"))
  (elfeed-org))

(setq browse-url-browser-function 'eww-browse-url)

(use-package embr
  :defer t
  ;; :hook (embr-mode . embr-vimium-mode)   ; modal navigation for evil users
  :config
  (setq embr-browser-engine 'cloakbrowser
        embr-hover-rate 30
        embr-viewport-sizing 'dynamic
        embr-screen-width (display-pixel-width)
        embr-screen-height (display-pixel-height)
        embr-color-scheme 'dark
        embr-search-engine 'google
        embr-scroll-method 'instant
        embr-scroll-step 100
        embr-frame-source 'screencast
        embr-render-backend 'default
        embr-display-method 'headless
        embr-home-url "about:blank"
        embr-session-restore t
        embr-tab-bar t
        embr-proxy-rules nil))

(global-goto-address-mode 1)   ; make URLs clickable everywhere
(set-frame-size nil 150 40)

(use-package! gt
  :defer t
  :config
  (setq gt-preset-translators
        `((it-en . ,(gt-translator
                     :taker   (gt-taker :langs '(it en) :text 'word :pick 'paragraph)
                     :engines (list (gt-google-engine))
                     :render  (gt-buffer-render)))
          (en-it . ,(gt-translator
                     :taker   (gt-taker :langs '(en it) :text 'word :pick 'paragraph)
                     :engines (list (gt-google-engine))
                     :render  (gt-buffer-render)))
          )))

(setq-default evil-escape-key-sequence "jk")

(after! evil
  (setq evil-move-cursor-back nil))

(setq evil-want-fine-undo t)

(use-package! jinx
  :defer t
  :init
  (add-hook 'doom-init-ui-hook #'global-jinx-mode)
  :config
  (setq jinx-languages "en_GB it_IT")
  ;; don't spellcheck inline source blocks in org
  (push 'org-inline-src-block
        (alist-get 'org-mode jinx-exclude-faces))
  (after! ispell
    (global-set-key [remap ispell-word] #'jinx-correct))
  (after! evil-commands
    (global-set-key [remap evil-next-flyspell-error] #'jinx-next)
    (global-set-key [remap evil-prev-flyspell-error] #'jinx-previous))
  (advice-add 'jinx-next :after (lambda (_) (left-word))))

(setq-default abbrev-mode t)
(setq abbrev-file-name (expand-file-name "abbrev.el" doom-user-dir))

(setq yas-snippet-dirs
      '("~/.config/emacs/snippets"))

(yas-global-mode 1)   ; or M-x yas-reload-all if YASnippet is already running

(after! yasnippet
  (use-package! yasnippet-capf))

(add-to-list 'exec-path (expand-file-name "~/.local/bin"))
(setenv "PATH" (concat (expand-file-name "~/.local/bin") ":" (getenv "PATH")))

(after! lsp-mode
  (setq lsp-completion-provider :none))

(after! lsp-pyright
  (setq lsp-pyright-langserver-command "pyright"))

(setq manim-quality "l")         ; "l" 480p, "m" 720p, "h" 1080p, "k" 4K
(setq manim-command "manim")     ; path to the manim executable
(setq manim-video-player nil)    ; nil = OS default (open / xdg-open)
(use-package! manim-mode)

(after! lsp-mode
  (add-to-list 'lsp-language-id-configuration
               '(manim-mode . "python")))

(after! lsp-pyright
  (dolist (server '(pyright pyright-remote pyright-tramp))
    (when-let ((client (gethash server lsp-clients)))
      (let ((modes
             (cl-struct-slot-value
              'lsp--client 'major-modes client)))
        (setf (cl-struct-slot-value
               'lsp--client 'major-modes client)
              (cons 'manim-mode
                    (remove 'manim-mode modes)))))))

(add-hook 'manim-mode-hook
          (lambda ()
            (require 'lsp-pyright)
            (setq-local lsp-enabled-clients '(pyright))
            (lsp-deferred)))

(setq org-directory "~/Documents/Org"
      org-agenda-files (list org-directory)
      org-use-property-inheritance t
      org-log-done 'time
      org-list-allow-alphabetical t        ; a. A. a) A) bullets
      org-fold-catch-invisible-edits 'show
      org-export-with-sub-superscripts t
      org-export-allow-bind-keywords t
      org-image-actual-width '(0.9)
      )

(setq org-babel-default-header-args
      '((:session . "none")
        (:results . "replace")
        (:exports . "code")
        (:cache . "no")
        (:noweb . "no")
        (:hlines . "no")
        (:tangle . "no")
        (:comments . "link")))

(remove-hook 'text-mode-hook #'visual-line-mode)
(add-hook 'text-mode-hook #'auto-fill-mode)

(setq org-agenda-prefix-format
      '((agenda . " %i %-12:c%?-12t% s")
        (todo   . " %i %-12:c%b")
        (tags   . " %i %-12:c%b")
        (search . " %i %-12:c%b")))
(setq org-agenda-breadcrumbs-separator " ❱ ")
(setq org-agenda-show-inherited-tags t)

(after! org
  (setq org-default-notes-file (expand-file-name "inbox.org" org-directory)
        org-capture-templates
        '(("X" "Inbox" entry
           (file "inbox.org")
           "* TODO %?\n:PROPERTIES:\n:CREATED: %U\n:END:\n"
           :empty-lines 1
           )
          ("l" "Log" entry
           (file+olp+datetree "log.org")
           "* %U\n%?"
           :empty-lines 1
           )
          )
        )
  )

(use-package! mixed-pitch
  :hook (org-mode . mixed-pitch-mode))
 
(use-package! olivetti
  :hook (org-mode . olivetti-mode)
  :config
  (setq olivetti-body-width 90))
 
(setq-hook! 'org-mode-hook line-spacing 0.3)  ; ~1.5x line height, as in Obsidian

(use-package! org-modern
  :hook (org-mode . org-modern-mode)
  :config
  (setq org-modern-star nil
       org-modern-hide-stars t 
        org-modern-table-vertical 1
        org-modern-table-horizontal 0.2
        org-modern-list '((?- . "•") (?+ . "◦") (?* . "•"))
        org-modern-todo-faces
        '(("TODO" :inherit org-todo             :extend nil)
          ("STRT" :inherit +org-todo-active     :extend nil)
          ("DONE" :inherit +org-todo-done       :extend nil)
          ("WAIT" :inherit +org-todo-onhold     :extend nil)
          )
        org-modern-footnote (cons nil (cadr org-script-display)) 
        org-modern-block-fringe 16
        org-modern-block-name
        '((t . t)
          ("src" "»" "«")
          ("quote" "❝" "❞")
          )
        org-modern-progress nil
        org-modern-priority nil
        org-modern-horizontal-rule (make-string 36 ?─)
        org-modern-keyword
        '((t . t)
          ("title" . "")
          ("results" . "🠶"))
        )

  (custom-set-faces! '(org-modern-statistics :inherit org-checkbox-statistics-todo)))

(after! org
  (setq org-hide-emphasis-markers t
        org-hide-leading-stars t
        org-pretty-entities t
        org-use-sub-superscripts '{}      ; only a_{1}, so snake_case stays plain
        org-startup-indented nil
        org-adapt-indentation nil
        org-ellipsis " …"
        org-fontify-quote-and-verse-blocks t
        org-fontify-whole-heading-line nil)
  (remove-hook 'org-mode-hook #'org-indent-mode))

(use-package! org-appear
  :hook (org-mode . org-appear-mode)
  :config
  (setq org-appear-autoemphasis t
        org-appear-autosubmarkers t
        org-appear-autolinks t
        org-appear-autoentities t
        org-appear-autokeywords t
        org-appear-inside-latex t
        org-appear-trigger 'manual)
  )
(add-hook 'org-mode-hook (lambda ()
                           (add-hook 'evil-insert-state-entry-hook
                                     #'org-appear-manual-start
                                     nil
                                     t)
                           (add-hook 'evil-insert-state-exit-hook
                                     #'org-appear-manual-stop
                                     nil
                                     t)))

(custom-set-faces!
  `(org-document-title  :weight extra-bold :height 1.8)
  `(org-level-1         :weight bold       :height 1.6)
  `(org-level-2         :weight bold       :height 1.4)
  `(org-level-3         :weight semi-bold  :height 1.25)
  `(org-level-4         :weight semi-bold  :height 1.15)
  `(org-level-5         :weight semi-bold  :height 1.05)
  `(org-level-6         :weight semi-bold)
  `(org-level-7         :weight semi-bold)
  `(org-level-8         :weight semi-bold)
  '(org-document-info-keyword :inherit shadow :height 0.85)
  '(org-meta-line             :inherit shadow :height 0.85)
  '(org-drawer                :inherit shadow :height 0.85)
  '(org-special-keyword       :inherit shadow :height 0.85)
  '(org-property-value        :inherit shadow :height 0.85)
  '(org-block-begin-line      :inherit shadow :height 0.85)
  '(org-block-end-line        :inherit shadow :height 0.85))

(defvar +org-spacing-heading-above '(1.2 0.9 0.6)
  "Space above level-1, level-2 and deeper headings.")
(defvar +org-spacing-heading-below 0.3
  "Space below a heading.")
(defvar +org-spacing-block 0.5
  "Space above #+begin_ and below #+end_ lines.")
(defvar +org-spacing-blank-height 0.5
  "Height of blank lines, as a fraction of normal text.")

(defun +org-spacing--keywords ()
  (let ((above (lambda (n) (nth (min (1- n) 2) +org-spacing-heading-above))))
    `(;; below headings (listed first so "above" wins on a shared newline)
      ("^\\*+ .*\\(\n\\)" 1 '(face nil line-spacing ,+org-spacing-heading-below))
      ;; above headings: on the newline ending the previous line
      ("\\(\n\\)\\* "         1 '(face nil line-spacing ,(funcall above 1)))
      ("\\(\n\\)\\*\\{2\\} "  1 '(face nil line-spacing ,(funcall above 2)))
      ("\\(\n\\)\\*\\{3,\\} " 1 '(face nil line-spacing ,(funcall above 3)))
      ;; around blocks
      ("\\(\n\\)[ \t]*#\\+[Bb][Ee][Gg][Ii][Nn]_" 1 '(face nil line-spacing ,+org-spacing-block))
      ("^[ \t]*#\\+[Ee][Nn][Dd]_.*\\(\n\\)"     1 '(face nil line-spacing ,+org-spacing-block))
      ;; shorter blank lines
      ("^[ \t]*\n" 0 '(:height ,+org-spacing-blank-height) append))))

(defun +org-spacing--extend-region ()
  "Refontify the previous line too when the region starts on a heading or
block line, since their spacing lives on the newline before them."
  (save-excursion
    (goto-char font-lock-beg)
    (when (and (bolp) (not (bobp))
               (looking-at "\\*+ \\|[ \t]*#\\+[Bb][Ee][Gg][Ii][Nn]_"))
      (forward-line -1)
      (setq font-lock-beg (point))
      t)))

(defun +org-spacing-h ()
  ;; let font-lock remove stale spacing when a line stops being a heading
  (setq-local font-lock-extra-managed-props
              (cons 'line-spacing font-lock-extra-managed-props))
  (add-hook 'font-lock-extend-region-functions #'+org-spacing--extend-region 90 t)
  (font-lock-add-keywords nil (+org-spacing--keywords) 'append)
  (font-lock-flush))

;; depth 90: after org-modern has installed its keywords
(add-hook 'org-mode-hook #'+org-spacing-h 90)

(defun locally-defer-font-lock ()
  "Set jit-lock defer and stealth, when buffer is over a certain size."
  (when (> (buffer-size) 50000)
    (setq-local jit-lock-defer-time 0.05
                jit-lock-stealth-time 1)))

(add-hook 'org-mode-hook #'locally-defer-font-lock)

(setq
 ;;org-ellipsis " …"
   ;;   org-startup-indented nil
    ;;  org-adapt-indentation nil
      org-priority-highest ?A
      org-priority-lowest ?E
      org-priority-faces
      '((?A . 'nerd-icons-red)
        (?B . 'nerd-icons-orange)
        (?C . 'nerd-icons-yellow)
        (?D . 'nerd-icons-green)
        (?E . 'nerd-icons-blue)))

(appendq! +ligatures-extra-symbols
          (list :list_property "∷"
                :em_dash       "—"
                :ellipsis      "…"
                :arrow_right   "→"
                :arrow_left    "←"
                :arrow_lr      "↔"
                :properties    "⚙"
                :end           "∎"
                )
          )
(defadvice! +org-init-appearance-h--no-ligatures-a ()
  :after #'+org-init-appearance-h
  (set-ligatures! 'org-mode nil)
  (set-ligatures! 'org-mode
    :list_property "::"
    :em_dash       "--"
    :ellipsis      "..."
    :arrow_right   "->"
    :arrow_left    "<-"
    :arrow_lr      "<->"
    :properties    ":PROPERTIES:"
    :end           ":END:"
    :priority_a    "[#A]"
    :priority_b    "[#B]"
    :priority_c    "[#C]"
    :priority_d    "[#D]"
    :priority_e    "[#E]"))

(setq org-highlight-latex-and-related '(latex script entities))
(require 'org-src)
(add-to-list 'org-src-block-faces '("latex" (:inherit default :extend t)))

(defun TeX-string-single-token-p (teststring)
  "Return t if TESTSTRING appears to be a single token, nil otherwise"
  (if (string-match-p "^\\\\?\\w+$" teststring) t nil))

(defun TeX-fold-parenthesize-as-necessary (tokens &optional suppress-left suppress-right)
  "Add ❪ ❫ parenthesis as if multiple LaTeX tokens appear to be present"
  (if (TeX-string-single-token-p tokens) tokens
    (concat (if suppress-left "" "❪")
            tokens
            (if suppress-right "" "❫"))))

(defun string-offset-roman-chars (offset word)
  "Shift the codepoint of each character in WORD by OFFSET with an extra -6 shift if the letter is lowercase"
  (apply 'string
         (mapcar (lambda (c)
                   (string-offset-apply-roman-char-exceptions
                    (+ (if (>= c 97) (- c 6) c) offset)))
                 word)))

(defun string-offset-apply-roman-char-exceptions (char)
  "Sometimes the codepoint doesn't contain the char you expect.
Such special cases should be remapped to another value, as given in `string-offset-roman-char-exceptions'."
  (if (assoc char string-offset-roman-char-exceptions)
      (cdr (assoc char string-offset-roman-char-exceptions))
    char))

(defvar string-offset-roman-char-exceptions
  '(;; lowercase serif
    (119892 .  8462) ; ℎ
    ;; lowercase caligraphic
    (119994 . 8495) ; ℯ
    (119996 . 8458) ; ℊ
    (120004 . 8500) ; ℴ
    ;; caligraphic
    (119965 . 8492) ; ℬ
    (119968 . 8496) ; ℰ
    (119969 . 8497) ; ℱ
    (119971 . 8459) ; ℋ
    (119972 . 8464) ; ℐ
    (119975 . 8466) ; ℒ
    (119976 . 8499) ; ℳ
    (119981 . 8475) ; ℛ
    ;; fraktur
    (120070 . 8493) ; ℭ
    (120075 . 8460) ; ℌ
    (120076 . 8465) ; ℑ
    (120085 . 8476) ; ℜ
    (120092 . 8488) ; ℨ
    ;; blackboard
    (120122 . 8450) ; ℂ
    (120127 . 8461) ; ℍ
    (120133 . 8469) ; ℕ
    (120135 . 8473) ; ℙ
    (120136 . 8474) ; ℚ
    (120137 . 8477) ; ℝ
    (120145 . 8484) ; ℤ
    )
  "An alist of deceptive codepoints, and then where the glyph actually resides.")

(setq TeX-fold-math-spec-list
      `(;; missing/better symbols
        ("≤" ("le"))
        ("≥" ("ge"))
        ("≠" ("ne"))
        ;; private macros
        ("ℝ" ("RR"))
        ("ℕ" ("NN"))
        ("ℤ" ("ZZ"))
        ("ℚ" ("QQ"))
        ("ℂ" ("CC"))
        ("ℙ" ("PP"))
        ("ℍ" ("HH"))
        ("𝔼" ("EE"))
        ("𝑑" ("dd"))
        ;; known commands
        ("" ("phantom"))
        ("‘{1}’" ("text"))
        ;; private commands
        ("|{1}|" ("abs"))
        ("‖{1}‖" ("norm"))
        ("⌊{1}⌋" ("floor"))
        ("⌈{1}⌉" ("ceil"))
        ("⌊{1}⌉" ("round"))
        ("𝑑{1}/𝑑{2}" ("dv"))
        ("∂{1}/∂{2}" ("pdv"))
        ;; fancification
        ("{1}" ("mathrm"))
        (,(lambda (word) (string-offset-roman-chars 119743 word)) ("mathbf"))
        (,(lambda (word) (string-offset-roman-chars 119951 word)) ("mathcal"))
        (,(lambda (word) (string-offset-roman-chars 120003 word)) ("mathfrak"))
        (,(lambda (word) (string-offset-roman-chars 120055 word)) ("mathbb"))
        (,(lambda (word) (string-offset-roman-chars 120159 word)) ("mathsf"))
        (,(lambda (word) (string-offset-roman-chars 120367 word)) ("mathtt"))
        )
      TeX-fold-macro-spec-list
      '(
        ;; as the defaults
        ("[f]" ("footnote" "marginpar"))
        ("[c]" ("cite"))
        ("[l]" ("label"))
        ("[r]" ("ref" "pageref" "eqref"))
        ("[i]" ("index" "glossary"))
        ("..." ("dots"))
        ("{1}" ("emph" "textit" "textsl" "textmd" "textrm" "textsf" "texttt"
                "textbf" "textsc" "textup"))
        ;; tweaked defaults
        ("©" ("copyright"))
        ("®" ("textregistered"))
        ("™"  ("texttrademark"))
        ("[1]:||►" ("item"))
        ("❡❡ {1}" ("part" "part*"))
        ("❡ {1}" ("chapter" "chapter*"))
        ("§ {1}" ("section" "section*"))
        ("§§ {1}" ("subsection" "subsection*"))
        ("§§§ {1}" ("subsubsection" "subsubsection*"))
        ("¶ {1}" ("paragraph" "paragraph*"))
        ("¶¶ {1}" ("subparagraph" "subparagraph*"))
        ))

(defface unimportant-latex-face
  '((t :inherit font-lock-comment-face :weight extra-light))
  "Face used to make \\(\\), \\[\\] less visible."
  :group 'LaTeX-math)

(font-lock-add-keywords
 'latex-mode
 `(("\\\\[]()[]" 0 'unimportant-latex-face prepend))
 'end)

(after! tex
  (map!
   :map LaTeX-mode-map
   :ei [C-return] #'LaTeX-insert-item)
  (setq TeX-electric-math '("\\(" . ""))

  (add-hook 'TeX-mode-hook
            (lambda ()
              ;; keep only LSP + snippets as CAPFs
              (setq-local completion-at-point-functions
                          '(lsp-completion-at-point
                            yasnippet-capf)
                          )
              )
            )
  )

(setq lsp-tex-server 'digestif)

(setq LaTeX-indent-level 4)
(setq TeX-brace-indent-level 4)
(setq LaTeX-item-indent 4)

(map! :map cdlatex-mode-map
      :i "TAB" #'cdlatex-tab)
(after! cdlatex
  (setq cdlatex-env-alist
        '(("bmatrix" "\\begin{bmatrix}\n?\n\\end{bmatrix}" nil)
          ("equation*" "\\begin{equation*}\n?\n\\end{equation*}" nil)))
  (setq ;; cdlatex-math-symbol-prefix ?\;  ;; doesn't work at the moment :(
   cdlatex-math-symbol-alist
   '( ;; adding missing functions to 3rd level symbols
     (?_    ("\\downarrow"  ""           "\\inf"))
     (?2    ("^2"           "\\sqrt{?}"     ""     ))
     (?3    ("^3"           "\\sqrt[3]{?}"  ""     ))
     (?^    ("\\uparrow"    ""           "\\sup"))
     (?k    ("\\kappa"      ""           "\\ker"))
     (?m    ("\\mu"         ""           "\\lim"))
     (?c    (""             "\\circ"     "\\cos"))
     (?d    ("\\delta"      "\\partial"  "\\dim"))
     (?D    ("\\Delta"      "\\nabla"    "\\deg"))
     ;; no idea why \Phi isn't on 'F' in the first place, \phi is on 'f'
     (?F    ("\\Phi"))
     ;; now just convenience
     (?.    ("\\cdot" "\\dots"))
     (?:    ("\\vdots" "\\ddots"))
     (?*    ("\\times" "\\star" "\\ast")))
   cdlatex-math-modify-alist
   '( ;; my own stuff
     (?B    "\\mathbb"        nil          t    nil  nil)
     (?a    "\\abs"           nil          t    nil  nil))))

(use-package laas
  :hook (LaTeX-mode . laas-mode)
  :config
  (aas-set-snippets 'laas-mode
                    :cond #'texmathp   ; expand only while in math
                    "supp" "\\supp"
                    "On" "O(n)"
                    "O1" "O(1)"
                    "Olog" "O(\\log n)"
                    "Olon" "O(n \\log n)"
                    ;; bind to functions!
                    "Sum" (lambda () (interactive)
                            (yas-expand-snippet "\\sum_{$1}^{$2} $0"))
                    "Span" (lambda () (interactive)
                             (yas-expand-snippet "\\Span($1)$0"))
                    ";;M" (lambda () (interactive)
                            (yas-expand-snippet "\\begin{pmatrix}
                                        $0
                                \\end{pmatrix}"))
                    ;; add accent snippets
                    :cond #'laas-object-on-left-condition
                    "qq" (lambda () (interactive) (laas-wrap-previous-object "sqrt"))))

(setq reftex-default-bibliography '("~/Documents/PhD/references.bib"))

(after! citar
  (setq citar-bibliography
        '("~/Documents/PhD/references.bib"))

  ;; what is shown in the completion list
  (setq citar-templates
        '((main . "${author editor:30%sn}     ${date year issued:4}     ${title:80}")
          (suffix . "     ${=key= id:15}")
          (preview . "${author editor} (${date year issued}) ${title}, ${journal journaltitle publisher container-title collection-title}.")
          (note . "Notes on ${author editor}, ${title}"))))

(use-package! citar-capf
  :after citar
  :hook
  (LaTeX-mode . citar-capf-setup)
  (latex-mode . citar-capf-setup))

(after! tex
  (defvar tec/tex-last-delim-char nil
    "Last open delim expanded in a tex document")
  (defvar tec/tex-delim-dot-second t
    "When the `tec/tex-last-delim-char' is . a second character (this) is prompted for")
  (defun tec/get-open-delim-char ()
    "Exclusivly read next char to tec/tex-last-delim-char"
    (setq tec/tex-delim-dot-second nil)
    (setq tec/tex-last-delim-char (read-char-exclusive "Opening deliminator, recognises: 9 ( [ { < | ."))
    (when (eql ?. tec/tex-last-delim-char)
      (setq tec/tex-delim-dot-second (read-char-exclusive "Other deliminator, recognises: 0 9 (  ) [ ] { } < > |"))))
  (defun tec/tex-open-delim-from-char (&optional open-char)
    "Find the associated opening delim as string"
    (unless open-char (setq open-char (if (eql ?. tec/tex-last-delim-char)
                                          tec/tex-delim-dot-second
                                        tec/tex-last-delim-char)))
    (pcase open-char
      (?\( "(")
      (?9  "(")
      (?\[ "[")
      (?\{ "\\{")
      (?<  "<")
      (?|  (if tec/tex-delim-dot-second "." "|"))
      (_   ".")))
  (defun tec/tex-close-delim-from-char (&optional open-char)
    "Find the associated closing delim as string"
    (if tec/tex-delim-dot-second
        (pcase tec/tex-delim-dot-second
          (?\) ")")
          (?0  ")")
          (?\] "]")
          (?\} "\\}")
          (?\> ">")
          (?|  "|")
          (_   "."))
      (pcase (or open-char tec/tex-last-delim-char)
        (?\( ")")
        (?9  ")")
        (?\[ "]")
        (?\{ "\\}")
        (?<  ">")
        (?\) ")")
        (?0  ")")
        (?\] "]")
        (?\} "\\}")
        (?\> ">")
        (?|  "|")
        (_   "."))))
  (defun tec/tex-next-char-smart-close-delim (&optional open-char)
    (and (bound-and-true-p smartparens-mode)
         (eql (char-after) (pcase (or open-char tec/tex-last-delim-char)
                             (?\( ?\))
                             (?\[ ?\])
                             (?{ ?})
                             (?< ?>)))))
  (defun tec/tex-delim-yas-expand (&optional open-char)
    (yas-expand-snippet (yas-lookup-snippet "_deliminators" 'latex-mode) (point) (+ (point) (if (tec/tex-next-char-smart-close-delim open-char) 2 1)))))

(eval-after-load
    "latex"
  '(TeX-add-style-hook
    "cleveref"
    (lambda ()
      (if (boundp 'reftex-ref-style-alist)
          (add-to-list
           'reftex-ref-style-alist
           '("Cleveref" "cleveref"
             (("\\cref" ?c) ("\\Cref" ?C) ("\\cpageref" ?d) ("\\Cpageref" ?D)))))
      (reftex-ref-style-activate "Cleveref")
      (TeX-add-symbols
       '("cref" TeX-arg-ref)
       '("Cref" TeX-arg-ref)
       '("cpageref" TeX-arg-ref)
       '("Cpageref" TeX-arg-ref)))))
