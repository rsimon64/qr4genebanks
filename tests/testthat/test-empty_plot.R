context("empty_plot")

test_that("empty plot works", {
  skip_on_cran()
  qr_emptyplot <- qr4genebanks:::empty_plot(max_lines = 5)

  vdiffr::expect_doppelganger("Empty plot", qr_emptyplot)
}
)
