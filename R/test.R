# # qrencoder uses native C library
# library(raster)
# library(qrencoder)
#
# empty_plot <- function() {
#   plot(1:10, axes = FALSE, xlab = "", ylab = "", col = "white")
# }
#
# family <-  "Helvetica"
#
#
# top1 <- Sys.Date()
# top2 <- "Recursos Genéticos"
# top3 <- "Banco in-vitro"
# top4 <- "PER1234567890"
#
# blc1 <- c("Ullucus tuberosum", "Ulluco", "", "Subcultivo:", "  2018-01-01", "Medio:","  novedoso" )
# blc2 <- c("Lab code: x1234","", "",  "Estado limpieza:", "  OK")
#
# txtq <- paste(top1, top2, top3, top4, paste(blc1, collapse=" "), paste(blc2, collapse = " "))
#
#
#
# pdf(file = "tst.pdf", width = 1.89, height = 2.75, pointsize = 8)
# #png(file = "tst.png", width = 47 * 8, height = 68 * 8, units = "px")
#
# old_mar <- par()$mar
# par(mar=c(0.2, 0.2, 0.2, 0.2))
# par(mfrow = c(2, 2))
#
# empty_plot()
# img <- imager::load.image("inia.png")
# rasterImage(img, 0, 5,11, 10)
# text(x = 5.5, y = 5.5, label = top1, family = family)
# text(x = 5.5, y = 4.5, label = top2, family = family)
# text(x = 5.5, y = 3.5, label = top3, family = family)
# text(x = 5.5, y = 2.5, label = top4, family = family)
#
# image(qrencoder::qrencode_raster(txtq), asp=1, col=c("white", "black"),
#       axes=FALSE, xlab="", ylab="")
#
#
# empty_plot()
# #text(x = 3, y = 9, label = "Hi you", family = family)
# legend(-1, 10, legend = blc1, bty = "n")
#
#
# empty_plot()
# #text(x = 3, y = 9, label = "Hi you", family = family)
# legend(-1, 10, legend = blc2, bty = "n")
#
# par(mar=old_mar)
#
# dev.off()
#
#
# #######################################
#
#
# pdf(file = "tst2.pdf", width = 1.3, height = 1.3, pointsize = 6 )
# #png(file = "tst.png", width = 47 * 8, height = 68 * 8, units = "px")
#
# top3 <- "Banco ADN"
#
# blc1 <- c("Ullucus tuberosum", "Ulluco", "Extracción:", "  2018-01-01", "", "Objetivo:","  secuenciamiento" )
# blc2 <- c("Codigo: a1234","", "",  "Metodo:", "  xyz")
#
# txtq <- paste(top1, top2, top3, top4, paste(blc1, collapse=" "), paste(blc2, collapse = " "))
#
#  old_mar <- par()$mar
#  par(mar=c(0.2, 0.2, 0.2, 0.2))
#  par(mfrow = c(2, 2))
#
#  empty_plot()
#  img <- imager::load.image("inia.png")
#  rasterImage(img, 0, 5,11, 10)
#  text(x = 5.5, y = 5.5, label = top1, family = family)
#  text(x = 5.5, y = 4.5, label = top2, family = family)
#  text(x = 5.5, y = 3.5, label = top3, family = family)
#  text(x = 5.5, y = 2.5, label = top4, family = family)
#
#  image(qrencoder::qrencode_raster(txtq), asp=1, col=c("white", "black"),
#        axes=FALSE, xlab="", ylab="")
#  empty_plot()
#  #text(x = 3, y = 9, label = "Hi you", family = family)
#  legend(-1, 11, legend = blc1, bty = "n")
#
#
#  empty_plot()
#  #text(x = 3, y = 9, label = "Hi you", family = family)
#  legend(-1, 11, legend = blc2, bty = "n")
#
# par(mar=old_mar)
#
# dev.off()
#
#
#
# pdf(file = "tst3.pdf", width = 4.13, height = .95, pointsize = 6 )
# #png(file = "tst.png", width = 47 * 8, height = 68 * 8, units = "px")
#
# top3 <- "Banco campo"
#
# blc1 <- c("Ullucus tuberosum", "Ulluco", "", "Siembra:", "  2018-01-01", "", "Objetivo:","  evaluación" )
# blc2 <- c("Codigo: x1234","", "",  "Feritilizantes:", "  NPK")
#
# txtq <- paste(top1, top2, top3, top4, paste(blc1, collapse=" "), paste(blc2, collapse = " "))
#
#
# old_mar <- par()$mar
# par(mar=c(0.3, 0.3, 0.3, 0.3))
# par(mfrow = c(1, 4))
#
# empty_plot()
# img <- imager::load.image("inia.png")
# rasterImage(img, 0, 5,11, 10)
# text(x = 5.5, y = 5.5, label = top1, family = family)
# text(x = 5.5, y = 4.5, label = top2, family = family)
# text(x = 5.5, y = 3.5, label = top3, family = family)
# text(x = 5.5, y = 2.5, label = top4, family = family)
#
# image(qrencoder::qrencode_raster(txtq), asp=1, col=c("white", "black"),
#       axes=FALSE, xlab="", ylab="")
# empty_plot()
# #text(x = 3, y = 9, label = "Hi you", family = family)
# legend(1, 9, legend = blc1, bty = "n")
#
#
# empty_plot()
# #text(x = 3, y = 9, label = "Hi you", family = family)
# legend(1, 9, legend = blc2, bty = "n")
#
# par(mar=old_mar)
#
# dev.off()
