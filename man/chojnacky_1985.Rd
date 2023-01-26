\name{chojnacky_1985}
\alias{chojnacky_1985}
\title{Chojnacky (1985)}
\description{Allometric models from Chojnacky (1985)}
\section{Stem Volume Models}{\code{vsa = (a + b * (dsoc^2 * hst))^3}
\itemize{
\item{\code{vsa [ft3]}}{ - volume of the entire stem, including top and stump}
\item{\code{dsoc [in]}}{ - diameter outside bark above the root collar}
\item{\code{hst [ft]}}{ - total height of the stem}
}
\bold{Model Parameters}
\preformatted{  region geographic_re~1 family genus species       a     b
1 US-CO  entire State    Cupre~ Juni~ scopul~  0.0243 0.119
2 US-CO  entire State    Fagac~ Quer~ gambel~ -0.136  0.146
3 US-ID  southern Idaho  Cupre~ Juni~ scopul~  0.0243 0.119
4 US-SD  Black Hills     Fagac~ Quer~ macroc~  0.129  0.106
5 US-UT  eastern Utah    Cupre~ Juni~ scopul~  0.0243 0.119
6 US-WY  entire State    Cupre~ Juni~ scopul~  0.0243 0.119
7 US-WY  Black Hills     Fagac~ Quer~ macroc~  0.129  0.106
# ... with abbreviated variable name 1: geographic_region}
\out{<hr>}
\code{vsa = (a + b * (dsoc^2 * hst + c * single_stem))^3}
\itemize{
\item{\code{vsa [ft3]}}{ - volume of the entire stem, including top and stump}
\item{\code{dsoc [in]}}{ - diameter outside bark above the root collar}
\item{\code{hst [ft]}}{ - total height of the stem}
\item{\code{single_stem []}}{ - Equal to 1 if the tree has one stem, 0 otherwise}
}
\bold{Model Parameters}
\preformatted{   region geographic_r~1 family genus species       a     b
 1 US-CO  eastern Color~ Cupre~ Juni~ monosp~ -0.193  0.136
 2 US-CO  western Color~ Cupre~ Juni~ osteos~ -0.0873 0.135
 3 US-CO  entire State   Pinac~ Pinus edulis  -0.203  0.150
 4 US-ID  southern Idaho Rosac~ Cerc~ ledifo~ -0.134  0.128
 5 US-ID  southern Idaho Cupre~ Juni~ occide~ -0.220  0.125
 6 US-ID  southern Idaho Cupre~ Juni~ osteos~ -0.134  0.134
 7 US-ID  southern Idaho Pinac~ Pinus monoph~ -0.142  0.148
 8 US-NV  entire State   Rosac~ Cerc~ ledifo~ -0.134  0.128
 9 US-NV  entire State   Cupre~ Juni~ occide~ -0.220  0.125
10 US-NV  Carson City, ~ Cupre~ Juni~ osteos~ -0.134  0.134
11 US-NV  Elya           Cupre~ Juni~ osteos~ -0.0366 0.136
12 US-NV  Winnemucca an~ Cupre~ Juni~ osteos~  0.0483 0.114
13 US-NV  entire State   Pinac~ Pinus monoph~ -0.142  0.148
14 US-UT  eastern Utah   Rosac~ Cerc~ ledifo~ -0.134  0.128
15 US-UT  eastern Utah   Cupre~ Juni~ osteos~ -0.0873 0.135
16 US-UT  western Utah   Cupre~ Juni~ osteos~ -0.134  0.134
17 US-UT  eastern Utah   Pinac~ Pinus edulis  -0.203  0.150
18 US-UT  western Utah   Pinac~ Pinus monoph~ -0.142  0.148
19 US-WY  entire State   Rosac~ Cerc~ ledifo~ -0.134  0.128
20 US-WY  entire State   Cupre~ Juni~ osteos~ -0.0873 0.135
21 US-WY  entire State   Pinac~ Pinus edulis  -0.203  0.150
# ... with 1 more variable: c <dbl>, and abbreviated
#   variable name 1: geographic_region
# i Use `colnames()` to see all variable names}
\out{<hr>}
\code{vsa = (a + b * (dsoc^2 * hst))^3}
\itemize{
\item{\code{vsa [ft3]}}{ - volume of the entire stem, including top and stump}
\item{\code{dsoc [in]}}{ - diameter outside bark above the root collar}
\item{\code{hst [ft]}}{ - total height of the stem}
}
\bold{Model Parameters}
\preformatted{  region species_group geographic_region      a     b
1 US-CO  hardwoods     entire State      -0.138 0.122
2 US-ID  hardwoods     southern Idaho    -0.138 0.122
3 US-WY  hardwoods     entire State      -0.138 0.122}
\out{<hr>}}
