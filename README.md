<!-- README.md is generated from README.Rmd. Please edit that file -->
`safebrowsing` : retrieve ASN & URL info from Google Safe Browsing

If you're not familiar with Google's "Safe Browing" "service", you should probably [go here](https://www.google.com/transparencyreport/safebrowsing/?hl=en) and read up on it before using this package.

Note also that this is package relies on undocumented APIs and could break if Google changes how they call the underlying XHR requests.

The following functions are implemented:

-   `gsb_as_ts`: Retrieve attack/compromised host time series info for an AS
-   `gsb_asinfo`: Retrive AS info from Google SafeBrowsing
-   `gsb_site_status`: Retrive URL "site status"

### News

-   Version released

### Installation

``` r
devtools::install_github("hrbrmstr/safebrowsing")
```

### Usage

``` r
library(safebrowsing)

# current verison
packageVersion("safebrowsing")
#> [1] '0.1.0.9000'

gsb_site_status(c("http://fgcdiesel.cl/encrypted.exe", 
                  "http://rud.is/", "http://dds.ec/"))
#> Source: local data frame [3 x 15]
#> 
#>            name malware_list_status uws_list_status social_list_status malware_download_list_status
#>           (chr)               (chr)           (chr)              (chr)                        (chr)
#> 1 fgcdiesel.cl/              listed        unlisted           unlisted                     unlisted
#> 2       rud.is/            unlisted        unlisted           unlisted                     unlisted
#> 3       dds.ec/            unlisted        unlisted           unlisted                     unlisted
#> Variables not shown: uws_download_list_status (chr), unknown_download_list_status (chr), num_ases (chr),
#>   num_listed_times (chr), as_list (chr), malware_site_type (chr), data_updated_date (chr), last_visit_date (chr),
#>   last_malicious_date (chr), num_tested (chr)

gsb_asinfo("largest", 7)
#> Source: local data frame [234 x 7]
#> 
#>    infection-count scanned-count          name                                       description infection-rate    asn
#>              (int)         (int)         (chr)                                             (chr)          (dbl)  (int)
#> 1             1081          5743    PEGTECHINC                                      PEG TECH INC           0.19  54600
#> 2              572          4778    RAINBOW-HK                           Rainbow network limited           0.12 134121
#> 3              785          6569 TOINTER-AS-AP   Royal Network Technology Co., Ltd. in Guangzhou           0.12 133731
#> 4              447          4741       ANCHNET Shanghai Anchang Network Security Technology Co.,           0.09  58879
#> 5             1692         19380       AS40676                                   Psychz Networks           0.09  40676
#> 6              765          9335    NOBIS-TECH                       Nobis Technology Group, LLC           0.08  15003
#> 7              945         14129     HOMEPL-AS                                           home.pl           0.07  12824
#> 8              228          3616     HOSTSPACE                            HOSTSPACE NETWORKS LLC           0.06  26484
#> 9              307          5702         CDMON                            10dencehispahard, S.L.           0.05 197712
#> 10             587         12613     NWT-AS-AP                 AS number for New World Telephone           0.05  17444
#> ..             ...           ...           ...                                               ...            ...    ...
#> Variables not shown: percent-all-sites (dbl)

gsb_as_ts("10439")
#> Source: local data frame [52 x 6]
#> 
#>          date   asn    name description attack compromised
#>        (date) (int)   (chr)       (chr)  (dbl)       (dbl)
#> 1  2015-03-01 10439 CARINET    CariNet,     10           0
#> 2  2015-03-08 10439 CARINET    CariNet,     11           0
#> 3  2015-03-15 10439 CARINET    CariNet,      8           3
#> 4  2015-03-22 10439 CARINET    CariNet,     10           4
#> 5  2015-03-29 10439 CARINET    CariNet,      9           2
#> 6  2015-04-05 10439 CARINET    CariNet,      8           0
#> 7  2015-04-12 10439 CARINET    CariNet,      8           3
#> 8  2015-04-19 10439 CARINET    CariNet,      7          10
#> 9  2015-04-26 10439 CARINET    CariNet,      8           3
#> 10 2015-05-03 10439 CARINET    CariNet,      7           2
#> ..        ...   ...     ...         ...    ...         ...
```

### Test Results

``` r
library(safebrowsing)
library(testthat)

date()
#> [1] "Sat Mar  5 09:22:38 2016"

test_dir("tests/")
#> testthat results ========================================================================================================
#> OK: 0 SKIPPED: 0 FAILED: 0
```

### Code of Conduct

Please note that this project is released with a [Contributor Code of Conduct](CONDUCT.md). By participating in this project you agree to abide by its terms.
