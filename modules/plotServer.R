library(dplyr)
library(ggplot2)

plotServer <- function(resource, small) {
  # if (width <= 766) id <- paste0("sm", id)
  dom_id <- paste0(
    c("", "sm")[small + 1],
    resource$dom_id
  )
  res_id <- resource$res_id
  SIMD <- resource$SIMD
  metrics <- resource$metrics

  moduleServer(
    dom_id,
    function(input, output, session) {
      output$plot <- r2d3::renderD3({
        d3Plot(resource)
      })
    }
  )
}
