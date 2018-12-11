
library(shinyware)

# src <- system.file("apps/sample-01/www/inia.png", package = "shinyware")
# file.copy(src, "inst/apps/www/inia.jpg")


header1 <- sw_dashboardHeader("Imprimir Códigos de Barra en QR", logo = "inia.jpg"
                              # ,
                              # shinydashboard::dropdownMenu(
                              #   type = "notifications",
                              #   icon = shiny::icon("question-circle"),
                              #   badgeStatus = NULL,
                              #   headerText = "See also:",
                              #
                              #   shinydashboard::notificationItem("Tutorial", icon = shiny::icon("file"),
                              #                                    href = "tutorial_english.html")
                              # )
)


qr4genebanks:::sidebar



body <- shinydashboard::dashboardBody(
  qr4genebanks:::ui_qr4genebanks()
)

ui_app <- shinydashboard::dashboardPage(
  skin = "green", header1, qr4genebanks:::sidebar, qr4genebanks:::body
)




sv_app <- function(input, output, session) {
  qr4genebanks:::sv_qr4genebanks(input, output, session)

  session$onSessionEnded(function() {
    shiny::stopApp()
  })

}




shiny::shinyApp(
  ui = ui_app,
  server = sv_app,
  options = list(
    port = 3141,
    launch.browser = TRUE
  )
)

