\name{moore_1996}
\alias{moore_1996}
\title{Moore, Zhang, and Stuck (1996)}
\description{Allometric models from Moore, Zhang, and Stuck (1996)}
\section{Stem Height Models}{\code{hst = 4.5 + exp(a + (b/(dsob + 1)))}
\itemize{
\item{\code{hst [ft]}}{ - total height of the stem}
\item{\code{dsob [in]}}{ - diameter of the stem, outside bark at breast height}
}
\bold{Model Parameters}
\preformatted{family       genus       species      a           b
Pinaceae     Pinus       monticola    5.3004 -12.4 
Pinaceae     Larix       occidentalis 5.2554 -11.3 
Pinaceae     Pseudotsuga menziesii    5.0207  -9.89
Pinaceae     Abies       grandis      5.1472 -10.4 
Pinaceae     Tsuga       heterophylla 4 9079  -8.01
Cupressaceae Thuja       plicata      5.1039 -14.6 
Pinaceae     Pinus       contorta     4.7979  -7.55
Pinaceae     Picea       engelmannii  5.1282 -12.8 
Pinaceae     Abies       lasiocarpa   4.918   -9.87
Pinaceae     Pinus       ponderosa    5.1094 -11.9 }
\out{<hr>}
\code{hst = 4.5 + a * exp(-b * dsob^(-c))}
\itemize{
\item{\code{hst [ft]}}{ - total height of the stem}
\item{\code{dsob [in]}}{ - diameter of the stem, outside bark at breast height}
}
\bold{Model Parameters}
\preformatted{family       genus       species          a     b     c
Pinaceae     Pinus       monticola     267.  6.23 0.649
Pinaceae     Larix       occidentalis 1286.  5.49 0.262
Pinaceae     Pseudotsuga menziesii     995.  5.00 0.249
Pinaceae     Abies       grandis       314.  4.72 0.478
Pinaceae     Tsuga       heterophylla  132.  7.12 1.00 
Cupressaceae Thuja       plicata       186.  7.73 0.752
Pinaceae     Pinus       contorta      120.  5.49 0.913
Pinaceae     Picea       engelmannii   559.  4.96 0.334
Pinaceae     Abies       lasiocarpa    172.  5.22 0.667
Pinaceae     Pinus       ponderosa    1769.  5.77 0.220}
\out{<hr>}}
