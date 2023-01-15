\name{ritchie_1987}
\alias{ritchie_1987}
\title{Ritchie and Hann (1987)}
\description{Allometric models from Ritchie and Hann (1987)}
\section{Crown Ratio Models}{\code{rc = 1 - ((1)/(1 + exp(b_0 + b_1 * hst + b_2 * ccfl + b_3 * log(gn) + b_4 * (dsob/hst) + b_5 * (hstix50 - 4.5))))}
\itemize{
\item{\code{rc [ft ft-1]}}{ - crown ratio}
\item{\code{hst [ft]}}{ - total height of the stem}
\item{\code{ccfl [ft2 ft-2]}}{ - variable not defined}
\item{\code{gn [ft2 acre-1]}}{ - variable not defined}
\item{\code{dsob [in]}}{ - diameter of the stem, outside bark at breast height}
\item{\code{hstix50 [ft]}}{ - site index at 50 year base age}
}
\bold{Model Parameters}
\preformatted{  family   genus       species     b_0      b_1      b_2    b_3   b_4     b_5
1 Pinaceae Pseudotsuga menziesii  2.60 -0.00726 -0.00458 -0.442  1.61 0.00468
2 Pinaceae Abies       grandis    2.71 -0.00367 -0.00455 -0.505  1.73 0.00473
3 Pinaceae Abies       concolor   2.71 -0.00367 -0.00455 -0.505  1.73 0.00473
4 Pinaceae Pinus       ponderosa  2.35 -0.00206 -0.00260 -0.622  3.10 0.00426}
\out{<hr>}
\code{rc = 1 - ((1)/(1 + exp(b_0 + b_1 * hst + b_2 * ccfl + b_3 * log(gn))))}
\itemize{
\item{\code{rc [ft ft-1]}}{ - crown ratio}
\item{\code{hst [ft]}}{ - total height of the stem}
\item{\code{ccfl [ft2 ft-2]}}{ - variable not defined}
\item{\code{gn [ft2 acre-1]}}{ - variable not defined}
}
\bold{Model Parameters}
\preformatted{  family    genus   species       b_0      b_1      b_2    b_3
1 Pinaceae  Pinus   lambertiana  2.60 -0.00726 -0.00458 -0.442
2 Ericaceae Arbutus menziesii    2.71 -0.00367 -0.00455 -0.505}
\out{<hr>}
\code{rc = 1 - ((1)/(1 + exp(b_0 + b_2 * ccfl + b_3 * log(gn) + b_4 * (dsob/hst))))}
\itemize{
\item{\code{rc [ft ft-1]}}{ - crown ratio}
\item{\code{hst [ft]}}{ - total height of the stem}
\item{\code{ccfl [ft2 ft-2]}}{ - variable not defined}
\item{\code{gn [ft2 acre-1]}}{ - variable not defined}
\item{\code{dsob [in]}}{ - diameter of the stem, outside bark at breast height}
}
\bold{Model Parameters}
\preformatted{  family       genus       species        b_0      b_2    b_3   b_4
1 Cupressaceae Calocedrus  decurrens     4.40 -0.00267 -0.845  1.09
2 Fagaceae     Chrysolepis chrysophylla  1.66 -0.00241 -0.355  1.25}
\out{<hr>}
\code{rc = 1 - ((1)/(1 + exp(b_0 + b_2 * ccfl)))}
\itemize{
\item{\code{rc [ft ft-1]}}{ - crown ratio}
\item{\code{ccfl [ft2 ft-2]}}{ - variable not defined}
}
\bold{Model Parameters}
\preformatted{  family   genus   species        b_0      b_2
1 Pinaceae Tsuga   heterophylla 0.791 -0.00256
2 Fagaceae Quercus garryana     0.362 -0.00648}
\out{<hr>}
\code{rc = 1 - ((1)/(1 + exp(b_2 * ccfl)))}
\itemize{
\item{\code{rc [ft ft-1]}}{ - crown ratio}
\item{\code{ccfl [ft2 ft-2]}}{ - variable not defined}
}
\bold{Model Parameters}
\preformatted{  family   genus            species           b_2
1 Fagaceae Notholithocarpus densiflorus -0.000886}
\out{<hr>}
\code{rc = 1 - ((1)/(1 + exp(b_0 + b_3 * log(gn))))}
\itemize{
\item{\code{rc [ft ft-1]}}{ - crown ratio}
\item{\code{gn [ft2 acre-1]}}{ - variable not defined}
}
\bold{Model Parameters}
\preformatted{  family   genus   species       b_0    b_3
1 Fagaceae Quercus chrysolepis  2.22 -0.427}
\out{<hr>}
\code{rc = 1 - ((1)/(1 + exp(b_0 + b_3 * log(gn) + b_4 * (dsob/hst))))}
\itemize{
\item{\code{rc [ft ft-1]}}{ - crown ratio}
\item{\code{hst [ft]}}{ - total height of the stem}
\item{\code{dsob [in]}}{ - diameter of the stem, outside bark at breast height}
\item{\code{gn [ft2 acre-1]}}{ - variable not defined}
}
\bold{Model Parameters}
\preformatted{  family   genus   species     b_0    b_3   b_4
1 Fagaceae Quercus kelloggii  2.66 -0.647 0.728}
\out{<hr>}
\code{rc = 1 - ((1)/(1 + exp(b_0 + b_1 * hst + b_2 * ccfl)))}
\itemize{
\item{\code{rc [ft ft-1]}}{ - crown ratio}
\item{\code{hst [ft]}}{ - total height of the stem}
\item{\code{ccfl [ft2 ft-2]}}{ - variable not defined}
}
\bold{Model Parameters}
\preformatted{  family   genus   species     b_0      b_1      b_2
1 Fagaceae Quercus kelloggii 0.919 -0.00768 -0.00618}
\out{<hr>}}
