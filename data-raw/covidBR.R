devtools::load_all(".")

list_files <- list.files(pattern="*.csv", path = "./data-raw")

list_files <- stringr::str_c("./data-raw",list_files, sep = "/")

unlink(list_files)

resp <- cbr_download(url_file = cbr_download_url(),
                     dir = "./data-raw",
                     keep_filename = TRUE)

abs_path_unzip <- stringr::str_c(
  "./data-raw/",
  stringr::str_replace(resp$url,
                       pattern = ".+/(.+)\\.\\w+$",
                       replacement = "\\1"),
  ".",
  tools::file_ext(resp$url)
)

cbr_unzip(abs_path_unzip,
          dir = "./data-raw",
          keep_zip_file = FALSE)

today <- Sys.Date()

date_3_months_ago <- today - months(3)

covidBR <- cbr_data(dir = "./data-raw",
                    date = c(date_3_months_ago, today))

usethis::use_data(covidBR, overwrite = TRUE)
