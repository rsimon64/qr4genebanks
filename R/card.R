card <- function(..., title = NULL, icon = shiny::icon("info"),
                 footer = NULL,
                 background = NULL, width = 3, height = NULL) {

  title <- shiny::HTML(paste0(as.character(icon), "&nbsp;", title,""))

  shinydashboard::box(..., title = title, footer = footer, status = "info",
                      style = "box-shadow: 0 8px 16px 0 rgba(0,0,0,0.3);transition: 0.3s;
                      border-radius: 5px;",
                      solidHeader = FALSE, background = background, width = width, height = height,
                      collapsible = FALSE, collapsed = FALSE)
}
