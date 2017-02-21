.PHONY: clean assets

CHAPTER = $(notdir $(shell pwd))

clean:
	rm -rf $(CHAPTER).md $(CHAPTER)/rmd-gen/

assets: $(CHAPTER).md

$(CHAPTER).md: $(CHAPTER).Rmd
	Rscript compile.R $(CHAPTER)
