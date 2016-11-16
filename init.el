(setq-default tab-width 4) 
(setq tab-stop-list (number-sequence 4 120 4))
(setq-default indent-tabs-mode nil)
(global-set-key (kbd "TAB") 'self-insert-command)
(setq c-basic-offset 4)
(setq c-basic-indent 4)
(setq python-indent 4)
(setq php-indent-level 4)
(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list
   'package-archives
   '("melpa" . "http://melpa.org/packages/")
   t)
  (package-initialize))
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(load-theme 'dracula t)
(global-linum-mode t)
(delete-selection-mode 1)
(require 'sass-mode)
(add-to-list 'auto-mode-alist '("\\.scss\\'" . sass-mode))
(require 'less-css-mode)
(add-to-list 'auto-mode-alist '("\\.less\\'" . less-css-mode))
(global-flycheck-mode)
(require 'auto-complete)
(global-auto-complete-mode t)
(add-to-list 'load-path "~/emacs.d/emmet-mode")
(require 'emmet-mode)
(require 'smartparens-config)
(add-hook 'js-mode-hook #'smartparens-mode)
(set-face-attribute 'default nil :height 105)
(menu-bar-mode -1)
(tool-bar-mode -1)
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(setq-default right-fringe-width  5)
(add-hook 'js-mode-hook 'js2-minor-mode)
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(put 'upcase-region 'disabled nil)
(put 'scroll-left 'disabled nil)
(put 'narrow-to-region 'disabled nil)
(put 'narrow-to-page 'disabled nil)
(setq column-number-mode t)
(display-time-mode 1)
(global-set-key (kbd "M-p") 'ace-window)
(setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
(put 'erase-buffer 'disabled nil)
(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/"))
(package-initialize)
(custom-set-variables
 '(markdown-command "pandoc"))
(global-set-key (kbd "C-x <deletechar>") 'erase-buffer)
;;Set up Typescript mode
(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  ;; company is an optional dependency. You have to
  ;; install it separately via package-install
  ;; `M-x package-install [ret] company`
  (company-mode +1))

;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)

;; formats the buffer before saving
(add-hook 'before-save-hook 'tide-format-before-save)

(add-hook 'typescript-mode-hook #'setup-tide-mode)

;; format options
(setq tide-format-options '(:insertSpaceAfterFunctionKeywordForAnonymousFunctions t :placeOpenBraceOnNewLineForFunctions nil))


(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))
(add-hook 'web-mode-hook
          (lambda ()
            (when (string-equal "tsx" (file-name-extension buffer-file-name))
              (setup-tide-mode))))

(add-hook 'js2-mode-hook #'setup-tide-mode)

(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.jsx\\'" . web-mode))
(add-hook 'web-mode-hook
          (lambda ()
            (when (string-equal "jsx" (file-name-extension buffer-file-name))
              (setup-tide-mode))))
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
;;Ess configuration
(require 'ess-site)
;;Helm Swoop
(global-set-key (kbd "M-i") 'helm-swoop)
;;Helm
(require 'helm)

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)

(global-set-key (kbd "C-x b") 'helm-buffers-list)
(global-set-key (kbd "C-x r b") 'helm-bookmarks)
(global-set-key (kbd "C-x m") 'helm-M-x)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-x C-f") 'helm-find-files)

;;; init.el ends here
