.PHONY : clean

source.md: text.tex
	pandoc text.tex -o source.md

assets: example-latex
	cp -R example-latex assets

clean :
	rm -rf assets source.md
