library(shiny)
library(dplyr)

# import all modules
path <- "./modules"
mods <- dir(path)
for (mod in mods) {
  source(paste0(path, "/", mod))
}

# define app
ui <- fixedPage(
  windowWidthInput(),
  # includeCSS("./www/responsive.css"),
  conditionalPanel("input.width <= 766",
    smallApp()
  ),
  conditionalPanel("input.width > 766",
    bigApp()
  )
)

server <- function(input, output, session) {

  lapply(config, function(resource) {
    # insert server for all plots (small and big screens)
    plotServer(resource, small = TRUE)
    plotServer(resource, small = FALSE)
  })


  contentServer("content")
}

# run app
shinyApp(ui, server)
