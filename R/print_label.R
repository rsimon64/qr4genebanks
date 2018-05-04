

print_label <- function(info, header = c("today", "Recursos Genéticos", "Banco in-vitro"),
                        template = "inst/templates/label1.yaml", tofile = "sample.pdf") {

  mm_to_inch <- 0.0393701
  tpl <- yaml::yaml.load_file(template)
  library(raster)
  library(qrencoder)

  max_lines <- as.numeric(tpl$lines)
  margin_width <- as.numeric(tpl$margin)
  pointsize <- tpl$pointsize
  labels_per_row <- tpl$labelsperrow
  width <- (tpl$width + .5) * mm_to_inch
  height <- tpl$height * mm_to_inch
  margin <- tpl$margin * mm_to_inch
  out <- paste0(tpl$prefix, tofile)
  family <-  tpl$fontfamily

  empty_plot <- function() {
    plot(1:max_lines, axes = FALSE, xlab = "", ylab = "", col = "white")
  }


  layout_label <- function(i) {


      #par(mfrow = c(tpl$layout, 4 / tpl$layout))



      rec <- info[i, ]
      #p <- dev.new(width = width, height = height, noRStudioGD = TRUE)


      # tiff(file = out, width = width, height = height, units = "in", pointsize = pointsize,
      #      res = 203)

      #old_mar <- par()$mar
      #par(mar=c(margin, margin, margin, margin))
      top1 <- ifelse(header[1] == "today", as.character(Sys.Date()), header[1])
      top2 <- ifelse(header[2] == "today", as.character(Sys.Date()), header[2])
      top3 <- ifelse(header[3] == "today", as.character(Sys.Date()), header[3])
      top4 <- rec$ID

      spacer <- ifelse(tpl$spacer == 1, "\n", "\n\n")


      block_order <-
        as.data.frame(cbind(
          pos = c(tpl$block_ID$position,
                  tpl$block_QR$position,
                  tpl$block_info$position,
                  tpl$block_info_optional$position
          ),
          name = c("ID", "QR", "MI", "OI")
        ), stringsAsFactors = FALSE)

      block_order = dplyr::arrange(block_order, pos)$name




      blc1 <- rec[c(2:5)]
      blc1n<- names(info[i, c(2:5)])
      blc2 <- rec[c(6:7)]
      blc2n<- names(info[i, c(6:7)])

      #txtq <- paste(top1, top2, top3, top4, paste(blc1, collapse=" "), paste(blc2, collapse = " "))
      txtq <- paste(top4)



      do_block_ID <- function() {
        empty_plot()
        img <- imager::load.image(tpl$block_ID$logo$path)
        rasterImage(img,
                    tpl$block_ID$logo$bl_x, tpl$block_ID$logo$bl_y,
                    tpl$block_ID$logo$tr_x, tpl$block_ID$logo$tr_y)

        text(x = tpl$block_ID$x_pos, y = tpl$block_ID$y_pos - 0, label = top1, family = family)
        text(x = tpl$block_ID$x_pos, y = tpl$block_ID$y_pos - 1, label = top2, family = family)
        text(x = tpl$block_ID$x_pos, y = tpl$block_ID$y_pos - 2, label = top3, family = family)
        text(x = tpl$block_ID$x_pos, y = tpl$block_ID$y_pos - 3, label = top4, family = family)
      }

      do_block_QR <-function() {
        image(qrencoder::qrencode_raster(txtq), asp=1, col=c("white", "black"),
              axes=FALSE, xlab="", ylab="")
      }

      do_block_MI <- function() {
        empty_plot()
        if (tpl$fieldnames) {
          legend(tpl$block_info$x_pos, tpl$block_info$y_pos  + tpl$spacer/2 -.15,
                 legend = paste0(blc1n, spacer),
                 bty = "n")
          blc1 <- paste0(" ", blc1)
        }

        legend(tpl$block_info$x_pos, tpl$block_info$y_pos - 1.15  + .1 * tpl$spacer + tpl$spacer/2,
               legend = paste0(blc1, spacer), text.font = tpl$fontface_data,
               bty = "n")

      }

      do_block_OI <- function() {
        empty_plot()
        if (tpl$fieldnames) {
          legend(tpl$block_info_optional$x_pos, tpl$block_info_optional$y_pos  + tpl$spacer/2 -.15,
                 legend = paste0(blc2n, spacer),
                 bty = "n")
          blc2 <- paste0(" ", blc2)
        }

        legend(tpl$block_info$x_pos, tpl$block_info$y_pos  - 1.15 + .1 * tpl$spacer + tpl$spacer/2,
               legend = paste0(blc2, spacer), text.font = tpl$fontface_data,
               bty = "n")
      }

      choose_block <- function(block_id) {
        switch(block_id,
               "ID" = do_block_ID(),
               "QR" = do_block_QR(),
               "MI" = do_block_MI(),
               "OI" = do_block_OI()
        )
      }



      lapply(block_order, choose_block)

      #par(mar=old_mar)
      #plot.new()


  }





  pdf(file = out, width = width * labels_per_row, height = height, pointsize = pointsize)
  old_mar <- par()$mar
  par(mar=c(margin, margin, margin, margin))
  #par(ps = 9, cex = 1.8, cex.main = 1)

  layout(get_design_matrix(labels_per_row))

  for(i in seq(1, nrow(info), by = labels_per_row)) {
    #message(paste("i", i))
     for(k in 1:labels_per_row) {
       if (i >= nrow(info)) break
       layout_label(i )
       i <- i + 1
    }

  }


  #par(mar=old_mar)
  dev.off()

}

info <- read.csv("inst/samples/invitro.csv", stringsAsFactors = FALSE)
print_label(info,  header = c("Recursos Genéticos", "Banco in-vitro", "today"),
            template = "inst/templates/label1.yaml", tofile = "label1.pdf" )
info <- read.csv("inst/samples/dna.csv", stringsAsFactors = FALSE)
print_label(info, header = c("Recursos Genéticos", "Banco ADN", ""),
            template = "inst/templates/label2.yaml",
            tofile = "label2.pdf" )
info <- read.csv("inst/samples/campo.csv", stringsAsFactors = FALSE)

#TODO turn text 90 degrees
# print_label(info, header = c("today", "Recursos Genéticos", "Banco campo"),
#             template = "inst/templates/label3.yaml",
#             tofile = "label3.pdf" )
print_label(info, header = c("today", "Recursos Genéticos", "Banco campo"),
            template = "inst/templates/label4.yaml",
            tofile = "label4.pdf" )
