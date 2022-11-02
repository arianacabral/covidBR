devtools::load_all(".")

resp <- cbr_download(url_file = cbr_dowload_url(),
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

covidBR <- cbr_data(dir = "./data-raw")

usethis::use_data(covidBR, overwrite = TRUE)
