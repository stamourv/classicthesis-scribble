#lang classicthesis

@title{Syntactic Extension for Languages with Implicitly Delimited and Infix Syntax}
@author{Jon Rafkind}
@degree{Doctor of Philosophy}
@department{School of Computing}
@university{University of Utah}
@location{Salt Lake City, Utah}
@submit-date{May 2013}

@approval{testapproval.pdf}

@include-abstract{test-abstract.scrbl}

@; Needs to have a blank line between the include-abstract and it. Don't ask.
@; Failing to do so adds a `\noindent` which causes the acks to not show up.
@include-acknowledgements{test-acknowledgements.scrbl}

@table-of-contents{}
@end-front-matter{}


@(require scriblib/figure)

@part[#:tag "aaa-tag"]{AAA}

@chapter[#:tag "ab-tag"]{AB}

@section[#:tag "a-tag"]{A}

aaa

@partref{aaa-tag}
@Partref{aaa-tag}
@chapterref{ab-tag}
@Chapterref{ab-tag}
@secref{a-tag}
@Secref{a-tag}
@secref{cc-tag}
@Secref{cc-tag}


@figure["eh" "eh"]{ehh}

@figure-ref{eh}
@Figure-ref{eh}

@section{B}

bbb

@subsection{BA}
baaa
@subsection{BB}
bbbb

@chapter{b.5}
@section{b.5.1}
@section{b/5/3}

@part{CCC}
@chapter{ccc}
@section{C}
@section[#:tag "cc-tag"]{CC}

ccc

@require["test-bib.rkt"]
@cite[oka]
@cite[bagwell-lists]
@cite[bagwell-trie]

@gen-bib[]
