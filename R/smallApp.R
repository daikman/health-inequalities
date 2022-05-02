smallApp <- function() {
  ns <- NS("small")
  div(
    header(),
    div(
      style = "text-align: center; position: absolute; bottom: 5vh; left: 0; width: 100%",
      id = "scroll-instructions",
      p("scroll down to see the data..."),
      icon("arrow-down")
    ),
    # spacing div
    div(style = "margin-top: 95vh;"),
    lapply(config, function(resource) {
      div(
        hr(),
        div(style = "height: 64px;"),
        plotDiv(ns(resource$dom_id)),
        mainContent(ns, resource)
      )
    }),
    style = "
      padding: 5%;
      padding-top: 100px;
    ",
    # remove scroll instructions certain scroll height
    tags$script(HTML("
        $(window).scroll(function() {
          const cutoff = 200;
          const dist = cutoff - scrollHeight
          const fraction = dist/cutoff

          if (dist > 0) {
            $('#scroll-instructions').css({
              opacity: fraction
            })
          } else {
            $('#scroll-instructions').css({
              opacity: 0
            })
          }


        })
      ")),
  )
}
