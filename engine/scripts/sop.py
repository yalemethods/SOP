#!/usr/bin/env python

import re, sys, yaml

def get_sop_meta(file):
    with open(file, 'r') as stream:
        try:
            sop = yaml.safe_load(stream)
        except yaml.YAMLError as exc:
            sys.stderr.write(exc)
            exit(1)
    return sop

def get_chapter_meta(md_file):
    with open(md_file, 'r') as file:
        the_md = file.read()
    try:
        raw_meta_data = re.split("(^---\s*$|^...\s*$)", the_md, flags = re.MULTILINE)[2]
        meta_data = yaml.safe_load(raw_meta_data)
    except yaml.YAMLError as exc:
        sys.stderr.write(exc)
        exit(1)
    return meta_data
