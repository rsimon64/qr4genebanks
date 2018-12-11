#' run_qr4genebanks
#'
#' Runs a shiny app to print QR labels
#'
#' @param port integer, default 9866
#'
#' @return NULL invisible
#' @author Reinhard Simon
#' @export
#'
#' @examples
#'
#' if(interactive()) {
#'    quagga::run_quagga()
#' }
#'
run_qr4genebanks <- function(port = 9866) {

  # shiny::shinyApp(
  #   ui = ui_app,
  #   server = sv_app,
  #   options = list(
  #     port = port,
  #     launch.browser = TRUE
  #   )
  # )

  shiny::runApp(system.file("apps", package = "qr4genebanks"), port = port)

}
