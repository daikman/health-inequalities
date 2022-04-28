main <- function() {
  div(
    class = "main",
    style = "
          width: 100%;
          max-width: 600px;
          padding: 5%;
          margin: auto;
          margin-top: 100px;
        ",
    lapply(config, function(resource) {
      div(
        hr(),
        h1(resource$dom_id),
        barPlot(resource$dom_id)
      )
    })
  )
}
