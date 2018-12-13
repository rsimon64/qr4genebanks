context("empty_plot")

epp <- tempfile(fileext = ".png")

test_that("empty_plot works", {
  skip_on_cran()
  png(epp)
  qr4genebanks:::empty_plot(1)
  dev.off()
  expect_true(file.exists(epp))
  unlink(epp)
})

