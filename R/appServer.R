appServer <- function(id) {
  moduleServer(
    id,
    function(input, output, session) {
      # add server module for each plot
      lapply(config, function(resource) {
        moduleServer(
          resource$dom_id,
          function(input, output, session) {
            output$plot <- r2d3::renderD3({
              d3Plot(resource, input$metrics, names(resource$metrics))
            })
          })
      })
    }
  )
}
