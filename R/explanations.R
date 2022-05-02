explanations <- function(resource) {
  div(
    lapply(seq_along(resource$metrics), function(i) {
      metric <- resource$metrics[i]
      exp <- resource$explanations[i]
      div(
        h4(metric, style = "font-weight: bold;"),
        p(exp)
      )
    })
  )
}
