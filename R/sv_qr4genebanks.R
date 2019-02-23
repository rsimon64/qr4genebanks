dict <- read.delim2(system.file("lang/dictionary.txt",
                                package = "qr4genebanks"), sep = "\t")

trlt <- function(term, lang) {
  shiny::HTML(as.character(dict[term == dict$id, lang]))
}

sv_qr4genebanks <- function(input, output, session) {
  get_langs <- function(lang) {
    langs <- as.list(names(dict)[-1])

    n <- length(langs)
    nms <- character(n)
    vls <- character(n)
    for (i in 1:n) {
      nms[i] <- trlt(langs[[i]], lang)
    }

    return(list(langs, nms))
  }


  shiny::observe({
    x <- input$lang

    # Can also set the label and select items
    shiny::updateRadioButtons(session, "lang",
      trlt("language", x),
      choiceNames = get_langs(x)[[2]],
      choiceValues = as.character(get_langs(x)[[1]]),
      selected = x
    )

    shiny::updateRadioButtons(session, "tplId",
      trlt("layout", x),
      choices = list.files(file.path(system.file("templates",
        package = "qr4genebanks"
      )), pattern = "label_")
      # choiceNames = c(trlt("2x1", x), trlt("3x1", x)),
      # choiceValues = c("2x1", "3x1")
    )

    output$headerTitle <- shiny::renderUI({
      trlt("title", x)
    })

    output$download <- shiny::renderUI({
      trlt("download", x)
    })

    output$btnClose <- shiny::renderUI({
      trlt("btnClose", x)
    })

    output$fileTitle <- shiny::renderUI({
      trlt("fileTitle", x)
    })

    output$fileLabel <- shiny::renderUI({
      trlt("fileLabel", x)
    })

    output$previewTitle <- shiny::renderUI({
      trlt("previewTitle", x)
    })

    output$qrHints <- shiny::renderUI({
      shiny::p(
        shiny::tags$ol(
          shiny::tags$li(trlt("hint1", x)),
          shiny::tags$li(trlt("hint2", x)),
          shiny::tags$li(trlt("hint3", x)),
          shiny::tags$li(trlt("hint4", x)),
          shiny::tags$li(trlt("hint5", x))
        )
      )
    })
  })





  inFile <- shiny::reactive({
    input$csvFile
  })

  csvData <- shiny::reactive({
    if (is.null(inFile())) {
      return(NULL)
    }
    utils::read.csv(inFile()$datapath, stringsAsFactors = FALSE)
  })


  output$contents <- shiny::renderTable({
    utils::head(csvData())
  })

  output$ready <- shiny::reactive({
    FALSE
  })

  tplId <- shiny::reactive({
    input$tplId
  })

  shiny::outputOptions(output, "ready", suspendWhenHidden = FALSE)


  shiny::observeEvent(input$csvFile, {
    shiny::withProgress(message = "Procesando ...", style = "notification",
                        value = 1, {

      # message(paste("id", tplId()))
      tplFile <- system.file(paste0("templates/", tplId()),
                             package = "qr4genebanks")
      outFile <- paste0(tempdir(), input$csvFile$name, ".", tplId(), ".pdf")
      outName <- paste0(input$csvFile$name, ".", tplId(), ".pdf")

      qr4genebanks::qg_print_labels(csvData(), template = tplFile,
                                    to_file = outFile)

      output$ready <- shiny::reactive({
        TRUE
      })

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
    if (input$close > 0) {
      shiny::stopApp()
    }
  })
}
