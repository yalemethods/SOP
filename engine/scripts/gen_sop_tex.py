#!/usr/bin/env python

import sop, sys
from string import Template

the_sop = sop.get_sop_meta(sys.argv[1])

front = Template("""\\input{preamble.tex}

\\author{$author}
\\title{$title}

\\begin{document}

\\renewcommand{\\bibname}{References}

%\\frontmatter
\\mainmatter

\\maketitle

\\begin{abstract}
    To be added...
\\end{abstract}
\\clearpage

\\tableofcontents*
\\clearpage

\\chapter{Introduction}

To be added...""").safe_substitute(author = the_sop["author"],
                                 title = the_sop["title"])

back = """\n
\\backmatter

\\end{document}
"""


print front

for part in the_sop["chapters"]:
    partname, chapters = part.popitem()
    print "\n\n\\part{" + partname + "}\n"
    for ch in chapters:
        print "\\include{" + ch + "-frag}"

print back
