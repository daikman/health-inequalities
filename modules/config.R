config <- list(
  "Suicide statistics" = list(
    dom_id = "suicide",
    res_id = "f4e70964-38c9-44f6-aaba-08e38f8dbb2f",
    SIMD = "SIMDDecile",
    metrics = c("IndividualsCount" = "Number of events")
  ),
  "Cardiovascular emergencies" = list(
    dom_id = "cardio",
    res_id = "cc2077e8-233f-4793-9e89-06a8380bc33e",
    SIMD = "SIMDQuintile",
    metrics = c("CardioAdmissions" = "Cardio admissions", "Average20182019" = "Average 2018-2019")
  ),
  "Alcohol-related hospital staya" = list(
    dom_id = "alcohol",
    res_id = "2d158224-1adf-4ffc-8e65-a05fe5712ea0",
    SIMD = "SIMDDecile",
    metrics = c("AverageNumberOfStaysPerPatient" = "Avg. stays per patient")
  ),
  "Mental illness related hospital stays" = list(
    dom_id = "mental-illness",
    res_id = "ff797b7c-94cb-4efa-83dd-58e378cb7d8d",
    SIMD = "SIMD",
    metrics = c("PatientsRates" = "Patients per 100000 pop.")
  ),
  "Ambulance incidents" = list(
    dom_id = "ambulance",
    res_id = "12e52d78-bff5-4fde-8085-f1b03667a8e5",
    SIMD = "SIMDQuintile",
    metrics = c("SASIncidents" = "Number of emergencies")
  )
)

# get all data at start-up
for (i in seq_along(config)) {
  resource <- config[[i]]

  # fetch data from API
  data <- phsopendata::get_resource(resource$res_id)

  # wrangle according to config
  data <- data %>%
    group_by(across(all_of(resource$SIMD))) %>%
    summarise(
      across(
        names(resource$metrics),
        ~mean(.x, na.rm = TRUE)
      )
    ) %>%
    mutate(across(everything(),
                  ~suppressWarnings(as.numeric(.x)))) %>%
    tidyr::drop_na()

  # normalize metrics
  data <- data %>%
    mutate(across(names(resource$metrics), ~(.x-min(.x))/(max(.x)-min(.x))))

  config[[i]]$data <- data
}
