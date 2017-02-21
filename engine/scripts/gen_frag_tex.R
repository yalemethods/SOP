#!/usr/bin/env Rscript

the_md <- commandArgs(trailingOnly = TRUE)[1]

read_frontmatter <- function(file) {
  file_content <- readLines(file)
  delimiters <- grep("^(---|\\.\\.\\.)\\s*$", file_content)
  frontmatter <- paste(file_content[(delimiters[1] + 1):(delimiters[2] - 1)], collapse = "\n")
  yaml::yaml.load(frontmatter)
}

chapter_meta <- read_frontmatter(the_md)
chapter_name <- tools::file_path_sans_ext(basename(the_md))

chapter_authors <- chapter_meta$author
if (length(chapter_authors) > 1L) {
  chapter_authors <- paste0(paste0(chapter_authors[-length(chapter_authors)], collapse = ", "),
                            " \\& ",
                            chapter_authors[length(chapter_authors)])
}

cat(sprintf("\\chapter{%s}\n\n\\chapterauthor{%s}\n\n\\input{%s-body}\n",
            chapter_meta$title, chapter_authors, chapter_name))

if ("bibliography" %in% names(chapter_meta)) {
  cat(sprintf("\n\\bibliographystyle{plainnat}\n\\bibliography{%s}\n",
              chapter_name))
}
