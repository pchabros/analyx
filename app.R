library(shiny)

box::use(modules/adjust_variable)

ui <- shiny::fluidPage(
  adjust_variable$ui("a")
)

server <- function(input, output) {
  adjust_variable$server("a", 1:10)
}

shiny::shinyApp(ui, server)
