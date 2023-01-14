\name{iffsc_2022}
\alias{iffsc_2022}
\title{IFFSC (2022)}
\description{Allometric models from IFFSC (2022)}
\section{Tree Biomass Models}{\code{bt = a * (dsob^2 * (1.3 + ((b * dsob)/(c * dsob))) * rwd)^d}
\itemize{
\item{\code{bt [kg]}}{ - tree biomass}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
\item{\code{rwd [g/cm^3]}}{ - wood specific gravity}
}
\bold{Model Parameters}
\preformatted{  geographic_region forest_type             a     b     c     d
1 pantropical       dense ombrophilous 0.0568  31.2  30.1 0.989}
\out{<hr>}
\code{bt = a/(1 + exp(b + c * dsoc + d * hst))}
\itemize{
\item{\code{bt [kg]}}{ - tree biomass}
\item{\code{dsoc [cm]}}{ - variable not defined}
\item{\code{hst [m]}}{ - total height of the stem}
}
\bold{Model Parameters}
\preformatted{  family    genus    species        a     b      c      d
1 Uritaceae Cecropia galaziovii  296.  6.14 -0.116 -0.152}
\out{<hr>}
\code{bt = a * dsob^b * hst^c}
\itemize{
\item{\code{bt [kg]}}{ - tree biomass}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
\item{\code{hst [m]}}{ - total height of the stem}
}
\bold{Model Parameters}
\preformatted{  family      genus   species      a     b     c
1 Cyatheaceae Cyathea delgadii 0.152  1.13  1.03}
\out{<hr>}
\code{bt = a * dsob^b * hst^c}
\itemize{
\item{\code{bt [kg]}}{ - tree biomass}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
\item{\code{hst [m]}}{ - total height of the stem}
}
\bold{Model Parameters}
\preformatted{  family    genus   species      a     b     c
1 Arecaceae Euterpe edulist 0.0175  1.53  1.66}
\out{<hr>}
\code{bt = a * (dsob^2 * (1.3 + b * exp(c/dsob)) * rwd)^d}
\itemize{
\item{\code{bt [kg]}}{ - tree biomass}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
\item{\code{rwd [g/cm^3]}}{ - wood specific gravity}
}
\bold{Model Parameters}
\preformatted{  family        genus     species           a     b     c     d
1 Araucariaceae Araucaria angustifolia 0.0568  23.1 -10.0 0.989}
\out{<hr>}
\code{bt = a * (dsob^2 * (1.3 + b * (1 - exp(c * dsob))) * rwd)^d}
\itemize{
\item{\code{bt [kg]}}{ - tree biomass}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
\item{\code{rwd [g/cm^3]}}{ - wood specific gravity}
}
\bold{Model Parameters}
\preformatted{  forest_type      a     b      c     d
1 deciduous   0.0568  20.7 0.0371 0.989}
\out{<hr>}}
