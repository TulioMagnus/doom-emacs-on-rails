;;; company.el --- Company                           -*- lexical-binding: t; -*-

;; Copyright (C) 2020  John Doe

;; Keywords: autocomplete, company

;; C-p when company is active
(map! :after company
      :map company-active-map
      "C-S-p" #'+company/dabbrev
      "C-p" #'dabbrev-expand)

(defun current-mode-company-mode ()
  (interactive)
  (when-let (backend (nth 1 company-backends))
    (company-begin-backend (nth 1 company-backends))))

(map! :i "<C-return>" #'yas-expand)
(map! :i "C-p" #'dabbrev-expand)
(map! :i "C-S-p" #'+company/dabbrev)
(map! :i :mode ruby-mode-map "C-i" #'current-mode-company-mode)

(map! :after company
      :map company-active-map
      "<tab>" #'company-complete-selection
      "RET" nil
      "<return>" nil
      "C-i" #'current-mode-company-mode
      "<C-return>" #'yas-expand)

(after! company
  (setq company-dabbrev-downcase 0)
  (setq company-show-numbers t)
  (setq company-idle-delay 0.14))

(defun yas-next-and-close-company ()
  (interactive)
  (company-abort)
  (yas-next-field))

(map! :after yasnippet
      :map yas-keymap
      "<tab>" #'company-complete-selection
      "<C-S-return>" 'yas-prev-field
      "<C-return>" 'yas-next-and-close-company)

(use-package! company-tabnine)

(after! robe
  (set-company-backend! 'ruby-mode 'company-tabnine 'company-capf 'company-dabbrev-code 'company-yasnippet))

(after! inf-ruby
  (set-company-backend! 'inf-ruby-mode 'compay-tabnine 'company-dabbrev-code 'company-capf 'company-yasnippet))

(after! tide
  (set-company-backend! 'js2-mode 'company-tabnine 'company-tide 'company-capf 'company-dabbrev-code 'company-yasnippet))

(add-hook! 'lsp-completion-mode-hook
  (defun init-company-dabbrev-code-h ()
    (when lsp-completion-mode
      (setq-local company-backends (cons 'company-tabnine company-backends)))))
