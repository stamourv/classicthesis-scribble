#lang at-exp racket

(require scriblib/autobib scribble/core (only-in scribble/manual emph)
         scribble/decode scribble/base)

(provide (all-defined-out))

(define-cite cite citet gen-bib)

(define bagwell (author-name "Phil" "Bagwell"))
(define okasaki (author-name "Chris" "Okasaki"))

(define oka
  (make-bib #:title "Purely Functional Data Structures"
            #:is-book? #t
            #:author okasaki
            #:location (book-location #:publisher "Cambridge University Press")
            #:date "1998"))
(define bagwell-lists
  (make-bib #:title "Fast Functional Lists, Hash-Lists, Deques and Variable Length Arrays"
            #:is-book? #f
            #:author bagwell
            #:location "In Implementation of Functional Languages, 14th International Workshop"
            #:date "2002"))
(define bagwell-trie
  (make-bib  #:title "Fast And Space Efficient Trie Searches"
             #:is-book? #f
             #:author bagwell
             #:location "Technical report, 2000/334, Ecole Polytechnique  F´ed´erale de Lausanne"
             #:date "2000"))
