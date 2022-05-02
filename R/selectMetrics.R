selectMetrics <- function(id, values, labels) {
  ns <- NS(id)
  dom_id <- ns("metrics")
  div(
    checkboxGroupInput(
      dom_id,
      "",
      choiceNames = unname(labels),
      choiceValues = unname(values),
      selected = unname(values)[1],
      inline = TRUE
    ),
    tags$style(HTML("
      .checkbox-inline {
        padding: 0;
      }
      .checkbox-inline input {
        opacity: 0;
        width: 0;
        margin: 0;
      }
    ")),
    # js to iterate over checkboxes and colors
    tags$script(paste0("
      $('#", dom_id, " .checkbox-inline span').each(function(i) {
        $(this).css({
          'padding': 6,
          'color': ['white', 'black', 'black'][i],
          'border': '2px solid transparent',
          'font-weight': 'bold',
          'opacity': [1, 0.3, 0.3][i],
          'background-color': ", jsonlite::toJSON(lineColours), "[i]
        })

        // toggle border on hover
        $(this).hover(
          function() {
            $(this).css({'border': '2px solid black'})
          },
          function() {
            $(this).css({'border': '2px solid transparent'})
          }
        )

        // toggle opacity on click
        $(this).click(function() {
          const opac = this.style.opacity
          console.log(opac)

          if (opac == 0.3) {
            $(this).css({opacity: 1, color: 'white'})
          } else {
            $(this).css({opacity: 0.3, color: 'black'})
          }

        })
      })
    "))
  )

}
