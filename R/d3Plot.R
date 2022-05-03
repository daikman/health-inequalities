library(dplyr)

d3Plot <- function(resource, selected_metrics, all_metrics) {
  data <- resource$data %>%
    rename("SIMD" = resource$SIMD) %>%
    select(SIMD, all_of(selected_metrics)) %>%
    # reverse-code SIMD
    mutate(SIMD = abs(SIMD - max(SIMD) - 1))

  r2d3::r2d3(jsonlite::toJSON(list(data, c(all_metrics))), "./js/plot.js")
}
