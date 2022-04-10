library(shiny)

box::use(
  shiny[fluidPage, tags, div, shinyApp],
  sass[sass, sass_file],
  magrittr[`%>%`],
  modules/adjust_panel,
  modules/calculation_panel,
)

css <- sass(sass_file("styles/main.scss"))
data <- AnalyticsPackage::data

ui <- fluidPage(
  tags$head(tags$style(css)),
  div(
    class = "main-panel",
    adjust_panel$ui(
      id = "adjust_panel",
      variables = colnames(data)
    ),
    calculation_panel$ui("table")
  )
)

server <- function(input, output) {
  data_adjusted <- adjust_panel$server(
    id = "adjust_panel",
    data = data
  )
  calculation_panel$server("table", data_adjusted)
}

shinyApp(ui, server)
