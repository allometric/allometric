\name{uller_2019}
\alias{uller_2019}
\title{Uller, Zimermann Oliveira, Klitzke et al. (2019)}
\description{Allometric models from Uller, Zimermann Oliveira, Klitzke et al. (2019)}
\section{Tree Biomass Models}{\code{bt = beta_0 + beta_1 * dsob^2}
\itemize{
\item{\code{bt [kg]}}{ - tree biomass}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
}
\bold{Model Parameters}
\preformatted{  beta_0 beta_1
1  -48.4  0.647}
\out{<hr>}
\code{bt = exp(log(beta_0) + beta_1 * log(dsob)) * bcf}
\itemize{
\item{\code{bt [kg]}}{ - tree biomass}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
}
\bold{Model Parameters}
\preformatted{  beta_0 beta_1   bcf
1  -2.37   2.52  1.05}
\out{<hr>}
\code{bt = beta_0 + beta_1 * (dsob^2 * hst)}
\itemize{
\item{\code{bt [kg]}}{ - tree biomass}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
\item{\code{hst [m]}}{ - total height of the stem}
}
\bold{Model Parameters}
\preformatted{  beta_0 beta_1
1   25.9 0.0258}
\out{<hr>}
\code{bt = exp(log(beta_0) + beta_1 * log(dsob^2 * hst)) * bcf}
\itemize{
\item{\code{bt [kg]}}{ - tree biomass}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
\item{\code{hst [m]}}{ - total height of the stem}
}
\bold{Model Parameters}
\preformatted{  beta_0 beta_1   bcf
1  -3.41  0.977  1.05}
\out{<hr>}
\code{bt = exp(log(beta_0) + beta_1 * log(dsob) + beta_2 * log(hst)) * bcf}
\itemize{
\item{\code{bt [kg]}}{ - tree biomass}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
\item{\code{hst [m]}}{ - total height of the stem}
}
\bold{Model Parameters}
\preformatted{  beta_0 beta_1 beta_2   bcf
1  -3.13   2.11 -0.710  1.05}
\out{<hr>}
\code{bt = exp(log(beta_0) + beta_1 * log(dsob^2) + beta_2 * log(hst)) * bcf}
\itemize{
\item{\code{bt [kg]}}{ - tree biomass}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
\item{\code{hst [m]}}{ - total height of the stem}
}
\bold{Model Parameters}
\preformatted{  beta_0 beta_1 beta_2   bcf
1  -3.15   2.07  0.760  1.05}
\out{<hr>}
\code{bt = exp(log(beta_0) + beta_1 * log(dsob) + beta_2 * log(rsd)) * bcf}
\itemize{
\item{\code{bt [kg]}}{ - tree biomass}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
\item{\code{rsd [kg m-3]}}{ - variable not defined}
}
\bold{Model Parameters}
\preformatted{  beta_0 beta_1 beta_2   bcf
1  -9.01   2.46   1.09  1.02}
\out{<hr>}
\code{bt = beta_0 + beta_1 * (dsob^2 * hst * rsd)}
\itemize{
\item{\code{bt [kg]}}{ - tree biomass}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
\item{\code{hst [m]}}{ - total height of the stem}
\item{\code{rsd [kg m-3]}}{ - variable not defined}
}
\bold{Model Parameters}
\preformatted{  beta_0  beta_1
1   10.3 0.00005}
\out{<hr>}
\code{bt = exp(log(beta_0) + beta_1 * log(dsob^2 * hst * rsd)) * bcf}
\itemize{
\item{\code{bt [kg]}}{ - tree biomass}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
\item{\code{hst [m]}}{ - total height of the stem}
\item{\code{rsd [kg m-3]}}{ - variable not defined}
}
\bold{Model Parameters}
\preformatted{  beta_0 beta_1   bcf
1  -9.20  0.956  1.02}
\out{<hr>}
\code{bt = exp(log(beta_0) + beta_1 * log(dsob) + beta_2 * log(hst) + beta_3 * log(rsd)) * bcf}
\itemize{
\item{\code{bt [kg]}}{ - tree biomass}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
\item{\code{hst [m]}}{ - total height of the stem}
\item{\code{rsd [kg m-3]}}{ - variable not defined}
}
\bold{Model Parameters}
\preformatted{  beta_0 beta_1 beta_2 beta_3   bcf
1  -8.89   2.16  0.507   1.00  1.02}
\out{<hr>}}
