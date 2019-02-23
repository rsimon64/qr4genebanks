context("get_design_matrix")


test_that("parameter type and range is ok", {
  expect_error({
    qr4genebanks:::get_design_matrix(0)
  })

  expect_error({
    qr4genebanks:::get_design_matrix("")
  })

  expect_error({
    qr4genebanks:::get_design_matrix(TRUE)
  })

  expect_error({
    qr4genebanks:::get_design_matrix(5)
  })
})

test_that("Return types work", {
  dm <- qr4genebanks:::get_design_matrix(1)
  expect_true(all(dim(dm) == c(2, 2)))

  dm <- qr4genebanks:::get_design_matrix(2)
  expect_true(all(dim(dm) == c(2, 4)))

  dm <- qr4genebanks:::get_design_matrix(3)
  expect_true(all(dim(dm) == c(2, 6)))

  dm <- qr4genebanks:::get_design_matrix(4)
  expect_true(all(dim(dm) == c(4, 4)))
})
