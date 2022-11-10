#' Compute information for a response.
#'
#' @description
#' This function use the GET request method to fetch data from a government
#' server and provides details about the response body.
#'
#' @return a `list`, corresponding the response body.
#' @seealso
#'   [httr::GET()], [httr::content()]
#' @noRd
#' @examples
#' \dontrun{
#' cbr_get_web_info()
#' }
cbr_get_web_info <- function(){

  gov_url <- "https://xx9p7hp1p7.execute-api.us-east-1.amazonaws.com/prod/PortalGeral"

  info <- httr::GET(
    gov_url,
    httr::add_headers("x-parse-application-id" = "unAFkcaNDeXajurGB7LChj8SgQYS2ptm")
  ) %>%
    httr::content() %>%
    purrr::flatten()

  return(info)

}
