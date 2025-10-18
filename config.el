;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;; --- --- --- --- --- ---
;; --- BETTER DEFAULTS ---
;; --- --- --- --- --- ---

(setq-default
 window-combination-resize t ; take new window space from all other windows (not just current)
 x-stretch-cursor t
 )

(setq
 evil-want-fine-undo t ; By default while in insert all changes are one big blob. Be more granular
 auto-save-default t ; Nobody likes to loose work, I certainly don't
 truncate-string-ellipsis "..." ; Unicode ellispis are nicer than "...", and also save /precious/ space
 password-cache-expiry nil ; I can trust my computers ... can't I?
 scroll-preserve-screen-position 'always ; Don't have `point' jump around
 scroll-margin 2 ; It's nice to maintain a little margin
 display-time-default-load-average nil ; I don't think I've ever found this useful
 ) 

(display-time-mode 1) ; Enable time in the mode-line
(global-subword-mode 1) ; Iterate through CamelCase words


(setq evil-vsplit-window-right t ;better splitting
      evil-split-window-below t
      )
(defadvice! prompt-for-buffer (&rest _) ;prompt buffer choice after splitting
  :after '(evil-window-split evil-window-vsplit)
  (consult-buffer)
  )

(global-set-key [remap dabbrev-expand] #'hippie-expand) ;better expansion


;; --- --- --- --- 
;; --- FONTS ---
;; --- --- --- ---
(setq
 doom-font (font-spec :family "JetBrains Mono" :size 18)
 doom-big-font (font-spec :family "JetBrains Mono" :size 30)
 doom-variable-pitch-font (font-spec :family "Overpass" :size 20)
 doom-symbol-font (font-spec :family "JuliaMono")
 doom-serif-font (font-spec :family "IBM Plex Mono" :size 16 :weight 'light)
 )


;; --- --- --- --- --- ---
;; --- LINE NUMBERS ---
;; --- --- --- --- --- ---
(setq display-line-numbers-type 'relative)


;; --- --- --- --- 
;; --- THEME ---
;; --- --- --- ---
(setq doom-theme 'doom-acario-light)

;; --- --- --- --- --- 
;; --- DASHBOARD ---
;; --- --- --- --- ---
(defun shrek ()
  (let* ((banner '(
                   "⢀⡴⠑⡄⠀⠀⠀⠀⠀⠀⠀⣀⣀⣤⣤⣤⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
                   "⠸⡇⠀⠿⡀⠀⠀⠀⣀⡴⢿⣿⣿⣿⣿⣿⣿⣿⣷⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
                   "⠀⠀⠀⠀⠑⢄⣠⠾⠁⣀⣄⡈⠙⣿⣿⣿⣿⣿⣿⣿⣿⣆⠀⠀⠀⠀⠀⠀⠀⠀"
                   "⠀⠀⠀⠀⢀⡀⠁⠀⠀⠈⠙⠛⠂⠈⣿⣿⣿⣿⣿⠿⡿⢿⣆⠀⠀⠀⠀⠀⠀⠀"
                   "⠀⠀⠀⢀⡾⣁⣀⠀⠴⠂⠙⣗⡀⠀⢻⣿⣿⠭⢤⣴⣦⣤⣹⠀⠀⠀⢀⢴⣶⣆"
                   "⠀⠀⢀⣾⣿⣿⣿⣷⣮⣽⣾⣿⣥⣴⣿⣿⡿⢂⠔⢚⡿⢿⣿⣦⣴⣾⠁⠸⣼⡿"
                   "⠀⢀⡞⠁⠙⠻⠿⠟⠉⠀⠛⢹⣿⣿⣿⣿⣿⣌⢤⣼⣿⣾⣿⡟⠉⠀⠀⠀⠀⠀"
                   "⠀⣾⣷⣶⠇⠀⠀⣤⣄⣀⡀⠈⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀"
                   "⠀⠉⠈⠉⠀⠀⢦⡈⢻⣿⣿⣿⣶⣶⣶⣶⣤⣽⡹⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀"
                   "⠀⠀⠀⠀⠀⠀⠀⠉⠲⣽⡻⢿⣿⣿⣿⣿⣿⣿⣷⣜⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀"
                   "⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣷⣶⣮⣭⣽⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀"
                   "⠀⠀⠀⠀⠀⠀⣀⣀⣈⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠇⠀⠀⠀⠀⠀⠀⠀"
                   "⠀⠀⠀⠀⠀⠀⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠃⠀⠀⠀⠀⠀⠀⠀⠀"
                   "⠀⠀⠀⠀⠀⠀⠀⠹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀"
                   "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠛⠻⠿⠿⠿⠿⠛⠉             "
                   ))
         (longest-line (apply #'max (mapcar #'length banner))))
    (put-text-property
     (point)
     (dolist (line banner (point))
       (insert (+doom-dashboard--center
                +doom-dashboard--width
                (concat line (make-string (max 0 (- longest-line (length line))) 32)))
               "\n"))
     'face 'doom-dashboard-banner)))

(setq +doom-dashboard-ascii-banner-fn #'shrek)


;; --- --- --- --- ---
;; --- WHICH KEY ---
;; --- --- --- --- ---
(setq which-key-allow-multiple-replacements t)
(after! which-key
  (pushnew!
   which-key-replacement-alist ;remove evil from key name
   '(("" . "\\`+?evil[-:]?\\(?:a-\\)?\\(.*\\)") . (nil . "\\1"))
   '(("\\`g s" . "\\`evilem--?motion-\\(.*\\)") . (nil . "\\1"))
   ))

