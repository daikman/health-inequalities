contentServer <- function(id) {
  moduleServer(
    id,
    function(input, output, session) {
      text <- reactiveVal("doop")
      output$content <- renderText({
        # text()
        "doop"
      })
    }
  )
}
