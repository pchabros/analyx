library(testthat)

env <- shiny::loadSupport()
test_dir(
  path = "tests/testthat",
  env = env,
  reporter = c("progress", "fail")
)
