#!/usr/bin/env Rscript

the_sop <- commandArgs(trailingOnly = TRUE)[1]
sop_meta <- yaml::yaml.load_file(the_sop)

front <- "\\input{preamble.tex}\n
\\title{%s}
\\author{%s}\n
\\begin{document}

\\renewcommand{\\bibname}{References}

%%\\frontmatter
\\mainmatter
\\maketitle

\\begin{abstract}
To be added...
\\end{abstract}
\\clearpage

\\tableofcontents*
\\clearpage

\\chapter{Introduction}
To be added...\n"

front <- sprintf(front, sop_meta$title, sop_meta$author)

back <- "\n\\backmatter
\\end{document}"

chapters <- sapply(sop_meta$chapters, function(part) {
  paste0("\n\\part{", names(part), "}\n",
         paste0(paste0("\\include{", unlist(part), "-frag}"), collapse = "\n"),
         "\n"
  )
})

cat(front, chapters, back, "\n", sep = "")
