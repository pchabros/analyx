box::use(
  shiny[...],
  dplyr[`%>%`, mutate],
  glue[glue],
  waiter[Waitress],
  ./table,
)

calculate <- AnalyticsPackage::calculate

#' @export
ui <- function(id) {
  ns <- NS(id)
  div(
    div(
      class = "calculation-panel-title",
      h4("results"),
    ),
    table$ui(ns("table")),
    actionButton(
      class = "calculation-panel-button",
      inputId = ns("calculate"),
      label = "calculate"
    )
  )
}

#' @export
server <- function(id, data) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns
    result <- reactiveVal("-")
    observeEvent(data(), {
      result("-")
    })
    data_with_result <- reactive({
      data() %>% mutate(result = result())
    })
    waitress <- Waitress$new(
      selector = glue("#{ns('calculate')}"),
      theme = "overlay-percent"
    )
    observeEvent(input$calculate, {
      waitress$start()
      waitress$auto(value = 1, ms = 99)
      result(
        calculate(data())$res
      )
      waitress$close()
    })
    table$server("table", data_with_result)
  })
}
