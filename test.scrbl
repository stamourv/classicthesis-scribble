#lang classicthesis @parts @pdfspacing

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

@part[#:tag "aaa-tag"
      #:preamble
      @elem{An extra informational blurb on this part. It will display
            under the part heading.}]{AAA}

@chapter[#:tag "ab-tag"]{AB}

@subsection[#:tag "a-tag"]{A}

aaa

@graffito{A margin note}

@part-ref{aaa-tag}
@Part-ref{aaa-tag}
@chapter-ref{ab-tag}
@Chapter-ref{ab-tag}
@secref{a-tag}
@Secref{a-tag}
@secref{cc-tag}
@Secref{cc-tag}


@figure["eh" "eh"]{ehh}
@figure*["eh2" "eh2"]{ehh2}

@figure-ref{eh}
@Figure-ref{eh2}

@(require (only-in scribble/manual racketblock))

@racketblock[(+ 2 2)]

@subsection{B}

bbb

@subsubsection{BA}
baaa
@subsubsection{BB}
bbbb

@chapter{b.5}
@subsection{b.5.1}
@subsection{b/5/3}

@include-part{test-part.scrbl}

@require["test-bib.rkt"]
@cite[oka]
@cite[bagwell-lists]
@cite[bagwell-trie]

@gen-bib[]
