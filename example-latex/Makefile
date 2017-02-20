.PHONY: clean assets

CHAPTER = $(notdir $(shell pwd))

clean:
	rm -f $(CHAPTER).md

assets:

$(CHAPTER).md: $(CHAPTER).tex
	pandoc -s -o $(CHAPTER).md $(CHAPTER).tex
