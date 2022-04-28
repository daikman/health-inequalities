style <- "
  position: fixed;
  top: 0;
  left: 0;
  margin: 0;
  padding: 0;
  width: 100%;
  height: 100px;
  background-color: rgba(100, 200, 100, 0.1);
"

header <- function() {
  tagList(
    fluidRow(
      column(
        6,
        h1("Deprivation and Health")
      ),
      column(
        6,
        buttons()
      ),
      style = style,
      class = "small-only"
    )
  )
}
