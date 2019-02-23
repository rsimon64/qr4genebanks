context("shiny card")
library(magrittr)


test_that("blank card works", {
  blank <- '<div class=\"col-sm-3\">\n  <div class=\"box box-info\">'

  card <-  as.character(qr4genebanks:::card()) %>%
  stringr::str_sub(1, 51)
  expect_true(identical(blank, card))
})
