#lang racket/base

;; Mostly copied from scribble/sigplan/lang

(require scribble/doclang
         scribble/core
         scribble/base
         scribble/decode
         scribble/latex-prefix
         scribble/latex-properties
         racket/list
         scribble/private/defaults
         setup/collects
         (for-syntax scheme/base))
(provide (except-out (all-from-out scribble/doclang) #%module-begin)
         (all-from-out scribble/base)
         (rename-out [module-begin #%module-begin]))

(define-syntax (module-begin stx)
  (syntax-case stx ()
    [(_ id . body)
     #`(#%module-begin id post-process () . body)]))

(define document-class ;; from the example in the classicthesis package
  #<<FORMAT
\documentclass[ twoside,openright,titlepage,numbers=noenddot,headinclude,%1headlines,% letterpaper a4paper
                footinclude=true,cleardoublepage=empty,abstractoff, % <--- obsolete, remove (todo)
                BCOR=5mm,paper=a4,fontsize=11pt,%11pt,a4paper,%
                ngerman,american,%
                ]{scrreprt}
FORMAT
)

(define (post-process doc)
  (add-defaults doc
                (string->bytes/utf-8 document-class)
                (collection-file-path "style.tex" "classicthesis")
                (list (collection-file-path "classicthesis.sty"
                                            "classicthesis"))
                #f))

;; thesis command wrappers
;; taken from John Rafkind's uuthesis wrapper
(define-syntax-rule (define-wrappers (name style) ...)
  (begin
    (define (name . str)
      (make-element (make-style style '()) (decode-content str)))
    ...
    (provide name ...)))
(define-syntax-rule (define-pre-title-wrappers (name style) ...)
  (begin
    (define (name . str)
      (make-paragraph
       (make-style 'pretitle '())
       (make-multiarg-element
        (make-style style '())
        (decode-content str))))
    ...
    (provide name ...)))

(define-pre-title-wrappers
  (degree "Sdegree")
  (department "Sdepartment")
  (university "Suniversity")
  (location "Slocation")
  (submit-date "Ssubmitdate"))
(define-wrappers
  (approval "Sapproval")
  (abstract "Sabstract") ;; TODO include-abstract too
  (acknowledgements "Sacknowledgements") ;; TODO include-acknowledgements too
  )

;; TODO possible additions (supported by classicthesis)
;;  - subtitles
;;  - dedications
