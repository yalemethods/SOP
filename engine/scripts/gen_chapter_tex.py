#!/usr/bin/env python

import sys

the_chapter = sys.argv[1]

front = """\\input{preamble.tex}

\\begin{document}

\\renewcommand{\\bibname}{References}

\\mainmatter"""

back = """\n
\\backmatter

\\end{document}
"""

print front + "\n\n\\include{" + the_chapter + "-frag}\n\n" + back
