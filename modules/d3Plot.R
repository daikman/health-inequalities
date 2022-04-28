d3Plot <- function(resource) {
  data <- resource$data %>%
    rename("SIMD" = resource$SIMD)
  r2d3::r2d3(data, "./js/plot.js")
}
