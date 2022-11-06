#' Read and bind multiple files of COVID-19 Portal
#'
#' @description This function read and bind all files available in a directory
#' and returns the database in data table format.
#'
#' @param dir a `character` string, corresponding the directory containing the
#' files downloaded from the COVID-19 Portal.
#' @param save2disk `logical`. If [TRUE], the database is saved in a file in
#' csv format.
#' @param filepath a `character` string, corresponding the folder where files will
#' be save. By default, the current directory is used
#' (see [getwd()]).
#' @param date a date string, in year-month-day format (e.g.:`"2022-11-06").
#' + Data from "2022-10-06" to "2022-10-07": date = c("2022-10-06","2022-10-07")
#'
#' @return a `data.table` object with 17 columns, corresponding the database.
#' @export
#'
#' @examples \dontrun{
#' covid_br_db <- cbr_data("./data-raw")
#' }
cbr_data <- function(dir = ".", filepath = ".", save2disk = FALSE, date = NULL){

  list_files <- list.files(pattern="*.csv", path = dir)

  list_files <- stringr::str_c(dir,list_files, sep = "/")

  covid_br_db <- purrr::map(list_files,
                            data.table::fread,
                            encoding = 'UTF-8') %>%
    dplyr::bind_rows() %>%
    janitor::remove_empty("cols") %>%
    janitor::clean_names()


  if(!is.null(date)){

    if(length(date) == 1){

      covid_br_db <- covid_br_db    %>%
        dplyr::filter(data == date)

      cat(paste("Data from",date))

    }
    else if(length(date) == 2){

      if(date[1] <= date[2]){

        date_from <- date[1]
        date_to <- date[2]

      }else{

        date_from <- date[2]
        date_to <- date[1]
      }

      covid_br_db <- covid_br_db    %>%
        dplyr::filter(dplyr::between(data,
                                     as.Date(date_from, "%Y-%m-%d"),
                                     as.Date(date_to, "%Y-%m-%d")))

      cat(paste("Data from",date_from,"to",date_to))

    }
    else{

      warning("Invalid date!")
      message(paste("Data from",max(covid_br_db$data)))

    }


  }


  if(save2disk){

    data.table::fwrite(covid_br_db,
                       file = stringr::str_c(
                         filepath,
                         "/",
                         "covidBR",
                         "_",
                         format(Sys.time(), "%d-%m-%Y_%H-%M-%S"),
                         ".csv",
                         sep = ""
                       ), encoding = 'UTF-8')
  }

  return(covid_br_db)

}
