windowWidthInput <- function() {
  tags$head(tags$script('
    // initialise window width variable
    let width = 0;
    $(document).on("shiny:connected", function(e) {
      width = window.innerWidth;
      Shiny.onInputChange("width", width);
    });

    // add listener for window resize
    $(window).resize(function(e) {
      width = window.innerWidth;
      Shiny.onInputChange("width", width);
    });
  '))
}

scrollHeightInput <- function() {
  tags$head(tags$script('
    // initialise scroll height variable
    let scrollHeight = 0;
    $(document).on("shiny:connected", function(e) {
      scrollHeight = window.pageYOffset;
      Shiny.onInputChange("scrollHeight", scrollHeight);
    });

    // add listener for window scroll
    $(window).scroll(function(e) {
      scrollHeight = window.pageYOffset;
      Shiny.onInputChange("scrollHeight", scrollHeight);
    });
  '))
}


