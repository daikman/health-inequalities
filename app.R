library(shiny)
library(dplyr)

# import all modules and scripts
path <- "./R"
mods <- dir(path)
for (mod in mods) {
  source(paste0(path, "/", mod))
}

# define app
ui <- fixedPage(
  title = "Health Inequalities in Scotland",
  # define lineColours variable in js
  # used for inputs and plots
  tags$script(paste0(
    "const lineColours = ", jsonlite::toJSON(lineColours)
  )),

  # apply general css
  theme = "custom.css",

  # set up scroll events
  scrollHeightInput(),

  # responsive routing
  # window narrower than 766px renders smallApp()
  # wider renders bigApp()
  windowWidthInput(),
  conditionalPanel("input.width < 766",
    smallApp()
  ),
  conditionalPanel("input.width >= 766",
    bigApp()
  ),
  # button and modal for information
  infoModal("info")
)

server <- function(input, output, session) {

  appServer("small")
  appServer("big")

}

# run app
shinyApp(ui, server)
