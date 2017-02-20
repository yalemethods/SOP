#!/usr/bin/env python

import sop, sys
from string import Template

the_chapter = sys.argv[1]
the_md = sys.argv[2]

chapter_meta = sop.get_chapter_meta(the_md)

authors = chapter_meta["author"]
if type(authors) is list:
    if len(authors) > 1:
        last_author = authors.pop()
        authors = ', '.join(authors) + " \\& " + last_author
    else:
        authors = authors[0]

tex = "\\chapter{$title}\n\n\\chapterauthor{$authors}\n\n\\input{$chapter-body}\n"

if "bibliography" in chapter_meta:
    tex += "\n\\bibliographystyle{plainnat}\n\\bibliography{$chapter}\n"

print Template(tex).safe_substitute(chapter = the_chapter,
                                    title = chapter_meta["title"],
                                    authors = authors)
