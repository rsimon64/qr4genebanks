downloadButton <- function (outputId, label = "Download", class = NULL, ...) {
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

header <- shinydashboard::dashboardHeader(
  titleWidth = 300,
  title = "Imprimir C\u00F3digos de Barra"
)

sidebar <- shinydashboard::dashboardSidebar(width = 300,
  shiny::radioButtons("tplId", "Escoja un dise\U00F1o", list(
    "Dise\u00F1o 2x1" = "1",
    "Dise\u00f1o 3x1" = "2"
  ), inline = TRUE),
  shiny::fileInput("csvFile", "Escoger el archivo de datos a imprimir"
                   , buttonLabel = "Navegar ...",
                   accept = c(
                     "text/csv",
                     "text/comma-separated-values,text/plain",
                     ".csv")
  ),
  shiny::tags$button(
    id = 'close',
    class = "btn action-button btn-primary",
    shiny::icon("power-off"),
    onclick = "setTimeout(function(){window.close();}, 10);",  # close browser
    "Cerrar applicaci\u00F3n"
  )
)




body <- shinydashboard::dashboardBody(
    shiny::fluidRow(
      shiny::column(12,
                    shinycards::card(
                      shiny::p("- La tabla debe tener de seis a nueve columnas."),
                      shiny::p("- La primera columna debe contener el c\u00F3digo de identificaci\u00F3n."),
                      shiny::p("- Las columnas dos a cinco deben contener informaci\u00F3n del primer bloque."),
                      shiny::p("- Las columnas seis a nueve deben contener informaci\u00F3n del segundo bloque."),
                      shiny::p("- El segundo bloque puede tener entre una a cuatro columnas.")
                    ),
                    shinycards::card(width = 9, icon = NULL,
                       title = "Mostrando un m\U00e1ximo de seis filas de la tabla.",
                       shiny::tableOutput("contents"),
                       shiny::conditionalPanel(condition = "output.ready",
                                               downloadButton('downloadData', 'Bajar PDF!')
                       )
                    )

      )
      )
)


ui_app <- shinydashboard::dashboardPage(skin = "green",
  header,
  sidebar,
  body
)


