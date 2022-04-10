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
    div(
      class = "adjust-panel-title",
      h4("adjust variables")
    ),
    div(
      class = "adjust-panel-inputs",
      map(variables, function(variable) {
        adjust_variable$ui(ns(variable))
      }),
      div(
        class = "labels",
        div(p("scale by [%]")),
        div(p("set value"))
      )
    )
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
