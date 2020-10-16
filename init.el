;;; .emacs --- starts here
;;; Commentary:
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;;; Code:
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)
(setq-default tab-width 4)
(setq tab-stop-list (number-sequence 4 120 4))
(global-linum-mode t)
(delete-selection-mode 1)
(menu-bar-mode -1)
(tool-bar-mode -1)
(require 'auto-complete)
(ac-config-default)
(global-auto-complete-mode t)
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(setq-default right-fringe-width  5)
(require 'smartparens-config)
(smartparens-global-mode 1)
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.vue\\'" . web-mode))
(put 'upcase-region 'disabled nil)
(put 'scroll-left 'disabled nil)
(put 'narrow-to-region 'disabled nil)
(put 'narrow-to-page 'disabled nil)
(setq column-number-mode t)
(display-time-mode 1)
(global-set-key (kbd "M-p") 'ace-window)
(defvar aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
;; Buffer clear
(put 'erase-buffer 'disabled nil)
(global-set-key (kbd "C-x <deletechar>") 'erase-buffer)
(global-flycheck-mode)
;; Helm
(require 'helm)
(global-set-key (kbd "M-i") 'helm-swoop)
(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)
(global-set-key (kbd "C-x b") 'helm-buffers-list)
(global-set-key (kbd "C-x r b") 'helm-bookmarks)
(global-set-key (kbd "C-x m") 'helm-M-x)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
;; Rename files
(defun rename-this-buffer-and-file ()
 "Renames current buffer and file it is visiting."
 (interactive)
 (let ((name (buffer-name))
       (filename (buffer-file-name)))
   (if (not (and filename (file-exists-p filename)))
       (error "Buffer '%s' is not visiting a file!" name)
     (let ((new-name (read-file-name "New name: " filename)))
       (cond ((get-buffer new-name)
              (error "A buffer named '%s' already exists!" new-name))
             (t
              (rename-file filename new-name 1)
              (rename-buffer new-name)
              (set-visited-file-name new-name)
              (set-buffer-modified-p nil)
              (message "File '%s' successfully renamed to '%s'" name (file-name-nondirectory new-name))))))))(global-set-key (kbd "C-c r") 'rename-this-buffer-and-file)
;; adjust indents for web-mode to 2 spaces
(defun my-web-mode-hook ()
  "Hooks for Web mode.  Adjust indent."
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2))
(add-hook 'web-mode-hook  'my-web-mode-hook)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(dracula))
 '(custom-safe-themes
   '("24714e2cb4a9d6ec1335de295966906474fdb668429549416ed8636196cb1441" default))
 '(package-selected-packages
   '(helm flycheck ace-window web-mode smartparens auto-complete dracula-theme)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
;;; .emacs ends here
