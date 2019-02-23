sv_app <- function(input, output, session) {
  sv_qr4genebanks(input = input, output = output, session = session)

  session$onSessionEnded(function() {
    shiny::stopApp()
  })
}
