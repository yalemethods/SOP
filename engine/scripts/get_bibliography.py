#!/usr/bin/env python

import sop, sys

chapter_meta = sop.get_chapter_meta(sys.argv[1])

if "bibliography" in chapter_meta:
    chapter_bib = chapter_meta["bibliography"]
    if type(chapter_bib) is list:
        chapter_bib = chapter_bib[0]
    print chapter_bib
else:
    print ""
