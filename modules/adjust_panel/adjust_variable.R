box::use(
  shiny[...],
  ../../utils[numeric_input, set_input_value]
)

#' @export
ui <- function(id) {
  ns <- NS(id)
  div(
    class = "adjust-variable",
    numeric_input(
      onfocus = set_input_value(ns("set_by_user"), "scale_by"),
      inputId = ns("scale_by"),
      label = NULL,
      value = 100,
      min = 0
      ),
    numeric_input(
      onfocus = set_input_value(ns("set_by_user"), "exact_value"),
      inputId = ns("exact_value"),
      label = NULL,
      value = 1,
      min = 0
    )
  )
}

#' @export
server <- function(id, vector) {
  moduleServer(id, function(input, output, session) {
    vector_sum <- sum(vector)
    updateNumericInput(
      inputId = "exact_value",
      value = vector_sum
    )
    observeEvent(input$scale_by, {
      req(input$set_by_user == "scale_by")
      new_exact_value <- vector_sum * input$scale_by / 100
      updateNumericInput(
        inputId = "exact_value",
        value = new_exact_value
      )
    })
    observeEvent(input$exact_value, {
      req(input$set_by_user == "exact_value")
      new_scale_by <- input$exact_value / vector_sum * 100
      updateNumericInput(
        inputId = "scale_by",
        value = new_scale_by
      )
    })
    return(reactive(vector * input$scale_by))
  })
}
