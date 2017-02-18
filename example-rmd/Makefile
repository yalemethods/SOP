.PHONY: clean source assets bibliography

CHAPTER = example-rmd

clean:
	rm -rf $(CHAPTER).md $(CHAPTER)/rmd-gen/

source: $(CHAPTER).md

assets: $(CHAPTER).md

bibliography: $(CHAPTER).bib

$(CHAPTER).md: $(CHAPTER).Rmd
	R -e 'rmarkdown::render(input = "$(CHAPTER).Rmd", \
	                        output_format = rmarkdown::output_format( \
	                            knitr = rmarkdown::knitr_options( \
	                                opts_chunk = list(fig.path = "$(CHAPTER)/rmd-gen/", \
	                                                  dev = "png", \
	                                                  fig.width = 7, \
	                                                  fig.height = 5, \
	                                                  fig.retina = NULL)), \
	                            pandoc = rmarkdown::pandoc_options( \
	                                to = "markdown", \
	                                from = rmarkdown:::rmarkdown_format()), \
	                            clean_supporting = FALSE), \
	                        output_file = "$(CHAPTER).md", \
	                        runtime = "static")'
