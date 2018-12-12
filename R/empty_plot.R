empty_plot <- function(max_lines = 5) {
  graphics::plot(
    1:max_lines,
    axes = FALSE,
    xlab = "",
    ylab = "",
    col = "white"
  )
}
