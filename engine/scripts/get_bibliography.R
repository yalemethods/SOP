#!/usr/bin/env Rscript

the_md <- commandArgs(trailingOnly = TRUE)[1]

read_frontmatter <- function(file) {
  file_content <- readLines(file)
  delimiters <- grep("^(---|\\.\\.\\.)\\s*$", file_content)
  frontmatter <- paste(file_content[(delimiters[1] + 1):(delimiters[2] - 1)], collapse = "\n")
  yaml::yaml.load(frontmatter)
}

chapter_meta <- read_frontmatter(the_md)

chapter_bib <- ""
if ("bibliography" %in% names(chapter_meta)) {
  chapter_bib <- chapter_meta$bibliography
  if (is.list(chapter_bib)) chapter_bib <- chapter_bib[[1]]
}

cat(chapter_bib, "\n", sep = "")
