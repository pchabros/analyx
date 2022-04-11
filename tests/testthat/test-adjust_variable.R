box::use(../../modules/adjust_panel/adjust_variable)

describe("adjust_variable", {
  it('changing "scale_by" input should trigger "exact_value" change and other way around', {
    update_numeric_input_mock <- mockery::mock()
    mockery::stub(adjust_variable$server, "updateNumericInput", update_numeric_input_mock)
    shiny::testServer(
      adjust_variable$server,
      args = list(
        vector = 1:3
      ), {
        session$setInputs(set_by_user = "scale_by")
        session$setInputs(scale_by = 200)
        session$flushReact()
        mockery::expect_args(
          update_numeric_input_mock,
          n = 2,
          inputId = "exact_value",
          value = 12
        )
        session$setInputs(set_by_user = "exact_value")
        session$setInputs(exact_value = 3)
        session$flushReact()
        mockery::expect_args(
          update_numeric_input_mock,
          n = 3,
          inputId = "scale_by",
          value = 50
        )
      }
    )
  })
})
