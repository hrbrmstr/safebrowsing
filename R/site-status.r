#' Retrive URL "site status"
#'
#' Pass in a vector of URLs and the Google Safe Browsing Site Status
#' for the URLs will be returned in a \code{data.frame} (\code{tbl_df})
#'
#' @param site_url non-relative URL to check
#' @return \code{data.frame} (\code{tbl_df}) with site status
#' @export
#' @examples \dontrun{
#' gsb_site_status(c("http://fgcdiesel.cl/encrypted.exe",
#'                   "http://rud.is/",
#'                   "http://dds.ec/"))
#' }
gsb_site_status <- function(site_urls) {
  purrr::map_df(site_urls, site_status)
}

site_status <- function(site_url) {

  res <- S_GET("https://www.google.com",
               path="safebrowsing/diagnostic",
               query=list(site=site_url,
                          output="jsonp"),
               httr::add_headers(Accept="*/*",
                                 Referer=REF2,
                                 `User-Agent`=UA))

  if (!is.null(res$result)) {

    js <- httr::content(res$result, as="text", encoding="UTF-8")

    js <- sub("^.*processResponse\\(", "", js)
    js <- sub("\\);$", "", js)

    .pkgenv$ctx$eval(sprintf("var dat=%s", js))

    tmp <- .pkgenv$ctx$get("dat")
    tmp <- as.list(unlist(tmp))

    tmp_names <- names(tmp)
    tmp_names <- sub("^website\\.", "", tmp_names)
    tmp_names <- gsub("\\.", "_", tmp_names)
    tmp_names <- gsub("([a-z])([A-Z])", "\\1_\\L\\2", tmp_names, perl=TRUE)
    tmp_names <- tolower(sub("^(.[a-z])", "\\L\\1", tmp_names, perl=TRUE))

    names(tmp) <- tmp_names

    dat <- dplyr::tbl_df(as.data.frame(tmp, stringsAsFactors=FALSE))

    return(dat)

  } else {
    stop("Error retrieving data safesearch detailed url info", call.=FALSE)
  }

}
