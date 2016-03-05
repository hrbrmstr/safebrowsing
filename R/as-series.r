#' Retrieve attack/compromised host time series info for an AS
#'
#' @param as AS number to query (without the "\code{AS}" prefix)
#' @param count return counts (\code{TRUE}) or perecentages (i.e. rate)
#' @return \code{data.frame} (\code{tbl_df}) with (probably) massive time series info
#' @export
#' @examples \dontrun{
#' gsb_as_ts("10439")
#' }
gsb_as_ts <- function(as, count=TRUE) { # count==FALSE gets %

  count <- if (count) "COUNT" else "RATE"
  as <- sub("^as", "", as, ignore.case=TRUE)

  SPATH <-
    sprintf("transparencyreport/jsonp/sb/malware/ts/%s/?a=%s&t=ATTACK&t=COMPROMISED&c=",
            as, count)

  res <- S_GET("https://www.google.com",
               path=SPATH,
               add_headers(Accept="*/*",
                           Referer=REF1,
                           `User-Agent`=UA))

  if (!is.null(res$result)) {

    js <- content(res$result, as="text")

    .pkgenv$ctx$eval(sprintf("var dat=%s", js))

    dat <- data.frame(.pkgenv$ctx$get("dat"), stringsAsFactors=FALSE)
    dat$date <- as.Date(as.POSIXct(dat$time.series.1/1000,
                                   origin='1970-01-01', tz="UTC"))
    dat <- select(dat,
                  date, asn, name, description, attack=time.series.2,
                  compromised=time.series.3, -sites.types, -time.series.1)

    return(dplyr::tbl_df(dat))

  } else {
    stop("Error retrieving data safesearch detailed asn info", call.=FALSE)
  }

}
