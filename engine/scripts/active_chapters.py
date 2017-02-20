#!/usr/bin/env python

import sop, sys

out_chapters = ""

for part in sop.get_sop_meta(sys.argv[1])["chapters"]:
    partname, chapters = part.popitem()
    for ch in chapters:
        out_chapters += ch + " "

print out_chapters
