CHAPTERS = $(shell cat chapters.txt)
CHAPTER_ALL = $(addprefix all-,$(CHAPTERS))
CHAPTER_PDF = $(addprefix pdf-,$(CHAPTERS))
CHAPTER_HTML = $(addprefix html-,$(CHAPTERS))
CHAPTER_TEXFRAG = $(addprefix texfrag-,$(CHAPTERS))
CHAPTER_MD = $(addprefix md-,$(CHAPTERS))

.PHONY: all \
        clean \
        pdf \
        pdfsoc \
        pdfchapters \
        html \
        texfrag \
        md \
        $(CHAPTER_ALL) \
        $(CHAPTER_PDF) \
        $(CHAPTER_HTML) \
        $(CHAPTER_TEXFRAG) \
        $(CHAPTER_MD)


# Main targets

all: html pdf

clean:
	rm -rf bin

pdf: bin/soc.pdf

pdfchapters: $(CHAPTER_PDF)

html: $(CHAPTER_HTML)

texfrag: $(CHAPTER_TEXFRAG)

md: $(CHAPTER_MD)


# Chapter targets

$(CHAPTER_ALL): all-% : html-% pdf-%

$(CHAPTER_PDF): pdf-% : bin/pdf-chapters/%.pdf

$(CHAPTER_HTML): html-% : bin/html/% bin/html/%.html

$(CHAPTER_TEXFRAG): texfrag-% : bin/tex/% bin/tex/%-frag.tex bin/tex/%.bib

$(CHAPTER_MD): md-% : bin/md/% bin/md/%.md bin/md/%.bib


# PDF main target

bin/soc.pdf: bin/tex/soc.tex bin/tex/preamble.tex $(CHAPTER_TEXFRAG)
	cd bin/tex && pdflatex soc
	cd bin/tex && for ch in $(CHAPTERS); do \
		if [ -s $${ch}.bib ]; then \
			bibtex $${ch}-frag.aux; \
		fi \
	done
	cd bin/tex && pdflatex soc && pdflatex soc
	cp -R bin/tex/soc.pdf bin/soc.pdf


# PDF chapters targets

bin/pdf-chapters/%.pdf: bin/tex/preamble.tex bin/tex/% bin/tex/%-chap.tex bin/tex/%-frag.tex bin/tex/%.bib
	if [ -s bin/tex/$(*F).bib ]; then \
		cd bin/tex && pdflatex $(*F)-chap && bibtex $(*F)-chap; \
	fi
	cd bin/tex && pdflatex $(*F)-chap && pdflatex $(*F)-chap
	mkdir -p bin/pdf-chapters
	cp -R bin/tex/$(*F)-chap.pdf $@


# HTML targets

bin/html/%.html: bin/md/%.md bin/md/%.bib
	mkdir -p bin/html
	pandoc -s --mathjax --filter pandoc-citeproc --bibliography bin/md/$(*F).bib bin/md/$(*F).md -o $@

bin/html/%: bin/md/%
	mkdir -p bin/html
	cp -R $< $@


# TeX targets

bin/tex/preamble.tex: templates/pdf/preamble.tex
	mkdir -p bin/tex
	cp $< $@

bin/tex/soc.tex: chapters.txt templates/pdf/soc-header.tex templates/pdf/footer.tex
	mkdir -p bin/tex
	echo "\\\\input{preamble.tex}\n\n" > bin/tex/soc.tex
	cat templates/pdf/soc-header.tex >> bin/tex/soc.tex
	for ch in $(CHAPTERS); do \
		echo "\\\\include{$$ch-frag}\n\n" >> bin/tex/soc.tex; \
	done
	cat templates/pdf/footer.tex >> bin/tex/soc.tex

bin/tex/%-chap.tex: templates/pdf/chapter-header.tex templates/pdf/footer.tex
	mkdir -p bin/tex
	echo "\\\\input{preamble.tex}\n\n" > $@
	cat templates/pdf/chapter-header.tex >> $@
	echo "\\\\include{$(*F)-frag}\n\n" >> $@
	cat templates/pdf/footer.tex >> $@

bin/tex/%-frag.tex: bin/tex/%.md bin/tex/%.bib
	if [ -s bin/tex/$(*F).bib ]; then \
		cd bin/tex && pandoc --listings --natbib --filter pandoc-citeproc --bibliography $(*F).bib $(*F).md -o tmp-$(*F)-frag.tex; \
	else \
		cd bin/tex && pandoc --listings $(*F).md -o tmp-$(*F)-frag.tex; \
	fi
	echo "\\\\chapter{$(*F)}\n\n" > bin/tex/$(*F)-frag.tex
	cat bin/tex/tmp-$(*F)-frag.tex >> bin/tex/$(*F)-frag.tex
	rm bin/tex/tmp-$(*F)-frag.tex
	if [ -s bin/tex/$(*F).bib ]; then \
		echo "\n\n\\\\bibliographystyle{plainnat}\n\\\\bibliography{$(*F)}\n" >> bin/tex/$(*F)-frag.tex; \
	fi

bin/tex/%.md: bin/md/%.md
	mkdir -p bin/tex
	cp -R $< $@

bin/tex/%: bin/md/%
	mkdir -p bin/tex
	cp -R $< $@

bin/tex/%.bib: bin/md/%.bib
	mkdir -p bin/tex
	cp -R $< $@


# Markdown targets

bin/md/%.md: %
	cd $< && $(MAKE) source
	mkdir -p bin/md
	pandoc $(<)/$(<).md -o $@

bin/md/%: %
	cd $< && $(MAKE) assets
	mkdir -p bin/md
	cp -R $(<)/$(<) $@

bin/md/%.bib: %
	cd $< && $(MAKE) bibliography
	mkdir -p bin/md
	cp -R $(<)/$(<).bib $@
