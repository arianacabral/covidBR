#' Extract contents of an archive
#'
#' @description Extract contents of an archive to a directory.
#' @param zip_file a `character` string, corresponding the archive filename, or
#' an [archive] object.
#' @param dir a `character` string, corresponding the directory to extract
#' archive contents. By default, the current directory is used.
#' (see [getwd()]).
#' @param keep_zip_file logical. If [TRUE], deletes the zip archive.
#'
#' @seealso [archive::archive_extract()],[base::unlink()]
#' @export
#'
#' @examples
#' \dontrun{
#' cbr_unzip(file.choose())
#' }
cbr_unzip <- function(zip_file,
                      dir = ".",
                      keep_zip_file = TRUE){

  message("... Unzipping file")

  filenames <- archive::archive_extract(archive = zip_file, dir = dir)

  cat(paste0(filenames, collapse = "\n"))

  if(!keep_zip_file){

    base::unlink(zip_file)

  }

  invisible(filenames)

}
