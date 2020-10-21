;;; company.el --- Company                           -*- lexical-binding: t; -*-

;; Copyright (C) 2020  John Doe

;; Keywords: autocomplete, company

;; C-p when company is active
(map! :after company
      :map company-active-map
      "C-S-p" #'+company/dabbrev
      "C-p" #'dabbrev-expand)

(map! :i "<C-return>" #'yas-expand)
(map! :i "C-p" #'dabbrev-expand)
(map! :i "C-S-p" #'+company/dabbrev)

(map! :after company
      :map company-active-map
      "<C-return>" #'yas-expand)

(after! company
  (setq company-dabbrev-downcase 0)
  (setq company-idle-delay 0.1))

(defun yas-next-and-close-company ()
  (interactive)
  (company-abort)
  (yas-next-field))

(map! :after yasnippet
      :map yas-keymap
      "<C-S-return>" 'yas-prev-field
      "<C-return>" 'yas-next-and-close-company)
