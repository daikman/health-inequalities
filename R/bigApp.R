bigApp <- function() {
  ns <- NS("big")

  div(
    div(
      style = "
        position: absolute;
        left: 0;
      ",
      sidebar(ns)
    ),
    div(
      style = "
        width: 60%;
        position: absolute;
        right: 0;
      ",
      div(
        style = "
          width: 100%;
          max-width: 600px;
          padding: 5%;
          margin: auto;
          margin-top: 100px;
        ",
        # render plot for each dataset
        lapply(config, function(resource) {
          div(
            plotDiv(ns(resource$dom_id)),
            # spacing between plots
            div(style = "margin-bottom: 250px"),
            hr(),
            div(style = "margin-bottom: 250px")
          )
        })
      )
    )
  )
}
