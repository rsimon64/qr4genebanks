sv_quagga <- function(input, output, session) {

  #shinyjs::hide("downloadData")
  #shinyjs::disable("downloadData")

  inFile <- shiny::reactive({
    input$csvFile
  })

  csvData <- shiny::reactive({
    if (is.null(inFile()))
      return(NULL)
    utils::read.csv(inFile()$datapath, stringsAsFactors = FALSE)
  })


  output$contents <- shiny::renderTable({
    head(csvData())
  })

  output$ready <- reactive({
    FALSE
  })
  outputOptions(output, "ready", suspendWhenHidden = FALSE)


  shiny::observeEvent(input$csvFile, {
    #shiny::updateActionButton(session, "downloadData", label ="Procesando", icon = shiny::icon("spinner"))

    shiny::withProgress(message = 'Procesando ...', style = "notification", value = 1, {

      tplFile <- system.file(paste0("templates/label", input$tplId, ".yaml"), package = "quagga")
      outFile <- paste0(tempdir(), input$csvFile$name, ".label", input$tplId, ".pdf")
      outName <- paste0(input$csvFile$name, ".label", input$tplId, ".pdf")

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
