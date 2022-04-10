box::use(
  shiny[...],
  purrr[map, imap, map_dfr],
  ./adjust_variable,
)

#' @export
ui <- function(id, variables) {
  ns <- NS(id)
  div(
    class = "adjust-panel",
    map(variables, function(variable) {
      adjust_variable$ui(ns(variable))
    })
  )
}

#' @export
server <- function(id, data) {
  moduleServer(id, function(input, output, session) {
    vectors_adjusted <- imap(data, function(values, variable) {
      adjust_variable$server(variable, values)
    })
    data_adjusted <- reactive({
      map_dfr(vectors_adjusted, ~.x())
    })
    return(data_adjusted)
  })
}
