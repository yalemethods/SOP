# Standard Operating Procedures

This project is created by members of the Yale Political Science Department for best practices in running surveys on Qualtrics and with Amazon Mechanical Turk workers. 

## Organization

The SOP sources are organized by chapters. Each chapter has its own folder containing all files it needs.

To create a new chapter, copy either the `example-latex` folder if you're writing in LaTeX or the `example-md` folder if you're writing in Markdown. Change the folder name to something good, and add the name as a new line in the `chapters.txt` file. Start editing the chapter.


## How to make SOP documents

The SOP can be compiled into PDFs or HTMLs. Everything is done by an automated build system using [Make](https://www.gnu.org/software/make/) and [Pandoc](http://pandoc.org). In order to make this run, some software is needed (see the "Dependencies" section below).

To build everything (PDFs and HTMLs for all chapters), simply run the following command in the top folder:

```shell
make
```

One can also build only PDFs or only HTMLs for all chapters by running either of:

```shell
make html
make pdf
```

Finally, one can also build PDFs and HTMLs for single chapters. In that case, simply add the chapter name and a dash as a suffix. E.g., to build for a chapter call "chapter1", run:

```shell
make all-chapter1
make html-chapter1
make pdf-chapter1
```

All compiled documents end up in the `bin/html` or `bin/pdf` folders.

In order the clean the project folder from compiled files, run:

```shell
make clean
```


## Dependencies

The software listed below is needed to build the SOP. **However, it's possible to work and build single chapters without most of these dependencies.** 

* **UNIX-like enviroment**
* [`make`](https://www.gnu.org/software/make/)
* [`pandoc`](http://pandoc.org) & [`pandoc-citeproc`](https://hackage.haskell.org/package/pandoc-citeproc)
* [`pdflatex`](https://www.tug.org/applications/pdftex/) & [`bibtex`](http://www.bibtex.org)


### Dependencies on Mac OS

`make` is included in Apple's Xcode command line developer tools (which is already installed on many Macs). You can check if the tools are install with 

```shell
xcode-select -p
```

This should return `/Applications/Xcode.app/Contents/Developer`. If not, then you need to install it with:

```shell
xcode-select --install
```

`pandoc` and `pandoc-citeproc` is easiest install using [Homebrew](http://brew.sh) like this:

```shell
brew install pandoc pandoc-citeproc
```

If you don't want to use Homebrew, consult [Pandoc's website](http://pandoc.org/installing.html#mac-os-x).

`pdflatex` and `bibtex` is best install through a [TeX distribution](https://tug.org/mactex/).


### Dependencies on Ubuntu

All dependencies can be install by Ubuntu's package manager:

```shell
sudo apt-get install build-essential pandoc pandoc-citeproc texlive
```


### Dependencies on Windows (untested)

It's slightly tricky to build the complete SOP on Windows. It might be smarter to focus on single chapters and let someone else do the final build. It should, however, be possible with some effort.

First, you need to install a UNIX-like enviroment. Several alternatives that should work. E.g., [Cygwin](https://cygwin.com), [MinGW](http://www.mingw.org), [Mingw-w64](http://mingw-w64.org/doku.php/start) and [WSL](https://msdn.microsoft.com/commandline/wsl/about).

In most cases, the UNIX enviroment includes `make`. If not, you need to install it. See, e.g., the [GNUwin32 project](http://gnuwin32.sourceforge.net/packages/make.htm).

See [Pandoc's website](http://pandoc.org/installing.html#windows) on how to install `pandoc` and `pandoc-citeproc`.

Finally, the two main TeX distributions for windows is [MiKTeX](https://miktex.org) and [TeX Live](http://tug.org/texlive/windows).

