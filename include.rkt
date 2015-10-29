#lang racket/base

;; #lang classicthesis/include
;; Allows splitting documents into files without constraining file bodies to
;; be sections (or `part`s in Scribble parlance). Allows to, e.g., thesis
;; chapters to be included.
;;
;; This is like scribble/doclang2 but exports all of the classicthesis bindings

(require (except-in classicthesis/lang #%module-begin)
         ;; re-use Scribble's doclang2 module-begin to sort everything
         ;; into a doc binding
         (rename-in scribble/doclang2 [#%module-begin mb]))

(provide (all-from-out classicthesis/lang)
         (rename-out [mb #%module-begin]))
