#' Download a file from an existing download URL
#'
#' @description Download a public file from an existing download URL.
#'
#' @param url_file a `character` string, corresponding the URL to download the
#'  public file.
#' @param dir a `character` string, corresponding the directory where file
#' should be downloaded. By default, the current directory is used
#' (see [getwd()]).
#' @param filename a `character` string, corresponding the filename (without the
#' extension) saved
#' on the local disc. By default, **covidBR** was used as filename.
#' @param keep_filename `logical`. If [TRUE], the name of public
#' file will be used and parameter `filename` is ignored (`default = FALSE`).
#' @param overwrite `logical`. If [TRUE], the default, the local file with the
#'  same name will be overwritten.
#' @param show_progress `logical`. If [TRUE], the default, shows a progress bar
#' for uploading.
#'
#' @seealso [httr::RETRY()], [httr::GET()]
#'
#' @export
#'
#' @examples
#' \dontrun{
#' # Get dowload url (COVID-19 Portal)
#' download_url <- cbr_dowload_url()
#'
#' # Save file with default name ('data')
#' cbr_download(url_file = download_url)
#'
#' # Save file with name 'my_data'
#' cbr_download(url_file = download_url, filename = "mydata")
#'
#' # Save file with default name of COVID-19 Portal
#' cbr_download(url_file = download_url, keep_filename = TRUE)
#'
#' # Save file in 'myfolder' folder
#' cbr_download(url_file = download_url, dir = "./myfolder")
#'
#' }
cbr_download <- function(url_file = NULL,
                         dir = getwd(),
                         filename = "covidBR",
                         keep_filename = FALSE,
                         overwrite = TRUE,
                         show_progress = getOption("covidBR.verbose", default = interactive())
){

  progress <- httr::progress("down")

  if (!show_progress){
    progress <- NULL
  }

  if(!keep_filename){

    if(stringi::stri_isempty(filename)){

      filename <- stringr::str_c(
        "covidBR",
        tools::file_ext(url_file),
        sep = "."
      )
    }
    else{

        filename <- stringr::str_c(
          tools::file_path_sans_ext(filename),
          tools::file_ext(url_file),
          sep = "."
        )

    }

  }else{

    filename <- fs::path_file(url_file)
  }


  abs_path <- stringr::str_c(
    dir, filename, sep = "/"
  )

  resp <- httr::RETRY(
    verb = "GET",
    url = url_file,
    httr::write_disk(abs_path,
                     overwrite = overwrite),
    progress
  )

  # Try to use the redirection URL instead in case of "bad request"
  if (resp$status_code == 400) {

    resp <- httr::RETRY(
      verb = "GET",
      url = url_file,
      httr::write_disk(abs_path,
                       overwrite = overwrite),
      progress
    )

  }

  if(getOption("covidBR.verbose", default = TRUE)){
    httr::warn_for_status(resp)
  }

  invisible(resp)

}
