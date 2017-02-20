chapter <- commandArgs(trailingOnly = TRUE)[1]

rmarkdown::render(input = paste0(chapter, ".Rmd"),
                  output_format = rmarkdown::output_format(
                    knitr = rmarkdown::knitr_options(
                      opts_chunk = list(fig.path = paste0(chapter, "/rmd-gen/"),
                                        dev = "png",
                                        fig.width = 7,
                                        fig.height = 5,
                                        fig.retina = NULL)),
                    pandoc = rmarkdown::pandoc_options(
                      to = "markdown",
                      from = rmarkdown:::rmarkdown_format(),
                      args = "--standalone"),
                    clean_supporting = FALSE),
                  output_file = paste0(chapter, ".md"),
                  runtime = "static")
