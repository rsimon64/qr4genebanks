
sv_app <- function(input, output, session) {
  sv_quagga(input = input, output = output, session = session)

  session$onSessionEnded(function() {
    shiny::stopApp()
  })


}
