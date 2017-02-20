CHAPTERS = $(shell ls -d */ | cut -f1 -d'/')
CHAPTER_ALL = $(addprefix all-,$(CHAPTERS))
CHAPTER_PDF = $(addprefix pdf-,$(CHAPTERS))
CHAPTER_HTML = $(addprefix html-,$(CHAPTERS))
CHAPTER_TEXFRAG = $(addprefix texfrag-,$(CHAPTERS))
CHAPTER_MD = $(addprefix md-,$(CHAPTERS))

.PHONY: all clean pdf pdfchapters html texfrag md \
        $(CHAPTER_ALL) $(CHAPTER_PDF) $(CHAPTER_HTML) \
        $(CHAPTER_TEXFRAG) $(CHAPTER_MD)


### Main targets

all: html pdf

clean:
	rm -rf bin

# Active chapters
.active: sop.yaml
	echo "ACTIVE_CHAPTERS = $$(python engine/scripts/active_chapters.py sop.yaml)" > .active

include .active

pdf: bin/sop.pdf

pdfchapters: $(addprefix pdf-,$(ACTIVE_CHAPTERS))

html: $(addprefix html-,$(ACTIVE_CHAPTERS))

texfrag: $(addprefix texfrag-,$(ACTIVE_CHAPTERS))

md: $(addprefix md-,$(ACTIVE_CHAPTERS))


### Chapter targets

$(CHAPTER_ALL): all-% : html-% pdf-%

$(CHAPTER_PDF): pdf-% : bin/pdf-chapters/%.pdf

$(CHAPTER_HTML): html-% : bin/html/% bin/html/%.html

$(CHAPTER_TEXFRAG): texfrag-% : bin/tex/% bin/tex/%-frag.tex bin/tex/%-body.tex bin/tex/%.bib

$(CHAPTER_MD): md-% : bin/md/% bin/md/%.md bin/md/%.bib


### PDF main target

bin/sop.pdf: bin/tex/sop.tex bin/tex/preamble.tex texfrag
	cd bin/tex && \
	pdflatex sop && \
	for ch in $(ACTIVE_CHAPTERS); do \
		if [ -s $${ch}.bib ]; then \
			bibtex $${ch}-frag.aux; \
		fi \
	done && \
	pdflatex sop && \
	pdflatex sop
	cp bin/tex/sop.pdf bin/sop.pdf


### PDF chapters targets

bin/pdf-chapters/%.pdf: bin/tex/preamble.tex bin/tex/% bin/tex/%-chap.tex bin/tex/%-frag.tex bin/tex/%-body.tex bin/tex/%.bib
	cd bin/tex && \
	if [ -s bin/tex/$(*F).bib ]; then \
		cd bin/tex && pdflatex $(*F)-chap && bibtex $(*F)-chap; \
	fi && \
	pdflatex $(*F)-chap && \
	pdflatex $(*F)-chap
	mkdir -p bin/pdf-chapters
	cp bin/tex/$(*F)-chap.pdf $@


### HTML targets

bin/html/%.html: bin/md/%.md bin/md/%.bib
	mkdir -p bin/html
	pandoc -s --mathjax --filter pandoc-citeproc --bibliography bin/md/$(*F).bib bin/md/$(*F).md -o $@

bin/html/%: bin/md/%
	mkdir -p bin/html
	cp -R $< $@


### TeX targets

bin/tex/preamble.tex: engine/templates/preamble.tex
	mkdir -p bin/tex
	cp $< $@

bin/tex/sop.tex: sop.yaml
	mkdir -p bin/tex
	python engine/scripts/gen_sop_tex.py sop.yaml > bin/tex/sop.tex

bin/tex/%-chap.tex:
	mkdir -p bin/tex
	python engine/scripts/gen_chapter_tex.py $(*F) > $@

bin/tex/%-frag.tex: bin/md/%.md
	engine/scripts/gen_frag_tex.py "$(*F)" bin/md/$(*F).md > $@

bin/tex/%-body.tex: bin/md/%.md bin/tex/%.bib
	cd bin/tex && \
	if [ -s $(*F).bib ]; then \
		pandoc --listings --natbib --filter pandoc-citeproc --bibliography $(*F).bib ../md/$(*F).md -o $(*F)-body.tex; \
	else \
		pandoc --listings ../md/$(*F).md -o $(*F)-body.tex; \
	fi

bin/tex/%: bin/md/%
	mkdir -p bin/tex
	cp -R $< $@

bin/tex/%.bib: bin/md/%.bib
	mkdir -p bin/tex
	cp $< $@


### Markdown targets

bin/md/%.md: %
	cd $< && $(MAKE) $(<).md
	mkdir -p bin/md
	pandoc -s -o $@ $(<)/$(<).md

bin/md/%: %
	cd $< && $(MAKE) assets
	mkdir -p bin/md
	cp -R $(<)/$(<) $@

bin/md/%.bib: % bin/md/%.md
	mkdir -p bin/md
	BIBFILE="$$(python engine/scripts/get_bibliography.py bin/md/$(*F).md)" && \
	if [ -n "$$BIBFILE" ]; then \
		cp $(*F)/$$BIBFILE $@; \
	else \
		touch $@; \
	fi
