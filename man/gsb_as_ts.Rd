% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/as-series.r
\name{gsb_as_ts}
\alias{gsb_as_ts}
\title{Retrieve attack/compromised host time series info for an AS}
\usage{
gsb_as_ts(as, count = TRUE)
}
\arguments{
\item{as}{AS number to query (without the "\code{AS}" prefix)}

\item{count}{return counts (\code{TRUE}) or perecentages (i.e. rate)}
}
\value{
\code{data.frame} (\code{tbl_df}) with (probably) massive time series info
}
\description{
Retrieve attack/compromised host time series info for an AS
}
\examples{
\dontrun{
gsb_as_ts("10439")
}
}

