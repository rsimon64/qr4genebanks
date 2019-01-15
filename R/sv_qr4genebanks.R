dict <- read.delim2(system.file("lang/dictionary.txt", package = "qr4genebanks"), sep = "\t")

trlt <- function(term, lang) {
  HTML(as.character(dict[term == dict$id, lang]))
}


sv_qr4genebanks <- function(input, output, session) {

  get_langs  <- function(lang) {
    langs <- list(
      "en",
      "es",
      "de"
    )
    n <- length(langs)
    nms <- character(n)
    vls <- character(n)
    for( i in 1:n) {
      nms[i] = trlt(langs[[i]], lang)
    }

    return(list(langs, nms))
  }

  observe({
    x <- input$lang

    # Can also set the label and select items
    updateRadioButtons(session, "lang",
                       trlt("language", x),
                       choiceNames = get_langs(x)[[2]],
                       choiceValues = as.character(get_langs(x)[[1]]),
                       selected = x
    )

    updateRadioButtons(session, "tplId",
                       trlt("layout", x),
                       choiceNames = c(trlt("2x1", x), trlt("3x1", x)),
                       choiceValues = c("2x1", "3x1"),
                       selected = x
    )

    output$headerTitle <- renderUI({
      trlt("title", x)
    })

    output$download <- renderUI({
      trlt("download", x)
    })

    output$btnClose <- renderUI({
      trlt("btnClose", x)
    })

    output$fileTitle <- renderUI({
      trlt("fileTitle", x)
    })

    output$fileLabel <- renderUI({
      trlt("fileLabel", x)
    })

    output$previewTitle <- renderUI({
      trlt("previewTitle", x)
    })

    output$qrHints <- renderUI({
      shiny::p(
        tags$ol(
          tags$li(trlt("hint1", x)),
          tags$li(trlt("hint2", x)),
          tags$li(trlt("hint3", x)),
          tags$li(trlt("hint4", x)),
          tags$li(trlt("hint5", x))
        )

      )
    })

  })





  inFile <- shiny::reactive({
    input$csvFile
  })

  csvData <- shiny::reactive({
    if (is.null(inFile()))
      return(NULL)
    utils::read.csv(inFile()$datapath, stringsAsFactors = FALSE)
  })


  output$contents <- shiny::renderTable({
    utils::head(csvData())
  })

  output$ready <- shiny::reactive({
    FALSE
  })

  tplId <- shiny::reactive({input$tplId})

  shiny::outputOptions(output, "ready", suspendWhenHidden = FALSE)


  shiny::observeEvent(input$csvFile, {

    shiny::withProgress(message = 'Procesando ...', style = "notification", value = 1, {

      #message(paste("id", tplId()))
      tplFile <- system.file(paste0("templates/label", tplId(), ".yaml"), package = "qr4genebanks")
      outFile <- paste0(tempdir(), input$csvFile$name, ".label", tplId(), ".pdf")
      outName <- paste0(input$csvFile$name, ".label", tplId(), ".pdf")

      qr4genebanks::qg_print_labels(csvData(), template = tplFile, tofile = outFile)

      output$ready <- shiny::reactive({TRUE})

      output$downloadData <- shiny::downloadHandler(
        filename = function() {
          outName
        },
        content = function(con) {
          file.copy(outFile, con)

        }
      )
    })
  })

  shiny::observeEvent(input$language, {
    Sys.setenv(QR4GB_LANUAGE = input$language)
  })



  shiny::observe({
    if (input$close > 0){
      shiny::stopApp()
    }
  })

}
