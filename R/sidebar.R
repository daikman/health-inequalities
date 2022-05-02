sidebar <- function(ns) {
  div(
    h2("Health Inequalities in Scotland", style = "font-weight: bold;"),
    hr(),
    lapply(config, function(resource) {
      sidebarContent(ns, resource)
    }),
    # add styling
    style = "
      position: fixed;
      left: 0;
      top: 0;
      background-color: rgba(100, 200, 200, 0.1);
      height: 100%;
      padding: 5%;
      width: 40%;
      overflow-y: auto;
    ",
    # fade-in css
    tags$style(HTML("
      .fade {
        animation-duration: 1s;
        animation-name: animate-fade;
        animation-fill-mode: forwards;
      }

      @keyframes animate-fade {
        0% { opacity: 0; }
        100% { opacity: 1; }
      }
    "))
  )

}
