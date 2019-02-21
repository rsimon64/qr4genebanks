message("Building ...")
devtools::document(roclets = c('rd', 'collate', 'namespace', 'vignette'))
devtools::build()

message("Creating site ...")

pkgdown::build_site()



version <- Biobase::package.version("qr4genebanks")

file_name <- paste0("../qr4genebanks_", version, ".tar.gz")

message("Check CRAN")
rhub::check_for_cran(file_name)
message("Check MacOS")
rhub::check_on_macos(file_name)
message("Check Linux")
rhub::check_on_linux(file_name)
message("Check Windows")
rhub::check_on_windows(file_name)
message("Check Next version")
rhub::check_with_rdevel(file_name)
