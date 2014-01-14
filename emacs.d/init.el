; Set to reload the last session
; use --no-desktop to disable
(desktop-save-mode 1)

; Automatically wrap long lines
(add-hook 'text-mode-hook 'turn-on-auto-fill)


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
          '(powerline)
          '(markdown-mode auctex ag magit) 
          '(auto-complete autopair)
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
(color-theme-tomorrow)

; Make status bar nicer
(require 'powerline)
(powerline-default-theme)


(require 'magit)
(require 'auto-complete)

;Python stuff
(require 'autopair)
(require 'python-mode)
(add-to-list 'auto-mode-alist '("\\.py$" . python-mode))
(add-hook 'python-mode-hook 'autopair-mode)


;Whitespace
(setq show-trailing-whitespace t)

; IDO is apparently essential - 'interactively do things'
;(require 'ido)
;(ido-mode t)
