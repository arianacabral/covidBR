#' Get the download url of a public file
#'
#' @description The original data comes from the Brazilian
#' COVID-19 Portal (Portal do COVID-19), and can be found at
#' <https://covid.saude.gov.br>. Daily, the Ministry of Health
#' (Ministerio da Saude) updates and publicly disseminates the database, and,
#' consequently, the download url is updated. This function scrape the link
#' address of the web page and returns the URL download for the public file.
#'
#' @return the URL to download the public file.
#'
#' @export
#'
#' @seealso
#'   [httr::GET()], [httr::content()]
#'
#' @examples
#'  \dontrun{cbr_dowload_url()}
#'
cbr_download_url <- function(){

  gov_url <- "https://xx9p7hp1p7.execute-api.us-east-1.amazonaws.com/prod/PortalGeral"

  info_pg <- httr::GET(
    gov_url,
    httr::add_headers("x-parse-application-id" = "unAFkcaNDeXajurGB7LChj8SgQYS2ptm")
  ) %>%
    httr::content()

  download_url <- info_pg$results[[1]]$arquivo$url

  return(download_url)

}
