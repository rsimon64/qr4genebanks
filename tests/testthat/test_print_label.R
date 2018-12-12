context("print_label")

res <- tempfile(fileext = ".pdf")

test_that("parameter type and range is ok", {
  expect_error({
    print_label("", tofile = res)
  })

  expect_message({
    print_label(template =
                  system.file("templates/label1_no_logo.yaml",
                                       package = "qr4genebanks"
    ), tofile = res)
  },regexp = "Logo file not found.")
})

test_that("Return types work", {
  # skip_on_cran()

  print_label(tofile = res)

  expect_true({
    file.exists(res)
  })

  expect_true({
    file.size(res) == 45910
  })

})


# test_that("formats work", {
#   skip_on_cran()
#
#   unlink(res)
#   res <- tempfile(fileext = ".pdf")
#   print_label(tofile = res,
#               template = system.file("templates/label2.yaml",
#                                      package = "qr4genebanks"
#               ))
#   expect_true({
#     file.exists(res)
#   })
#
#
#   unlink(res)
#   res <- tempfile(fileext = ".pdf")
#   print_label(tofile = res,
#               template = system.file("templates/label3.yaml",
#                                      package = "qr4genebanks"
#               ))
#   expect_true({
#     file.exists(res)
#   })
#
#   unlink(res)
#   res <- tempfile(fileext = ".pdf")
#   print_label(tofile = res,
#               template = system.file("templates/label4.yaml",
#                                      package = "qr4genebanks"
#               ))
#   expect_true({
#     file.exists(res)
#   })
#
# })
