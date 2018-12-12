get_design_matrix <- function(labels_per_row = 2) {
  # numbers within matrix indicate order of sub-plots or boxes
  switch(labels_per_row,
    "1" = matrix(c(
      1, 2, 3, 4
      ), nrow = 2, ncol = 2, byrow = TRUE),
    "2" = matrix(c(
      1, 2, 5, 6,
      3, 4, 7, 8
    ), nrow = 2, ncol = 4, byrow = TRUE),
    "3" = matrix(c(
      1, 2, 5, 6, 9, 10,
      3, 4, 7, 8, 11, 12
    ), nrow = 2, ncol = 6, byrow = TRUE),
    "4" = matrix(c(
      1, 5, 9, 13,
      2, 6, 10, 14,
      3, 7, 11, 15,
      4, 8, 12, 16
    ), nrow = 4, ncol = 4, byrow = TRUE)
  )
}
