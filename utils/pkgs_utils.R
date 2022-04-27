library(dplyr)
library(purrr)
library(tidyr)
library(forcats)
library(stringr)
library(cwi)
library(dcws)
library(camiller)

##########  VARIABLES  ################################################## ----
yr <- 2020
cws_yr <- 2021

##########  FUNCTIONS  ################################################## ----
has_digits <- function(x) all((str_detect(x, "^\\d")), na.rm = TRUE)
not_digits <- function(x) !has_digits(x)

collapse_response <- function(data, categories, nons = c("Don't know", "Refused")) {
  keeps <- names(categories)
  df1 <- data %>%
    dplyr::mutate(response = forcats::fct_collapse(response, !!!categories)) %>%
    dplyr::group_by(dplyr::across(-value)) %>%
    dplyr::summarise(value = sum(value)) %>%
    dplyr::ungroup()
  
  if (is.null(nons)) {
    out <- df1 %>% dplyr::filter(response %in% keeps)
  } else {
    out <- df1 %>%
      cwi::sub_nonanswers(nons = nons) %>%
      dplyr::filter(response %in% keeps)
  }
  out
}

calc_shares_moe <- function(...) calc_shares(..., moe = moe, digits = 2)
add_grps_moe <- function(...) add_grps(..., moe = moe)