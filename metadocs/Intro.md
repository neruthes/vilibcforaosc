---
type: article
author: 'VI Lib For AOSC'
date: '2023-09-13'
---



# VI Lib For AOSC: Project Introduction



## Abstract

This project is an UNOFFICIAL library for the visual identity of AOSC.
We aim to provide a suite of ready-to-use templates that
any person or organization may find helpful when in need for branding.




## Source Code

The source code of this project is available on [GitHub](https://github.com/neruthes/vilibforaosc).





## Installation

### Portable Installation
You may install this library on your machine so that
you can use Pandoc or similar toolchains to reference certain files provided here.

```bash
### Clone repository
git clone https://github.com/neruthes/vilibforaosc
cd vilibforaosc
### Install into HOME
./make.sh install
```

Then, you may want to have the library seen in a particular project directory.
This can be done by running the `vilibforaosc-installer.sh` script
which should have been installed to your `~/.local/bin` during installation.

The installer script also helps updating from the upstream when it is executed.
This behavior can be disabled by setting `NOAUTOPULL=y` in the `.localenv` file within the repository directory.

### Using Individual Templates
Alternatively, you may download individual template files.

//TODO







## Use Cases

### Current Coverage

Some use cases are covered already.
See the **User Manual** section below.

### Known Vacancies

These use cases are know to be needed, but not ready for service.

- Slides templates (LibreOffice)
- Slides styling (Pandoc header)







## Copyright

The source code of this project is released with the MIT license.
However, AOSC raw branding assets from the upstream [AOSC-Dev/LOGO](https://github.com/AOSC-Dev/LOGO)
may be copyrighted by their original creators and published with their original licenses.



## Contributing

There are several ways to contribute to this project.

- **Submit a use case**  
Inform the maintainers of this project if you have a specific use case in mind where a template or something else can be helpful.
When submitting, please include the following information:
  - Who will use it
  - With what toolchain will it be used
- **Make a pull request**  
You can make a pull request for any known vacancy (as listed above).






## User Manual

Finally, here is the full user manual.
We offer detailed instructions for every component.

### PDF Article Header (Pandoc/LaTeX)

The PDF version of this document is built with this component.

You can use this LaTeX header file in combination with LaTeX, or employ Pandoc as an intermediary.

To use this component, you must install the lib into your project directory by running the `vilibforaosc-installer.sh` script.

#### Pandoc

If you would like to include `author` and `date` information,
your Markdown file should contain a front-matter.
For more information about front-matter, refer to Pandoc manual and other online discussions.

The Pandoc CLI is shown below.

```bash
pandoc -i metadocs/Intro.md -f gfm \
  -o metadocs/Intro.md.pdf -N \
  -H _dist/vilibforaosc/real/latex/aosc-article.H.tex \
  --pdf-engine=xelatex --shift-heading-level-by=-1 \
  -V fontsize:12pt -V papersize:A4 \
  -V geometry:textwidth=35em
```

It is a bit lengthy.
You may want to save the main stuff within `pandoc.sh` script
so that you can simply run `./pandoc.sh metadocs/Intro.md`.


#### LaTeX

Since this is a header, you may simply write a LaTeX document like...

```latex
\documentclass[a4paper,12pt]{article}
\usepackage[textwidth=35em]{geometry}
\input{_dist/vilibforaosc/real/latex/aosc-article.H.tex}
\title{My Article Title}
\author{John Appleseed}
\date{2007 Jan 09, 09:41}
\begin{document}
\maketitle\par
Hello world!
\end{document}
```
