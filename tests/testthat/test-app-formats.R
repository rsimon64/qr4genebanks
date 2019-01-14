library(shinytest)
library(testthat)

context("Test Shiny app")

# open Shiny app and PhantomJS
app <- ShinyDriver$new(system.file("appdir", package = "qr4genebanks"))

test_that("output is correct", {
expect_identical(
    app$findWidget("tplId")$getValue(),
    "1"
  )
})

test_that("output is correct", {

  app$setInputs(tplId = "2")

  expect_identical(
    app$findWidget("tplId")$getValue(),
    "2"
  )
})



# stop the Shiny app
app$stop()

