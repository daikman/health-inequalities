smallApp <- function() {
  fixedRow(
    header(),
    div(
      lapply(config, function(resource) {
        h1(resource$dom_id)
        p("selection")
        barPlot(paste0("sm", resource$dom_id))
      }),
      style = "
        padding-top: 100px;
      "
    )

  )
}
