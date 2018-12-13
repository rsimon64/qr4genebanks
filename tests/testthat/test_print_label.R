context("print_label")

res <- tempfile(fileext = ".pdf", pattern = "Label_")

test_that("parameter type and range is ok", {
  skip_on_cran()
  expect_error({
    print_label("", tofile = res)
  })

  expect_message({
    print_label(template =
                  system.file("templates/label1_no_logo.yaml",
                                       package = "qr4genebanks"
    ), to_file = res)
  }, regexp = "Logo file not found.")
})

test_that("Return types work", {
  skip_on_cran()

  print_label(to_file = res)

  expect_true({
    file.exists(res)
  })

  expect_true({
    file.size(res) == 15206
  })

  unlink(res)

})


