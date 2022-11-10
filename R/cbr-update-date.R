#' Get the update date
#'
#' @description This function scrape the link
#' address of the web page and returns the update date of the public files.
#'
#' @return a `character` string, corresponding to the date when the public
#' files were last updated.
#' @export
#'
#' @examples
#' \dontrun{cbr_update_date()}
cbr_update_date <- function(){

  info <- cbr_get_web_info()

  update_date <- info$results$dt_atualizacao

  return(update_date)

}
