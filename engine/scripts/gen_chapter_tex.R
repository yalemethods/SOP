#!/usr/bin/env Rscript

the_chapter <- commandArgs(trailingOnly = TRUE)[1]

front <- "\\input{preamble.tex}\n
\\begin{document}
\\renewcommand{\\bibname}{References}
\\mainmatter"

back <- "\\backmatter
\\end{document}"

cat(front, "\n\n\\include{", the_chapter, "-frag}\n\n", back, "\n", sep = "")
