downloadButton <- function (outputId, label = "Download", class = NULL, ...)
{
  aTag <-
    shiny::tags$a(
      id = outputId,
      class = paste("btn btn-primary shiny-download-link",
                    class),
      href = "",
      target = "_blank", # NA here instead of _blank
      download = NA,
      shiny::icon("download"),
      label,
      ...
    )
}


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
                      class = "btn action-button btn-primary",
                      #class = "btn-warning",
                      onclick = "setTimeout(function(){window.close();}, 10);",  # close browser
                      "Cerrar applicaci\u00F3n"
                    ),
                    shiny::conditionalPanel(condition = "output.ready",
                                            downloadButton('downloadData', 'Bajar PDF!')
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
