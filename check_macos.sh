#!/bin/sh

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

ALL_OK=true


printf "* Looking for 'make'... "
if command -v make >/dev/null 2>&1; then
  printf "${GREEN}OK${NC}\n"
else
  printf "${RED}Missing!${NC}\n"
  printf ">>> Please install Apple's command line tools with: 'xcode-select --install'\n"
  ALL_OK=false
fi


printf "* Looking for 'Rscript'... "
if command -v Rscript >/dev/null 2>&1; then
  printf "${GREEN}OK${NC}\n"

  printf "* Looking for R package 'yaml'... "
  if Rscript -e "packageVersion(\"yaml\")" >/dev/null 2>&1; then
    printf "${GREEN}OK${NC}\n"
  else
    printf "${RED}Missing!${NC}\n"
    printf ">>> Please install with R code: 'install.packages(\"yaml\")'\n"
    ALL_OK=false
  fi

  printf "* Looking for R package 'rmarkdown'... "
  if Rscript -e "packageVersion(\"rmarkdown\")" >/dev/null 2>&1; then
    printf "${GREEN}OK${NC}\n"
  else
    printf "${RED}Missing!${NC}\n"
    printf ">>> Please install with R code: 'install.packages(\"rmarkdown\")'\n"
    ALL_OK=false
  fi

else
  printf "${RED}Missing!${NC}\n"
  printf ">>> Please install R: https://cran.r-project.org/bin/macosx/\n"
  ALL_OK=false
fi


printf "* Looking for 'pdflatex'... "
if command -v pdflatex >/dev/null 2>&1; then
  printf "${GREEN}OK${NC}\n"

  printf "* Looking for 'bibtex'... "
  if command -v bibtex >/dev/null 2>&1; then
    printf "${GREEN}OK${NC}\n"
  else
    printf "${RED}Missing!${NC}\n"
    ALL_OK=false
  fi

else
  printf "${RED}Missing!${NC}\n"
  printf ">>> Please install TeX distribution: https://tug.org/mactex/\n"
  ALL_OK=false
fi


printf "* Looking for 'pandoc'... "
if command -v pandoc >/dev/null 2>&1; then
  printf "${GREEN}OK${NC}\n"

  printf "* Looking for 'pandoc-citeproc'... "
  if command -v pandoc-citeproc >/dev/null 2>&1; then
    printf "${GREEN}OK${NC}\n"
  else
    printf "${RED}Missing!${NC}\n"
    printf ">>> Please read instructions here: http://pandoc.org/installing.html#mac-os-x\n"
    ALL_OK=false
  fi

else
  printf "${RED}Missing!${NC}\n"
  printf ">>> Please read instructions here: http://pandoc.org/installing.html#mac-os-x\n"
  ALL_OK=false
fi


if [ "$ALL_OK" = "false" ]; then
  exit 1
fi
