tr <- function(text) {
  cur_lang <- Sys.getenv("QR4GB_LANGUAGE")
  if (cur_lang == "") cur_lang = "en"

  if (cur_lang == "en") return("Upload archive to print")

  return("Subir archivo para imprimir")
}
