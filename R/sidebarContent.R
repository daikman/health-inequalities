sidebarContent <- function(ns, resource) {
  this_id <- ns(resource$dom_id)
  logic1 <- paste0(
    "input.scrollHeight >= $('#", this_id, "-plot", "').offset().top - 400"
  )
  logic2 <- paste0(
    " && input.scrollHeight < $('#", this_id, "-plot", "').offset().top + 400"
  )
  query <- paste0(logic1, logic2)
  conditionalPanel(
    query,
    mainContent(ns, resource)
  )
}
