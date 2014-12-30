#lang classicthesis

@title{Syntactic Extension for Languages with Implicitly Delimited and Infix Syntax}
@author{Jon Rafkind}
@degree{Doctor of Philosophy}
@department{School of Computing}
@university{University of Utah}
@location{Salt Lake City, Utah}
@submit-date{May 2013}

@approval{testapproval.pdf}

@abstract{
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
}

@acknowledgements{
First and foremost, I owe a debt of gratitude to my advisor, Matthias
 Felleisen, who saw a PhD student in me and gave me a chance when I did not
 deserve one. Of course, this is unsurprising for someone who has been a
 visionary leader in the field for the past three decades. As a mentor,
 Matthias goes above and beyond the call of duty when teaching his students
 about the art of research. Most remarkably, he does so in the most selfless
 manner possible, readily accepting blame for students' failures but eagerly
 bestowing credit for successes. I am privileged to have worked with such an
 extraordinary person.

Also, this dissertation would not exist if not for the support I received from
 the Northeastern PRL group. The first question that a visiting prospective
 student always asks is, ``what separates Northeastern's PL program from the
 others?'' The unequivocal answer is the collaborative nature of its
 members. If someone is working towards a paper deadline, everyone else is
 reading drafts. If another lab member is preparing a talk, everyone else drops
 what they are doing and ``tortures'' the talk until it's ready. In no
 particular order, thanks to Asumu Takikawa, Vincent St-Amour, Ian Johnson,
 Jonathan Schuster, Christos Dimoulas, Dan Brown, Aaron Turon, Zane Shelby,
 Tony Garnock-Jones, Stevie Strickland, Carl Eastlund, Sam Tobin-Hochstadt,
 David Van Horn, Eli Barzilay, Phillip Mates, Billy Bowman, Jamie Perconti,
 Jesse Tov, Justin Slepak, Claire Alvis, Bryan Chadwick, Ryan Culpepper, Felix
 Klock, Erik Silkensen, Paul Stansifer, Ahmed Abdelmeged, Dimitris Vardoulakis,
 Mitch Wand, Olin Shivers, Amal Ahmed, Will Clinger, Riccardo Pucella, and
 Viera Proulx.

Thanks to my coauthors, David Van Horn, John Clements, and Eli Barzilay, for
guidance and patience while I learned how to write a research paper. Thanks to
my thesis committee, Amal Ahmed, David Van Horn, Eli Barzilay, and Greg
Morrisett, who provided lots of helpful feedback on my ideas. Thanks to Greg
Morrisett and Norman Ramsey, whose courses introduced me to the exciting world
of programming language research.

Thanks to my parents, who are my heroes and have always supported me no matter
what. If I can achieve a mere fraction of what they have accomplished, then my
life can be considered a success.

Finally, thanks to my family Jen, Stella, and Evan. Jen, thanks for being my
inspiration and for making me strive to be a better person in all aspects of
life. Stella and Evan, thanks for providing meaning and purpose in life, in a
way that I previously did not know was possible. I love you all.
}
