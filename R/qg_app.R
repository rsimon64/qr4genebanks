#' qg_app
#'
#' QR4genebanks Sample App
#'
#' @return shiny.appobj
#' @export
#'
#' @examples
#'
#' if (interactive()) {
#'   qr4genebanks::qr4gb_app()
#' }
qg_app <- function() {
  shiny::shinyApp(
    ui = ui_app,
    server = sv_qr4genebanks
  )
}
