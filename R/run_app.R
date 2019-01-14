run_app <- function(port = 9866) {


  shiny::runApp(system.file("apps", package = "qr4genebanks"), port = port)

}
