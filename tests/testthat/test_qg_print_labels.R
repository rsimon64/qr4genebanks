context("qg_print_labels")

res <- tempfile(fileext = ".pdf", pattern = "Label_")

test_that("parameter type and range is ok", {
  skip_on_cran()
  expect_error({
    qg_print_labels("", to_file = res)
  })

  expect_message({
    qg_print_labels(template =
                  system.file("templates/label1_no_logo.yaml",
                                       package = "qr4genebanks"
    ), to_file = res)
  }, regexp = "Logo file not found.")
})

test_that("Return types work", {
  skip_on_cran()

  qg_print_labels(to_file = res)

  expect_true({
    file.exists(res)
  })

  expect_true({
    file.size(res) == 15089
  })

  unlink(res)

})


