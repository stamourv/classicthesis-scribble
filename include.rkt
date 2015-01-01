#lang racket/base

;; #lang classicthesis/include
;; Allows splitting documents into files without constraining file bodies to
;; be sections (or `part`s in Scribble parlance). Allows to, e.g., thesis
;; chapters to be included.
;; Could potentially be useful as part of scribble proper, or as its own
;; package.

(require (except-in classicthesis/lang #%module-begin)
         (for-syntax racket/base))

(provide (all-from-out classicthesis/lang)
         (rename-out [module-begin #%module-begin]))

;; A list of content/element/whatever is a fine content/element/whatever.
;; So just take all the pieces that are in the file, and put them together.
;; Then, `include-section` can just take all of it an insert it.
;; TODO doesn't support definitions, requires, provides, etc. filter those
(define-syntax-rule (module-begin id . body)
  (#%module-begin
   (define id (list . body))
   (provide id)))
