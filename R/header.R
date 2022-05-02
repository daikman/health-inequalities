style <- "
  position: fixed;
  top: 0;
  left: 0;
  margin: 0;
  padding: 0;
  width: 100%;
  height: 64px;
  background-color: rgb(240, 250, 240);
  z-index: 10;
"

header <- function() {
  tagList(
    fluidRow(
      column(
        6,
        h2(
          "Health Inequalities in Scotland",
          style = "font-weight: bold; font-size: 24px"
        )
      ),
      column(
        6
      ),
      style = style
    )
  )
}
