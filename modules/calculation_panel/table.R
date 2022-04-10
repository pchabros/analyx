box::use(
  shiny[...],
  reactable[...],
  ../../utils[normalize, navy_palette],
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
        height = 400,
        columns = list(
          result = colDef(
            width = 150,
            style = function(value) {
              normalized <- normalize(
                value = value,
                min = min(data()$result),
                max = max(data()$result)
              )
              background <- navy_palette(normalized)
              color <- ifelse(normalized > 0.5, "white", "black")
              list(
                background = background,
                color = color
              )
            }
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
