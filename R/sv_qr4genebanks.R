sv_qr4genebanks <- function(input, output, session) {

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
      tplFile <- system.file(paste0("templates/label", tplId(), ".yaml"), package = "quagga")
      outFile <- paste0(tempdir(), input$csvFile$name, ".label", tplId(), ".pdf")
      outName <- paste0(input$csvFile$name, ".label", tplId(), ".pdf")

      quagga::print_label(csvData(), template = tplFile, tofile = outFile)

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



  shiny::observe({
    if (input$close > 0){
      shiny::stopApp()
    }
  })

}
