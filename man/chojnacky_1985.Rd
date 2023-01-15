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
\preformatted{  region geographic_region family       genus     species          a     b
1 US-CO  entire State      Cupressaceae Juniperus scopulorum  0.0243 0.119
2 US-CO  entire State      Fagaceae     Quercus   gambelii   -0.136  0.146
3 US-ID  southern Idaho    Cupressaceae Juniperus scopulorum  0.0243 0.119
4 US-SD  Black Hills       Fagaceae     Quercus   macrocarpa  0.129  0.106
5 US-UT  eastern Utah      Cupressaceae Juniperus scopulorum  0.0243 0.119
6 US-WY  entire State      Cupressaceae Juniperus scopulorum  0.0243 0.119
7 US-WY  Black Hills       Fagaceae     Quercus   macrocarpa  0.129  0.106}
\out{<hr>}
\code{vsa = (a + b * (dsoc^2 * hst + c * single_stem))^3}
\itemize{
\item{\code{vsa [ft3]}}{ - volume of the entire stem, including top and stump}
\item{\code{dsoc [in]}}{ - diameter outside bark above the root collar}
\item{\code{hst [ft]}}{ - total height of the stem}
\item{\code{single_stem []}}{ - Equal to 1 if the tree has one stem, 0 otherwise}
}
\bold{Model Parameters}
\preformatted{   region geographic_region                                 family       genus       species            a     b       c
 1 US-CO  eastern Colorado                                  Cupressaceae Juniperus   monosperma   -0.193  0.136  0.0382
 2 US-CO  western Colorado                                  Cupressaceae Juniperus   osteosperma  -0.0873 0.135 -0.0196
 3 US-CO  entire State                                      Pinaceae     Pinus       edulis       -0.203  0.150  0.0542
 4 US-ID  southern Idaho                                    Rosaceae     Cercocarpus ledifolius   -0.134  0.128  0.0802
 5 US-ID  southern Idaho                                    Cupressaceae Juniperus   occidentalis -0.220  0.125  0.100 
 6 US-ID  southern Idaho                                    Cupressaceae Juniperus   osteosperma  -0.134  0.134  0.0363
 7 US-ID  southern Idaho                                    Pinaceae     Pinus       monophylla   -0.142  0.148 -0.0167
 8 US-NV  entire State                                      Rosaceae     Cercocarpus ledifolius   -0.134  0.128  0.0802
 9 US-NV  entire State                                      Cupressaceae Juniperus   occidentalis -0.220  0.125  0.100 
10 US-NV  Carson City, Battle Mountain, Elko, and Las Vegas Cupressaceae Juniperus   osteosperma  -0.134  0.134  0.0363
11 US-NV  Elya                                              Cupressaceae Juniperus   osteosperma  -0.0366 0.136 -0.0185
12 US-NV  Winnemucca and Susanville                         Cupressaceae Juniperus   osteosperma   0.0483 0.114 -0.0458
13 US-NV  entire State                                      Pinaceae     Pinus       monophylla   -0.142  0.148 -0.0167
14 US-UT  eastern Utah                                      Rosaceae     Cercocarpus ledifolius   -0.134  0.128  0.0802
15 US-UT  eastern Utah                                      Cupressaceae Juniperus   osteosperma  -0.0873 0.135 -0.0196
16 US-UT  western Utah                                      Cupressaceae Juniperus   osteosperma  -0.134  0.134  0.0363
17 US-UT  eastern Utah                                      Pinaceae     Pinus       edulis       -0.203  0.150  0.0542
18 US-UT  western Utah                                      Pinaceae     Pinus       monophylla   -0.142  0.148 -0.0167
19 US-WY  entire State                                      Rosaceae     Cercocarpus ledifolius   -0.134  0.128  0.0802
20 US-WY  entire State                                      Cupressaceae Juniperus   osteosperma  -0.0873 0.135 -0.0196
21 US-WY  entire State                                      Pinaceae     Pinus       edulis       -0.203  0.150  0.0542}
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
