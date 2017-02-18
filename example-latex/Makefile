.PHONY: clean source assets bibliography

CHAPTER = example-latex

clean:
	rm -f $(CHAPTER).md

source: $(CHAPTER).md

assets: $(CHAPTER)

bibliography: $(CHAPTER).bib

$(CHAPTER).md: $(CHAPTER).tex
	pandoc $(CHAPTER).tex -o $(CHAPTER).md
