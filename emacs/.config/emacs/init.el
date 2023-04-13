(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

(server-start)
(require 'org-protocol)

;; Don't ask to follow symlinks, mostly for init.el in dotfiles.
(setq vc-follow-symlinks nil)

;; org-journal
(setq org-journal-file-type 'yearly)
(setq org-journal-dir "~/org/journal")
(setq org-journal-file-format "%Y-%m-%d.org")
(setq org-journal-date-format "%A %-d %B %Y")
(setq org-journal-time-format "%H:%M")
;; created property must be only date and not time to work
(setq org-journal-created-property-timestamp-format "[%Y-%m-%d %a]")
(require 'org-journal)
(global-set-key (kbd "C-c j") #'org-journal-new-entry)

;; Automatically reload files was modified by external program
;; Useful for memacs ;-)
(global-auto-revert-mode 1)

;; maximize initial screen at application start
;; https://emacs.stackexchange.com/a/3008
;; https://emacs.stackexchange.com/a/3017
(add-to-list 'initial-frame-alist '(fullscreen . maximized))
(add-to-list 'default-frame-alist '(fullscreen . fullheight))

;; Set global keys for better experience
(global-set-key (kbd "C-c l") #'org-store-link)
(global-set-key (kbd "C-c a") #'org-agenda)
(global-set-key (kbd "C-c c") #'org-capture)

(require 'org-tempo)

(setq set-language-environment "Dutch")

;; org-mobile
;; https://orgmode.org/manual/Org-Mobile.html
(setq org-mobile-directory "~/Library/Mobile Documents/iCloud~com~mobileorg~mobileorg/Documents")
(setq org-mobile-inbox-for-pull "~/org/inbox.org")

(setq org-directory "~/org")
(setq org-default-notes-file "~/org/refile.org")

;; TODO
;; https://orgmode.org/manual/Tracking-TODO-state-changes.html
(setq org-todo-keywords
      '((sequence "TODO(t)" "NEXT(n)" "STARTED(s!/!)" "WAIT(w@/!)" "|" "CANCELLED(c@/!)" "DONE(d!/!)")))
(setq org-log-into-drawer t)

;; Org-Agenda
(setq org-agenda-files
      '(
	"~/org/"
	"~/org/memacs/"
	"~/org/migrated/"
	"~/Library/Mobile Documents/iCloud~is~workflow~my~workflows/Documents/shortcuts.org"
	"~/Library/Mobile Documents/iCloud~com~appsonthemove~beorg/Documents/org/beorg.org"
	))
(setq org-agenda-custom-commands
   '(("n" "Agenda and all TODOs"
      ((agenda "" nil)
       (alltodo "" nil))
      nil)
     ("w" "WAITING" alltodo "" nil)))

;; Org-Refile
(setq org-refile-targets '((nil :maxlevel . 9)
			   (org-agenda-files :maxlevel . 9)))
(setq org-refile-use-outline-path 'file)

;; Org-Capture
(setq org-capture-templates '(
  ;; many more capture templates
  ("b" "Bookmark" entry (file+headline "~/org/notes.org" "Bookmarks")
       "* %?\n:PROPERTIES:\n:CREATED: %U\n:END:\n\n" :empty-lines 1)
  ("c" "Contacts" entry (file "~/org/contacts.org")
       "* %(org-contacts-template-name)
:PROPERTIES:
:EMAIL: %(org-contacts-template-email)
:END:")
 ;; many more capture templates
 ))

(setq org-agenda-include-diary t)

(setq org-contacts-files '("~/org/contacts.org"))
(require' org-contacts)

;; ----------

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(current-language-environment "Dutch")
 '(custom-enabled-themes '(nord))
 '(custom-safe-themes
   '("b60b55ecd22db6cf1072d72532cbc87174edd81c18419962deb4b8ba48f6b49d" "fee7287586b17efbfda432f05539b58e86e059e78006ce9237b8732fde991b4c" "f5b6be56c9de9fd8bdd42e0c05fecb002dedb8f48a5f00e769370e4517dde0e8" "50221b754c90ba6627bd8e40a13d01845a6d906d28062982d8c9aeab16efd211" "5dbdb4a71a0e834318ae868143bb4329be492dd04bdf8b398fb103ba1b8c681a" "9271c0ad73ef29af016032376d36e8aed4e89eff17908c0b578c33e54dfa1da1" "d543a5f82ce200d50bdce81b2ecc4db51422439ba7c0e6845483dd89566e4cf9" default))
 '(global-visual-line-mode t)
 '(package-selected-packages
   '(org-journal org-contacts nord-theme solarized-theme snazzy-theme)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#2E3440" :foreground "#D8DEE9" :inverse-video nil :box nil :strike-through nil :extend nil :overline nil :underline nil :slant normal :weight normal :height 140 :width normal :foundry "nil" :family "IBM Plex Mono")))))
