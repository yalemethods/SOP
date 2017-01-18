CHAPTERS = $(shell cat chapters.txt)
CHAPTER_ALL = $(addprefix all-,$(CHAPTERS))
CHAPTER_SOURCE = $(addprefix source-,$(CHAPTERS))
CHAPTER_HTML = $(addprefix html-,$(CHAPTERS))
CHAPTER_PDF = $(addprefix pdf-,$(CHAPTERS))

.PHONY : clean all source html pdf $(CHAPTER_SOURCE) $(CHAPTER_HTML) $(CHAPTER_PDF)

# Make all

all : source html pdf

$(CHAPTER_ALL) : all-% : source-% html-% pdf-%


# Make sources

source : $(CHAPTER_SOURCE)

$(CHAPTER_SOURCE) : source-% : %/assets %/source.md %/bibliography.bib

%/assets : %
	cd $< && $(MAKE) assets

%/source.md : %
	cd $< && $(MAKE) source.md

%/bibliography.bib : %
	cd $< && $(MAKE) bibliography.bib


# Make html

html : $(CHAPTER_HTML)

$(CHAPTER_HTML) : html-% : bin/html/% bin/html/%.html

bin/html/% : %/assets bin/html
	cp -R $< $@

bin/html/%.html : bin/html %/source.md %/bibliography.bib
	pandoc -s --mathjax --filter pandoc-citeproc --bibliography $(*F)/bibliography.bib $(*F)/source.md -o $@

bin/html :
	mkdir -p bin/html


# Make pdf

pdf : $(CHAPTER_PDF)

$(CHAPTER_PDF) : pdf-% : bin/pdf/%.pdf bin/tex/% bin/tex/%.tex bin/tex/%.bib

bin/pdf/%.pdf : bin/pdf bin/tex/% bin/tex/%.tex bin/tex/%.bib
	if [ -s bin/tex/$(*F).bib ]; then \
		cd bin/tex && pdflatex $(*F) && bibtex $(*F); \
	fi
	cd bin/tex && pdflatex $(*F) && pdflatex $(*F)
	cp -R bin/tex/$(*F).pdf $@

bin/tex/% : %/assets bin/tex
	cp -R $< $@

bin/tex/%.tex : bin/tex/%.md bin/tex/%.bib
	if [ -s bin/tex/$(*F).bib ]; then \
		cd bin/tex && pandoc -s --listings --natbib --filter pandoc-citeproc --bibliography $(*F).bib $(*F).md -o $(*F).tex; \
	else \
		cd bin/tex && pandoc -s --listings $(*F).md -o $(*F).tex; \
	fi

bin/tex/%.md : %/source.md bin/tex
	cp -R $< $@

bin/tex/%.bib : %/bibliography.bib bin/tex
	cp -R $< $@

bin/pdf :
	mkdir -p bin/pdf

bin/tex :
	mkdir -p bin/tex


# Clean

clean :
	rm -rf bin
