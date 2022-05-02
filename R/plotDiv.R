plotDiv <- function(id) {
  ns <- NS(id)
  tagList(
    div(
      r2d3::d3Output(ns("plot"))
    )
  )
}

