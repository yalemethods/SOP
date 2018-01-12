# Standard Operating Procedures

[![Build Status](https://travis-ci.org/yalemethods/SOP.svg?branch=master)](https://travis-ci.org/yalemethods/SOP)

This project is created by members of the Yale Political Science Department for best practices in running surveys on Qualtrics and with Amazon Mechanical Turk workers.

## Organization

The SOP sources are organized by chapters. Each chapter has its own folder containing all files it needs.

To create a new chapter, copy one of the example folders:

*   `example-latex` if you're writing in LaTeX,
*   `example-md` if you're writing in Markdown,
*   `example-rmd` if you're writing in Rmarkdown,

and change the folder's name to something good. Now you can start writing the chapter. When the chapter is ready to be included in the SOP, add the chapter's name to the `sop.yml` file.


## How to compile the SOP

The SOP can be compiled into PDFs or HTMLs. Everything is done by an automated build system using [Make](https://www.gnu.org/software/make/), [Pandoc](http://pandoc.org) and [R](https://cran.r-project.org). You might need to install some software to make it run (see the [dependencies section](#dependencies)).

To build everything (i.e., the complete PDF and HTMLs for all chapters), simply run the following command in the top folder:

```shell
make
```

The result will end up in `bin/sop.pdf` and `bin/html/`.

You can also build parts of the SOP (e.g., when you're writing on a chapter and want to see how it turned out):

```shell
# Compile only the PDF (i.e., `bin/sop.pdf`)
make pdf

# Compile PDF chapters seperately (they end up in the `bin/pdf-chapters/` folder)
make pdfchapters

# Compile only HTMLs
make html

# Compile PDF and HTML for chapter "NAME" only
make all-NAME

# Compile PDF for chapter "NAME" only
make pdf-NAME

# Compile HTML for chapter "NAME" only
make html-NAME
```

Finally, you can remove all the compiled files with:

```shell
make clean
```


## Dependencies

To compile the complete SOP, you'll need:

*   UNIX-like enviroment including [`make`](https://www.gnu.org/software/make/)
*   [`pandoc`](http://pandoc.org) and [`pandoc-citeproc`](https://hackage.haskell.org/package/pandoc-citeproc)
*   [`R`](https://cran.r-project.org) with packages [`rmarkdown`](http://rmarkdown.rstudio.com) and [`yaml`](https://cran.r-project.org/web/packages/yaml/index.html)
*   A TeX distribution with [`pdflatex`](https://www.tug.org/applications/pdftex/) and [`bibtex`](http://www.bibtex.org)

**However, it's possible to edit and build single chapters without most of these dependencies.**


### Dependencies on Mac OS

To check if all software is installed, run the following command in the top folder:

```shell
./check_macos.sh
```


### Dependencies on Ubuntu

All dependencies can be installed by Ubuntu's package manager:

```shell
sudo apt-get install build-essential pandoc pandoc-citeproc r-base texlive
```

Install the required R packages with:

```shell
Rscript -e "install.packages(c('rmarkdown', 'yaml'), repos='http://cran.r-project.org')"
```


### Dependencies on Windows (untested)

It's slightly tricky to build the complete SOP on Windows. It might be smarter to focus on single chapters and let someone else do the final build. It should, however, be possible with some effort.

First, you need to install a UNIX-like enviroment. There's several alternatives: [Cygwin](https://cygwin.com), [MinGW](http://www.mingw.org), [Mingw-w64](http://mingw-w64.org/doku.php/start) and [WSL](https://msdn.microsoft.com/commandline/wsl/about).

In most cases, the UNIX enviroment you installed includes `make`. If not, you need to install it. See, e.g., the [GNUwin32 project](http://gnuwin32.sourceforge.net/packages/make.htm).

See [Pandoc's website](http://pandoc.org/installing.html#windows) on how to install `pandoc` and `pandoc-citeproc`.

R can be downloaded from their [website](https://cran.r-project.org).

Finally, the two main TeX distributions for windows are [MiKTeX](https://miktex.org) and [TeX Live](http://tug.org/texlive/windows).
