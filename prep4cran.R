devtools::document(roclets = c('rd', 'collate', 'namespace', 'vignette'))
devtools::build()

pkgdown::build_site()

version <- Biobase::package.version("qr4genebanks")

file_name <- paste0("../qr4genebanks_", version, ".tar.gz")

rhub::check_for_cran(file_name)
rhub::check_on_macos(file_name)
rhub::check_on_linux(file_name)
rhub::check_on_windows(file_name)
rhub::check_with_rdevel(file_name)
