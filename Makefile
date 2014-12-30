all:
	scribble --latex test.scrbl
	rubber -d test.tex
	rubber -d test.tex
