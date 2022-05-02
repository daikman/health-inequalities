mainContent <- function(ns, resource) {
  div(
    class="fade",
    h3(resource$title, style = "font-weight: bold;"),
    selectMetrics(ns(resource$dom_id), names(resource$metrics), resource$metrics),
    hr(),
    explanations(resource),
    hr(),
    p(paste0(
      "Data last updated: ", resource$last_mod
    )),
    HTML(paste0(
      "<p>Learn more about this data <a href='",
      resource$url, "' target='_blank'>here</a>.</p>"
    ))
  )
}
