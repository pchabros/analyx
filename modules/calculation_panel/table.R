box::use(
  shiny[...],
  reactable[...],
)

#' @export
ui <- function(id) {
  ns <- NS(id)
  div(reactableOutput(ns("table")))
}

#' @export
server <- function(id, data) {
  moduleServer(id, function(input, output, session) {
    output$table <- renderReactable({
      reactable(
        data = data(),
        bordered = TRUE,
        fullWidth = FALSE,
        highlight = TRUE,
        pagination = FALSE,
        height = 600,
        columns = list(
          result = colDef(
            width = 150
          )
        ),
        defaultColDef = colDef(
          format = colFormat(
            digits = 1,
            separators = TRUE
          ),
          align = "left",
          width = 100
        )
      )
    })
  })
}
