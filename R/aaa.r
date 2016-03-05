S_GET <- purrr::safely(httr::GET)

UA <- paste0("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_3) ",
             "AppleWebKit/537.36 (KHTML, like Gecko) Chrome/48.0.2564.116 ",
             "Safari/537.36", sep="", collapse="")

REF1 <- "https://www.google.com/transparencyreport/safebrowsing/malware/?hl=en"
REF2 <- "https://www.google.com/transparencyreport/safebrowsing/diagnostic/"
