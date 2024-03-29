;Strip things down a bit:
;(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
;(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

; Set to reload the last session
; use --no-desktop to disable
;(desktop-save-mode 1)

; Enable org mode
(require 'org)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)

; Disable the really annoying beeps when you scroll too far...
(setq visible-bell 1)

; Automatically wrap long lines
(add-hook 'text-mode-hook 'turn-on-auto-fill)

;El-get is a bit like Vundle
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

(setq el-get-user-package-directory "~/.emacs.d/el-get-user/init/")
(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user/recipes/")

(el-get 'sync)

(setq my-packages
  (append '(color-theme tomorrow-theme solarized-theme)
          '(markdown-mode auctex ag magit) 
          '(auto-complete autopair evil )
          '(exec-path-from-shell python-mode)
      ))

(el-get 'sync my-packages)

; We want the same PATH as in the shell
(when (memq window-system '(mac ns))
    (exec-path-from-shell-initialize))

; LaTeX and AucTex
; note the British spell checker might need to be disabled for code
(setq-default TeX-master nil)
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq TeX-PDF-mode t)
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(autoload 'flyspell-mode "flyspell" "On-the-fly spelling checker." t)
(setq ispell-dictionary "british")
(setq ispell-list-command "--list")

(require 'color-theme-solarized)
(require 'color-theme-tomorrow)
(color-theme-solarized-light)

; Make the editor vim like
(require 'evil)
(evil-mode 1)

; A couple of niceties
(require 'magit)
(require 'auto-complete)

;Python stuff
(require 'autopair)
(require 'python-mode)
(add-to-list 'auto-mode-alist '("\\.py$" . python-mode))
(add-hook 'python-mode-hook 'autopair-mode)

; Haskell
(require 'haskell-mode)
(define-key haskell-mode-map (kbd "C-c C-l") 'haskell-process-load-or-reload)
(define-key haskell-mode-map (kbd "C-`") 'haskell-interactive-bring)
(define-key haskell-mode-map (kbd "C-c C-t") 'haskell-process-do-type)
(define-key haskell-mode-map (kbd "C-c C-i") 'haskell-process-do-info)
(define-key haskell-mode-map (kbd "C-c C-c") 'haskell-process-cabal-build)
(define-key haskell-mode-map (kbd "C-c C-k") 'haskell-interactive-mode-clear)
(define-key haskell-mode-map (kbd "C-c c") 'haskell-process-cabal)
(define-key haskell-mode-map (kbd "SPC") 'haskell-mode-contextual-space)

;Whitespace
(setq show-trailing-whitespace t)

; IDO is apparently essential - 'interactively do things'
(when (> emacs-major-version 21)
  (require 'ido)
  (ido-mode t)
  (setq ido-enable-prefix nil
        ido-enable-flex-matching t
        ido-create-new-buffer 'always
        ido-use-filename-at-point t
        ido-max-prospects 10))
