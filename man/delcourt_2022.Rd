\name{delcourt_2022}
\alias{delcourt_2022}
\title{Delcourt et al. (2022)}
\description{Allometric models from Delcourt et al. (2022)}
\section{Stem Biomass Models}{\code{bs = a * dsob^b}
\itemize{
\item{\code{bs [kg]}}{ - stem biomass}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
}
\bold{Model Parameters}
\preformatted{  region response_name dbh_range_cm     a     b
1 RU-MAG bs            3.9-52.8     0.066  2.49
2 RU-SAK bs            1.8-18.9     0.128  2.23}
\out{<hr>}}
\section{Wood Biomass Models}{\code{bw = a * dsob^b}
\itemize{
\item{\code{bw [kg]}}{ - stem biomass without bark}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
}
\bold{Model Parameters}
\preformatted{  region response_name dbh_range_cm     a     b
1 RU-MAG bw            3.9-52.8     0.058  2.50
2 RU-SAK bw            1.8-18.9     0.084  2.31}
\out{<hr>}}
\section{Bark Biomass Models}{\code{bk = a * dsob^b}
\itemize{
\item{\code{bk [kg]}}{ - bark biomass}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
}
\bold{Model Parameters}
\preformatted{  region response_name dbh_range_cm     a     b
1 RU-MAG bk            3.9-52.8     0.006  2.56
2 RU-SAK bk            1.8-18.9     0.046  2.01}
\out{<hr>}}
\section{Root Biomass Models}{\code{br = a * dsob^b}
\itemize{
\item{\code{br [kg]}}{ - root biomass}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
}
\bold{Model Parameters}
\preformatted{  region response_name dbh_range_cm     a     b
1 RU-MAG br            3.9-52.8     0.031  2.14
2 RU-SAK br            1.8-18.9     0.105  1.76}
\out{<hr>}}
\section{Foliage Biomass Models}{\code{bf = a * dsob^b}
\itemize{
\item{\code{bf [kg]}}{ - foliage biomass}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
}
\bold{Model Parameters}
\preformatted{  region response_name dbh_range_cm     a     b
1 RU-MAG bf            3.9-52.8     0.016  1.84
2 RU-SAK bf            1.8-18.9     0.043  1.64}
\out{<hr>}}
\section{Tree Biomass Models}{\code{bt = a * dsob^b}
\itemize{
\item{\code{bt [kg]}}{ - tree biomass}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
}
\bold{Model Parameters}
\preformatted{  region response_name dbh_range_cm     a     b
1 RU-MAG bt            3.9-52.8     0.097  2.42
2 RU-SAK bt            1.8-18.9     0.26   2.06}
\out{<hr>}}
