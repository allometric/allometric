\name{huy_2019}
\alias{huy_2019}
\title{Huy et al. (2019)}
\description{Allometric models from Huy et al. (2019)}
\section{Stem Biomass Models}{\code{bs = a_1 * dsob^b_11 * hst^b_12 * es^b_13}
\itemize{
\item{\code{bs [kg]}}{ - stem biomass}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
\item{\code{hst [m]}}{ - total height of the stem}
\item{\code{es [g cm-3]}}{ - stem density}
}
\bold{Model Parameters}
\preformatted{  family              a_1  b_11  b_12  b_13
1 <NA>             0.0206  2.35 0.591 0.691
2 Dipterocarpaceae 0.0255  2.25 0.695 0.954}
\out{<hr>}
\code{bs = a_1 * dsob^b_11}
\itemize{
\item{\code{bs [kg]}}{ - stem biomass}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
}
\bold{Model Parameters}
\preformatted{  family           genus            a_1  b_11
1 Dipterocarpaceae Dipterocarpus 0.0183  2.76
2 Dipterocarpaceae Shorea        0.0392  2.47}
\out{<hr>}}
\section{Branch Biomass Models}{\code{bb = a_2 * dsob^b_21}
\itemize{
\item{\code{bb [kg]}}{ - branch biomass}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
}
\bold{Model Parameters}
\preformatted{  family           genus             a_2  b_21
1 <NA>             <NA>          0.00669  2.86
2 Dipterocarpaceae <NA>          0.0110   2.74
3 Dipterocarpaceae Dipterocarpus 0.00481  2.96
4 Dipterocarpaceae Shorea        0.0213   2.49}
\out{<hr>}}
\section{Foliage Biomass Models}{\code{bf = a_3 * dsob^b_31}
\itemize{
\item{\code{bf [kg]}}{ - foliage biomass}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
}
\bold{Model Parameters}
\preformatted{  family           genus            a_3  b_31
1 <NA>             <NA>          0.0370  1.68
2 Dipterocarpaceae <NA>          0.0456  1.63
3 Dipterocarpaceae Dipterocarpus 0.0892  1.44
4 Dipterocarpaceae Shorea        0.0512  1.51}
\out{<hr>}}
\section{Bark Biomass Models}{\code{bk = a_4 * dsob^b_41}
\itemize{
\item{\code{bk [kg]}}{ - bark biomass}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
}
\bold{Model Parameters}
\preformatted{  family           genus             a_4  b_41
1 <NA>             <NA>          0.0154   2.44
2 Dipterocarpaceae <NA>          0.00399  2.84
3 Dipterocarpaceae Dipterocarpus 0.00116  3.19
4 Dipterocarpaceae Shorea        0.320    1.47}
\out{<hr>}}
