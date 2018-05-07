
#' print_label
#'
#' Creates a PDF file with barcoded labels given a data.frame,
#' a template with formatting instructions and a name for the pdf file.
#' Currently, only QR code is supported.
#'
#' All options for fine-tuning the label are contained within the template
#' file. The file uses a yaml format. Options can be adjusted for different
#' label sizes. The basic layout pattern consists of four blocks.
#'
#' ID block
#'
#' QR block
#'
#' Info block
#'
#' Optional info block
#'
#' @param info data.frame with content for barcode
#' @param template path to yaml file with configuration details
#' @param tofile path to output file
#'
#' @return nothing
#' @export
#'
#' @examples
#'
#' if (interactive()) {
#' info <- read.csv(
#'   system.file("/samples/invitro.csv", package = "quagga"),
#'   stringsAsFactors = FALSE)
#' print_label(info,
#'  header = c("Recursos Genéticos", "Banco in-vitro", "today"),
#'  template = "inst/templates/label1.yaml",
#'  tofile = "label1.pdf" )
#' }
#'
print_label <- function(info,
                        # header = c("today",
                        #            "Recursos Geneticos",
                        #            "Banco in-vitro"),
                        template = system.file("templates/label1.yaml",
                                               package = "quagga"),
                        tofile = "sample.pdf") {

  mm_to_inch <- 0.0393701
  tpl <- yaml::yaml.load_file(template)

  header <- c(
    tpl$header1,
    tpl$header2,
    tpl$header3
  )

  pointsize <- tpl$pointsize
  labels_per_row <- tpl$labelsperrow
  width <- (tpl$width + .5) * mm_to_inch
  height <- tpl$height * mm_to_inch
  margin <- tpl$margin * mm_to_inch
  #out <- paste0(tpl$prefix, tofile)
  out <- tofile
  old_mar <- graphics::par()$mar


  grDevices::pdf(file = out, width = width * labels_per_row, height = height, pointsize = pointsize)
  graphics::par(mar=c(margin, margin, margin, margin))
  graphics::layout(get_design_matrix(labels_per_row))

  for(i in seq(1, nrow(info), by = labels_per_row)) {
     for(k in 1:labels_per_row) {
       if (i >= nrow(info)) break
       layout_label(i, header, info, tpl)
       i <- i + 1
    }
  }

  grDevices::dev.off()
}

# TODO move to examples or tests

# info <- read.csv("inst/samples/invitro.csv", stringsAsFactors = FALSE)
# print_label(info,  header = c("Recursos Genéticos", "Banco in-vitro", "today"),
#             template = "inst/templates/label1.yaml", tofile = "label1.pdf" )
# info <- read.csv("inst/samples/dna.csv", stringsAsFactors = FALSE)
# print_label(info, header = c("Recursos Genéticos", "Banco ADN", ""),
#             template = "inst/templates/label2.yaml",
#             tofile = "label2.pdf" )
# info <- read.csv("inst/samples/campo.csv", stringsAsFactors = FALSE)
#
# #TODO turn text 90 degrees
# # print_label(info, header = c("today", "Recursos Genéticos", "Banco campo"),
# #             template = "inst/templates/label3.yaml",
# #             tofile = "label3.pdf" )
# print_label(info, header = c("today", "Recursos Genéticos", "Banco campo"),
#             template = "inst/templates/label4.yaml",
#             tofile = "label4.pdf" )
