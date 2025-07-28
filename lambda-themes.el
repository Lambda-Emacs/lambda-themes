;;; lambda-themes.el --- A custom theme  -*- lexical-binding: t; -*-
;; Copyright (C) 2020 Colin McLear
;; -------------------------------------------------------------------
;; Authors: Colin McLear
;; -------------------------------------------------------------------
;; URL: https://github.com/mclear-tools/lambda-themes
;; -------------------------------------------------------------------
;; Created: 2021-03-16
;; Version: 0.1
;; Package-Requires: ((emacs "25.1"))
;; -------------------------------------------------------------------
;; This file is not part of GNU Emacs.
;;
;; This program is free software: you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation, either version 3 of the
;; License, or (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program. If not, see <http://www.gnu.org/licenses/>
;; -------------------------------------------------------------------
;;; Commentary:
;; Lamda-themes provides a set of light and dark medium contrast themes that
;; keeping colors easily distinguishable and with enough contrast, while still
;; being aesthetically pleasing.
;; -------------------------------------------------------------------

;;; Code:

;;;; Requirements
(eval-when-compile
  (require 'cl-macs))

(unless (>= emacs-major-version 25)
  (error "Requires Emacs 25 or later"))

;; Define evil cursor vars
(defvar evil-emacs-state-cursor)
(defvar evil-normal-state-cursor)
(defvar evil-visual-state-cursor)
(defvar evil-insert-state-cursor)
(defvar evil-replace-state-cursor)
(defvar evil-motion-state-cursor)
(defvar evil-operator-state-cursor)
(defvar hl-todo-keyword-faces)

;; Define mode/status-line vars
(defvar lambda-line-position)
(defvar lambda-line-status-invert nil)
(defvar bespoke-modeline-position)
(defvar bespoke-modeline-size)
(defvar nano-modeline-position)

;;;; Theme Options

(defcustom lambda-themes-set-theme 'light
  "Choose which theme variant, light or dark, regular or 'faded', to use."
  :group 'lambda-themes
  :type 'symbol)

;; Cursors
(defcustom lambda-themes-set-evil-cursors t
  "If t then use lambda evil cursor colors."
  :group 'lambda-themes
  :type 'boolean)

;; Font options
(defcustom lambda-themes-set-italic-comments t
  "If t then use italics for comments."
  :group 'lambda-themes
  :type 'boolean)

(defcustom lambda-themes-set-italic-keywords t
  "If t then use italics for keywords."
  :group 'lambda-themes
  :type 'boolean)

(defcustom lambda-themes-set-variable-pitch t
  "If t then use variable-pitch for headings and status-line."
  :group 'lambda-themes
  :type 'boolean
  :set (lambda (sym val)
         (set-default sym val)
         (when (and (boundp 'lambda-themes-active-theme)
                    lambda-themes-active-theme)
           (load-theme lambda-themes-active-theme t))))

(defcustom lambda-themes-set-vibrant nil
  "If t then use vibrant syntax coloring.variable-pitch for headings and status-line."
  :group 'lambda-themes
  :type 'boolean)

(defcustom lambda-themes-custom-colors nil
  "Specify a list of custom colors."
  :type 'alist
  :group 'lambda-themes)

;;;; Define Lambda Faces
(defgroup lambda-themes nil
  "Faces and colors for lambda-themes."
  :group 'faces)

(defface lambda-bg nil "Background face for lambda-themes." :group 'faces)
(defface lambda-fg nil "Foreground face for lambda-themes." :group 'faces)
(defface lambda-ultralight nil "Bright highlight face." :group 'faces)
(defface lambda-highlight nil  "Highlight face." :group 'faces)
(defface lambda-lowlight nil   "Dim highlight face." :group 'faces)
(defface lambda-urgent nil
  "Urgent face requires your attention.
It should stick out from any other faces currently displayed."
  :group 'faces)
(defface lambda-crucial nil    "Crucial face displays important information." :group 'faces)
(defface lambda-focus nil      "Focus face display information that is useful or pertinent." :group 'faces)
(defface lambda-strong nil     "Strong face is for a structural accent in contrast with the normal foreground face." :group 'faces)
(defface lambda-meek nil
  "Meek face is for information that is useful but less important."
  :group 'faces)
(defface lambda-mild nil
  "Mild face is for shading that is differentiable from the background but doesn't stand out."
  :group 'faces)
(defface lambda-faint nil
  "Faint face is for very slightly accenting or shading information."
  :group 'faces)
(defface lambda-blue nil       "A blue accent face." :group 'faces)
(defface lambda-green nil      "A green accent face." :group 'faces)
(defface lambda-red nil        "A red accent face." :group 'faces)
(defface lambda-yellow nil     "A yellow accent face." :group 'faces)
(defface lambda-orange nil     "An orange accent face." :group 'faces)
(defface lambda-purple nil     "A purple accent face." :group 'faces)
(defface lambda-aqua nil       "An aqua accent face." :group 'faces)

;;;; After Load Theme Hook
(defvar lambda-themes-after-load-theme-hook nil
  "Hook run after lambda-theme is loaded using `load-theme'.")

;;;; Disable Theme Function
(defun lambda-themes--disable-all-themes ()
  "Disable all active themes."
  (dolist (i custom-enabled-themes)
    (disable-theme i)))

;;;; Theme Toggle
(defcustom lambda-themes-active-theme 'light "Variable for holding light/dark value of theme appearance."
  :group 'lambda-themes
  :type 'symbol)

;;;###autoload
(defun lambda-themes-toggle-theme ()
  "Toggle between dark and light variants."
  (interactive)
  (if (eq lambda-themes-active-theme 'light)
      (progn
        (lambda-themes--disable-all-themes)
        (load-theme 'lambda-dark t)
        (setq lambda-themes-active-theme 'dark)
        (run-hooks 'lambda-themes-after-load-theme-hook))
    (progn
      (lambda-themes--disable-all-themes)
      (load-theme 'lambda-light t)
      (setq lambda-themes-active-theme 'light)
      (run-hooks 'lambda-themes-after-load-theme-hook)
      )))

;;;; Color Palettes
(defconst lambda-themes-dark-palette
  '((fg          . "#EBE9E7")
    (bg          . "#141414")
    (ultralight  . "#2c2c34")
    (highlight   . "#212228")
    (lowlight    . "#1A1919")
    (urgent      . "#CF6752")
    (crucial     . "#F4BF4F")
    (focus       . "#7A9EFF")
    (strong      . "#F5F2F0")
    (meek        . "#A3A3A3")
    (mild        . "#474648")
    (faint       . "#37373E")
    (black       . "#000000")
    (white       . "#FFFFFF")
    (red         . "#EC6A5E")
    (green       . "#62C554")
    (blue        . "#81a1c1")
    (yellow      . "#F2DA61")
    (orange      . "#d08770")
    (aqua        . "#85CCC6")
    (cyan        . "#00FFFF")
    (purple      . "#9D67E6"))
  "Color palette for lambda-dark theme.")

(defconst lambda-themes-dark-faded-palette
  '((fg          . "#eceff1")
    (bg          . "#282b35")
    (ultralight  . "#525868")
    (highlight   . "#444B5c")
    (lowlight    . "#3c4353")
    (urgent      . "#f46715")
    (crucial     . "#88c0d0")
    (focus       . "#bc85ff")
    (strong      . "#ffffff")
    (meek        . "#959eb1")
    (mild        . "#8791A7")
    (faint       . "#333a47")
    (black       . "#000000")
    (white       . "#FFFFFF")
    (red         . "#bf616a")
    (green       . "#8eb89d")
    (blue        . "#81a1c1")
    (yellow      . "#e9b85d")
    (orange      . "#d08770")
    (aqua        . "#85CCC6")
    (cyan        . "#66CCCC")
    (purple      . "#9D67E6"))
  "Color palette for lambda-dark-faded theme.")

(defconst lambda-themes-light-palette
  '((fg          . "#0C0D0D")
    (bg          . "#FFFEFD")
    (ultralight  . "#EBE9E7")
    (highlight   . "#F5F2F0")
    (lowlight    . "#F8F6F4")
    (urgent      . "#B30000")
    (crucial     . "#5D00DA")
    (focus       . "#0044CC")
    (strong      . "#000000")
    (meek        . "#706F6F")
    (mild        . "#C1C1C1")
    (faint       . "#E3E1E0")
    (black       . "#000000")
    (white       . "#FFFFFF")
    (red         . "#EC6A5E")
    (green       . "#005A02")
    (blue        . "#4C4CFF")
    (yellow      . "#e0a500")
    (orange      . "#ED8811")
    (aqua        . "#278C87")
    (cyan        . "#007F7F")
    (purple      . "#833AE6"))
  "Color palette for lambda-light theme.")

(defconst lambda-themes-light-faded-palette
  '((fg          . "#282b35")
    (bg          . "#fcfaf6")
    (ultralight  . "#cfd6e2")
    (highlight   . "#dbe1eb")
    (lowlight    . "#e3e7ef")
    (urgent      . "#f53137")
    (crucial     . "#303db4")
    (focus       . "#940B96")
    (strong      . "#000000")
    (meek        . "#727d97")
    (mild        . "#C8CDD8")
    (faint       . "#eceff1")
    (black       . "#000000")
    (white       . "#FFFFFF")
    (red         . "#960d36")
    (green       . "#00796b")
    (blue        . "#30608c")
    (yellow      . "#e0a500")
    (orange      . "#966e53")
    (aqua        . "#278C87")
    (cyan        . "#66CCCC")
    (purple      . "#833AE6"))
  "Color palette for lambda-light-faded theme.")

;;;; Theme Colors
(defun lambda-themes-create (variant theme-name)
  "Define colors with VARIANT and THEME-NAME."
  (let ((class '((class color) (min-colors 89))) ;;     ~~Dark~~                                                            ~~Light~~
        ;; basic
        (lambda-fg          (cond ((eq variant 'dark)  "#EBE9E7") ((eq variant 'dark-faded) "#eceff1") ((eq variant 'light) "#0C0D0D") ((eq variant 'light-faded) "#282b35")))
        (lambda-bg          (cond ((eq variant 'dark)  "#141414") ((eq variant 'dark-faded) "#282b35") ((eq variant 'light) "#FFFEFD") ((eq variant 'light-faded) "#fcfaf6")))
        ;; highlighting
        (lambda-ultralight  (cond ((eq variant 'dark)  "#2c2c34") ((eq variant 'dark-faded) "#525868") ((eq variant 'light) "#EBE9E7") ((eq variant 'light-faded) "#cfd6e2")))
        (lambda-highlight   (cond ((eq variant 'dark)  "#212228") ((eq variant 'dark-faded) "#444B5c") ((eq variant 'light) "#F5F2F0") ((eq variant 'light-faded) "#dbe1eb")))
        (lambda-lowlight    (cond ((eq variant 'dark)  "#1A1919") ((eq variant 'dark-faded) "#3c4353") ((eq variant 'light) "#F8F6F4") ((eq variant 'light-faded) "#e3e7ef")))
        ;; attention
        (lambda-urgent      (cond ((eq variant 'dark)  "#CF6752") ((eq variant 'dark-faded) "#f46715") ((eq variant 'light) "#B30000") ((eq variant 'light-faded) "#f53137")))
        (lambda-crucial     (cond ((eq variant 'dark)  "#F4BF4F") ((eq variant 'dark-faded) "#88c0d0") ((eq variant 'light) "#5D00DA") ((eq variant 'light-faded) "#303db4")))
        (lambda-focus       (cond ((eq variant 'dark)  "#7A9EFF") ((eq variant 'dark-faded) "#bc85ff") ((eq variant 'light) "#0044CC") ((eq variant 'light-faded) "#940B96")))

        (lambda-strong      (cond ((eq variant 'dark)  "#F5F2F0") ((eq variant 'dark-faded) "#ffffff") ((eq variant 'light) "#000000") ((eq variant 'light-faded) "#000000")))
        (lambda-meek        (cond ((eq variant 'dark)  "#A3A3A3") ((eq variant 'dark-faded) "#959eb1") ((eq variant 'light) "#706F6F") ((eq variant 'light-faded) "#727d97")))
        (lambda-mild        (cond ((eq variant 'dark)  "#474648") ((eq variant 'dark-faded) "#8791A7") ((eq variant 'light) "#C1C1C1") ((eq variant 'light-faded) "#C8CDD8")))
        (lambda-faint       (cond ((eq variant 'dark)  "#37373E") ((eq variant 'dark-faded) "#333a47") ((eq variant 'light) "#E3E1E0") ((eq variant 'light-faded) "#eceff1")))
        ;; accent
        (lambda-white       (cond ((eq variant 'dark)  "#FFFFFF") ((eq variant 'dark-faded) "#FFFFFF") ((eq variant 'light) "#FFFFFF") ((eq variant 'light-faded) "#FFFFFF")))
        (lambda-red         (cond ((eq variant 'dark)  "#EC6A5E") ((eq variant 'dark-faded) "#bf616a") ((eq variant 'light) "#EC6A5E") ((eq variant 'light-faded) "#960d36")))
        (lambda-green       (cond ((eq variant 'dark)  "#62C554") ((eq variant 'dark-faded) "#8eb89d") ((eq variant 'light) "#005A02") ((eq variant 'light-faded) "#00796b")))
        (lambda-blue        (cond ((eq variant 'dark)  "#81a1c1") ((eq variant 'dark-faded) "#81a1c1") ((eq variant 'light) "#4C4CFF") ((eq variant 'light-faded) "#30608c")))
        (lambda-yellow      (cond ((eq variant 'dark)  "#F2DA61") ((eq variant 'dark-faded) "#e9b85d") ((eq variant 'light) "#e0a500") ((eq variant 'light-faded) "#e0a500")))
        (lambda-orange      (cond ((eq variant 'dark)  "#d08770") ((eq variant 'dark-faded) "#d08770") ((eq variant 'light) "#ED8811") ((eq variant 'light-faded) "#966e53")))
        (lambda-aqua        (cond ((eq variant 'dark)  "#85CCC6") ((eq variant 'dark-faded) "#85CCC6") ((eq variant 'light) "#278C87") ((eq variant 'light-faded) "#278C87")))
        (lambda-cyan        (cond ((eq variant 'dark)  "#00FFFF") ((eq variant 'dark-faded) "#66CCCC") ((eq variant 'light) "#007F7F") ((eq variant 'light-faded) "#66CCCC")))
        (lambda-purple      (cond ((eq variant 'dark)  "#9D67E6") ((eq variant 'dark-faded) "#9D67E6") ((eq variant 'light) "#833AE6") ((eq variant 'light-faded) "#833AE6")))
        ;; Terminal colors - properly adapted for light/dark themes
        (lambda-term-black  (cond ((eq variant 'dark)  "#000000") ((eq variant 'dark-faded) "#1a1a1a") ((eq variant 'light) "#718096") ((eq variant 'light-faded) "#4a5568")))
        (lambda-term-white  (cond ((eq variant 'dark)  "#d4d4d4") ((eq variant 'dark-faded) "#c0c0c0") ((eq variant 'light) "#f0f0f0") ((eq variant 'light-faded) "#6a737d")))
        (lambda-term-bright-white (cond ((eq variant 'dark)  "#ffffff") ((eq variant 'dark-faded) "#e0e0e0") ((eq variant 'light) "#000000") ((eq variant 'light-faded) "#000000")))
        (lambda-term-fg     (cond ((eq variant 'dark)  "#d4d4d4") ((eq variant 'dark-faded) "#c0c0c0") ((eq variant 'light) "#24292e") ((eq variant 'light-faded) "#282b35"))))

    (cl-loop for (cvar . val) in lambda-themes-custom-colors
             do (set cvar val))

;;;; Define Theme
    (custom-theme-set-faces
     theme-name
;;;;; Default
     `(default              ((,class (:background ,lambda-bg :foreground ,lambda-fg))))
     `(cursor               ((,class (:background ,lambda-fg))))
     `(fringe               ((,class (:background ,lambda-bg :weight light))))
     `(hl-line              ((,class (:background ,lambda-highlight))))
     `(region               ((,class (:background ,lambda-mild))))
     `(secondary-selection  ((,class (:background ,lambda-ultralight))))
     `(buffer-menu-buffer   ((,class (:foreground ,lambda-strong))))
     `(minibuffer-prompt    ((,class (:background ,lambda-bg :foreground ,lambda-crucial))))
     `(vertical-border      ((,class (:foreground ,lambda-bg))))
     `(internal-border      ((,class (:background ,lambda-bg :foreground ,lambda-bg))))
     `(show-paren-match     ((,class (:background ,lambda-ultralight :foreground ,lambda-crucial :weight bold))))
     `(show-paren-mismatch  ((,class (:background ,lambda-ultralight :foreground ,lambda-urgent :weight bold :box t))))
     `(link                 ((,class (:background ,lambda-lowlight :foreground ,lambda-strong :underline t))))
     `(shadow               ((,class (:foreground ,lambda-meek :weight light))))

     ;; NOTE: We want the lambda-themes- colors to be available as faces. It seems like there
     ;; should be a better way to do this but...
     `(lambda-fg          ((,class (:foreground ,lambda-fg))))
     `(lambda-bg          ((,class (:background ,lambda-bg))))
     `(lambda-ultralight  ((,class (:background ,lambda-ultralight))))
     `(lambda-highlight   ((,class (:foreground ,lambda-highlight))))
     `(lambda-lowlight    ((,class (:background ,lambda-lowlight))))
     `(lambda-urgent      ((,class (:foreground ,lambda-urgent))))
     `(lambda-focus       ((,class (:foreground ,lambda-focus))))
     `(lambda-strong      ((,class (:foreground ,lambda-strong :weight semi-bold))))
     `(lambda-crucial     ((,class (:foreground ,lambda-crucial))))
     `(lambda-mild        ((,class (:foreground ,lambda-mild))))
     `(lambda-faint       ((,class (:foreground ,lambda-faint))))
     `(lambda-blue        ((,class (:foreground ,lambda-blue))))
     `(lambda-green       ((,class (:foreground ,lambda-green))))
     `(lambda-red         ((,class (:foreground ,lambda-red))))
     `(lambda-orange      ((,class (:foreground ,lambda-orange))))
     `(lambda-yellow      ((,class (:foreground ,lambda-yellow))))
     `(lambda-aqua        ((,class (:foreground ,lambda-aqua))))
     `(lambda-cyan        ((,class (:foreground ,lambda-cyan))))
     `(lambda-purple      ((,class (:foreground ,lambda-purple))))
     `(lambda-meek        ((,class (:foreground ,lambda-meek))))

;;;;; Basic faces
     `(error                ((,class (:foreground ,lambda-red :bold t))))
     `(success              ((,class (:foreground ,lambda-green :bold t))))
     `(warning              ((,class (:foreground ,lambda-yellow :bold t))))
     `(alert-low-face       ((,class (:foreground ,lambda-orange))))
     `(trailing-whitespace  ((,class (:background ,lambda-mild))))
     `(escape-glyph         ((,class (:foreground ,lambda-aqua))))
     `(highlight            ((,class (:background ,lambda-highlight))))
     `(homoglyph            ((,class (:foreground ,lambda-focus))))
     `(match                ((,class (:background ,lambda-lowlight :background ,lambda-focus))))

;;;;; Built-in syntax (Font-Lock)
     `(font-lock-builtin-face        ((,class ,(if lambda-themes-set-vibrant `(:foreground ,lambda-purple :weight normal) `(:foreground ,lambda-fg :weight light)))))
     `(font-lock-constant-face       ((,class ,(if lambda-themes-set-vibrant `(:foreground ,lambda-aqua :weight normal) `(:foreground ,lambda-fg :weight light)))))
     `(font-lock-comment-face        ((,class (:foreground ,(if lambda-themes-set-vibrant lambda-green lambda-meek) :slant ,(if lambda-themes-set-italic-comments 'italic 'normal)
                                               :weight ,(if lambda-themes-set-vibrant 'light 'normal)))))
     `(font-lock-function-name-face  ((,class ,(if lambda-themes-set-vibrant `(:foreground ,lambda-crucial :weight bold) `(:foreground ,lambda-strong :weight bold)))))
     `(font-lock-keyword-face        ((,class ,(if lambda-themes-set-vibrant `(:foreground ,lambda-focus :weight light :slant ,(if lambda-themes-set-italic-keywords 'italic 'normal))
                                                 `(:foreground ,lambda-fg :weight light :slant ,(if lambda-themes-set-italic-keywords 'italic 'normal))))))
     `(font-lock-string-face         ((,class ,(if lambda-themes-set-vibrant `(:foreground ,lambda-strong :background ,lambda-ultralight :weight light)
                                                 `(:foreground ,lambda-fg :background ,lambda-faint)))))
     `(font-lock-variable-name-face  ((,class ,(if lambda-themes-set-vibrant `(:foreground ,lambda-cyan :weight normal) `(:foreground ,lambda-strong :weight light)))))
     `(font-lock-type-face           ((,class ,(if lambda-themes-set-vibrant `(:foreground ,lambda-purple :weight normal) `(:foreground ,lambda-fg :weight light)))))
     `(font-lock-warning-face        ((,class (:foreground ,lambda-urgent :weight bold))))
     `(font-lock-preprocessor-face   ((,class ,(if lambda-themes-set-vibrant `(:foreground ,lambda-aqua :weight normal) `(:foreground ,lambda-fg :weight medium)))))

;;;;; Childframes
;;;;;; Mini-Frame
     `(mini-popup-background ((,class (:background ,lambda-faint))))
     `(mini-popup-border     ((,class (:background ,lambda-faint))))

     ;;;;;; Mini-Popup (Childframe)
     `(mini-popup-background ((,class (:background ,lambda-faint))))
     `(mini-popup-border     ((,class (:background ,lambda-faint))))

;;;;;; Posframe
     `(which-key-posframe                           ((,class (:background ,lambda-faint))))
     `(which-key-posframe-border                    ((,class (:background ,lambda-faint))))
     `(transient-posframe-border                    ((,class (:background ,lambda-faint))))
     `(transient-posframe                           ((,class (:foreground ,lambda-strong :background ,lambda-faint))))

;;;;; Completion/Narrowing

;;;;;; General Completion
     `(completions-annotations                     ((,class (:foreground ,lambda-meek))))

;;;;;; Company-mode
     `(company-scrollbar-bg                        ((,class (:background ,lambda-faint))))
     `(company-scrollbar-fg                        ((,class (:background ,lambda-mild))))
     `(company-tooltip                             ((,class (:foreground ,(if (eq variant 'dark-faded) lambda-fg lambda-meek) :background ,(if (eq variant 'dark-faded) lambda-lowlight lambda-mild)))))
     `(company-tooltip-annotation                  ((,class (:foreground ,lambda-green))))
     `(company-tooltip-annotation-selection        ((,class (:inherit    company-tooltip-annotation))))
     `(company-tooltip-selection                   ((,class (:foreground ,lambda-purple :background ,lambda-faint))))
     `(company-tooltip-common                      ((,class (:foreground ,lambda-blue :underline t))))
     `(company-tooltip-common-selection            ((,class (:foreground ,lambda-blue :underline t))))
     `(company-preview-common                      ((,class (:foreground ,lambda-highlight))))
     `(company-preview                             ((,class (:background ,lambda-blue))))
     `(company-preview-search                      ((,class (:background ,lambda-aqua))))
     `(company-template-field                      ((,class (:foreground ,lambda-bg :background ,lambda-yellow))))
     `(company-echo-common                         ((,class (:foreground ,lambda-red))))

;;;;;; Consult
     `(consult-separator                           ((,class (:foreground ,lambda-meek))))
     `(consult-file                                ((,class (:foreground ,lambda-fg))))
     `(consult-preview-line                        ((,class (:foreground ,lambda-crucial :background ,lambda-lowlight))))
     `(consult-line-number                         ((,class (:foreground ,lambda-meek))))
     `(consult-line-number-prefix                  ((,class (:foreground ,lambda-meek))))
     `(consult-help                                ((,class (:foreground ,lambda-meek))))
     `(consult-completing-read-multiple            ((,class (:foreground ,lambda-meek))))
     `(consult-grep-context                        ((,class (:foreground ,lambda-mild))))

;;;;;; Consult Notes
     `(consult-notes-sep       ((,class (:foreground ,lambda-meek))))
     `(consult-notes-name      ((,class (:foreground ,lambda-meek :weight light :slant italic))))
     `(consult-notes-backlinks ((,class (:foreground ,lambda-meek :weight light :slant italic))))
     `(consult-notes-time      ((,class (:foreground ,lambda-meek :weight light :slant italic))))
     `(consult-notes-size      ((,class (:foreground ,lambda-meek :weight light :slant italic))))
     `(consult-notes-dir       ((,class (:foreground ,lambda-meek :weight light :slant italic))))

;;;;;; Corfu
     `(corfu-annotations                           ((,class (:foreground ,lambda-meek))))
     `(corfu-bar                                   ((,class (:foreground ,lambda-ultralight))))
     `(corfu-border                                ((,class (:foreground ,lambda-faint))))
     `(corfu-current                               ((,class (:foreground ,lambda-crucial :background ,lambda-highlight))))
     `(corfu-default                               ((,class (:inherit default :background ,lambda-faint))))
     `(corfu-deprecated                            ((,class (:foreground ,lambda-mild))))
     `(corfu-echo                                  ((,class (:inherit default))))

;;;;;; Helm
     `(helm-selection                                ((,class (:foreground ,lambda-meek :weight bold))))
     `(helm-match                                    ((,class (:foreground ,lambda-strong))))
     `(helm-source-header                            ((,class (:foreground ,lambda-focus))))
     `(helm-visible-mark                             ((,class (:foreground ,lambda-strong))))
     `(helm-swoop-target-line-face                   ((,class (:foreground ,lambda-meek :weight bold))))
     `(helm-moccur-buffer                            ((,class (:foreground ,lambda-strong))))
     `(helm-ff-file                                  ((,class (:foreground ,lambda-meek))))
     `(helm-ff-prefix                                ((,class (:foreground ,lambda-strong))))
     `(helm-ff-dotted-directory                      ((,class (:foreground ,lambda-meek))))
     `(helm-ff-directory                             ((,class (:foreground ,lambda-strong))))
     `(helm-ff-executable                            ((,class (:foreground ,lambda-crucial))))
     `(helm-grep-match                               ((,class (:foreground ,lambda-strong))))
     `(helm-grep-file                                ((,class (:foreground ,lambda-meek))))
     `(helm-grep-lineno                              ((,class (:foreground ,lambda-meek))))
     `(helm-grep-finish                              ((,class (:foreground ,lambda-fg))))

;;;;;; Icomplete
     `(icomplete-first-match    ((,class (:inherit success))))
     `(icomplete-selected-match ((,class (:background ,lambda-highlight))))

;;;;;; Icomplete-vertical
     `(icomplete-vertical-separator ((,class (:inherit shadow))))

;;;;;; Ido
     `(ido-only-match                              ((,class (:inherit success))))
     `(ido-first-match                             ((,class (:foreground ,lambda-ultralight :weight bold :underline t))))
     `(ido-subdir                                  ((,class (:inherit dired-directory))))

;;;;;; Ivy
     `(ivy-current-match                           ((,class (:background ,lambda-highlight :foreground ,lambda-fg :weight bold :underline t))))
     `(ivy-minibuffer-match-face-1                 ((,class (:foreground ,lambda-orange))))
     `(ivy-minibuffer-match-face-2                 ((,class (:foreground ,lambda-yellow))))
     `(ivy-minibuffer-match-face-3                 ((,class (:foreground ,lambda-orange))))
     `(ivy-minibuffer-match-face-4                 ((,class (:foreground ,lambda-yellow))))

;;;;;; Orderless
     `(orderless-match-face-0                      ((,class (:background ,lambda-crucial :foreground ,lambda-bg :weight bold))))
     `(orderless-match-face-1                      ((,class (:background ,lambda-aqua :foreground ,lambda-bg :weight bold))))
     `(orderless-match-face-2                      ((,class (:background ,lambda-orange :foreground ,lambda-bg :weight bold))))
     `(orderless-match-face-3                      ((,class (:background ,lambda-green :foreground ,lambda-bg :weight bold))))

;;;;;; Selectrum
     `(selectrum-current-candidate                   ((,class (:weight bold :background ,lambda-highlight))))
     `(selectrum-prescient-secondary-highlight       ((,class (:weight bold :foreground ,lambda-blue))))
     `(selectrum-prescient-primary-highlight         ((,class (:weight bold :foreground ,lambda-focus))))
     `(selectrum-completion-docsig                   ((,class (:slant italic :inherit selectrum-completion-annotation))))
     `(selectrum-completion-annotation               ((,class (:inherit completions-annotations))))
     `(selectrum-group-separator                     ((,class (:strike-through t :inherit shadow))))
     `(selectrum-group-title                         ((,class (:slant italic :inherit shadow))))
     `(selectrum-quick-keys-match                    ((,class (:inherit isearch))))
     `(selectrum-quick-keys-highlight                ((,class (:foreground ,lambda-crucial))))

;;;;;; Vertico
     `(vertico-current                             ((,class (:weight bold :background ,lambda-highlight))))
     `(vertico-group-separator                     ((,class (:foreground ,lambda-ultralight :strike-through t))))
     `(vertico-multiline                           ((,class (:foreground ,lambda-meek))))
     `(vertico-group-title                         ((,class (:foreground ,lambda-meek))))

;;;;; Diffs & VC

;;;;;; Diff
     `(diff-header                               ((,class (:foreground ,lambda-fg))))
     `(diff-file-header                          ((,class (:foreground ,lambda-fg))))
     `(diff-hunk-header                          ((,class (:foreground ,lambda-fg))))
     `(diff-context                              ((,class (:background ,lambda-lowlight))))

     `(diff-changed                              ((,class (:background unspecified :foreground ,lambda-blue))))
     `(diff-refine-changed                       ((,class (:foreground ,lambda-blue))))
     `(diff-added                                ((,class (:background unspecified :foreground ,lambda-green))))
     `(diff-refine-added                         ((,class (:background unspecified :foreground ,lambda-green))))
     `(diff-removed                              ((,class (:background unspecified :foreground ,lambda-red))))
     `(diff-refine-removed                       ((,class (:background unspecified :foreground ,lambda-meek :strike-through t))))

     `(diff-indicator-changed                    ((,class (:inherit diff-changed))))
     `(diff-indicator-added                      ((,class (:inherit diff-added))))
     `(diff-indicator-removed                    ((,class (:inherit diff-removed))))

;;;;;; Diff-hl
     `(diff-hl-change ((,class (:inherit default :foreground ,lambda-blue ))))
     `(diff-hl-delete ((,class (:inherit default :foreground ,lambda-red  ))))
     `(diff-hl-insert ((,class (:inherit default :foreground ,lambda-green))))

;;;;;; Ediff
     `(ediff-even-diff-A                         ((,class (:background ,lambda-mild))))
     `(ediff-even-diff-B                         ((,class (:background ,lambda-mild))))
     `(ediff-even-diff-C                         ((,class (:background ,lambda-mild))))
     `(ediff-even-diff-Ancestor                  ((,class (:background ,lambda-mild))))
     `(ediff-odd-diff-A                          ((,class (:background ,lambda-faint))))
     `(ediff-odd-diff-B                          ((,class (:background ,lambda-faint))))
     `(ediff-odd-diff-C                          ((,class (:background ,lambda-faint))))
     `(ediff-odd-diff-Ancestor                   ((,class (:background ,lambda-faint))))

     ;; TODO: Fix fine diffs
     ;; (ediff-fine-diff-A                         (:background ,lambda-ediff-fine-diff-A))
     ;; (ediff-fine-diff-Ancestor                  (:background ,lambda-ediff-fine-diff-Ancestor))
     ;; (ediff-fine-diff-B                         (:background ,lambda-ediff-fine-diff-B))
     ;; (ediff-fine-diff-C                         (:background ,lambda-ediff-fine-diff-C))
     ;; (ediff-current-diff-A                      (:background ,lambda-ediff-current-diff-A))
     ;; (ediff-current-diff-Ancestor               (:background ,lambda-ediff-current-diff-Ancestor))
     ;; (ediff-current-diff-B                      (:background ,lambda-ediff-current-diff-B))
     ;; (ediff-current-diff-C                      (:background ,lambda-ediff-current-diff-C))

     `(js2-warning                               ((,class (:underline (:color ,lambda-yellow :style wave)))))
     `(js2-error                                 ((,class (:underline (:color ,lambda-red :style wave)))))
     `(js2-external-variable                     ((,class (:underline (:color ,lambda-aqua :style wave)))))
     `(js2-jsdoc-tag                             ((,class (:background ,lambda-lowlight))))
     `(js2-jsdoc-type                            ((,class (:background ,lambda-highlight))))
     `(js2-jsdoc-value                           ((,class (:background ,lambda-lowlight))))
     `(js2-function-param                        ((,class (:background unspecified :foreground ,lambda-aqua))))
     `(js2-function-call                         ((,class (:background unspecified :foreground ,lambda-blue))))
     `(js2-instance-member                       ((,class (:background unspecified :foreground ,lambda-orange))))
     `(js2-private-member                        ((,class (:background unspecified :foreground ,lambda-yellow))))
     `(js2-private-function-call                 ((,class (:background unspecified :foreground ,lambda-aqua))))
     `(js2-jsdoc-html-tag-name                   ((,class (:background unspecified :foreground ,lambda-highlight))))
     `(js2-jsdoc-html-tag-delimiter              ((,class (:background ,lambda-lowlight))))

;;;;;; Eglot
     `(eglot-highlight-symbol-face          ((,class (:background ,lambda-lowlight :foreground ,lambda-blue))))
     `(eglot-diagnostic-tag-deprecated      ((,class (:strike-through t :background ,lambda-lowlight))))
     `(eglot-diagnostic-tag-unnecessary     ((,class (:underline (:color ,lambda-lowlight :style wave)))))
     `(eglot-inlay-hint-face                ((,class (:inherit shadow :background ,lambda-lowlight))))
     `(eglot-inlay-hint-type-face           ((,class (:foreground ,lambda-yellow :slant italic))))
     `(eglot-inlay-hint-parameter-face      ((,class (:foreground ,lambda-aqua :weight bold))))


;;;;;; Git-gutter
     `(git-gutter:unchanged ((,class (:foreground ,lambda-bg))))
     `(git-gutter:modified  ((,class (:foreground ,lambda-blue))))
     `(git-gutter:added     ((,class (:foreground ,lambda-green))))
     `(git-gutter:deleted   ((,class (:foreground ,lambda-red))))

;;;;;; Git-gutter+
     `(git-gutter+-unchanged ((,class (:foreground ,lambda-bg))))
     `(git-gutter+-modified  ((,class (:foreground ,lambda-blue))))
     `(git-gutter+-added     ((,class (:foreground ,lambda-green))))
     `(git-gutter+-deleted   ((,class (:foreground ,lambda-red))))

;;;;;; Git-gutter-fringe
     `(git-gutter-fr:unchanged ((,class (:inherit git-gutter:unchanged))))
     `(git-gutter-fr:modified  ((,class (:inherit git-gutter:modified))))
     `(git-gutter-fr:added     ((,class (:inherit git-gutter:added))))
     `(git-gutter-fr:deleted   ((,class (:inherit git-gutter:deleted))))

;;;;;; Change-Log and Log-View (`vc-print-log' and `vc-print-root-log')
     `(change-log-acknowledgment ((,class :inherit shadow)))
     `(change-log-conditionals ((,class :foreground ,lambda-yellow)))
     `(change-log-date ((,class :foreground ,lambda-fg :background ,lambda-ultralight)))
     `(change-log-email ((,class :foreground ,lambda-mild)))
     `(change-log-file ((,class :inherit bold :foreground ,lambda-blue)))
     `(change-log-function ((,class :inherit font-lock-function)))
     `(change-log-list ((,class :foreground ,lambda-orange)))
     `(change-log-name ((,class :foreground ,lambda-purple)))
     `(log-edit-header            ((,class :foreground ,lambda-strong)))
     `(log-edit-headers-separator ((,class :height 1 :background ,lambda-lowlight :extend t)))
     `(log-edit-summary           ((,class :inherit bold :foreground ,lambda-blue)))
     `(log-edit-unknown-header    ((,class :inherit shadow)))
     `(log-view-commit-body       ((,class :foreground ,lambda-blue)))
     `(log-view-file              ((,class :inherit bold :foreground ,lambda-aqua)))
     `(log-view-message           ((,class :foreground ,lambda-meek :background ,lambda-highlight)))

;;;;;; Magit
     `(magit-header-line            ((,class (:foreground ,lambda-fg :background ,lambda-highlight))))
     `(magit-header-line-log-select ((,class (:foreground ,lambda-fg :background ,lambda-highlight))))
     `(magit-section-heading        ((,class (:foreground ,lambda-meek :inherit ,(if lambda-themes-set-variable-pitch 'variable-pitch 'default) :height 1.4))))
     `(magit-dimmed                 ((,class (:foreground ,lambda-meek))))
     `(magit-blame-dimmed           ((,class (:foreground ,lambda-meek))))

     ;; (magit-bisect-bad                          (:foreground ,lambda-red))
     ;; (magit-bisect-good                         (:foreground ,lambda-green))
     ;; (magit-bisect-skip                         (:foreground ,lambda-yellow))
     ;; (magit-blame-heading                       (:foreground ,lambda-ultralight :background ,lambda-faint))
     ;; (magit-branch-local                        (:foreground ,lambda-blue))
     ;; (magit-branch-current                      (:underline ,lambda-blue :inherit 'magit-branch-local))
     ;; (magit-branch-remote                       (:foreground ,lambda-green))
     ;; (magit-cherry-equivalent                   (:foreground ,lambda-purple))
     ;; (magit-cherry-unmatched                    (:foreground ,lambda-aqua))
     ;; (magit-diff-added                          (:foreground ,lambda-green))
     ;; (magit-diff-added-highlight                (:foreground ,lambda-green :inherit 'magit-diff-context-highlight))
     ;; (magit-diff-base                           (:background ,lambda-yellow :foreground ,lambda-ultralight))
     ;; (magit-diff-base-highlight                 (:background ,lambda-yellow :foreground ,lambda-ultralight))
     ;; (magit-diff-context                        (:foreground ,lambda-fg))
     ;; (magit-diff-context-highlight              (:background ,lambda-faint  :foreground ,lambda-strong))
     ;; (magit-diff-hunk-heading                   (:background ,lambda-ultralight  :foreground ,lambda-strong))
     ;; (magit-diff-hunk-heading-highlight         (:background ,lambda-ultralight  :foreground ,lambda-strong))
     ;; (magit-diff-hunk-heading-selection         (:background ,lambda-faint  :foreground ,lambda-orange))
     ;; (magit-diff-lines-heading                  (:background ,lambda-orange :foreground ,lambda-strong))
     ;; (magit-diff-removed                        (:foreground ,lambda-red :weight 'light))
     ;; (magit-diff-removed-highlight              (:foreground ,lambda-red :inherit 'magit-diff-context-highlight :weight 'light))
     ;; (magit-diffstat-added                      (:foreground ,lambda-green))
     ;; (magit-diffstat-removed                    (:foreground ,lambda-red))

     ;; (magit-filename                           (:foreground ,lambda-strong :weight 'bold))
     ;; (magit-hash                                (:foreground ,lambda-blue))
     ;; (magit-diff-file-heading                   (:foreground ,lambda-strong :weight 'bold))
     ;; (magit-log-author                          (:foreground ,lambda-red))
     ;; (magit-log-date                            (:foreground ,lambda-aqua))
     ;; (magit-log-graph                           (:foreground ,lambda-mild))
     ;; (magit-process-ng                          (:foreground ,lambda-red :weight 'bold))
     ;; (magit-process-ok                          (:foreground ,lambda-green :weight 'bold))
     ;; (magit-reflog-amend                        (:foreground ,lambda-purple))
     ;; (magit-reflog-checkout                     (:foreground ,lambda-blue))
     ;; (magit-reflog-cherry-pick                  (:foreground ,lambda-green))
     ;; (magit-reflog-commit                       (:foreground ,lambda-green))
     ;; (magit-reflog-merge                        (:foreground ,lambda-green))
     ;; (magit-reflog-other                        (:foreground ,lambda-aqua))
     ;; (magit-reflog-rebase                       (:foreground ,lambda-purple))
     ;; (magit-reflog-remote                       (:foreground ,lambda-blue))
     ;; (magit-reflog-reset                        (:foreground ,lambda-red))
     ;; (magit-refname                             (:foreground ,lambda-fg))

     ;; (magit-section-heading-selection           (:foreground ,lambda-focus))
     ;; (magit-section-highlight                   (:background ,lambda-faint))
     ;; (magit-sequence-drop                       (:foreground ,lambda-focus))
     ;; (magit-sequence-head                       (:foreground ,lambda-aqua))
     ;; (magit-sequence-part                       (:foreground ,lambda-focus))
     ;; (magit-sequence-stop                       (:foreground ,lambda-green))
     ;; (magit-signature-bad                       (:foreground ,lambda-red :weight 'bold))
     ;; (magit-signature-error                     (:foreground ,lambda-red))
     ;; (magit-signature-expired                   (:foreground ,lambda-orange))
     ;; (magit-signature-good                      (:foreground ,lambda-green))
     ;; (magit-signature-revoked                   (:foreground ,lambda-purple))
     ;; (magit-signature-untrusted                 (:foreground ,lambda-blue))
     ;; (magit-tag                                 (:foreground ,lambda-yellow))


;;;;; Directories
;;;;;; All The Icons Dired
     `(all-the-icons-dired-dir-face   ((,class (:foreground ,lambda-focus))))

;;;;;;  Dired
     `(dired-directory                ((,class (:foreground ,lambda-fg))))
     `(dired-symlink                  ((,class (:slant italic))))
     `(dired-mark                     ((,class (:foreground ,lambda-strong))))
     `(dired-marked                   ((,class (:foreground ,lambda-urgent))))

;;;;;; dired+
     `(diredp-file-name                          ((,class (:foreground ,lambda-strong))))
     `(diredp-file-suffix                        ((,class (:foreground ,lambda-ultralight))))
     `(diredp-compressed-file-suffix             ((,class (:foreground ,lambda-blue))))
     `(diredp-dir-name                           ((,class (:foreground ,lambda-blue))))
     `(diredp-dir-heading                        ((,class (:foreground ,lambda-blue))))
     `(diredp-symlink                            ((,class (:foreground ,lambda-orange))))
     `(diredp-date-time                          ((,class (:foreground ,lambda-ultralight))))
     `(diredp-number                             ((,class (:foreground ,lambda-blue))))
     `(diredp-no-priv                            ((,class (:foreground ,lambda-faint))))
     `(diredp-other-priv                         ((,class (:foreground ,lambda-faint))))
     `(diredp-rare-priv                          ((,class (:foreground ,lambda-faint))))
     `(diredp-ignored-file-name                  ((,class (:foreground ,lambda-faint))))

     `(diredp-dir-priv                           ((,class (:foreground ,lambda-blue  :background ,lambda-blue))))
     `(diredp-exec-priv                          ((,class (:foreground ,lambda-blue  :background ,lambda-blue))))
     `(diredp-link-priv                          ((,class (:foreground ,lambda-aqua  :background ,lambda-aqua))))
     `(diredp-read-priv                          ((,class (:foreground ,lambda-red  :background ,lambda-red))))
     `(diredp-write-priv                         ((,class (:foreground ,lambda-aqua :background ,lambda-aqua))))

;;;;;; Dired Colors (Diredfl)
     `(diredfl-write-priv                            ((,class (:foreground ,lambda-urgent))))
     `(diredfl-tagged-autofile-name                  ((,class (:foreground ,lambda-bg))))
     `(diredfl-symlink                               ((,class (:foreground ,lambda-urgent))))
     `(diredfl-read-priv                             ((,class (:foreground ,lambda-urgent))))
     `(diredfl-rare-priv                             ((,class (:foreground ,lambda-urgent :background ,lambda-urgent))))
     `(diredfl-other-priv                            ((,class (:background ,lambda-red))))
     `(diredfl-omit-file-name                        ((,class (:strike-through ,lambda-mild :foreground ,lambda-mild))))
     `(diredfl-number                                ((,class (:foreground ,lambda-meek))))
     `(diredfl-no-priv                               ((,class (:foreground ,lambda-urgent))))
     `(diredfl-mode-line-flagged                     ((,class (:foreground ,lambda-urgent))))
     `(diredfl-mode-line-marked                      ((,class (:foreground ,lambda-focus))))
     `(diredfl-link-priv                             ((,class (:foreground ,lambda-urgent))))
     `(diredfl-ignored-file-name                     ((,class (:foreground ,lambda-meek))))
     `(diredfl-flag-mark-line                        ((,class (:foreground ,lambda-urgent))))
     `(diredfl-flag-mark                             ((,class (:foreground ,lambda-urgent :background ,lambda-focus))))
     `(diredfl-file-suffix                           ((,class (:foreground ,lambda-meek))))
     `(diredfl-file-name                             ((,class (:foreground ,lambda-fg))))
     `(diredfl-executable-tag                        ((,class (:foreground ,lambda-urgent))))
     `(diredfl-exec-priv                             ((,class (:foreground ,lambda-urgent))))
     `(diredfl-dir-priv                              ((,class (:foreground ,lambda-mild))))
     `(diredfl-dir-name                              ((,class (:foreground ,lambda-fg))))
     `(diredfl-dir-heading                           ((,class (:inherit ,(if lambda-themes-set-variable-pitch 'variable-pitch 'default) :height 1.3 :foreground ,lambda-blue :background ,lambda-lowlight))))
     `(diredfl-deletion-file-name                    ((,class (:foreground ,lambda-urgent))))
     `(diredfl-deletion                              ((,class (:foreground ,lambda-urgent :background ,lambda-urgent))))
     `(diredfl-date-time                             ((,class (:foreground ,lambda-meek))))
     `(diredfl-compressed-file-suffix                ((,class (:foreground ,lambda-mild))))
     `(diredfl-compressed-file-name                  ((,class (:foreground ,lambda-bg))))
     `(diredfl-autofile-name                         ((,class (:background ,lambda-faint))))

;;;;;; Denote dired mode
	 `(denote-faces-time                             ((,class (:foreground ,lambda-blue))))
	 `(denote-faces-date                             ((,class (:foreground ,lambda-blue))))
	 `(denote-faces-keywords                         ((,class (:foreground ,lambda-purple))))

;;;;;; Dirvish
	 `(dirvish-hl-line                               ((,class (:background ,lambda-lowlight))))

;;;;; Editing
;;;;;; Meow
     `(meow-normal-cursor         ((,class (:background ,lambda-yellow))))
     `(meow-insert-cursor         ((,class (:background ,lambda-urgent))))
     `(meow-keypad-cursor         ((,class (:background ,lambda-orange))))
     `(meow-motion-cursor         ((,class (:background ,lambda-green))))
     `(meow-kmacro-cursor         ((,class (:background ,lambda-focus))))
     `(meow-beacon-cursor         ((,class (:background ,lambda-yellow))))
     `(meow-beacon-fake-selection ((,class (:background ,lambda-ultralight))))
     `(meow-beacon-fake-cursor    ((,class (:background ,lambda-yellow))))

;;;;;; Flycheck
     `(flycheck-warning                          ((,class (:underline (:style wave :color ,lambda-yellow)))))
     `(flycheck-error                            ((,class (:underline (:style wave :color ,lambda-red)))))
     `(flycheck-info                             ((,class (:underline (:style wave :color ,lambda-blue)))))
     `(flycheck-fringe-warning                   ((,class (:foreground ,lambda-yellow))))
     `(flycheck-fringe-error                     ((,class (:foreground ,lambda-red))))
     `(flycheck-fringe-info                      ((,class (:foreground ,lambda-blue))))
     `(flycheck-error-list-warning               ((,class (:foreground ,lambda-yellow :bold t))))
     `(flycheck-error-list-error                 ((,class (:foreground ,lambda-red :bold t))))
     `(flycheck-error-list-info                  ((,class (:foreground ,lambda-blue :bold t))))

;;;;;; Flyspell
     `(flyspell-duplicate                        ((,class (:underline (:color ,lambda-red :style line)))))
     `(flyspell-incorrect                        ((,class (:underline (:color ,lambda-red :style line)))))

;;;;;; Highlight indentation mode
     `(highlight-indentation-current-column-face ((,class (:background ,lambda-faint))))
     `(highlight-indentation-face                ((,class (:background ,lambda-mild))))

;;;;;; Hi-lock-mode
     `(hi-black-b                                ((,class (:foreground ,lambda-bg :weight bold))))
     `(hi-black-hb                               ((,class (:foreground ,lambda-bg :weight bold :height 1.5))))
     `(hi-blue                                   ((,class (:foreground ,lambda-faint :background ,lambda-blue))))
     `(hi-blue-b                                 ((,class (:foreground ,lambda-blue :weight bold))))
     `(hi-green                                  ((,class (:foreground ,lambda-faint :background ,lambda-green))))
     `(hi-green-b                                ((,class (:foreground ,lambda-green :weight bold))))
     `(hi-pink                                   ((,class (:foreground ,lambda-faint :background ,lambda-purple))))
     `(hi-red-b                                  ((,class (:foreground ,lambda-red :weight bold))))
     `(hi-yellow                                 ((,class (:foreground ,lambda-faint :background ,lambda-yellow))))

;;;;;; iEdit Mode
     `(iedit-occurrence                          ((,class (:foreground ,lambda-bg :background ,lambda-crucial))))
     `(iedit-read-only-occurrence                ((,class (:foreground ,lambda-bg :background ,lambda-crucial))))

;;;;;; Line numbers
     `(line-number                               ((,class (:foreground ,lambda-ultralight))))
     `(line-number-current-line                  ((,class (:foreground ,lambda-orange :background ,lambda-faint))))
     `(linum                                     ((,class (:foreground ,lambda-faint :background ,lambda-mild))))
     `(linum-highlight-face                      ((,class (:foreground ,lambda-orange :background ,lambda-faint))))
     `(linum-relative-current-face               ((,class (:foreground ,lambda-orange :background ,lambda-faint))))

;;;;;; Undo-tree
     `(undo-tree-visualizer-active-branch-face   ((,class (:foreground ,lambda-ultralight))))
     `(undo-tree-visualizer-current-face         ((,class (:foreground ,lambda-red))))
     `(undo-tree-visualizer-default-face         ((,class (:foreground ,lambda-faint))))
     `(undo-tree-visualizer-register-face        ((,class (:foreground ,lambda-yellow))))
     `(undo-tree-visualizer-unmodified-face      ((,class (:foreground ,lambda-aqua))))

;;;;;; Whitespace-mode

     `(whitespace-space                          ((,class (:background ,lambda-bg :foreground ,lambda-faint))))
     `(whitespace-hspace                         ((,class (:background ,lambda-bg :foreground ,lambda-faint))))
     `(whitespace-tab                            ((,class (:background ,lambda-bg :foreground ,lambda-faint))))
     `(whitespace-newline                        ((,class (:background ,lambda-bg :foreground ,lambda-faint))))
     `(whitespace-trailing                       ((,class (:background ,lambda-mild :foreground ,lambda-mild))))
     `(whitespace-line                           ((,class (:background ,lambda-mild :foreground ,lambda-mild))))
     `(whitespace-space-before-tab               ((,class (:background ,lambda-bg :foreground ,lambda-faint))))
     `(whitespace-indentation                    ((,class (:background ,lambda-bg :foreground ,lambda-faint))))
     `(whitespace-empty                          ((,class (:background unspecified :foreground unspecified))))
     `(whitespace-space-after-tab                ((,class (:background ,lambda-bg :foreground ,lambda-faint))))

;;;;; Programming

;;;;;; Rainbow Delimiters

     `(rainbow-delimiters-depth-1-face           ((,class (:foreground ,lambda-green))))
     `(rainbow-delimiters-depth-2-face           ((,class (:foreground ,lambda-purple))))
     `(rainbow-delimiters-depth-3-face           ((,class (:foreground ,lambda-red))))
     `(rainbow-delimiters-depth-4-face           ((,class (:foreground ,lambda-blue))))
     `(rainbow-delimiters-depth-5-face           ((,class (:foreground ,lambda-green))))
     `(rainbow-delimiters-depth-6-face           ((,class (:foreground ,lambda-purple))))
     `(rainbow-delimiters-depth-7-face           ((,class (:foreground ,lambda-red))))
     `(rainbow-delimiters-depth-8-face           ((,class (:foreground ,lambda-blue))))
     `(rainbow-delimiters-depth-9-face           ((,class (:foreground ,lambda-green))))
     `(rainbow-delimiters-depth-10-face          ((,class (:foreground ,lambda-purple))))
     `(rainbow-delimiters-depth-11-face          ((,class (:foreground ,lambda-red))))
     `(rainbow-delimiters-depth-12-face          ((,class (:foreground ,lambda-blue))))
     `(rainbow-delimiters-unmatched-face         ((,class (:background ,lambda-bg :foreground ,lambda-red :weight bold))))

;;;;;; Langtool
     `(langtool-errline                          ((,class (:foreground ,lambda-faint :background ,lambda-red))))
     `(langtool-correction-face                  ((,class (:foreground ,lambda-yellow :weight bold))))

;;;;;; Smartparens
     `(sp-pair-overlay-face                      ((,class (:background ,lambda-faint))))
     `(sp-show-pair-match-face                   ((,class (:background ,lambda-faint)))) ;; Pair tags highlight))
     `(sp-show-pair-mismatch-face                ((,class (:background ,lambda-red)))) ;; Highlight for bracket without pair))
     ;;(sp-wrap-overlay-face                     (:inherit 'sp-wrap-overlay-face))
     ;;(sp-wrap-tag-overlay-face                 (:inherit 'sp-wrap-overlay-face))

;;;;;; Cider
     `(cider-debug-code-overlay-face             ((,class (:background ,lambda-faint :foreground ,lambda-ultralight))))
     `(cider-deprecated-face                     ((,class (:background ,lambda-faint :foreground ,lambda-orange))))
     `(cider-enlightened-local-face              ((,class (:foreground ,lambda-orange :weight bold))))
     `(cider-error-highlight-face                ((,class (:foreground ,lambda-red :underline t :style wave))))
     `(cider-fringe-good-face                    ((,class (:foreground ,lambda-green))))
     `(cider-instrumented-face                   ((,class (:background ,lambda-mild :box (:line-width -1 :color ,lambda-red)))))
     `(cider-result-overlay-face                 ((,class (:background ,lambda-faint :box (:line-width -1 :color ,lambda-yellow)))))
     `(cider-test-error-face                     ((,class (:background ,lambda-red))))
     `(cider-test-error-face                     ((,class (:background ,lambda-orange))))
     `(cider-test-success-face                   ((,class (:background ,lambda-green))))
     `(cider-traced                              ((,class (:background ,lambda-aqua))))
     `(cider-warning-highlight-face              ((,class (:foreground ,lambda-yellow :underline t :style wave))))

;;;;;; Latex
     `(font-latex-bold-face                      ((,class (:foreground ,lambda-green :bold t))))
     `(font-latex-italic-face                    ((,class (:foreground ,lambda-green :underline t))))
     `(font-latex-math-face                      ((,class (:foreground ,lambda-strong))))
     `(font-latex-script-char-face               ((,class (:foreground ,lambda-aqua))))
     `(font-latex-sectioning-5-face              ((,class (:foreground ,lambda-yellow :bold t))))
     `(font-latex-sedate-face                    ((,class (:foreground ,lambda-strong))))
     `(font-latex-string-face                    ((,class (:foreground ,lambda-orange))))
     `(font-latex-verbatim-face                  ((,class (:foreground ,lambda-strong))))
     `(font-latex-warning-face                   ((,class (:foreground ,lambda-red :weight bold))))
     `(preview-face                              ((,class (:background ,lambda-mild))))

;;;;;; Lsp
     `(lsp-lsp-flycheck-warning-unnecessary-face ((,class (:underline (:color ,lambda-orange :style wave)))
                                                  :foreground ,lambda-urgent))
     `(lsp-ui-doc-background                     ((,class (:background ,lambda-mild))))
     `(lsp-ui-doc-header                         ((,class (:background ,lambda-blue))))
     `(lsp-ui-peek-filename                      ((,class (:foreground ,lambda-red))))
     `(lsp-ui-sideline-code-action               ((,class (:foreground ,lambda-yellow))))
     `(lsp-ui-sideline-current-symbol            ((,class (:foreground ,lambda-aqua))))
     `(lsp-ui-sideline-symbol                    ((,class (:foreground ,lambda-faint))))

;;;;;; Web-mode
     `(web-mode-doctype-face          ((,class (:foreground ,lambda-blue))))
     `(web-mode-html-tag-bracket-face ((,class (:foreground ,lambda-blue))))
     `(web-mode-html-tag-face         ((,class (:foreground ,lambda-blue))))
     `(web-mode-html-attr-name-face   ((,class (:foreground ,lambda-yellow))))
     `(web-mode-html-attr-equal-face  ((,class (:foreground ,lambda-yellow))))
     `(web-mode-html-attr-value-face  ((,class (:foreground ,lambda-green))))

;;;;; UI (Frames, Windows, Buffers)

;;;;;; Ace-jump-mode
     `(ace-jump-face-background                  ((,class (:foreground ,lambda-ultralight :background ,lambda-bg :inverse-video nil))))
     `(ace-jump-face-foreground                  ((,class (:foreground ,lambda-red :background ,lambda-bg :inverse-video nil))))

;;;;;; Ace-window
     `(aw-background-face                       ((,class (:foreground ,lambda-ultralight :background ,lambda-bg :inverse-video nil))))
     `(aw-leading-char-face                     ((,class (:foreground ,lambda-red :background ,lambda-bg :height 4.0))))

;;;;;; Buttons
     `(custom-button                                 ((,class (:foreground ,lambda-fg :background ,lambda-highlight :box nil))))
     `(custom-button-mouse                           ((,class (:foreground ,lambda-fg :background ,lambda-mild :box nil))))
     `(custom-button-pressed                         ((,class (:foreground ,lambda-bg :background ,lambda-fg :box nil))))

;;;;;; Customize faces

     `(custom-group-subtitle                         ((,class (:foreground ,lambda-fg :bold t))))
     `(custom-group-tag                              ((,class (:foreground ,lambda-fg :bold t))))
     `(custom-group-tag-1                            ((,class (:foreground ,lambda-fg :bold t))))
     `(custom-comment                                ((,class (:foreground ,lambda-mild))))
     `(custom-comment-tag                            ((,class (:foreground ,lambda-mild))))
     `(custom-changed                                ((,class (:foreground ,lambda-focus))))
     `(custom-modified                               ((,class (:foreground ,lambda-focus))))
     `(custom-face-tag                               ((,class (:foreground ,lambda-fg :bold t))))
     `(custom-variable-tag                           ((,class (:foreground ,lambda-fg :bold t))))
     `(custom-invalid                                ((,class (:foreground ,lambda-crucial))))
     `(custom-visibility                             ((,class (:foreground ,lambda-focus))))
     `(custom-state                                  ((,class (:foreground ,lambda-focus))))
     `(custom-link                                   ((,class (:foreground ,lambda-focus))))
     `(custom-button                                 ((,class (:foreground ,lambda-mild :background ,lambda-bg :box (:line-width 1 :color ,lambda-mild :style nil)))))
     `(custom-button-mouse                           ((,class (:foreground ,lambda-mild :background ,lambda-faint :box (:line-width 1 :color ,lambda-mild :style nil)))))
     `(custom-button-pressed                         ((,class (:foreground ,lambda-fg :background ,lambda-focus :inverse-video nil :box (:line-width 1 :color ,lambda-focus :style nil)))))

;;;;;; Dashboard
     `(dashboard-banner-logo-title-face             ((,class (:foreground ,lambda-fg :bold t))))
     `(dashboard-text-banner-face                   ((,class (:foreground ,lambda-meek))))
     `(dashboard-heading-face                       ((,class (:foreground ,lambda-fg :bold t :height 1.1))))
     `(dashboard-items-face                         ((,class (:foreground ,lambda-fg))))

;;;;;; Elscreen
     `(elscreen-tab-background-face              ((,class (:background ,lambda-bg :box nil)))) ;; Tab bar, not the tabs))
     `(elscreen-tab-control-face                 ((,class (:background ,lambda-faint :foreground ,lambda-red :underline nil :box nil)))) ;; The controls))
     `(elscreen-tab-current-screen-face          ((,class (:background ,lambda-faint :foreground ,lambda-strong :box nil)))) ;; Current tab))
     `(elscreen-tab-other-screen-face            ((,class (:background ,lambda-faint :foreground ,lambda-ultralight :underline nil :box nil)))) ;; Inactive tab))

;;;;;; Highlight-Indentation
     `(highlight-indentation-face ((,class (:inherit ,lambda-highlight))))
     `(highlight-indentation-current-column-face ((,class (:background ,lambda-yellow))))

;;;;;; Highlight Indentation Guides
     `(highlight-indent-guides-stack-odd-face        ((,class (:foreground ,lambda-orange))))
     `(highlight-indent-guides-stack-even-face       ((,class (:foreground ,lambda-yellow))))
     `(highlight-indent-guides-top-odd-face          ((,class (:foreground ,lambda-orange))))
     `(highlight-indent-guides-top-even-face         ((,class (:foreground ,lambda-yellow))))
     `(highlight-indent-guides-odd-face              ((,class (:foreground ,lambda-orange))))
     `(highlight-indent-guides-even-face             ((,class (:foreground ,lambda-yellow))))
     `(highlight-indent-guides-character-face        ((,class (:foreground ,lambda-highlight))))
     `(highlight-indent-guides-top-character-face    ((,class (:foreground ,lambda-highlight))))
     `(highlight-indent-guides-stack-character-face  ((,class (:foreground ,lambda-highlight))))

;;;;;; Popup
     `(popup-face                                ((,class (:underline nil :foreground ,lambda-highlight :background ,lambda-mild))))
     `(popup-menu-mouse-face                     ((,class (:underline nil :foreground ,lambda-white :background ,lambda-green))))
     `(popup-menu-selection-face                 ((,class (:underline nil :foreground ,lambda-white :background ,lambda-green))))
     `(popup-tip-face                            ((,class (:underline nil :foreground ,lambda-ultralight :background ,lambda-faint))))

;;;;;; Pulse
     `(pulse-highlight-face       ((,class (:background ,lambda-crucial))))
     `(pulse-highlight-start-face ((,class (:background ,lambda-crucial))))

;;;;;; Lambda-Splash Faces

     `(lem-splash-title-face    ((,class (:foreground ,lambda-strong :weight bold))))
     `(lem-splash-header-face   ((,class (:foreground ,lambda-meek :weight light))))
     `(lem-splash-footer-face   ((,class (:foreground ,lambda-meek))))
     `(lem-splash-image-face    ((,class (:foreground ,lambda-meek :weight light))))
     `(lem-splash-menu-face     ((,class (:foreground ,lambda-purple))))

;;;;;; Tab-bar
     ;; `flat-button' is only available on emacs 28 and higher so accommodate other versions.
     (when (>= emacs-major-version 28)
       `(tab-bar                    ((,class (:foreground ,lambda-meek
                                              :weight light
                                              :inherit ,(if lambda-themes-set-variable-pitch 'variable-pitch 'default)
                                              :box (:line-width (1 . 1)
                                                    :color nil
                                                    :style flat-button))))))

     (when (<= emacs-major-version 28)
       `(tab-bar                    ((,class (:foreground ,lambda-meek
                                              :weight light
                                              :inherit ,(if lambda-themes-set-variable-pitch 'variable-pitch 'default)
                                              :box (:line-width 2
                                                    :color ,lambda-bg
                                                    :style nil))))))

     `(tab-bar-tab                ((,class (:background ,lambda-ultralight
                                            :foreground ,lambda-fg
                                            :height 1.1))))
     `(tab-bar-tab-inactive       ((,class (:background ,lambda-lowlight :foreground ,lambda-meek))))
     `(tab-bar-tab-ungrouped      ((,class (:background ,lambda-bg :foreground ,lambda-faint))))
     `(tab-bar-tab-group-current  ((,class (:background ,lambda-bg :foreground ,lambda-fg :underline t))))
     `(tab-bar-tab-group-inactive ((,class (:background ,lambda-bg :foreground ,lambda-faint))))

     `(tab-line                   ((,class (:inherit tab-bar))))
     `(tab-line-tab               ((,class (:inherit tab-bar-tab-inactive))))
     `(tab-line-tab-current       ((,class (:inherit tab-bar-tab))))

     ;; `(tab-bar                    ((,class (:background ,lambda-bg :foreground ,lambda-meek :inherit ,(if lambda-themes-set-variable-pitch 'variable-pitch 'default)))))
     ;; `(tab-bar-tab                ((,class (:background ,lambda-ultralight :foreground ,lambda-fg :underline (:color ,lambda-mild) :height 1.1))))

;;;;;; Tab-bar Echo
     `(tab-bar-echo-area-tab                      ((,class (:foreground ,lambda-strong :underline t :weight bold))))
     `(tab-bar-echo-area-tab-group-current        ((,class (:foreground ,lambda-strong))))
     `(tab-bar-echo-area-tab-ungrouped            ((,class (:foreground ,lambda-strong :weight light))))

;;;;;; Tables
     `(table-cell ((,class (:background ,lambda-bg :foreground ,lambda-strong))))

;;;;;; Transient
     `(transient-key                             ((,class (:foreground ,lambda-focus :weight bold))))
     `(transient-heading                         ((,class (:foreground ,lambda-strong :background ,lambda-highlight))))
     `(transient-argument                        ((,class (:foreground ,lambda-urgent))))
     `(transient-unreachable                     ((,class (:foreground ,lambda-meek))))
     `(transient-inapt-suffix                    ((,class (:foreground ,lambda-meek))))
     `(transient-inactive-value                  ((,class (:foreground ,lambda-meek))))
     `(transient-inactive-argument               ((,class (:foreground ,lambda-meek))))
     `(transient-separator                       ((,class (:background ,lambda-lowlight))))

;;;;;; Tool tips
     `(tooltip                                   ((,class (:foreground ,lambda-highlight :background ,lambda-mild))))

;;;;;; Widget faces
     `(widget-button-pressed-face                ((,class (:foreground ,lambda-red))))
     `(widget-inactive                           ((,class (:foreground ,lambda-meek))))
     `(widget-documentation-face                 ((,class (:foreground ,lambda-green))))
     `(widget-field                              ((,class (:background ,lambda-faint))))
     `(widget-button                             ((,class (:foreground ,lambda-fg :bold t))))
     `(widget-single-line-field                  ((,class (:background ,lambda-faint))))

;;;;;; Window Divs
     ;; divide windows more attractively
     `(window-divider                            ((,class (:foreground ,lambda-highlight))))
     `(window-divider-first-pixel                ((,class (:foreground ,lambda-highlight))))
     `(window-divider-last-pixel                 ((,class (:foreground ,lambda-highlight))))
     ;; divide windows better in terminal
     ;; see https://www.reddit.com/r/emacs/comments/3u0d0u/how_do_i_make_the_vertical_window_divider_more/
     ;; (when (not (display-graphic-p))
     ;;   (set-face-background 'vertical-border ,lambda-bg)
     ;;   (set-face-foreground 'vertical-border (face-background 'vertical-border)))

;;;;; Help, Info, & Menus

;;;;;; Bookmarks
     `(bookmark-menu-heading                     ((,class (:foreground ,lambda-strong))))
     `(bookmark-menu-bookmark                    ((,class (:foreground ,lambda-focus))))
     `(bookmark-face                             ((,class (:foreground ,lambda-focus))))

;;;;;; Help(ful)
     `(helpful-heading ((,class (:inherit ,(if lambda-themes-set-variable-pitch 'variable-pitch 'default) :height 1.4 :foreground ,lambda-blue))))

;;;;;; Hydra
     `(hydra-face-red                            ((,class (:foreground ,lambda-red :weight bold))))
     `(hydra-face-blue                           ((,class (:foreground ,lambda-blue :weight bold))))
     `(hydra-face-amaranth                       ((,class (:foreground ,lambda-yellow :weight bold))))
     `(hydra-face-pink                           ((,class (:foreground ,lambda-purple :weight bold))))
     `(hydra-face-teal                           ((,class (:foreground ,lambda-aqua :weight bold))))

;;;;;; Imenu List
     `(imenu-list-entry-face                     ((,class (:foreground ,lambda-fg))))
     `(imenu-list-entry-face-0                   ((,class (:inherit imenu-list-entry-face))))
     `(imenu-list-entry-face-1                   ((,class (:inherit imenu-list-entry-face))))
     `(imenu-list-entry-face-2                   ((,class (:inherit imenu-list-entry-face))))
     `(imenu-list-entry-face-3                   ((,class (:inherit imenu-list-entry-face))))

;;;;;; Info (Documentation)
     `(info-menu-header                          ((,class (:foreground ,lambda-strong))))
     `(info-header-node                          ((,class (:foreground ,lambda-green))))
     `(info-index-match                          ((,class (:foreground ,lambda-crucial))))
     `(info-xref                                 ((,class (:foreground ,lambda-focus))))
     `(info-xref-visited                         ((,class (:foreground ,lambda-purple))))
     `(Info-quoted                               ((,class (:foreground ,lambda-meek))))
     `(info-title-1                              ((,class (:inherit outline-1))))
     `(info-title-2                              ((,class (:inherit outline-2))))
     `(info-title-3                              ((,class (:inherit outline-3))))
     `(info-title-4                              ((,class (:inherit outline-4))))

;;;;;; Marginalia
     `(marginalia-documentation                  ((,class (:italic t :foreground ,lambda-strong))))

;;;;;; Message-mode
     `(message-header-to                         ((,class (:inherit font-lock-variable-name-face))))
     `(message-header-cc                         ((,class (:inherit font-lock-variable-name-face))))
     `(message-header-subject                    ((,class (:foreground ,lambda-orange :weight bold))))
     `(message-header-newsgroups                 ((,class (:foreground ,lambda-yellow :weight bold))))
     `(message-header-other                      ((,class (:inherit font-lock-variable-name-face))))
     `(message-header-name                       ((,class (:inherit font-lock-keyword-face))))
     `(message-header-xheader                    ((,class (:foreground ,lambda-blue))))
     `(message-separator                         ((,class (:inherit font-lock-comment-face))))
     `(message-cited-text                        ((,class (:inherit font-lock-comment-face))))
     `(message-mml                               ((,class (:foreground ,lambda-green :weight bold))))

;;;;;; Package (M-x list-packages)
     `(package-description                       ((,class :inherit font-lock-string-face)))
     `(package-help-section-name                 ((,class :inherit lambda-strong)))
     `(package-name                              ((,class :inherit button)))
     `(package-status-available                  ((,class :foreground ,lambda-fg)))
     `(package-status-avail-obso                 ((,class :inherit error)))
     `(package-status-built-in                   ((,class :foreground ,lambda-purple)))
     `(package-status-dependency                 ((,class :foreground ,lambda-orange)))
     `(package-status-disabled                   ((,class :inherit warning)))
     `(package-status-external                   ((,class :foreground ,lambda-fg)))
     `(package-status-held                       ((,class :foreground ,lambda-yellow)))
     `(package-status-incompat                   ((,class :inherit warning)))
     `(package-status-installed                  ((,class :foreground ,lambda-meek)))
     `(package-status-new                        ((,class :inherit success)))
     `(package-status-unsigned                   ((,class :inherit error)))

;;;;;; Which-function-mode
     `(which-func                                 ((,class (:foreground ,lambda-blue))))

;;;;;; Neotree
     `(neo-banner-face                           ((,class (:foreground ,lambda-purple :bold t))))
     `(neo-dir-link-face                         ((,class (:foreground ,lambda-yellow))))
     `(neo-expand-btn-face                       ((,class (:foreground ,lambda-orange))))
     `(neo-file-link-face                        ((,class (:foreground ,lambda-ultralight))))
     `(neo-header-face                           ((,class (:foreground ,lambda-purple))))
     `(neo-root-dir-face                         ((,class (:foreground ,lambda-purple :bold t))))


;;;;;; Speed Bar

     `(speedbar-button-face                         ((,class (:foreground ,lambda-mild))))
     `(speedbar-directory-face                      ((,class (:foreground ,lambda-fg :bold t))))
     `(speedbar-file-face                           ((,class (:foreground ,lambda-fg :background ,lambda-bg))))
     `(speedbar-highlight-face                      ((,class (:foreground ,lambda-highlight))))
     `(speedbar-selected-face                       ((,class (:background ,lambda-faint :bold t))))
     `(speedbar-separator-face                      ((,class (:foreground ,lambda-mild))))
     `(speedbar-tag-face                            ((,class (:foreground ,lambda-mild))))

;;;;; Writing

;;;;;; Citar
     `(citar                   ((,class (:foreground ,lambda-meek))))
     `(citar-highlight         (( )))
     `(citar-org-style-preview ((,class (:foreground ,lambda-fg))))
;;;;;; Outline
     `(outline-minor-0      ((,class (:background ,lambda-lowlight :height 1.1))))
     `(outline-1            ((,class (:inherit ,(if lambda-themes-set-variable-pitch 'variable-pitch 'default) :height 1.4 :foreground ,lambda-fg))))
     `(outline-2            ((,class (:inherit ,(if lambda-themes-set-variable-pitch 'variable-pitch 'default) :height 1.4 :foreground ,lambda-meek))))
     `(outline-3            ((,class (:inherit ,(if lambda-themes-set-variable-pitch 'variable-pitch 'default) :height 1.4 :foreground ,lambda-fg))))
     `(outline-4            ((,class (:inherit ,(if lambda-themes-set-variable-pitch 'variable-pitch 'default) :height 1.4 :foreground ,lambda-meek))))
     `(outline-5            ((,class (:inherit outline-1))))
     `(outline-6            ((,class (:inherit outline-2))))
     `(outline-7            ((,class (:inherit outline-3))))
     `(outline-8            ((,class (:inherit outline-4))))

;;;;;; Markdown-mode
     `(markdown-header-face-1          ((,class (:inherit outline-1))))
     `(markdown-header-face-2          ((,class (:inherit outline-2))))
     `(markdown-header-face-3          ((,class (:inherit outline-3))))
     `(markdown-header-face-4          ((,class (:inherit outline-4))))
     `(markdown-header-face-5          ((,class (:inherit outline-5))))
     `(markdown-header-face-6          ((,class (:inherit outline-6))))
     `(markdown-code-face              ((,class (:inherit default))))
     `(markdown-footnote-marker-face   ((,class (:foreground ,lambda-meek))))
     `(markdown-list-face              ((,class (:foreground ,lambda-meek))))
     `(markdown-markup-face            ((,class (:foreground ,lambda-mild))))

;;;;; Org mode
;;;;;; Org Base Theme
     `(org-archived                                 ((,class (:foreground ,lambda-meek))))
     `(org-block                                    ((,class (:foreground ,lambda-meek))))
     `(org-block-begin-line                         ((,class (:foreground ,lambda-meek))))
     `(org-block-end-line                           ((,class (:foreground ,lambda-meek))))
     `(org-checkbox                                 ((,class (:foreground ,lambda-meek))))
     `(org-checkbox-statistics-done                 ((,class (:foreground ,lambda-meek))))
     `(org-checkbox-statistics-todo                 ((,class (:foreground ,lambda-meek))))
     `(org-cite                                     ((,class (:foreground ,lambda-meek))))
     `(org-cite-key                                 ((,class (:foreground ,lambda-crucial))))
     `(org-clock-overlay                            ((,class (:foreground ,lambda-meek))))
     `(org-code                                     ((,class (:foreground ,lambda-meek))))
     `(org-column                                   ((,class (:foreground ,lambda-meek))))
     `(org-column-title                             ((,class (:foreground ,lambda-meek))))
     `(org-date                                     ((,class (:foreground ,lambda-meek))))
     `(org-date-selected                            ((,class (:foreground ,lambda-meek))))
     `(org-default                                  ((,class (:foreground ,lambda-meek))))
     `(org-document-info                            ((,class (:foreground ,lambda-meek :weight light :height 1.0 :inherit ,(if lambda-themes-set-variable-pitch 'variable-pitch 'default)))))
     `(org-document-info-keyword                    ((,class (:foreground ,lambda-meek :weight light :height 1.0 :inherit ,(if lambda-themes-set-variable-pitch 'variable-pitch 'default)))))
     `(org-document-title                           ((,class (:inherit ,(if lambda-themes-set-variable-pitch 'variable-pitch 'default) :height 1.25 :foreground ,lambda-fg :weight medium))))
     `(org-done                                     ((,class (:foreground ,lambda-meek :strike-through t))))
     `(org-drawer                                   ((,class (:foreground ,lambda-meek :weight light))))
     `(org-ellipsis                                 ((,class (:foreground ,lambda-meek))))
     `(org-footnote                                 ((,class (:foreground ,lambda-meek))))
     `(org-formula                                  ((,class (:foreground ,lambda-meek))))
     `(org-habit-alert-face                         ((,class (:inherit default))))
     `(org-headline-done                            ((,class (:foreground ,lambda-meek))))
     `(org-imminent-deadline                        ((,class (:foreground ,lambda-urgent))))
     `(org-latex-and-related                        ((,class (:foreground ,lambda-meek))))
     `(org-level-1                                  ((,class (:inherit outline-1))))
     `(org-level-2                                  ((,class (:inherit outline-2))))
     `(org-level-3                                  ((,class (:inherit outline-3))))
     `(org-level-4                                  ((,class (:inherit outline-4))))
     `(org-level-5                                  ((,class (:inherit outline-5))))
     `(org-level-6                                  ((,class (:inherit outline-6))))
     `(org-level-7                                  ((,class (:inherit outline-7))))
     `(org-level-8                                  ((,class (:inherit outline-8))))
     `(org-link                                     ((,class (:foreground ,lambda-focus))))
     `(org-list-dt                                  ((,class (:foreground ,lambda-strong :weight semi-bold))))
     `(org-macro                                    ((,class (:foreground ,lambda-meek))))
     `(org-meta-line                                ((,class (:foreground ,lambda-meek :weight light :height 1.0 :inherit ,(if lambda-themes-set-variable-pitch 'variable-pitch 'default)))))
     `(org-mode-line-clock                          ((,class (:foreground ,lambda-meek))))
     `(org-mode-line-clock-overrun                  ((,class (:foreground ,lambda-meek))))
     `(org-priority                                 ((,class (:foreground ,lambda-meek))))
     `(org-property-value                           ((,class (:foreground ,lambda-meek :weight light))))
     `(org-quote                                    ((,class (:background ,lambda-faint :foreground ,lambda-fg))))
     `(org-scheduled                                ((,class (:foreground ,lambda-strong))))
     `(org-scheduled-previously                     ((,class (:foreground ,lambda-strong :weight light))))
     `(org-scheduled-today                          ((,class (:foreground ,lambda-focus))))
     `(org-sexp-date                                ((,class (:foreground ,lambda-meek))))
     `(org-special-keyword                          ((,class (:foreground ,lambda-meek :weight light))))
     `(org-table                                    ((,class (:inherit   default))))
     `(org-tag                                      ((,class (:foreground ,lambda-meek))))
     `(org-tag-group                                ((,class (:foreground ,lambda-meek))))
     `(org-target                                   ((,class (:foreground ,lambda-meek))))
     `(org-time-grid                                ((,class (:foreground ,lambda-meek))))
     `(org-todo                                     ((,class (:foreground ,lambda-yellow))))
     `(org-upcoming-deadline                        ((,class (:foreground ,lambda-strong))))
     `(org-upcoming-distant-deadline                ((,class (:foreground ,lambda-fg))))
     `(org-verbatim                                 ((,class (:foreground ,lambda-meek))))
     `(org-verse                                    ((,class (:foreground ,lambda-meek))))
     `(org-warning                                  ((,class (:foreground ,lambda-crucial))))
;;;;;; Org-agenda
     `(org-agenda-calendar-event                    ((,class (:inherit default))))
     `(org-agenda-calendar-sexp                     ((,class (:foreground ,lambda-meek))))
     `(org-agenda-clocking                          ((,class (:foreground ,lambda-meek))))
     `(org-agenda-column-dateline                   ((,class (:foreground ,lambda-meek))))
     `(org-agenda-current-time                      ((,class (:foreground ,lambda-meek))))
     `(org-agenda-date                              ((,class (:foreground ,lambda-focus))))
     `(org-agenda-date-today                        ((,class (:inherit ,(if lambda-themes-set-variable-pitch 'variable-pitch 'default) :height 1.5 :foreground ,lambda-blue))))
     `(org-super-agenda-header                      ((,class (:inherit ,(if lambda-themes-set-variable-pitch 'variable-pitch 'default) :height 1.5 :foreground ,lambda-blue))))
     `(org-agenda-date-weekend                      ((,class (:foreground ,lambda-meek))))
     `(org-agenda-diary                             ((,class (:foreground ,lambda-meek))))
     `(org-agenda-dimmed-todo-face                  ((,class (:foreground ,lambda-meek))))
     `(org-agenda-done                              ((,class (:foreground ,lambda-meek :strike-through t))))
     `(org-agenda-filter-category                   ((,class (:foreground ,lambda-meek))))
     `(org-agenda-filter-effort                     ((,class (:foreground ,lambda-meek))))
     `(org-agenda-filter-regexp                     ((,class (:foreground ,lambda-meek))))
     `(org-agenda-filter-tags                       ((,class (:foreground ,lambda-meek))))
     `(org-agenda-restriction-lock                  ((,class (:foreground ,lambda-meek))))
     `(org-agenda-structure                         ((,class (:foreground ,lambda-strong :weight medium :height 1.1 :inherit ,(if lambda-themes-set-variable-pitch 'variable-pitch 'default)))))
;;;;;; Org-habit
     `(org-habit-clear-face                      ((,class (:background ,lambda-blue))))
     `(org-habit-clear-future-face               ((,class (:background ,lambda-blue))))
     `(org-habit-ready-face                      ((,class (:background ,lambda-green))))
     `(org-habit-ready-future-face               ((,class (:background ,lambda-green))))
     `(org-habit-alert-face                      ((,class (:background ,lambda-yellow))))
     `(org-habit-alert-future-face               ((,class (:background ,lambda-yellow))))
     `(org-habit-overdue-face                    ((,class (:background ,lambda-red))))
     `(org-habit-overdue-future-face             ((,class (:background ,lambda-red))))

;;;;;; Org-Modern
     `(org-modern-label                          ((,class (:height 1.0 :inherit ,(if lambda-themes-set-variable-pitch 'variable-pitch 'default)))))
     `(org-modern-bracket-line                   ((,class (:foreground ,lambda-mild :weight light))))

;;;;; Search
;;;;;; Ag (The Silver Searcher)
     `(ag-hit-face                               ((,class (:foreground ,lambda-blue))))
     `(ag-match-face                             ((,class (:foreground ,lambda-red))))

;;;;;; Anzu-mode
     `(anzu-mode-line                            ((,class (:foreground ,lambda-yellow :weight bold))))
     `(anzu-match-1                              ((,class (:background ,lambda-green))))
     `(anzu-match-2                              ((,class (:background ,lambda-yellow))))
     `(anzu-match-3                              ((,class (:background ,lambda-aqua))))
     `(anzu-replace-to                           ((,class (:foreground ,lambda-yellow))))
     `(anzu-replace-highlight                    ((,class (:inherit isearch))))

;;;;;; Isearch
     `(lazy-highlight                               ((,class (:foreground ,lambda-fg :background ,lambda-yellow))))
     `(evil-ex-search                               ((,class (:background ,lambda-focus))))
     `(isearch                                      ((,class (:background ,lambda-focus :foreground ,lambda-highlight :weight bold))))
     `(isearch-fail                                 ((,class (:background ,lambda-urgent))))
     `(isearch-group-1                              ((,class (:background ,lambda-blue))))
     `(isearch-group-2                              ((,class (:background ,lambda-red))))
     `(query-replace                                ((,class (:background ,lambda-yellow))))

;;;;;; Wgrep
     `(wgrep-delete-face                          ((,class (:strike-through ,lambda-red))))
     `(wgrep-done-face                            ((,class (:foreground ,lambda-aqua))))
     `(wgrep-face                                 ((,class (:underline (:color ,lambda-yellow :style line)))))
     `(wgrep-file-face                            ((,class (:inherit highlight))))
     `(wgrep-reject-face                          ((,class (:foreground ,lambda-red :bold t))))

;;;;; Shell
;;;;;; Term
     `(term-color-black                          ((,class (:foreground ,lambda-faint))))
     `(term-color-blue                           ((,class (:foreground ,lambda-blue))))
     `(term-color-cyan                           ((,class (:foreground ,lambda-aqua))))
     `(term-color-green                          ((,class (:foreground ,lambda-green))))
     `(term-color-magenta                        ((,class (:foreground ,lambda-purple))))
     `(term-color-red                            ((,class (:foreground ,lambda-red))))
     `(term-color-white                          ((,class (:foreground ,lambda-strong))))
     `(term-color-yellow                         ((,class (:foreground ,lambda-yellow))))
     `(term-default-fg-color                     ((,class (:foreground ,lambda-fg))))
     `(term-default-bg-color                     ((,class (:background ,lambda-bg))))
;;;;;; Eat (modern terminal emulator)
     `(eat-term-color-0                          ((,class (:foreground ,lambda-faint))))
     `(eat-term-color-1                          ((,class (:foreground ,lambda-red))))
     `(eat-term-color-2                          ((,class (:foreground ,lambda-green))))
     `(eat-term-color-3                          ((,class (:foreground ,lambda-yellow))))
     `(eat-term-color-4                          ((,class (:foreground ,lambda-blue))))
     `(eat-term-color-5                          ((,class (:foreground ,lambda-purple))))
     `(eat-term-color-6                          ((,class (:foreground ,lambda-aqua))))
     `(eat-term-color-7                          ((,class (:foreground ,lambda-meek))))
     `(eat-term-color-8                          ((,class (:foreground ,lambda-mild))))
     `(eat-term-color-9                          ((,class (:foreground ,lambda-red))))
     `(eat-term-color-10                         ((,class (:foreground ,lambda-green))))
     `(eat-term-color-11                         ((,class (:foreground ,lambda-yellow))))
     `(eat-term-color-12                         ((,class (:foreground ,lambda-blue))))
     `(eat-term-color-13                         ((,class (:foreground ,lambda-purple))))
     `(eat-term-color-14                         ((,class (:foreground ,lambda-aqua))))
     `(eat-term-color-15                         ((,class (:foreground ,lambda-strong))))
     `(eat-term-default-fg                       ((,class (:foreground ,lambda-fg))))
     `(eat-term-default-bg                       ((,class (:background ,lambda-bg))))

;;;;;; Shell script
     `(sh-quoted-exec                            ((,class (:foreground ,lambda-purple))))
     `(sh-heredoc                                ((,class (:foreground ,lambda-orange))))

;;;;;; Eshell
     `(eshell-prompt                              ((,class (:foreground ,lambda-yellow))))
     `(eshell-ls-archive                          ((,class (:foreground ,lambda-meek))))
     `(eshell-ls-backup                           ((,class (:foreground ,lambda-meek))))
     `(eshell-ls-clutter                          ((,class (:foreground ,lambda-orange :weight bold))))
     `(eshell-ls-directory                        ((,class (:foreground ,lambda-blue :weight bold))))
     `(eshell-ls-executable                       ((,class (:weight bold))))
     `(eshell-ls-missing                          ((,class (:foreground ,lambda-red :bold t))))
     `(eshell-ls-product                          ((,class (:foreground ,lambda-red))))
     `(eshell-ls-readonly                         ((,class (:backgtround ,lambda-highlight :foreground ,lambda-meek :weight light))))
     `(eshell-ls-special                          ((,class (:foreground ,lambda-yellow :bold t))))
     `(eshell-ls-symlink                          ((,class (:foreground ,lambda-red))))
     `(eshell-ls-unreadable                       ((,class (:foreground ,lambda-red :bold t))))

;;;;; Elfeed
     `(elfeed-search-title-face                  ((,class (:foreground ,lambda-meek))))
     `(elfeed-search-unread-title-face           ((,class (:foreground ,lambda-strong :weight bold))))
     `(elfeed-search-date-face                   ((,class (:foreground ,lambda-meek))))
     `(elfeed-search-feed-face                   ((,class (:foreground ,lambda-meek))))
     `(elfeed-search-tag-face                    ((,class (:foreground ,lambda-fg :background ,lambda-lowlight :weight light))))
     `(elfeed-search-last-update-face            ((,class (:foreground ,lambda-meek))))
     `(elfeed-search-unread-count-face           ((,class (:foreground ,lambda-strong))))
     `(elfeed-search-filter-face                 ((,class (:inherit font-lock-string-face))))

;;;;; Mu4e
     `(mu4e-attach-number-face                      ((,class ((,class (:foreground ,lambda-strong))))))
     `(mu4e-cited-1-face                            ((,class (:foreground ,lambda-meek))))
     `(mu4e-cited-2-face                            ((,class (:foreground ,lambda-meek))))
     `(mu4e-cited-3-face                            ((,class (:foreground ,lambda-meek))))
     `(mu4e-cited-4-face                            ((,class (:foreground ,lambda-meek))))
     `(mu4e-cited-5-face                            ((,class (:foreground ,lambda-meek))))
     `(mu4e-cited-6-face                            ((,class (:foreground ,lambda-meek))))
     `(mu4e-cited-7-face                            ((,class (:foreground ,lambda-meek))))
     `(mu4e-compose-header-face                     ((,class (:foreground ,lambda-meek))))
     `(mu4e-compose-separator-face                  ((,class (:foreground ,lambda-meek))))
     `(mu4e-contact-face                            ((,class (:foreground ,lambda-focus))))
     `(mu4e-context-face                            ((,class (:foreground ,lambda-mild))))
     `(mu4e-draft-face                              ((,class (:foreground ,lambda-meek :weight light :slant italic))))
     `(mu4e-flagged-face                            ((,class (:foreground ,lambda-yellow))))
     `(mu4e-footer-face                             ((,class (:foreground ,lambda-meek))))
     `(mu4e-forwarded-face                          ((,class (:inherit    default))))
     `(mu4e-header-face                             ((,class (:inherit    default))))
     `(mu4e-header-highlight-face                   ((,class (:inherit highlight))))
     `(mu4e-header-key-face                         ((,class (:foreground ,lambda-strong :weight bold))))
     `(mu4e-header-marks-face                       ((,class (:foreground ,lambda-meek))))
     `(mu4e-header-title-face                       ((,class (:foreground ,lambda-strong))))
     `(mu4e-header-value-face                       ((,class (:inherit    default))))
     `(mu4e-highlight-face                          ((,class (:foreground ,lambda-focus))))
     `(mu4e-link-face                               ((,class (:foreground ,lambda-focus))))
     `(mu4e-modeline-face                           ((,class (:foreground ,lambda-faint))))
     `(mu4e-moved-face                              ((,class (:foreground ,lambda-mild))))
     `(mu4e-ok-face                                 ((,class (:foreground ,lambda-mild))))
     `(mu4e-region-code                             ((,class (:foreground ,lambda-meek))))
     `(mu4e-replied-face                            ((,class (:foreground ,lambda-crucial))))
     `(mu4e-special-header-value-face               ((,class (:inherit   default))))
     `(mu4e-system-face                             ((,class (:foreground ,lambda-mild))))
     `(mu4e-title-face                              ((,class (:weight bold :foreground ,lambda-crucial))))
     `(mu4e-trashed-face                            ((,class (:foreground ,lambda-mild :weight light))))
     `(mu4e-unread-face                             ((,class (:inherit    bold))))
     `(mu4e-url-number-face                         ((,class (:foreground ,lambda-meek))))
     `(mu4e-view-body-face                          ((,class (:inherit    default))))
     `(mu4e-warning-face                            ((,class (:foreground ,lambda-urgent))))

;;;;; Circe
     `(circe-prompt-face               ((,class (:foreground ,lambda-aqua))))
     `(circe-fool                      ((,class (:foreground ,lambda-faint))))
     `(circe-highlight-nick-face       ((,class (:foreground ,lambda-yellow))))
     `(circe-server-face               ((,class (:foreground ,lambda-faint))))
     `(circe-my-message-face           ((,class (:foreground ,lambda-aqua))))
     `(lui-time-stamp-face             ((,class (:foreground ,lambda-blue))))

;;;;; Erc
     `(erc-action-face            ((,class ((,class (:inherit erc-default-face))))))
     `(erc-bold-face              ((,class (:weight bold))))
     `(erc-current-nick-face      ((,class (:foreground ,lambda-aqua))))
     `(erc-dangerous-host-face    ((,class (:inherit font-lock-warning-face))))
     `(erc-default-face           ((,class (:inherit default))))
     `(erc-direct-msg-face        ((,class (:inherit erc-default-face))))
     `(erc-error-face             ((,class (:inherit font-lock-warning-face))))
     `(erc-fool-face              ((,class (:inherit erc-default-face))))
     `(erc-input-face             ((,class (:foreground ,lambda-aqua))))
     `(erc-my-nick-face           ((,class (:foreground ,lambda-aqua))))
     `(erc-nick-msg-face          ((,class (:inherit erc-default-face))))
     `(erc-notice-face            ((,class (:foreground ,lambda-faint))))
     `(erc-timestamp-face         ((,class (:foreground ,lambda-green))))
     `(erc-underline-face         ((,class (:underline t))))
     `(erc-prompt-face            ((,class (:foreground ,lambda-aqua))))
     `(erc-pal-face               ((,class (:foreground ,lambda-yellow :weight bold))))
     `(erc-keyword-face           ((,class (:foreground ,lambda-orange :weight bold))))
     `(erc-nick-default-face      ((,class (:weight regular))))
     `(erc-button                 ((,class (:weight bold  :underline t))))

;;;;; Gnus
     `(gnus-group-mail-1           ((,class (:weight bold :foreground ,lambda-ultralight))))
     `(gnus-group-mail-2           ((,class (:inherit gnus-group-mail-1))))
     `(gnus-group-mail-3           ((,class (:inherit gnus-group-mail-1))))
     `(gnus-group-mail-1-empty     ((,class (:foreground ,lambda-faint))))
     `(gnus-group-mail-2-empty     ((,class (:inherit gnus-group-mail-1-empty))))
     `(gnus-group-mail-3-empty     ((,class (:inherit gnus-group-mail-1-empty))))
     `(gnus-group-news-1           ((,class (:inherit gnus-group-mail-1))))
     `(gnus-group-news-2           ((,class (:inherit gnus-group-news-1))))
     `(gnus-group-news-3           ((,class (:inherit gnus-group-news-1))))
     `(gnus-group-news-4           ((,class (:inherit gnus-group-news-1))))
     `(gnus-group-news-5           ((,class (:inherit gnus-group-news-1))))
     `(gnus-group-news-6           ((,class (:inherit gnus-group-news-1))))
     `(gnus-group-news-1-empty     ((,class (:inherit gnus-group-mail-1-empty))))
     `(gnus-group-news-2-empty     ((,class (:inherit gnus-group-news-1-empty))))
     `(gnus-group-news-3-empty     ((,class (:inherit gnus-group-news-1-empty))))
     `(gnus-group-news-4-empty     ((,class (:inherit gnus-group-news-1-empty))))
     `(gnus-group-news-5-empty     ((,class (:inherit gnus-group-news-1-empty))))
     `(gnus-group-news-6-empty     ((,class (:inherit gnus-group-news-1-empty))))
     `(gnus-group-mail-low         ((,class (:inherit gnus-group-mail-1 :weight normal))))
     `(gnus-group-mail-low-empty   ((,class (:inherit gnus-group-mail-1-empty))))
     `(gnus-group-news-low         ((,class (:inherit gnus-group-mail-1 :foreground ,lambda-faint))))
     `(gnus-group-news-low-empty   ((,class (:inherit gnus-group-news-low :weight normal))))
     `(gnus-header-content         ((,class (:inherit message-header-other))))
     `(gnus-header-from            ((,class (:inherit message-header-other))))
     `(gnus-header-name            ((,class (:inherit message-header-name))))
     `(gnus-header-newsgroups      ((,class (:inherit message-header-other))))
     `(gnus-header-subject         ((,class (:inherit message-header-subject))))
     `(gnus-summary-cancelled      ((,class (:foreground ,lambda-red :strike-through t))))
     `(gnus-summary-normal-ancient ((,class (:foreground ,lambda-faint :inherit italic))))
     `(gnus-summary-normal-read    ((,class (:foreground ,lambda-ultralight))))
     `(gnus-summary-normal-ticked  ((,class (:foreground ,lambda-purple))))
     `(gnus-summary-normal-unread  ((,class (:foreground ,lambda-green :inherit bold))))
     `(gnus-summary-selected       ((,class (:foreground ,lambda-blue :weight bold))))
     `(gnus-cite-1                 ((,class (:foreground ,lambda-purple))))
     `(gnus-cite-2                 ((,class (:foreground ,lambda-purple))))
     `(gnus-cite-3                 ((,class (:foreground ,lambda-purple))))
     `(gnus-cite-4                 ((,class (:foreground ,lambda-green))))
     `(gnus-cite-5                 ((,class (:foreground ,lambda-green))))
     `(gnus-cite-6                 ((,class (:foreground ,lambda-green))))
     `(gnus-cite-7                 ((,class (:foreground ,lambda-purple))))
     `(gnus-cite-8                 ((,class (:foreground ,lambda-purple))))
     `(gnus-cite-9                 ((,class (:foreground ,lambda-purple))))
     `(gnus-cite-10                ((,class (:foreground ,lambda-orange))))
     `(gnus-cite-11                ((,class (:foreground ,lambda-orange))))
     `(gnus-signature              ((,class (:foreground ,lambda-orange))))
     `(gnus-x-face                 ((,class (:background ,lambda-faint :foreground ,lambda-ultralight))))

;;;;; Coq
     `(coq-solve-tactics-face      ((,class (:inherit font-lock-constant-face))))
     `(coq-cheat-face              ((,class (:box (:line-width -1 :color ,lambda-red :style nil)))
                                    :foreground ,lambda-red))
     `(coq-button-face             ((,class (:background ,lambda-bg))))
     `(coq-button-face-active      ((,class (:background ,lambda-mild))))
     `(coq-button-face-pressed     ((,class (:background ,lambda-bg))))

;;;;; Proof General
     `(proof-active-area-face      ((,class (:underline t))))
     `(proof-tacticals-name-face   ((,class (:inherit font-lock-constant-face))))
     `(proof-tactics-name-face     ((,class (:inherit font-lock-constant-face))))
     `(proof-locked-face           ((,class (:background ,lambda-mild))))
     `(proof-queue-face            ((,class (:background ,lambda-faint))))
     `(proof-warning-face          ((,class (:background ,lambda-red))))
     `(proof-error-face            ((,class (:background ,lambda-bg :foreground ,lambda-red))))

;;;;; Ledger-mode
     `(ledger-font-xact-highlight-face  ((,class (:background ,lambda-mild))))

;;;;; Modeline/Headerline
;;;;;; Basic Modeline/Headerline
     (unless (or (fboundp 'lambda-line)
                 (fboundp 'bespoke-modeline)
                 (fboundp 'nano-modeline)
                 (fboundp 'doom-modeline))
       `(mode-line          ((,class (:foreground ,lambda-fg   :background ,lambda-faint    :box (:line-width 1 :color ,lambda-highlight :style nil))))))

     (unless (or (fboundp 'lambda-line)
                 (fboundp 'bespoke-modeline)
                 (fboundp 'nano-modeline)
                 (fboundp 'doom-modeline))
       `(mode-line-inactive ((,class (:foreground ,lambda-meek :background ,lambda-lowlight :box (:line-width 1 :color ,lambda-highlight :style nil))))))

;;;;;; Doom Modeline
     (when (fboundp 'doom-modeline)
       `(mode-line          ((,class (:foreground ,lambda-fg   :background ,lambda-faint)))))
     (when (fboundp 'doom-modeline)
       `(mode-line-inactive ((,class (:foreground ,lambda-meek :background ,lambda-lowlight)))))
     `(doom-modeline-bar ((,class (:background ,lambda-focus :foreground ,lambda-focus))))
     `(doom-modeline-bar-inactive ((,class (:background ,lambda-lowlight :box (:line-width 1 :color ,lambda-lowlight :style nil)))))
     `(doom-modeline-evil-emacs-state    ((,class (:inherit bold :foreground ,lambda-aqua))))
     `(doom-modeline-evil-insert-state   ((,class (:inherit bold :foreground ,lambda-green))))
     `(doom-modeline-evil-motion-state   ((,class (:inherit bold :foreground ,lambda-meek))))
     `(doom-modeline-evil-normal-state   ((,class (:inherit bold :foreground ,lambda-yellow))))
     `(doom-modeline-evil-operator-state ((,class (:inherit bold :foreground ,lambda-blue))))
     `(doom-modeline-evil-replace-state  ((,class (:inherit bold :foreground ,lambda-red))))
     `(doom-modeline-evil-visual-state   ((,class (:inherit bold :foreground ,lambda-purple))))

;;;;;; Lambda-line
     ;; Conditional load of header vs. footer status-line
     ;; Header line
     (when (and (fboundp 'lambda-line)
                (eq lambda-line-position 'top))
       `(header-line ((,class (:foreground ,lambda-fg :background ,lambda-highlight
                               :box (:line-width 1 :color ,lambda-ultralight :style nil))))))
     (when (and (fboundp 'lambda-line)
                (eq lambda-line-position 'top))
       `(mode-line ((,class (:underline ,lambda-highlight :height 0.1)))))
     (when (and (fboundp 'lambda-line)
                (eq lambda-line-position 'top))
       `(mode-line-active ((,class (:underline ,lambda-highlight :height 0.1)))))
     (when (and (fboundp 'lambda-line)
                (eq lambda-line-position 'top))
       `(mode-line-inactive ((,class (:underline ,lambda-highlight :height 0.1)))))

     ;; Footer line
     (when (and (fboundp 'lambda-line)
                (eq lambda-line-position 'bottom))
       `(header-line ((,class :inherit mode-line))))
     (when (and (fboundp 'lambda-line)
                (eq lambda-line-position 'bottom))
       `(mode-line   ((,class (:foreground ,lambda-fg :background ,lambda-faint
                               :box (:line-width 1 :color ,lambda-highlight :style nil))))))
     (when (and (fboundp 'lambda-line)
                (eq lambda-line-position 'bottom))
       `(mode-line-inactive ((,class (:foreground ,lambda-meek :background ,lambda-lowlight :box (:line-width 1 :color ,lambda-ultralight :style nil))))))

     `(lambda-line-active               ((,class (:foreground ,lambda-fg :background unspecified :box (:line-width 1 :color ,lambda-ultralight :style nil)))))
     `(lambda-line-inactive             ((,class (:foreground ,lambda-meek :background unspecified :box (:line-width 1 :color ,lambda-ultralight :style nil)))))
     `(lambda-line-active-name          ((,class (:inherit ,(if lambda-themes-set-variable-pitch 'variable-pitch 'default) :foreground ,lambda-fg))))
     `(lambda-line-inactive-name        ((,class (:inherit ,(if lambda-themes-set-variable-pitch 'variable-pitch 'default) :foreground ,lambda-meek))))
     `(lambda-line-active-primary       ((,class (:inherit ,(if lambda-themes-set-variable-pitch 'variable-pitch 'default) :foreground ,lambda-meek :weight light))))
     `(lambda-line-inactive-primary     ((,class (:inherit ,(if lambda-themes-set-variable-pitch 'variable-pitch 'default) :foreground ,lambda-meek :weight light))))
     `(lambda-line-active-secondary     ((,class (:inherit fixed-width :foreground ,lambda-fg))))
     `(lambda-line-inactive-secondary   ((,class (:inherit fixed-width :foreground ,lambda-meek))))
     `(lambda-line-active-tertiary      ((,class (:inherit fixed-width :foreground ,lambda-fg))))
     `(lambda-line-inactive-tertiary    ((,class (:inherit fixed-width))))
     `(lambda-line-active-status-RW     ((,class (:foreground ,lambda-green  :inverse-video ,(if lambda-line-status-invert t nil)
                                                  :box ,(if lambda-line-status-invert `(:line-width 1 :color ,lambda-green :style nil)
                                                          `(:line-width 1 :color ,lambda-ultralight :style nil))))))
     `(lambda-line-inactive-status-RW   ((,class (:foreground ,lambda-meek   :inverse-video ,(if lambda-line-status-invert t nil)
                                                  :box ,(if lambda-line-status-invert `(:line-width 1 :color ,lambda-mild :style nil)
                                                          `(:line-width 1 :color ,lambda-ultralight :style nil))))))
     `(lambda-line-active-status-MD     ((,class (:foreground ,lambda-red    :inverse-video ,(if lambda-line-status-invert t nil)
                                                  :box ,(if lambda-line-status-invert `(:line-width 1 :color ,lambda-red :style nil)
                                                          `(:line-width 1 :color ,lambda-ultralight :style nil))))))
     `(lambda-line-inactive-status-MD   ((,class (:foreground ,lambda-meek   :inverse-video ,(if lambda-line-status-invert t nil)
                                                  :box ,(if lambda-line-status-invert `(:line-width 1 :color ,lambda-mild :style nil)
                                                          `(:line-width 1 :color ,lambda-ultralight :style nil))))))
     `(lambda-line-active-status-RO     ((,class (:foreground ,lambda-yellow :inverse-video ,(if lambda-line-status-invert t nil)
                                                  :box ,(if lambda-line-status-invert `(:line-width 1 :color ,lambda-yellow :style nil)
                                                          `(:line-width 1 :color ,lambda-ultralight :style nil))))))
     `(lambda-line-inactive-status-RO   ((,class (:foreground ,lambda-meek   :inverse-video ,(if lambda-line-status-invert t nil)
                                                  :box ,(if lambda-line-status-invert `(:line-width 1 :color ,lambda-mild :style nil)
                                                          `(:line-width 1 :color ,lambda-ultralight :style nil))))))
     `(lambda-line-visual-bell          ((,class (:background ,lambda-urgent))))

;;;;;; Smart-mode-line
     `(sml/global                                ((,class (:foreground ,lambda-strong :inverse-video nil))))
     `(sml/modes                                 ((,class (:foreground ,lambda-green))))
     `(sml/filename                              ((,class (:foreground ,lambda-red :weight bold))))
     `(sml/prefix                                ((,class (:foreground ,lambda-ultralight))))
     `(sml/read-only                             ((,class (:foreground ,lambda-blue))))
     `(persp-selected-face                       ((,class (:foreground ,lambda-orange))))

;;;;;; Powerline
     `(powerline-active0                         ((,class (:background ,lambda-faint :foreground ,lambda-ultralight))))
     `(powerline-active1                         ((,class (:background ,lambda-strong :foreground ,lambda-ultralight))))
     `(powerline-active2                         ((,class (:background ,lambda-faint :foreground ,lambda-ultralight))))
     `(powerline-inactive0                       ((,class (:background ,lambda-faint :foreground ,lambda-ultralight))))
     `(powerline-inactive1                       ((,class (:background ,lambda-mild  :foreground ,lambda-ultralight))))
     `(powerline-inactive2                       ((,class (:background ,lambda-faint :foreground ,lambda-ultralight))))

;;;;;; Mood-line
     `(mood-line-modified       ((,class (:foreground ,lambda-red))))
     `(mood-line-status-error   ((,class (:inherit bold :foreground ,lambda-urgent))))
     `(mood-line-status-info    ((,class (:foreground ,lambda-focus))))
     `(mood-line-status-neutral ((,class (:foreground ,lambda-blue))))
     `(mood-line-status-success ((,class (:inherit success))))
     `(mood-line-status-warning ((,class (:inherit bold :foreground ,lambda-yellow))))
     `(mood-line-unimportant    ((,class (:foreground ,lambda-meek))))

;;;;;; Bespoke Modeline
     ;; Header line
     (when (and (fboundp 'bespoke-modeline)
                (eq bespoke-modeline-position 'top))
       `(header-line        ((,class (:foreground ,lambda-fg :background ,lambda-faint :box (:line-width 1 :color ,lambda-highlight :style nil))))))
     (when (and (fboundp 'bespoke-modeline)
                (eq bespoke-modeline-position 'top))
       `(mode-line ((,class (:underline ,lambda-highlight)))))
     (when (and (fboundp 'bespoke-modeline)
                (eq bespoke-modeline-position 'top))
       `(mode-line-inactive ((,class (:underline ,lambda-lowlight)))))

     ;; Footer line
     (when (and (fboundp 'bespoke-modeline)
                (eq bespoke-modeline-position 'bottom))
       `(header-line ((,class :inherit mode-line))))
     (when (and (fboundp 'bespoke-modeline)
                (eq bespoke-modeline-position 'bottom))
       `(mode-line   ((,class (:foreground ,lambda-fg :background ,lambda-faint
                               :box (:line-width 1 :color ,lambda-highlight :style nil))))))
     (when (and (fboundp 'bespoke-modeline)
                (eq bespoke-modeline-position 'bottom))
       `(mode-line-inactive ((,class (:foreground ,lambda-meek :background ,lambda-lowlight :box (:line-width 1 :color ,lambda-highlight :style nil))))))

     (with-eval-after-load 'bespoke-modeline
       `(bespoke-modeline-active               ((,class (:foreground ,lambda-fg :box (:line-width ,bespoke-modeline-size :color ,lambda-faint :style nil)))))
       `(bespoke-modeline-inactive             ((,class (:foreground ,lambda-meek :box (:line-width ,bespoke-modeline-size :color ,lambda-faint :style nil)))))
       `(bespoke-modeline-active-name          ((,class (:foreground ,lambda-fg))))
       `(bespoke-modeline-inactive-name        ((,class (:foreground ,lambda-meek))))
       `(bespoke-modeline-active-primary       ((,class (:foreground ,lambda-meek :weight light))))
       `(bespoke-modeline-inactive-primary     ((,class (:foreground ,lambda-meek :weight light))))
       `(bespoke-modeline-active-secondary     ((,class (:foreground ,lambda-fg))))
       `(bespoke-modeline-inactive-secondary   ((,class (:foreground ,lambda-meek))))
       `(bespoke-modeline-active-status-RW     ((,class (:foreground ,lambda-strong :background ,lambda-green
                                                         :box (:line-width ,bespoke-modeline-size :color ,lambda-green :style nil)))))
       `(bespoke-modeline-inactive-status-RW   ((,class (:foreground ,lambda-meek :background ,lambda-ultralight
                                                         :box (:line-width ,bespoke-modeline-size :color ,lambda-ultralight :style nil)))))
       `(bespoke-modeline-active-status-**     ((,class (:foreground ,lambda-strong :background ,lambda-red
                                                         :box (:line-width ,bespoke-modeline-size :color ,lambda-red :style nil)))))
       `(bespoke-modeline-inactive-status-**   ((,class (:foreground ,lambda-meek :background ,lambda-ultralight
                                                         :box (:line-width ,bespoke-modeline-size :color ,lambda-ultralight :style nil)))))
       `(bespoke-modeline-active-status-RO     ((,class (:foreground ,lambda-strong :background ,lambda-yellow
                                                         :box (:line-width ,bespoke-modeline-size :color ,lambda-yellow :style nil)))))
       `(bespoke-modeline-inactive-status-RO   ((,class (:foreground ,lambda-meek :background ,lambda-ultralight
                                                         :box (:line-width ,bespoke-modeline-size :color ,lambda-ultralight :style nil))))))

;;;;;; Nano-Modeline
     ;; Header line
     (when (and (fboundp 'nano-modeline)
                (eq nano-modeline-position 'top))
       `(header-line        ((,class (:foreground ,lambda-fg :background ,lambda-faint :box (:line-width 1 :color ,lambda-highlight :style nil))))))
     (when (and (fboundp 'nano-modeline)
                (eq nano-modeline-position 'top))
       `(mode-line ((,class (:underline ,lambda-highlight :height 0.1)))))
     (when (and (fboundp 'nano-modeline)
                (eq nano-modeline-position 'top))
       `(mode-line-inactive ((,class (:underline ,lambda-lowlight  :height 0.1)))))

     ;; Footer line
     (when (and (fboundp 'nano-modeline)
                (eq nano-modeline-position 'bottom))
       `(header-line ((,class :inherit mode-line))))
     (when (and (fboundp 'nano-modeline)
                (eq nano-modeline-position 'bottom))
       `(mode-line   ((,class (:foreground ,lambda-fg :background ,lambda-faint
                               :box (:line-width 1 :color ,lambda-highlight :style nil))))))
     (when (and (fboundp 'nano-modeline)
                (eq nano-modeline-position 'bottom))
       `(mode-line-inactive ((,class (:foreground ,lambda-meek :background ,lambda-lowlight :box (:line-width 1 :color ,lambda-highlight :style nil))))))

     `(nano-modeline-active             ((,class (:inherit mode-line :background ,lambda-faint))))
     `(nano-modeline-inactive           ((,class (:inherit mode-line-inactive :background ,lambda-lowlight))))
     `(nano-modeline-active-name        ((,class (:inherit mode-line :foreground ,lambda-fg))))
     `(nano-modeline-inactive-name      ((,class (:inherit mode-line-inactive :foreground ,lambda-meek))))
     `(nano-modeline-active-primary     ((,class (:inherit mode-line :foreground ,lambda-fg))))
     `(nano-modeline-active-secondary   ((,class (:inherit mode-line :foreground ,lambda-fg))))
     `(nano-modeline-active-status-**   ((,class (:inherit mode-line :background ,lambda-red))))
     `(nano-modeline-active-status-RO   ((,class (:inherit mode-line :background ,lambda-yellow))))
     `(nano-modeline-active-status-RW   ((,class (:inherit mode-line :background ,lambda-green))))
     `(nano-modeline-inactive-primary   ((,class (:inherit mode-line-inactive :foreground ,lambda-meek :weight light))))
     `(nano-modeline-inactive-secondary ((,class (:inherit mode-line-inactive :foreground ,lambda-meek))))
     `(nano-modeline-inactive-status-** ((,class (:inherit mode-line-inactive :foreground ,lambda-meek))))
     `(nano-modeline-inactive-status-RO ((,class (:inherit mode-line-inactive :foreground ,lambda-meek))))
     `(nano-modeline-inactive-status-RW ((,class (:inherit mode-line-inactive :foreground ,lambda-meek)))))

;;;; Custom set variables
    (custom-theme-set-variables
     theme-name

          ;;; ansi-color-names
     `(ansi-color-names-vector
       [,lambda-faint
        ,lambda-red
        ,lambda-green
        ,lambda-yellow
        ,lambda-blue
        ,lambda-purple
        ,lambda-aqua
        ,lambda-strong])


          ;;; pdf-tools
     `(pdf-view-midnight-colors '(,lambda-fg . ,lambda-ultralight))

;;;; End Theme Definition
     )))

;;;; Define evil cursor colors
(defun lambda-themes--evil-load-cursors ()
  "Load theme specific cursor colors."
  (setq evil-emacs-state-cursor    `('lambda-focus box))
  (setq evil-normal-state-cursor   `('lambda-yellow box))
  (setq evil-visual-state-cursor   `('lambda-meek box))
  (setq evil-insert-state-cursor   `('lambda-urgent (bar . 2)))
  (setq evil-replace-state-cursor  `('lambda-urgent hbar))
  (setq evil-motion-state-cursor   `('lambda-green box))
  (setq evil-operator-state-cursor `('lambda-orange hollow)))

(when lambda-themes-set-evil-cursors
(add-hook 'lambda-themes-after-load-theme-hook #'lambda-themes--evil-load-cursors))

;;;; Set Hl-Todo
;; inherit faces
(setq hl-todo-keyword-faces
      '(("HOLD" .       query-replace)
        ("TODO" .       warning)
        ("NEXT" .       highlight)
        ("OKAY" .       success)
        ("DONT" .       error)
        ("FAIL" .       error)
        ("DONE" .       success)
        ("NOTE" .       warning)
        ("KLUDGE" .     warning)
        ("HACK" .       warning)
        ("TEMP" .       warning)
        ("FIXME" .      error)
        ("XXX+" .       error)
        ("BUG" .        error)
        ("REVIEW" .     warning)
        ("DEPRECATED" . warning)))

;;;; Set Minibuffer & Echo Area
(defun lambda-themes--minibuffer ()
  "Derive minibuffer / echo area faces from lambda faces."
  ;; Minibuffer / echo area
  (dolist (buffer (list " *Minibuf-0*" " *Echo Area 0*"
                        " *Minibuf-1*" " *Echo Area 1*"))
    (when (get-buffer buffer)
      (with-current-buffer buffer
        (face-remap-add-relative 'default 'lambda-meek)))))
(add-hook 'lambda-themes-after-load-theme-hook #'lambda-themes--minibuffer)

;;;; Take Screenshots

(defvar lambda-themes-screenshot-command "screencapture -w %s%s.png"
  "Command used to take automated screenshots for lambda-themes.
Should contain 2 %s constructs to allow for theme name and directory/prefix")

(defun lambda-themes-screenshot (prefix)
  "Take a screenshot of all versions of the lambda-themes theme.
The name of the screenshots will be PREFIX followed by the theme name."
  (interactive "sScreenshot Prefix: ")
  (dolist (theme '(lambda-light
                   lambda-dark
                   lambda-light-faded
                   lambda-dark-faded))
    (load-theme theme t)
    (redisplay t)
    (shell-command (format lambda-themes-screenshot-command
                           prefix theme))))


;;; Provide file
;;;###autoload
(and load-file-name
     (boundp 'custom-theme-load-path)
     (add-to-list 'custom-theme-load-path
                  (file-name-as-directory
                   (file-name-directory load-file-name))))

(provide 'lambda-themes)

;; Local Variables:
;; eval: (when (fboundp 'rainbow-mode) (rainbow-mode +1))
;; End:
;;; lambda-themes.el ends here
