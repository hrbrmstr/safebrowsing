# get the data behind https://www.google.com/transparencyreport/safebrowsing/malware/

#' Retrive AS info from Google SafeBrowsing
#'
#' @param as_size return results for \code{all} ASNs or just the \code{largest}?
#' @param time_range number of days of history for the time series
#' @param type_detected one of \code{both}, \code{attack} or \code{compromised}.
#' @param region ISO2 region code or \code{all}
#' @param .progress display a progress bar?
#' @note Depending on the parameters used (especially \code{time_range}),
#'       this opereation could take a while. You should probably turn on
#'       progress bars for any query > 7 days.
#' @return \code{data.frame} (\code{tbl_df}) with ASN info
#' @references See \href{https://www.google.com/transparencyreport/safebrowsing/malware/?hl=en}{Google's page}
#'       for more information on how they scan & report ASN info.
#' @export
#' @examples \dontrun{
#' gsb_asinfo("largest", 7)
#' }
gsb_asinfo <- function(as_size=c("largest", "all"),
                       time_range=90,
                       type_detected=c("both", "attack", "compromised"),
                       region="all",
                       .progress=FALSE) {

  as_size <- match.arg(as_size, c("largest", "all"))
  type_detected <- match.arg(type_detected, c("both", "attack", "compromised"))

  first <- get_as_info_page(0, as_size, time_range, type_detected, region)

  if (.progress & interactive()) pb <- txtProgressBar(0, first$`page-count`, style=3)

  map_df(1:(first$`page-count`-1), function(pg) {
    if (.progress & interactive()) setTxtProgressBar(pb, pg)
    res <- get_as_info_page(pg, as_size, time_range, type_detected, region)
    res$table
  }) -> asn_tbl_pages

  if (.progress & interactive()) close(pb)

  dplyr::bind_rows(first$table, asn_tbl_pages)

}

get_as_info_page <- function(page=0,
                             as_size=c("largest", "all"),
                             time_range=90,
                             type_detected=c("both", "attack", "compromised"),
                             region="all") {

  as_size <- toupper(match.arg(as_size, c("largest", "all")))
  type_detected <- toupper(match.arg(type_detected, c("both", "attack", "compromised")))
  if (region == "all") region <- ""

  res <- S_GET("https://www.google.com",
               path="transparencyreport/jsonp/sb/malware/table/",
               query=list(t=type_detected,
                          d=time_range,
                          z=as_size,
                          p=page,
                          r=region,
                          c=""),
               httr::add_headers(Accept="*/*",
                                 Referer=REF1,
                                 `User-Agent`=UA))

  if (!is.null(res$result)) {

    js <- httr::content(res$result, as="text")

    .pkgenv$ctx$eval(sprintf("var dat=%s", js))

    dat <- .pkgenv$ctx$get("dat")

    return(dat)

  } else {
    stop("Error retrieving data safesearch asn info", call.=FALSE)
  }

}
