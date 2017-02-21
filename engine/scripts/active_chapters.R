#!/usr/bin/env Rscript

the_sop <- commandArgs(trailingOnly = TRUE)[1]
cat(unlist(yaml::yaml.load_file(the_sop)$chapters), "\n")
