context("qg_print_labels")

res <- tempfile(fileext = ".pdf", pattern = "Labels_")

test_that("parameter type and range is ok", {
  skip_on_cran()

  expect_error({
    qg_print_labels("", to_file = res)
  })

  qg_print_labels(template =
                    system.file("templates/label1_no_logo.yaml",
                                package = "qr4genebanks"
                    ), to_file = res)

  expect_true(file.info(res)$size == 15093)

  qg_print_labels(template =
                    system.file("templates/label2.yaml",
                                package = "qr4genebanks"
                    ), to_file = res)


  expect_true(file.info(res)$size == 44008)
})


