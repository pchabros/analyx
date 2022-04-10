#' @export
set_input_value <- function(input, value) {
  glue::glue("Shiny.setInputValue('{input}', '{value}')")
}

#' @export
numeric_input <- function(..., onfocus = NULL, width = 100) {
  input <- shiny::numericInput(..., width = width)
  input$children[[2]]$attribs$onfocus <- onfocus
  input
}
