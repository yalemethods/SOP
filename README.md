# Standard Operating Procedures

[![Build Status](https://travis-ci.org/yalemethods/SOP.svg?branch=master)](https://travis-ci.org/yalemethods/SOP)

This project is created by members of the Yale Political Science Department for best practices in running surveys on Qualtrics and with Amazon Mechanical Turk workers.

## Organization

The SOP sources are organized by chapters. Each chapter has its own folder containing all files it needs.

To create a new chapter, copy one of the example folders:

*   `example-latex` if you're writing in LaTeX
*   `example-md` if you're writing in Markdown
*   `example-rmd` if you're writing in Rmarkdown

Change the folder's name to something good and add that name to the `sop.yml` file. Now you can start writing the chapter!


## How to compile the SOP

The SOP can be compiled into PDFs or HTMLs. Everything is done by an automated build system using [Make](https://www.gnu.org/software/make/), [Pandoc](http://pandoc.org) and R. You might need to install some software to compile the complete SOP (see the "Dependencies" section below).

To build everything (i.e., the complete SOP PDF and HTMLs for all chapters), simply run the following command in the top folder:

```shell
make
```

The result will end up in `bin/sop.pdf` and `bin/html/`.

You can also build part of the PDF (e.g., when you're writing on a chapter and want to see how it turned out):

```shell
# Compile only the PDF (i.e., `bin/sop.pdf`)
make pdf

# Compile PDF chapters seperately (they end up in the `bin/pdf-chapters/` folder)
make pdfchapters

# Compile only HTMLs
make html

# Compile PDF and HTML only for chapter "NAME"
make all-NAME

# Compile PDF only for chapter "NAME"
make pdf-NAME

# Compile HTML only for chapter "NAME"
make html-NAME
```

Finally, you can remove all the compiled files with:

```shell
make clean
```


## Dependencies

The software listed below is needed to build the SOP:

*   **UNIX-like enviroment**
*   [`make`](https://www.gnu.org/software/make/)
*   [`pandoc`](http://pandoc.org)
    *   [`pandoc-citeproc`](https://hackage.haskell.org/package/pandoc-citeproc)
*   [`pdflatex`](https://www.tug.org/applications/pdftex/) & [`bibtex`](http://www.bibtex.org)
*   [`R`](https://cran.r-project.org)
    *   [`R Markdown`](http://rmarkdown.rstudio.com)
    *   `yaml`

**However, it's possible to work on and build single chapters without most of these dependencies.**

### Dependencies on Mac OS

`make` is included in Apple's Xcode command line developer tools (which is already installed on many Macs). You can check if the tools are installed on your computer with:

```shell
xcode-select -p
```

If they are installed, this should return `/Applications/Xcode.app/Contents/Developer`. If not, then you need to install them with:

```shell
xcode-select --install
```

The easiest way to install `pandoc` and `pandoc-citeproc` is with [Homebrew](http://brew.sh), like this:

```shell
brew install pandoc pandoc-citeproc
```

If you don't want to use Homebrew, consult [Pandoc's website](http://pandoc.org/installing.html#mac-os-x).

`pdflatex` and `bibtex` is best installed as part of a [TeX distribution](https://tug.org/mactex/). (This can be done with [Cask](https://caskroom.github.io) if you don't prefer to do it manually.)


### Dependencies on Ubuntu

All dependencies can be installed by Ubuntu's package manager:

```shell
sudo apt-get install build-essential pandoc pandoc-citeproc texlive
```


### Dependencies on Windows (untested)

It's slightly tricky to build the complete SOP on Windows. It might be smarter to focus on single chapters and let someone else do the final build. It should, however, be possible with some effort.

First, you need to install a UNIX-like enviroment. There's several alternatives that should work. E.g., [Cygwin](https://cygwin.com), [MinGW](http://www.mingw.org), [Mingw-w64](http://mingw-w64.org/doku.php/start) and [WSL](https://msdn.microsoft.com/commandline/wsl/about).

In most cases, the UNIX enviroment you installed includes `make`. If not, you need to install it. See, e.g., the [GNUwin32 project](http://gnuwin32.sourceforge.net/packages/make.htm).

See [Pandoc's website](http://pandoc.org/installing.html#windows) on how to install `pandoc` and `pandoc-citeproc`.

Finally, the two main TeX distributions for windows are [MiKTeX](https://miktex.org) and [TeX Live](http://tug.org/texlive/windows).
