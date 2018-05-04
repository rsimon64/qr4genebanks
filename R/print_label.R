

print_label <- function(info, header = c("today", "Recursos Genéticos", "Banco in-vitro"),
                        template = "inst/templates/label1.yaml", tofile = "sample.pdf") {

  mm_to_inch <- 0.0393701
  tpl <- yaml::yaml.load_file(template)

  pointsize <- tpl$pointsize
  labels_per_row <- tpl$labelsperrow
  width <- (tpl$width + .5) * mm_to_inch
  height <- tpl$height * mm_to_inch
  margin <- tpl$margin * mm_to_inch
  out <- paste0(tpl$prefix, tofile)
  family <-  tpl$fontfamily


  max_lines <- as.numeric(tpl$lines)

  pdf(file = out, width = width * labels_per_row, height = height, pointsize = pointsize)
  old_mar <- par()$mar
  par(mar=c(margin, margin, margin, margin))

  layout(get_design_matrix(labels_per_row))

  for(i in seq(1, nrow(info), by = labels_per_row)) {
     for(k in 1:labels_per_row) {
       if (i >= nrow(info)) break
       layout_label(i, header, info, tpl)
       i <- i + 1
    }

  }

  dev.off()
}

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
