#' Get the download url of a public file
#'
#' @description The original data comes from the Brazilian
#' COVID-19 Portal (Portal do COVID-19), and can be found at
#' <https://covid.saude.gov.br>. Daily, the Ministry of Health
#' (Ministerio da Saude) updates and publicly disseminates the database, and,
#' consequently, the download URL is updated. This function scrape the link
#' address of the web page and returns the URL download for the public file.
#'
#' @return the URL to download the public file.
#'
#' @export
#'
#' @examples
#'  \dontrun{cbr_download_url()}
#'
cbr_download_url <- function(){

  info <- cbr_get_web_info()

  download_url <- info$results$arquivo$url

  return(download_url)

}
