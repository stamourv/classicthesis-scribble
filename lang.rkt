#lang at-exp racket/base

;; Mostly copied from scribble/sigplan/lang

(require scribble/doclang
         (except-in scribble/core part)
         (except-in scribble/base table-of-contents)
         scribble/decode
         scribble/latex-prefix
         scribble/latex-properties
         racket/list
         scribble/private/defaults
         setup/collects
         (for-syntax racket/base
                     syntax/parse))
(provide (except-out (all-from-out scribble/doclang) #%module-begin)
         (all-from-out scribble/base)
         (rename-out [module-begin #%module-begin]))

;; define keywords for #lang options
(define-syntax-rule (define-keywords k ...)
  (begin (define-syntax k (syntax-rules ())) ...
         (provide k) ...))

(define-keywords drafting parts nochapters linedheaders eulerchapternumbers
                 beramono eulermath pdfspacing minionprospacing
                 tocaligned dottedtoc manychapters)

(define-syntax (module-begin stx)
  (syntax-parse stx
    [(_ doc:id . body)
     ;; parse options like scribble/sigplan and similar languages
     ;; this doesn't need to be a hash (can be a set), but a hash lets us
     ;; have keywords with arguments like font sizing in the future
     (define options (make-hash))
     (let loop ([contents #'body])
       (syntax-parse contents
         [(ws . body)
          ;; stolen from scribble/sigplan
          #:when (and (string? (syntax-e #'ws))
                      (regexp-match? #rx"^ *$" (syntax-e #'ws)))
          (loop #'body)]
         [((~and kw (~or (~literal drafting)
                         (~literal parts)
                         (~literal nochapters)
                         (~literal linedheaders)
                         (~literal eulerchapternumbers)
                         (~literal beramono)
                         (~literal eulermath)
                         (~literal pdfspacing)
                         (~literal minionprospacing)
                         (~literal tocaligned)
                         (~literal dottedtoc)
                         (~literal manychapters)))
           . body)
          (hash-set! options
                     (identifier-binding-symbol #'kw)
                     #t)
          (loop #'body)]
         [body
          #`(#%module-begin doc (post-process #,options) () . body)]))]))

;; from the example in the classicthesis package, parameterized
;; with the options provided on the #lang line
(define (document-class options)
  @string-append{
    \documentclass[ twoside,openright,titlepage,numbers=noenddot,headinclude,%1headlines,% letterpaper a4paper
                    footinclude=true,cleardoublepage=empty,abstractoff, % <--- obsolete, remove (todo)
                    BCOR=5mm,paper=a4,fontsize=11pt,%11pt,a4paper,%
                    ngerman,american,%
                    @(apply string-append
                            (add-between (map symbol->string (hash-keys options))
                                         ","))]{scrreprt}
  })

(define ((post-process options) doc)
  (add-defaults doc
                (string->bytes/utf-8 (document-class options))
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

(define-syntax-rule (define-section-like name style)
  (begin
    (define (name #:tag [tag (symbol->string (gensym))] . str)
      (make-multiarg-element (make-style style '())
                             (list (decode-content (list tag))
                                   (decode-content str))))
    (provide name)))

(define-pre-title-wrappers
  (degree "Sdegree")
  (department "Sdepartment")
  (university "Suniversity")
  (location "Slocation")
  (submit-date "Ssubmitdate"))

(define-wrappers
  (approval "Sapproval")
  (abstract "Sabstract")
  (acknowledgements "Sacknowledgements")
  (table-of-contents "Stableofcontents")
  (part-ref "Sthesispartref")
  (Part-ref "SthesisPartref")
  (chapter-ref "Sthesischapterref")
  (Chapter-ref "SthesisChapterref")
  (end-front-matter "Sendfrontmatter")
  (graffito "graffito"))

(define-section-like part "Sthesispart")
(define-section-like chapter "Sthesischapter")

(define-syntax-rule (define-includer name style)
  (begin
    (define-syntax (name stx)
      (syntax-case stx ()
        [(_ module)
         (let ()
           (define name* (gensym 'name))
           #'(begin
               (require (rename-in module [doc name*]))
               (make-nested-flow (make-style style '(command))
                                 (part-blocks name*))))]))
    (provide name)))

(define-includer include-abstract "Sabstract")
(define-includer include-acknowledgements "Sacknowledgements")

;; TODO possible additions (supported by classicthesis)
;;  - subtitles
;;  - dedications
;;  - list of figures, tables, etc. (may require same trickery as for sections to get labels to agree)
