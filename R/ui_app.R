
ui_app <- shiny::fluidPage(
  shiny::titlePanel("Imprimir c\u00F3digos de barra"),

  shiny::verticalLayout(
    shiny::fluidRow(
      shiny::column(6,
                    shiny::radioButtons("tplId", "Escoja un dise\u00F1o", list(
                      "Dise\u00F1o 2x1" = "1",
                      "Dise\u00f1o 3x1" = "2"
                    )),
                    shiny::fileInput("csvFile", "Escoja el archivo de datos a imprimir"
                                     ,
                                     accept = c(
                                       "text/csv",
                                       "text/comma-separated-values,text/plain",
                                       ".csv")
                    )


      ),
      shiny::column(6,

                    shiny::tags$button(
                      id = 'close',
                      type = "button",
                      class = "btn action-button",
                      #class = "btn-warning",
                      onclick = "setTimeout(function(){window.close();}, 10);",  # close browser
                      "Cerrar applicaci\u00F3n"
                    ),
                    shiny::conditionalPanel(condition = "output.ready",
                                            shiny::downloadButton('downloadData', 'Bajar PDF!')
                    )
      )
      ),
    shiny::fluidRow(
      shiny::column(12,
      shiny::tags$hr(),
      shiny::tableOutput("contents")
      )
    )

  )

)
