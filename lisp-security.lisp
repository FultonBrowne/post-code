(defpackage :simpledata
  (:use :common-lisp)
  (:export :shared-data)
  )
(in-package :simpledata) ;; Create and enter a package
(defvar shared-data "Hello :P")
(defvar password "1234567890qwerty") ;; define some variables
(in-package :cl-user)
;; We're back in the main env
;; We can access simpledata:shared-data
;; We can't access simpledata:nuclear-codes
;; without changing package context....
(defpackage :untrusted
  (:use :common-lisp)
  (:export :spawn))
(in-package :untrusted)
(defun spawn ()
  (print simpledata:shared-data)
  (in-package :simpledata)
  (print password))
(in-package :cl-user)
(untrusted:spawn);; The code can't switch context in a function so it crashes

;; What about restrecting access to specific functions, say the load function
(defpackage :virus
  (:use :common-lisp)
  (:export :spawn)
  )
(in-package :virus)
(defun spawn ()
  (load "./virus.lisp")

(in-package :cl-user)
(virus:spawn) ;; you can use functions like (load) and (compile-file) to do bad things
;;https://github.com/kanru/cl-isolated offers a solution
(ql:quickload "isolated")
(isolated:read-eval-print "(load ./virus.lisp)") ;; Now the propgram can't access scary functions
