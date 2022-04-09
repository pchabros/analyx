#' @export
ui <- function(id) {
  ns <- shiny::NS(id)
  shiny::div(
    shiny::numericInput(
      inputId = ns("scale_by"),
      label = "scale by",
      value = 100,
      min = 0
    ),
    shiny::numericInput(
      inputId = ns("exact_value"),
      label = "exact value",
      value = 1,
      min = 0
    )
  )
}

#' @export
server <- function(id, vector) {
  shiny::moduleServer(id, function(input, output, session) {
    vector_sum <- sum(vector)
    scale_by <- shiny::debounce(shiny::reactive(input$scale_by), 100)
    exact_value <- shiny::debounce(shiny::reactive(input$exact_value), 100)
    shiny::observeEvent(input$scale_by, {
      new_exact_value <- vector_sum * input$scale_by / 100
      shiny::req(new_exact_value != exact_value())
      shiny::updateNumericInput(
        inputId = "exact_value",
        value = new_exact_value
      )
    })
    shiny::observeEvent(input$exact_value, {
      new_scale_by <- input$exact_value / vector_sum * 100
      shiny::req(new_scale_by != scale_by())
      shiny::updateNumericInput(
        inputId = "scale_by",
        value = new_scale_by
      )
    })
  })
}
