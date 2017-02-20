.PHONY: clean assets

CHAPTER = example-latex

clean:
	rm -f $(CHAPTER).md

assets:

$(CHAPTER).md: $(CHAPTER).tex
	pandoc -s -o $(CHAPTER).md $(CHAPTER).tex
