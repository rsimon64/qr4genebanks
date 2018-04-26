info <- read.csv("inst/samples/invitro.csv", stringsAsFactors = FALSE)

print_label <- function(info, header = c("Recursos Genéticos", "Banco in-vitro", "today"),
                        template = "inst/templates/label1.yaml", tofile = "sample.pdf") {

  mm_to_inch <- 0.0393701
  tpl <- yaml::yaml.load_file(template)
  library(raster)
  library(qrencoder)

  max_lines <- as.numeric(tpl$lines)
  margin_width <- as.numeric(tpl$margin)
  pointsize <- tpl$pointsize
  width <- tpl$width * mm_to_inch
  height <- tpl$height * mm_to_inch
  margin <- tpl$margin * mm_to_inch
  out <- paste0(tpl$prefix, tofile)
  family <-  tpl$fontfamily

  empty_plot <- function() {
    plot(1:max_lines, axes = FALSE, xlab = "", ylab = "", col = "white")
  }



  #i <- 1

  pdf(file = out, width = width, height = height, pointsize = pointsize)

  top1 <- header[1]
  top2 <- header[2]
  top3 <- ifelse(header[3] == "today", as.character(Sys.Date()), header[3])

  for(i in 1:nrow(info)) {
    rec <- info[i, ]

    top4 <- rec$ID

    blc1 <- rec[c(2:5)]
    blc2 <- rec[c(6:7)]

    txtq <- paste(top1, top2, top3, top4, paste(blc1, collapse=" "), paste(blc2, collapse = " "))

    old_mar <- par()$mar
    par(mar=c(margin, margin, margin, margin))
    par(mfrow = c(tpl$layout, 2))

    empty_plot()
    img <- imager::load.image("inia.png")
    rasterImage(img, 0, 5,11, 10)
    text(x = 5.5, y = 5.5, label = top1, family = family)
    text(x = 5.5, y = 4.5, label = top2, family = family)
    text(x = 5.5, y = 3.5, label = top3, family = family)
    text(x = 5.5, y = 2.5, label = top4, family = family)

    image(qrencoder::qrencode_raster(txtq), asp=1, col=c("white", "black"),
          axes=FALSE, xlab="", ylab="")


    empty_plot()
    #text(x = 3, y = 9, label = "Hi you", family = family)
    legend(-1, 10, legend = blc1, bty = "n")


    empty_plot()
    #text(x = 3, y = 9, label = "Hi you", family = family)
    legend(-1, 10, legend = blc2, bty = "n")

    par(mar=old_mar)

  }

  dev.off()





}

print_label(info)
