windowWidthInput <- function() {
  tags$head(tags$script('
    var width = 0;
    $(document).on("shiny:connected", function(e) {
      width = window.innerWidth;
      Shiny.onInputChange("width", width);
    });
    $(window).resize(function(e) {
      width = window.innerWidth;
      Shiny.onInputChange("width", width);
    });
  '))
}
