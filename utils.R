box::use(
  grDevices[rgb, colorRamp],
)

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

#' @export
normalize <- function(value, min, max) {
  if (value == "-") return(0)
  (value - min) / (max - min)
}

#' @export
navy_palette <- function(value) {
  rgb(
    colorRamp(c("white", "#525E75"))(value),
    maxColorValue = 255
  )
}
