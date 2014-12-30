all:
	scribble --latex test.scrbl
	rubber -d test.tex
