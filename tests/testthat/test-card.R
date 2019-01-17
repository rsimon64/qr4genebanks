context("shiny card")


test_that("blank card works", {
  blank = '<div class=\"col-sm-3\">\n  <div class=\"box box-info\">\n    <div class=\"box-header\">\n      <h3 class=\"box-title\"><i class=\"fa fa-info\"></i>&nbsp;</h3>\n    </div>\n    <div class=\"box-body\" style=\"box-shadow: 0 8px 16px 0 rgba(0,0,0,0.3);transition: 0.3s;&#10;                      border-radius: 5px;\"></div>\n  </div>\n</div>'

  expect_true(identical(blank, as.character(qr4genebanks:::card())))
}
)