;; --- --- --- --- 
;; --- ABBREVS ---
;; --- --- --- ---
;; for instance vf->vector field
(setq-default abbrev-mode t)
(setq abbrev-file-name (expand-file-name "abbrev.el" doom-user-dir));set the file where they are saved


;; --- --- --- --- 
;; --- EVIL ---
;; --- --- --- ---
(after! evil
  (setq evil-move-cursor-back nil ; Don't move the block cursor when toggling insert mode
        )
  )
(setq-default evil-escape-key-sequence "jk")

;; --- --- --- --- 
;; --- CONSULT ---
;; --- --- --- ---
;; ie buffer/dir/etc list
(after! consult
  (set-face-attribute 'consult-file nil :inherit 'consult-buffer)
  (setf (plist-get (alist-get 'perl consult-async-split-styles-alist) :initial) ";"))

;; --- --- --- --- 
;; --- JINX ---
;; --- --- --- ---
;; better spellcheck
(use-package! jinx
  :defer t
  :init
  (add-hook 'doom-init-ui-hook #'global-jinx-mode)
  :config
  ;; Use my custom dictionary
  (setq jinx-languages "en_GB")
  ;; Extra face(s) to ignore
  (push 'org-inline-src-block
        (alist-get 'org-mode jinx-exclude-faces))
  ;; Take over the relevant bindings.
  (after! ispell
    (global-set-key [remap ispell-word] #'jinx-correct))
  (after! evil-commands
    (global-set-key [remap evil-next-flyspell-error] #'jinx-next)
    (global-set-key [remap evil-prev-flyspell-error] #'jinx-previous))
  ;; I prefer for `point' to end up at the start of the word,
  ;; not just after the end.
  (advice-add 'jinx-next :after (lambda (_) (left-word))))

;; --- --- --- --- ---
;; --- MODELINE ---
;; --- --- --- --- ---
;; better modeline for pdf
;;;(doom-modeline-def-segment buffer-name
;;;  "Display the current buffer's name, without any other information."
;;;  (concat
;;;   (doom-modeline-spc)
;;;   (doom-modeline--buffer-name)))
;;;(doom-modeline-def-segment pdf-icon
;;;  "PDF icon from nerd-icons."
;;;  (concat
;;;   (doom-modeline-icon sucicon "nf-seti-pdf" nil nil
;;;                       (doom-modeline-spc)
;;;                       :face (if (doom-modeline--active)
;;;                                 'nerd-icons-red
;;;                               'mode-line-inactive)
;;;                       :v-adjust 0.02)))
;;;(defun doom-modeline-update-pdf-pages ()
;;;  "Update PDF pages."
;;;  (setq doom-modeline--pdf-pages
;;;        (let ((current-page-str (number-to-string (eval
;;;                                                   ↩→ `(pdf-view-current-page))))
;;;              (total-page-str (number-to-string (pdf-cache-number-of-pages))))
;;;          (concat
;;;           (propertize
;;;            (concat (make-string (- (length total-page-str) (length
;;;                                                             ↩→ current-page-str)) ? )
;;;                    " P" current-page-str)
;;;            'face 'mode-line)
;;;           (propertize (concat "/" total-page-str) 'face
;;;                       ↩→ 'doom-modeline-buffer-minor-mode)))))
;;;(doom-modeline-def-segment pdf-pages
;;;  "Display PDF pages."
;;;  (if (doom-modeline--active) doom-modeline--pdf-pages
;;;    (propertize doom-modeline--pdf-pages 'face 'mode-line-inactive)))
;;;(doom-modeline-def-modeline 'pdf
;;;  '(bar window-number pdf-pages pdf-icon buffer-name)
;;;  '(misc-info matches major-mode process vcs))


;; --- --- --- --- ---
;; --- MIXED PITCH ---
;; --- --- --- --- ---
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

;;;(defvar mixed-pitch-modes '(org-mode LaTeX-mode markdown-mode gfm-mode Info-mode)
;;;  "Modes that ` mixed-pitch-mode ' should be enabled in, but only after UI initialisation." )
;;;
;;;(defun init-mixed-pitch-h ()
;;;  "Hook ` mixed-pitch-mode ' into each mode in ` mixed-pitch-modes '. Also immediately enables ` mixed-pitch-modes ' if currently in one of the modes."
;;;  (when (memq major-mode mixed-pitch-modes)
;;;    (mixed-pitch-mode 1))
;;;  (dolist (hook mixed-pitch-modes)
;;;    (add-hook (intern (concat (symbol-name hook) "-hook")) #'mixed-pitch-mode)))
;;;
;;;(add-hook 'doom-init-ui-hook #'init-mixed-pitch-h)
;;;(autoload #'mixed-pitch-serif-mode "mixed-pitch" "Change the default face of the current buffer to a serifed variable pitch, while keeping some faces fixed pitch." t)
;;;(setq! variable-pitch-serif-font (font-spec :family "Alegreya" :size 27))
;;;(after! mixed-pitch
;;;  (setq mixed-pitch-set-height t)
;;;  (set-face-attribute 'variable-pitch-serif nil :font variable-pitch-serif-font)
;;;  (defun mixed-pitch-serif-mode (&optional arg)
;;;    "Change the default face of the current buffer to a serifed variable pitch, while keeping some faces fixed pitch."
;;;    (interactive)
;;;    (let ((mixed-pitch-face 'variable-pitch-serif))
;;;      (mixed-pitch-mode (or arg 'toggle)))))
;;;
;;;(set-char-table-range composition-function-table ?f '(["\\(?:ff?[fijlt]\\)" 0 font-shape-gstring]))
;;;(set-char-table-range composition-function-table ?T '(["\\(?:Th\\)" 0 font-shape-gstring]))
;;;(defface variable-pitch-serif
;;;  '((t (:family "serif")))
;;;  "A variable-pitch face with serifs."
;;;  :group 'basic-faces)
;;;
;;;(defcustom variable-pitch-serif-font (font-spec :family "serif")
;;;  "The font face used for ` variable-pitch-serif '."
;;;  :group 'basic-faces
;;;  :type '(restricted-sexp :tag "font-spec" :match-alternatives (fontp))
;;;  :set (lambda (symbol value)
;;;         (set-face-attribute 'variable-pitch-serif nil :font value)
;;;         (set-default-toplevel-value symbol value)))


;; --- --- --- --- ---
;; --- MARGINALIA ---
;; --- --- --- --- ---
;; better files metadata
(after! marginalia
  (setq marginalia-censor-variables nil)
  (defadvice! +marginalia--anotate-local-file-colorful (cand)
    "Just a more colourful version of ` marginalia--anotate-local-file '."
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
      ;; 1 - log(3 + 1/(days + 1)) % grey
      (propertize (marginalia--time time) 'face (list :foreground color))))
  (defun +marginalia-file-size-colorful (size)
    (let* ((size-index (/ (log (+ 1 size)) 7.0))
           (color (if (< size-index 10000000) ; 10m
                      (doom-blend 'orange 'green size-index)
                    (doom-blend 'red 'orange (- size-index 1)))))
      (propertize (file-size-human-readable size) 'face (list :foreground color)))))

;; --- --- --- --- ---
;; --- WRITEROOM ---
;; --- --- --- --- ---
;; Custom settings for org
(setq +zen-text-scale 0.8)

(defvar +zen-serif-p t
  "Whether to use a serifed font with `mixed-pitch-mode'.")
(defvar +zen-org-starhide t
  "The value `org-modern-hide-stars' is set to.")

(after! writeroom-mode
  (defvar-local +zen--original-org-indent-mode-p nil)
  (defvar-local +zen--original-mixed-pitch-mode-p nil)
  (defun +zen-enable-mixed-pitch-mode-h ()
    "Enable `mixed-pitch-mode' when in `+zen-mixed-pitch-modes'."
    (when (apply #'derived-mode-p +zen-mixed-pitch-modes)
      (if writeroom-mode
          (progn
            (setq +zen--original-mixed-pitch-mode-p mixed-pitch-mode)
            (funcall (if +zen-serif-p #'mixed-pitch-serif-mode #'mixed-pitch-mode) 1))
        (funcall #'mixed-pitch-mode (if +zen--original-mixed-pitch-mode-p 1 -1)))))
  (defun +zen-prose-org-h ()
    "Reformat the current Org buffer appearance for prose."
    (when (eq major-mode 'org-mode)
      (setq display-line-numbers nil
            visual-fill-column-width 60
            org-adapt-indentation nil)
      (when (featurep 'org-modern)
        (setq-local org-modern-star '("🙘" "🙙" "🙚" "🙛")
                    ;; org-modern-star '("🙐" "🙑" "🙒" "🙓" "🙔" "🙕" "🙖" "🙗")
                    org-modern-hide-stars +zen-org-starhide)
        (org-modern-mode -1)
        (org-modern-mode 1))
      (setq
       +zen--original-org-indent-mode-p org-indent-mode)
      (org-indent-mode -1)))
  (defun +zen-nonprose-org-h ()
    "Reverse the effect of `+zen-prose-org'."
    (when (eq major-mode 'org-mode)
      (when (bound-and-true-p org-modern-mode)
        (org-modern-mode -1)
        (org-modern-mode 1))
      (when +zen--original-org-indent-mode-p (org-indent-mode 1))))
  (pushnew! writeroom--local-variables
            'display-line-numbers
            'visual-fill-column-width
            'org-adapt-indentation
            'org-modern-mode
            'org-modern-star
            'org-modern-hide-stars)
  (add-hook 'writeroom-mode-enable-hook #'+zen-prose-org-h)
  (add-hook 'writeroom-mode-disable-hook #'+zen-nonprose-org-h))


;; --- --- --- --- --- ---
;; --- ORG DEFAULTS ---
;; --- --- --- --- --- ---
(setq org-directory "~/Documents/" ; Let's put files here.
      org-agenda-files (list org-directory)                  ; Seems like the obvious place.
      org-use-property-inheritance t                         ; It's convenient to have properties inherited.
      org-log-done 'time                                     ; Having the time a item is done sounds convenient.
      org-list-allow-alphabetical t                          ; Have a. A. a) A) list bullets.
      org-catch-invisible-edits 'smart                       ; Try not to accidently do weird stuff in invisible regions.
      org-export-with-sub-superscripts '{}                   ; Don't treat lone _ / ^ as sub/superscripts, require _{} / ^{}.
      org-export-allow-bind-keywords t                       ; Bind keywords can be handy
      org-image-actual-width '(0.9))                         ; Make the in-buffer display closer to the exported result..
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

;; --- --- --- --- ---
;; --- ORG MODERN ---
;; --- --- --- --- ---
(use-package! org-modern
  :hook (org-mode . org-modern-mode)
  :config
  (setq org-modern-star '("◉" "○" "✸" "✿" "✤" "✜" "◆" "▶")
        org-modern-table-vertical 1
        org-modern-table-horizontal 0.2
        org-modern-list '((43 . "➤")
                          (45 . "–")
                          (42 . "•"))
        org-modern-todo-faces
        '(("TODO" :inverse-video t :inherit org-todo)
          ("STRT" :inverse-video t :inherit +org-todo-active)
          ("WAIT" :inverse-video t :inherit +org-todo-onhold)
          org-modern-footnote
          (cons nil (cadr org-script-display))
          org-modern-block-fringe nil
          org-modern-block-name
          '((t . t)
            ("src" "»" "«")
            ("example" "»–" "–«")
            ("quote" "❝" "❞")
            ("export" "⏩" "⏪"))
          org-modern-progress nil
          org-modern-priority nil
          org-modern-horizontal-rule (make-string 36 ?─)
          org-modern-keyword
          '((t . t)
            ("title" . "𝙏")
            ("subtitle" . "𝙩")
            ("author" . "𝘼")
            ("email" . "")
            ("date" . "𝘿")
            ("property" . "󰠳")
            ("options" . #("󰘵" 0 1 (display (height 0.75))))
            ("startup" . "⏻")
            ("macro" . "𝓜")
            ("bind" . "󰌷")
            ("bibliography" . "")
            ("print_bibliography" . "󰌱")
            ("cite_export" . "⮭")
            ("print_glossary" . "󰌱ᴬᶻ")
            ("glossary_sources" . "󰒻")
            ("include" . "⇤")
            ("setupfile" . "⇚")
            ("html_head" . "🅷")
            ("html" . "🅗")
            ("latex_class" . "🄻")
            ("latex_class_options" . "🄻󰒓")
            ("latex_header" . "🅻")
            ("latex_header_extra" . "🅻⁺")
            ("latex" . "🅛")
            ("beamer_theme" . "🄱")
            ("beamer_color_theme" . "🄱󰏘")
            ("beamer_font_theme" . "🄱𝐀")
            ("beamer_header" . "🅱")
            ("beamer" . "🅑")
            ("attr_latex" . "🄛")
            ("attr_html" . "🄗")
            ("attr_org" . "⒪")
            ("call" . "󰜎")
            ("name" . "⁍")
            ("header" . "›")
            ("caption" . "☰")
            ("results" . "🠶")))
        (custom-set-faces! '(org-modern-statistics :inherit org-checkbox-statistics-todo))))

(after! spell-fu
  (cl-pushnew 'org-modern-tag (alist-get 'org-mode +spell-excluded-faces-alist)))

;; --- --- --- --- ---
;; --- ORG APPEAR --- 
;; --- --- --- --- ---
(use-package! org-appear
  :hook (org-mode . org-appear-mode)
  :config
  (setq org-appear-autoemphasis t
        org-appear-autosubmarkers t
        org-appear-autolinks nil)
  ;; for proper first-time setup, `org-appear--set-elements'
  ;; needs to be run after other hooks have acted.
  (run-at-time nil nil #'org-appear--set-elements))

;; --- --- --- --- ---
;; --- ORG VISUALS --- 
;; --- --- --- --- ---
;; Set outline dimensions
(custom-set-faces!
  '(outline-1 :weight extra-bold :height 1.25)
  '(outline-2 :weight bold :height 1.15)
  '(outline-3 :weight bold :height 1.12)
  '(outline-4 :weight semi-bold :height 1.09)
  '(outline-5 :weight semi-bold :height 1.06)
  '(outline-6 :weight semi-bold :height 1.03)
  '(outline-8 :weight semi-bold)
  '(outline-9 :weight semi-bold))

(custom-set-faces!
  '(org-document-title :height 1.2))

;; Better quote blocks
(setq org-fontify-quote-and-verse-blocks t)

;; Improve performance
(defun locally-defer-font-lock ()
  "Set jit-lock defer and stealth, when buffer is over a certain size."
  (when (> (buffer-size) 50000)
    (setq-local jit-lock-defer-time 0.05
                jit-lock-stealth-time 1)))

(add-hook 'org-mode-hook #'locally-defer-font-lock)

;; Better indent and line spacing
(defadvice! +org-indent--reduced-text-prefixes ()
  :after #'org-indent--compute-prefixes
  (setq org-indent--text-line-prefixes
        (make-vector org-indent--deepest-level nil))
  (when (> org-indent-indentation-per-level 0)
    (dotimes (n org-indent--deepest-level)
      (aset org-indent--text-line-prefixes
            n
            (org-add-props
             (concat (make-string (* n (1- org-indent-indentation-per-level))
                                  ?\s)
                     (if (> n 0)
                         (char-to-string org-indent-boundary-char)
                       "\u200b"))
             nil 'face 'org-indent)))))


;; Nice Symbols
(setq org-ellipsis " ▾ "
      org-hide-leading-stars t
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
                :ellipses      "…"
                :arrow_right   "→"
                :arrow_left    "←"
                :arrow_lr      "↔"
                :properties    "⚙"
                :end           "∎"
                :priority_a    #("⚑" 0 1 (face nerd-icons-red))
                :priority_b    #("⬆" 0 1 (face nerd-icons-orange))
                :priority_c    #("■" 0 1 (face nerd-icons-yellow))
                :priority_d    #("⬇" 0 1 (face nerd-icons-green))
                :priority_e    #("❓" 0 1 (face nerd-icons-blue))))

(defadvice! +org-init-appearance-h--no-ligatures-a ()
  :after #'+org-init-appearance-h
  (set-ligatures! 'org-mode nil)
  (set-ligatures! 'org-mode
    :list_property "::"
    :em_dash       "---"
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

;; Better latex fragments
(setq org-highlight-latex-and-related '(latex script entities))
(require 'org-src)
(add-to-list 'org-src-block-faces '("latex" (:inherit default :extend t)))
(add-hook 'org-mode-hook #'org-latex-preview-auto-mode)
