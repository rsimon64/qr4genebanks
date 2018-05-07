downloadButtonEdit <- function (outputId, label = "Bajar", class = NULL, ...)
{
  aTag <-
    shiny::tags$a(
      id = outputId,
      class = paste("btn btn-default shiny-download-link",
                    class),
      href = "",
      target = NA, # NA here instead of _blank
      download = NA,
      shiny::icon("download"),
      label,
      ...
    )
}

ui_app <- shiny::fluidPage(

  #shinyjs::useShinyjs(),
  #shiny::tags$style(appCSS),
  shiny::titlePanel("Imprimir c\u00F3digos de barra"),

  shiny::verticalLayout(

    #ui_quagga()
    shiny::fluidRow(
      shiny::column(6,
                    shiny::fileInput("csvFile", "Escoja el archivo de datos a imprimir"
                                     ,
                                     accept = c(
                                       "text/csv",
                                       "text/comma-separated-values,text/plain",
                                       ".csv")
                    ),

                    shiny::radioButtons("tplId", "Escoja un dise\u00F1o", list(
                      "Dise\u00F1o 2x1" = "1",
                      "Dise\u00f1o 3x1" = "2"
                    ))
      ),
      shiny::column(6,
                    shiny::actionButton(
                      "runBtn",
                      "Procesar archivo",
                      class = "btn-primary",
                      icon = shiny::icon("hourglass-start")
                    ),




                    downloadButtonEdit('downloadData', 'Bajar'),

                    shiny::tags$button(
                      id = 'close',
                      type = "button",
                      class = "btn action-button",
                      #class = "btn-warning",
                      onclick = "setTimeout(function(){window.close();}, 10);",  # close browser
                      "Cerrar applicaci\u00F3n"
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
