devtools::load_all(".")

# Checks if there is a newer version of dataset

if(cbr_check4updates()){

  # Delete files from "inst/extdata" folder
  list_files <- list.files(pattern="*.csv", path = "./inst/extdata")
  list_files <- stringr::str_c("./inst/extdata",list_files, sep = "/")
  unlink(list_files)

  # Request
  resp <- cbr_download(url_file = cbr_download_url(),
                       dir = "./inst/extdata",
                       keep_filename = TRUE)


  # Get absolute path
  abs_path_unzip <- stringr::str_c(
    "./inst/extdata/",
    stringr::str_replace(resp$url,
                         pattern = ".+/(.+)\\.\\w+$",
                         replacement = "\\1"),
    ".",
    tools::file_ext(resp$url)
  )


  # Unzip
  cbr_unzip(abs_path_unzip,
            dir = "./inst/extdata",
            keep_zip_file = FALSE)


  # Set the date range
  today <- Sys.Date()
  date_3_months_ago <- today - months(3)


  # Get database
  covidBR <- cbr_data(dir = "./inst/extdata",
                      date = c(date_3_months_ago, today))


  # Generate the R dataset
  usethis::use_data(covidBR, overwrite = TRUE)

}else{

  message("The data is now up to date!")

}
