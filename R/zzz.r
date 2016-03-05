.pkgenv <- new.env(parent=emptyenv())

.onAttach <- function(...) {

  ctx <- V8::v8()
  assign("ctx", ctx, envir=.pkgenv)

  if (!interactive()) return()

  packageStartupMessage(paste0("safebrowsing is under *active* development. ",
                               "See https://github.com/hrbrmstr/safebrowsing for changes"))

}
