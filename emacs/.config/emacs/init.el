(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

;; set to nl_NL.UTF-8 for Dutch month/day names
(set-locale-environment "en_NL.UTF-8")

(setq set-language-environment "Dutch")

(set-face-attribute 'default nil
                    :family "JetBrains Mono"
                    :height 130)

(set-face-attribute 'fixed-pitch nil
                    :family  "JetBrains Mono"
                    :height 130)

;; When opening a file, start searching at the user's home directory.
(setq default-directory "~/")

(setq org-directory "~/org")
(setq org-default-notes-file (concat org-directory "/inbox.org"))

;; org-journal
(setq org-journal-file-type 'yearly)
(setq org-journal-dir (concat org-directory "/journal"))
(setq org-journal-file-format "%Y-%m-%d.org")
(setq org-journal-date-format "%A %-d %B %Y")
(setq org-journal-time-format "%H:%M")
;; created property must be only date and not time to work
(setq org-journal-created-property-timestamp-format "[%Y-%m-%d %a]")
(require 'org-journal)

;; Automatically reload files was modified by external program
;; Useful for memacs ;-)
(global-auto-revert-mode t)

;; Don't ask to follow symlinks, mostly for init.el in dotfiles.
(setq vc-follow-symlinks nil)

;; Don't assume that sentences should have two spaces after periods.
(setq sentence-end-double-space nil)

;; maximize initial screen at application start
;; https://emacs.stackexchange.com/a/3008
;; https://emacs.stackexchange.com/a/3017
(add-to-list 'initial-frame-alist '(fullscreen . maximized))
(add-to-list 'default-frame-alist '(fullscreen . fullheight))

;; Set global keys for better experience
(global-set-key (kbd "C-c a") #'org-agenda)
(global-set-key (kbd "C-c c") #'org-capture)
(global-set-key (kbd "C-c j") #'org-journal-new-entry)
(global-set-key (kbd "C-c l") #'org-store-link)

;; org-tempo
(require 'org-tempo)

;; ---------- org-mobile ----------
;; https://orgmode.org/manual/Org-Mobile.html

(setq org-mobile-directory "~/Library/Mobile Documents/iCloud~com~mobileorg~mobileorg/Documents")

(setq org-mobile-inbox-for-pull org-default-notes-file)

;; ---------- org-todo ----------

;; https://orgmode.org/manual/Tracking-TODO-state-changes.html
(setq org-todo-keywords
      '((sequence "TODO(t)" "NEXT(n)" "STARTED(s!/!)" "WAIT(w@/!)"
		  "|" "CANCELLED(c@/!)" "DONE(d!/!)")))

;; Log state changes to LOGBOOK drawer
(setq org-log-into-drawer t)

;; ---------- org-agenda ----------

(setq org-agenda-files
      '(
	"~/org/"
	"~/org/memacs/"
	"~/org/migrated/"
	))

(setq org-agenda-custom-commands
   '(("n" "Agenda and all TODOs"
      ((agenda "" nil)
       (alltodo "" nil))
      nil)
     ("w" "WAITING" alltodo "" nil)))

(setq org-agenda-include-diary t)

;; Hide entries based on time in global todo list
(setq org-agenda-todo-ignore-time-comparison-use-seconds t)

;; Hide entries with future scheduled date from global todo list
(setq org-agenda-todo-ignore-scheduled 'future)

;; Hide entries with future deadlines from global todo list
(setq org-agenda-todo-ignore-deadlines 'future)

;; Honor hidden todos when filtering with tags
(setq org-agenda-tags-todo-honor-ignore-options t)

;; ---------- org-refile ----------

(setq org-refile-targets '((nil :maxlevel . 9)
			   (org-agenda-files :maxlevel . 9)))
(setq org-refile-use-outline-path 'file)

;; ---------- org-contacts ----------

(setq org-contacts-files '("~/org/contacts.org"))
(require' org-contacts)

;; ---------- org-capture ----------

(setq org-capture-templates
      '(
	("t" "todo" entry (file org-default-notes-file)
	 "* TODO %?\n:PROPERTIES:\n:CREATED: %U\n:END:\n%a\n" :empty-lines 1)

	("b" "Bookmark" entry (file+headline "~/org/notes.org" "Bookmarks")
	 "* %?\n:PROPERTIES:\n:CREATED: %U\n:END:\n\n" :empty-lines 1)

	("c" "Contacts" entry (file "~/org/contacts.org")
	 "* %(org-contacts-template-name)
:PROPERTIES:
:EMAIL: %(org-contacts-template-email)
:END:")
	))

;; Store backups and auto-saved files in TEMPORARY-FILE-DIRECTORY
;; (which defaults to /tmp on Unix),;; instead of in the same
;; directory as the file. This means we're still making backups, but
;; not where they'll get in the way.

;; WARNING: on most Unix-like systems /tmp is volatile, in-memory
;; storage, so your backups won't survive if your computer crashes!
;; If you're not willing to take this risk, you shouldn't enable this
;; setting.

(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; Create ID in interactive (C-c l)
(setq org-id-link-to-org-use-id 'create-if-interactive)

;; Call DELETE-TRAILING-WHITESPACE every time a buffer is saved.
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; If you save a file that doesn't end with a newline, automatically
;; append one.
(setq require-final-newline t)

;; If some text is selected, and you type some text, delete the
;; selected text and start inserting your typed text.
(delete-selection-mode t)

;; Ask if you're sure that you want to close Emacs.
(setq confirm-kill-emacs 'y-or-n-p)

;; Don't ask `yes/no?', ask `y/n?'.
(fset 'yes-or-no-p 'y-or-n-p)

;; Don't present the usual startup message, and clear the scratch
;; buffer."
(setq inhibit-startup-message t)
(setq initial-scratch-message nil)

;; Turn on syntax highlighting whenever possible.
(global-font-lock-mode t)

;; Visually indicate matching pairs of parentheses.
(show-paren-mode t)
(setq show-paren-delay 0.0)

;; When you perform a problematic operation, flash the screen instead
;; of ringing the terminal bell.
(setq visible-bell t)

;; "When you double-click on a file in the Mac Finder open it as a
;; buffer in the existing Emacs frame, rather than creating a new
;; frame just for that file.
;; (setq ns-pop-up-frames nil)

;; Solarized theme
;;
;; Don't change size of org-mode headlines (but keep other size-changes)
(setq solarized-scale-org-headlines nil)
;; Don't change the font for some headings and titles
(setq solarized-use-variable-pitch nil)

;; -----------------------------------------------------------------

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(solarized-dark))
 '(custom-safe-themes
   '("4c56af497ddf0e30f65a7232a8ee21b3d62a8c332c6b268c81e9ea99b11da0d3" "fee7287586b17efbfda432f05539b58e86e059e78006ce9237b8732fde991b4c" "b60b55ecd22db6cf1072d72532cbc87174edd81c18419962deb4b8ba48f6b49d" default))
 '(org-agenda-files
   '("~/org/memacs/ingbank.org" "/Users/robert/org/inbox.org" "/Users/robert/org/memacs/lastfm.org")))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t nil))))
