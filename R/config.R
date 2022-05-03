library(dplyr)

lineColours <- c(
  "rgb(100, 200, 200)", "rgb(200, 100, 200)", "rgb(200, 200, 100)"
)

config <- list(
  list(
    title = "Mental-illness related hospital stays",
    dom_id = "mental-illness",
    res_id = "ff797b7c-94cb-4efa-83dd-58e378cb7d8d",
    SIMD = "SIMD",
    metrics = c("PatientsRates" = "Patient rate", "DischargeRates" = "Discharge rate"),
    explanations = c(
      "Number of mental-illness patients per 100,000 population",
      "Number of discharges per 100,000 population. A discarge is a release from hospital, including deaths."
    ),
    url = "https://www.opendata.nhs.scot/dataset/mental-health-inpatient-activity/resource/ff797b7c-94cb-4efa-83dd-58e378cb7d8d"
  ),
  list(
    title = "Quiting Smoking",
    dom_id = "quit-smoking",
    res_id = "25e85a15-c1c4-4cef-9c87-b777beaa3323",
    SIMD = "SIMDQuintile",
    metrics = c("FourWeekQuitRate" = "Four week quit rate", "TwelveWeekQuitRate" = "Twelve week quit rate"),
    explanations = c(
      "Percentage of successful quits at 4-week follow-up",
      "Percentage of successful quits at 12-week follow-up"
    ),
    url = "https://www.opendata.nhs.scot/dataset/nhs-smoking-cessation-service-statistics-scotland/resource/25e85a15-c1c4-4cef-9c87-b777beaa3323"
  ),
  list(
    title = "Suicide statistics",
    dom_id = "suicide",
    res_id = "f4e70964-38c9-44f6-aaba-08e38f8dbb2f",
    SIMD = "SIMDDecile",
    metrics = c("CrudeRate" = "Rate of cases", "IndividualsCount" = "Number of cases"),
    url = "https://www.opendata.nhs.scot/dataset/the-scottish-public-health-observatory-suicide-overview/resource/f4e70964-38c9-44f6-aaba-08e38f8dbb2f",
    explanations = c(
      "The crude rate of suicides per 100,000 population in each deprivation group",
      "The total number of individuals whose underlying cause of death is classified as ‘intentional self-harm’ or ‘event of undetermined intent’."
    )
  ),
  list(
    title = "Cardiovascular emergencies",
    dom_id = "cardio",
    res_id = "cc2077e8-233f-4793-9e89-06a8380bc33e",
    SIMD = "SIMDQuintile",
    metrics = c("CardioAdmissions" = "Cardio admissions", "Average20182019" = "Average 2018-2019"),
    url = "https://www.opendata.nhs.scot/dataset/covid-19-wider-impacts-cardiovascular-activity/resource/cc2077e8-233f-4793-9e89-06a8380bc33e",
    explanations = c(
      "The weekly number of A&E attendances with cardiovascular problems.",
      "Average weekly number of cardiovascular attendances in 2018-2019."
    )
  ),
  list(
    title = "Alcohol-related hospital stays",
    dom_id = "alcohol",
    res_id = "2d158224-1adf-4ffc-8e65-a05fe5712ea0",
    SIMD = "SIMDDecile",
    metrics = c("AverageNumberOfStaysPerPatient" = "Avg. stays per patient", "EASRPatients" = "Patient rate"),
    explanations = c(
      "Number of hospital stays per patient, annually updated figure.",
      "The number of patients standardised by population size, age and sex."
    ),
    url = "https://www.opendata.nhs.scot/dataset/alcohol-related-hospital-statistics-scotland/resource/2d158224-1adf-4ffc-8e65-a05fe5712ea0"
  ),
  list(
    title = "Ambulance incidents",
    dom_id = "ambulance",
    res_id = "12e52d78-bff5-4fde-8085-f1b03667a8e5",
    SIMD = "SIMDQuintile",
    metrics = c("SASIncidents" = "Number of emergencies"),
    explanations = c(
      "Weekly number of incidents where Scottish Ambulance Services were called."
    ),
    url = "https://www.opendata.nhs.scot/dataset/43e244a6-35cb-4841-a622-34b6436ba743/resource/12e52d78-bff5-4fde-8085-f1b03667a8e5"
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

  # get last updated date
  last_mod <- httr::content(httr::GET(
    paste0("https://www.opendata.nhs.scot/api/3/action/resource_show?id=", resource$res_id)
  ))$result$last_modified %>%
    lubridate::as_date()

  config[[i]]$last_mod <- last_mod
  config[[i]]$data <- data
}
