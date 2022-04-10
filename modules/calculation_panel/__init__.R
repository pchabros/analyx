box::use(
  shiny[...],
  dplyr[`%>%`, mutate],
  ./table,
)

calculate <- AnalyticsPackage::calculate

#' @export
ui <- function(id) {
  ns <- NS(id)
  div(
    table$ui(ns("table")),
    actionButton(
      inputId = ns("calculate"),
      label = "calculate"
    )
  )
}

#' @export
server <- function(id, data) {
  moduleServer(id, function(input, output, session) {
    result <- reactiveVal("-")
    data_with_result <- reactive({
      data() %>% mutate(result = result())
    })
    observeEvent(input$calculate, {
      result(
        calculate(data())$res
      )
    })
    table$server("table", data_with_result)
  })
}
