
<!-- README.md is generated from README.Rmd. Please edit that file -->

# qr4genebanks

[![AppVeyor build
status](https://ci.appveyor.com/api/projects/status/github/rsimon64/qr4genebanks?branch=master&svg=true)](https://ci.appveyor.com/project/rsimon64/qr4genebanks)

[![Travis build
status](https://travis-ci.org/rsimon64/qr4genebanks.svg?branch=master)](https://travis-ci.org/rsimon64/qr4genebanks)

[![lifecycle](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://www.tidyverse.org/lifecycle/#maturing)

The goal of qr4genebanks is to provide simple tools to print
2-dimensional bar-codes in the popular QR format for plant collection
genebanks. The package has currently only one function that expects a
table containing the information to be printed with one row per label.

Label designs are available for a few standard label sizes and are
created in PDF format. The PDF file can then be sent to the label
printer over the intranet. The designs are based on four square blocks
that can be arranged in rows and columns.

## Installation

You can install the released version of qr4genebanks from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("qr4genebanks")
```

## Example

The following code will create a [sample](sample.pdf) file.

``` r
qr4genebanks::print_label()
```
