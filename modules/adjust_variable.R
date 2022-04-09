box::use(
  ../utils[numeric_input, set_input_value]
)

#' @export
ui <- function(id) {
  ns <- shiny::NS(id)
  shiny::div(
    numeric_input(
      onfocus = set_input_value(ns("set_by_user"), "scale_by"),
      inputId = ns("scale_by"),
      label = "scale by",
      value = 100,
      min = 0
      ),
    numeric_input(
      onfocus = set_input_value(ns("set_by_user"), "exact_value"),
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
    shiny::updateNumericInput(
      inputId = "exact_value",
      value = vector_sum
    )
    shiny::observeEvent(input$scale_by, {
      shiny::req(input$set_by_user == "scale_by")
      new_exact_value <- vector_sum * input$scale_by / 100
      shiny::updateNumericInput(
        inputId = "exact_value",
        value = new_exact_value
      )
    })
    shiny::observeEvent(input$exact_value, {
      shiny::req(input$set_by_user == "exact_value")
      new_scale_by <- input$exact_value / vector_sum * 100
      shiny::updateNumericInput(
        inputId = "scale_by",
        value = new_scale_by
      )
    })
  })
}
