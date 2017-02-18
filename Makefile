CHAPTERS = $(shell cat chapters.txt)
CHAPTER_ALL = $(addprefix all-,$(CHAPTERS))
CHAPTER_MD = $(addprefix md-,$(CHAPTERS))
CHAPTER_HTML = $(addprefix html-,$(CHAPTERS))
CHAPTER_PDF = $(addprefix pdf-,$(CHAPTERS))

.PHONY : clean all md html pdf $(CHAPTER_ALL) $(CHAPTER_MD) $(CHAPTER_HTML) $(CHAPTER_PDF)


# Make all

all : md html pdf

$(CHAPTER_ALL) : all-% : md-% html-% pdf-%


# Make Markdown

md : $(CHAPTER_MD)

$(CHAPTER_MD) : md-% : bin/md/% bin/md/%.md bin/md/%.bib

bin/md/% : % bin/md
	cd $< && $(MAKE) assets
	cp -R $(<)/$(<) $@

bin/md/%.md : % bin/md
	cd $< && $(MAKE) source
	pandoc $(<)/$(<).md -o $@

bin/md/%.bib : % bin/md
	cd $< && $(MAKE) bibliography
	cp -R $(<)/$(<).bib $@

bin/md :
	mkdir -p bin/md


# Make html

html : $(CHAPTER_HTML)

$(CHAPTER_HTML) : html-% : bin/html/% bin/html/%.html

bin/html/% : bin/md/% bin/html
	cp -R $< $@

bin/html/%.html : bin/html bin/md/%.md bin/md/%.bib
	pandoc -s --mathjax --filter pandoc-citeproc --bibliography bin/md/$(*F).bib bin/md/$(*F).md -o $@

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

bin/tex/% : bin/md/% bin/tex
	cp -R $< $@

bin/tex/%.tex : bin/tex/%.md bin/tex/%.bib
	if [ -s bin/tex/$(*F).bib ]; then \
		cd bin/tex && pandoc -s --listings --natbib --filter pandoc-citeproc --bibliography $(*F).bib $(*F).md -o $(*F).tex; \
	else \
		cd bin/tex && pandoc -s --listings $(*F).md -o $(*F).tex; \
	fi

bin/tex/%.md : bin/md/%.md bin/tex
	cp -R $< $@

bin/tex/%.bib : bin/md/%.bib bin/tex
	cp -R $< $@

bin/pdf :
	mkdir -p bin/pdf

bin/tex :
	mkdir -p bin/tex


# Clean

clean :
	rm -rf bin
