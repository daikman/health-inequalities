sidebar <- function() {
  div(
    h1("Deprivation and Health"),
    uiOutput("hello"),
    style = "
      position: fixed;
      left: 0;
      top: 0;
      background-color: rgba(100, 200, 200, 0.1);
      height: 100%;
      padding: 5%;
      width: 33%;
      overflow-y: auto;
    "
  )

}
