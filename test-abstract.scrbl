#lang classicthesis

I present the design of a parser that adds Scheme-style language extensibility
to languages with implicitly delimited and infix syntax. A key element of my design is an
@italic{enforestation} parsing step, which converts a flat stream of tokens into
an S-expression-like tree, in addition to the initial ``read'' phase of parsing
and interleaved with the ``macro-expand'' phase.

My parser uses standard lexical scoping rules to communicate syntactic
extensions to the parser. In this way extensions naturally compose locally as
well as through module boundaries. I argue that this style of communication is
better suited towards a useful extension system than tools not directly
integrated with the compiler.

This dissertation explores the limits of this design in a new language called
Honu. I use the extensiblity provided by Honu to develop useful language
extensions such as LINQ and a parser generator. I also demonstrate the
generality of the parsing techniques by applying them to Java and Python.
