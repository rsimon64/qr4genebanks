#' qr4gb_app
#'
#' QR4genebanks Sample App
#'
#' @return shiny.appobj
#' @export
#'
#' @examples
#'
#' if (interactive()) {
#' library(qr4genebanks)
#'    qr4gb_app()
#' }
#'
#'
qr4gb_app <- function() {


    shiny::shinyApp(
      ui = ui_app,
      server = sv_qr4genebanks

    )

}
