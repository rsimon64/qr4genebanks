

downloadButton <- function(outputId, label = shiny::uiOutput("download"),
                           class = NULL, ...) {
  aTag <-
    shiny::tags$a(
      id = outputId,
      class = paste(
        "btn btn-primary shiny-download-link",
        class
      ),
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
  title = shiny::uiOutput("headerTitle") # "Imprimir C\u00F3digos de Barra"
)

local_lang <- stringr::str_split(Sys.getenv("OOBEUILang"), "-")[[1]][1]
local_lang <- ifelse(!local_lang %in% c("en", "es", "de"), "en", local_lang)


sidebar <- shinydashboard::dashboardSidebar(
  width = 300,
  # shiny::uiOutput("radioLangs"),
  shiny::radioButtons("lang", "Language",
    list(
      English = "en",
      Spanish = "es",
      German = "de"
    ),
    selected = local_lang
  ),

  shiny::radioButtons("tplId", "Choose a layout", list(
    "Layout 2x1" = "1",
    "Layout 3x1" = "2"
  ), inline = TRUE),
  shiny::fileInput("csvFile", shiny::uiOutput("fileTitle"),
    buttonLabel = shiny::uiOutput("fileLabel"),
    placeholder = "...",
    accept = c(
      "text/csv",
      "text/comma-separated-values,text/plain",
      ".csv"
    )
  ),
  shiny::tags$button(
    id = "close",
    class = "btn action-button btn-primary",
    shiny::icon("power-off"),
    onclick = "setTimeout(function(){window.close();}, 10);", # close browser
    shiny::uiOutput("btnClose")
  )
)





body <- shinydashboard::dashboardBody(
  shiny::fluidRow(
    shiny::column(
      12,
      card(
        width = 9, icon = NULL,
        title = shiny::uiOutput("previewTitle"),
        shiny::tableOutput("contents"),
        shiny::conditionalPanel(
          condition = "output.ready",
          downloadButton("downloadData", shiny::uiOutput("pdfDownload"))
        )
      ),
      card(
        shiny::uiOutput("qrHints")
      )
    )
  )
)

ui_app <- shinydashboard::dashboardPage(
  skin = "green",
  header,
  sidebar,
  body
)
