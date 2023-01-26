\name{hann_2011}
\alias{hann_2011}
\title{Hann (2011)}
\description{Allometric models from Hann (2011)}
\section{Stem Diameter Models}{\code{dsib = b_1 * dsob^b_2 * exp(b_3 * (1 - rc)^(0.5))}
\itemize{
\item{\code{dsib [in]}}{ - diameter of the stem, inside bark at breast height}
\item{\code{dsob [in]}}{ - diameter of the stem, outside bark at breast height}
\item{\code{rc [ft ft-1]}}{ - crown ratio}
}
\bold{Model Parameters}
\preformatted{  family       genus       species       b_1   b_2     b_3
1 Pinaceae     Pseudotsuga menziesii   0.924 0.989 -0.0341
2 Cupressaceae Calocedrus  <NA>        0.879 1     -0.0770
3 Pinaceae     Pinus       ponderosa   0.809 1.02   0     
4 Pinaceae     Pinus       lambertiana 0.859 1      0     
5 Pinaceae     Abies       concolor    0.922 1     -0.0342
6 Pinaceae     Abies       grandis     0.922 1     -0.0342}
\out{<hr>}}
\section{Stump Diameter Models}{\code{dui1 = b_1 + b_2 * dsob^b_3 * exp(b_4 * rc^b_5)}
\itemize{
\item{\code{dui1 [in]}}{ - diameter of the stump, inside bark at one unit}
\item{\code{dsob [in]}}{ - diameter of the stem, outside bark at breast height}
\item{\code{rc [ft ft-1]}}{ - crown ratio}
}
\bold{Model Parameters}
\preformatted{  family       genus  species   b_1   b_2 b_3     b_4   b_5
1 Pinaceae     Pseud~ menzie~ 0.150 0.901 1.02~ 0.134  3.68
2 Cupressaceae Caloc~ <NA>    0.452 0.832 1.05~ 0.216  7.00
3 Pinaceae     Pinus  ponder~ 0     1.00  0     0      0   
4 Pinaceae     Pinus  lamber~ 0     1.04  0     0      0   
5 Pinaceae     Abies  concol~ 0.393 0.730 1 09~ 0.121  1   
6 Pinaceae     Abies  grandis 0.393 0.730 1 09~ 0.121  1   }
\out{<hr>}}
\section{Stem Volume Models}{\code{vso = b_1 * (hso/dsob)^(b_2 * (1 - exp(b_3 * dsob^b_4)))^k * exp(b_5 * (hsv/hso)) * dsob^b_7 * dsob^2 * hso}
\itemize{
\item{\code{vso [ft3]}}{ - volume of the stem above breast height}
\item{\code{hso [ft]}}{ - height of the stem above breast height}
\item{\code{dsob [in]}}{ - diameter of the stem, outside bark at breast height}
\item{\code{hsv [ft]}}{ - height of the stem to crown base above breast height}
}
\bold{Model Parameters}
\preformatted{  family    genus species     b_1   b_2    b_3   b_4    b_5
1 Pinaceae  Pseu~ menzie~ 1.24e-3 0.346 -0.566 0.632 -0.152
2 Cupressa~ Calo~ <NA>    9.08e-4 0.343 -0.639 1.59   0    
3 Pinaceae  Pinus ponder~ 1.28e-3 0.162  1     0      0    
4 Pinaceae  Pinus lamber~ 8.56e-4 0.388  1     0      0    
5 Pinaceae  Abies concol~ 1.33e-3 0.358 -0.755 0.5   -0.262
6 Pinaceae  Abies grandis 1.33e-3 0.358 -0.755 0.5   -0.262
# ... with 3 more variables: b_6 <dbl>, b_7 <dbl>, k <int>
# i Use `colnames()` to see all variable names}
\out{<hr>}}
