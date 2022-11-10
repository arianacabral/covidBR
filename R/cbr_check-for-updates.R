#' Checks if there is a newer version of database
#'
#' @description Fetches the latest dataset version and compares it with your
#'  currently installed dataset version.
#' @return `logical`. If `TRUE`, there is a newer version of dataset.
#'
#' @noRd
#' @examples \dontrun{cbr_check4updates()}
#'
cbr_check4updates <- function(){

  url_date <- lubridate::dmy_hm(cbr_update_date(),
                                tz = "GMT")

  url_date <- lubridate::ymd(
    stringr::str_c(
      lubridate::year(url_date),
      lubridate::month(url_date),
      lubridate::day(url_date),
      sep = "-")
  )

  last_date <- max(covidBR$data, na.rm = TRUE)

  if(url_date > last_date){

    res <- TRUE

  }else{

    res <- FALSE

  }

  return(res)

}
