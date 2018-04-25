# qrencoder uses native C library

empty_plot <- function() {
  plot(1:10, axes = FALSE, xlab = "", ylab = "", col = "white")
}

family = "Helvetica"

library(raster)

pdf(file = "tst.pdf", width = 1.89, height = 2.75, pointsize = 8)
#png(file = "tst.png", width = 47 * 8, height = 68 * 8, units = "px")

old_mar <- par()$mar
par(mar=c(0.2, 0.2, 0.2, 0.2))
par(mfrow = c(2, 2))

empty_plot()
img <- imager::load.image("inia.png")
rasterImage(img, 0, 5,11, 10)
text(x = 5.5, y = 5, label = Sys.Date(), family = family)
text(x = 5.5, y = 4, label = "Recursos Genéticos", family = family)
text(x = 5.5, y = 3, label = "Banco in-vitro", family = family)

image(qrencoder::qrencode_raster("Quagga means zebra"), asp=1, col=c("white", "black"),
      axes=FALSE, xlab="", ylab="")
empty_plot()
text(x = 3, y = 9, label = "Hi you", family = family)
image(qrencoder::qrencode_raster("This is a test"), asp=1, col=c("white", "black"),
      axes=FALSE, xlab="", ylab="")

par(mar=old_mar)

dev.off()



