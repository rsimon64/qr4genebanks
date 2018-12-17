#' qg_print_labels
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
#' @param to_file path to output file
#'
#' @return nothing
#' @export
#'
#' @examples
#'
#' if (interactive()) {
#'   print_label()
#' }
qg_print_labels <- function(info = utils::read.csv(
                          system.file("samples/invitro.csv",
                            package = "qr4genebanks"
                          ), stringsAsFactors = FALSE
                        ),
                        template = system.file("templates/label1.yaml",
                          package = "qr4genebanks"
                        ),
                        to_file = "sample.pdf") {
  stopifnot(is.data.frame(info))
  stopifnot(nrow(info) > 0)
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

  out <- to_file
  old_mar <- graphics::par()$mar


  grDevices::pdf(
    file = out, width = width * labels_per_row,
    height = height, pointsize = pointsize
  )
  graphics::par(mar = c(margin, margin, margin, margin))
  graphics::layout(get_design_matrix(labels_per_row))

  for (i in seq(1, nrow(info), by = labels_per_row)) {
    for (k in 1:labels_per_row) {
      if (i >= nrow(info)) break
      layout_label(i, header, info, tpl)
      i <- i + 1
    }
  }

  grDevices::dev.off()
}
