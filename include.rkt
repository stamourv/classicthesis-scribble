#lang racket/base

;; #lang classicthesis/include
;; Allows splitting documents into files without constraining file bodies to
;; be sections (or `part`s in Scribble parlance). Allows to, e.g., thesis
;; chapters to be included.
;; Could potentially be useful as part of scribble proper, or as its own
;; package.

(require (except-in classicthesis/lang #%module-begin)
         (for-syntax racket/base syntax/kerncase))

(provide (all-from-out classicthesis/lang)
         (rename-out [module-begin #%module-begin]))

;; A list of content/element/whatever is a fine content/element/whatever.
;; So just take all the pieces that are in the file, and put them together.
;; Then, `include-section` can just take all of it an insert it.
(define-syntax (module-begin stx)
  (syntax-case stx ()
    [(_ id . body)
     (let-values ([(expressions non-expressions) (filter-expressions #'body)])
       #`(#%module-begin
          #,@non-expressions
          (define id (list #,@expressions))
          (provide id)))]))

;; mostly taken from by scribble/doclang's doc-begin
;; returns: (values expressions non-expressions)
(define-for-syntax (filter-expressions body)
  (define-values (rev-expressions rev-non-expressions)
    (for/fold ([rev-expressions     '()]
               [rev-non-expressions '()])
        ([stx (syntax->list body)])
      (define expanded
        (local-expand
         stx 'module
         (append (kernel-form-identifier-list)
                 (syntax->list #'(provide
                                  require)))))
      (syntax-case expanded (begin)
        [(begin body1 ...)
         (let-values ([(expressions non-expressions)
                       (filter-expressions #'(body1 ...))])
           ;; we reverse what we just put in the right order. oh well.
           (values (append (reverse expressions)     rev-expressions)
                   (append (reverse non-expressions) rev-non-expressions)))]
        [(id . rest)
         (and (identifier? #'id)
              (ormap (lambda (kw) (free-identifier=? #'id kw))
                     (syntax->list #'(require
                                      provide
                                      define-values
                                      define-syntaxes
                                      begin-for-syntax
                                      module
                                      module*
                                      #%require
                                      #%provide
                                      #%declare))))
         (values rev-expressions
                 (cons stx rev-non-expressions))]
        [else
         (values (cons stx rev-expressions)
                 rev-non-expressions)])))
  (values (reverse rev-expressions) (reverse rev-non-expressions)))
