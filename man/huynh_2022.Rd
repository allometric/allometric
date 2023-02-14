\name{huynh_2022}
\alias{huynh_2022}
\title{Huynh et al. (2022)}
\description{Allometric models from Huynh et al. (2022)}
\section{Tree Biomass Models}{\code{bt = alpha * dsob^beta}
\itemize{
\item{\code{bt [kg]}}{ - tree biomass}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
}
\bold{Model Parameters}
\preformatted{  equation_no  alpha  beta
1 3           0.0822  2.64}
\out{<hr>}
\code{bt = alpha * hst^beta}
\itemize{
\item{\code{bt [kg]}}{ - tree biomass}
\item{\code{hst [m]}}{ - total height of the stem}
}
\bold{Model Parameters}
\preformatted{  equation_no   alpha  beta
1 4           0.00622  3.50}
\out{<hr>}
\code{bt = alpha * dsob^beta * hst^beta_1}
\itemize{
\item{\code{bt [kg]}}{ - tree biomass}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
\item{\code{hst [m]}}{ - total height of the stem}
}
\bold{Model Parameters}
\preformatted{  equation_no  alpha  beta beta_1 
1 5           0.0525  2.40 0.38285}
\out{<hr>}
\code{bt = alpha * (dsob^2 * hst)^beta}
\itemize{
\item{\code{bt [kg]}}{ - tree biomass}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
\item{\code{hst [m]}}{ - total height of the stem}
}
\bold{Model Parameters}
\preformatted{  equation_no  alpha  beta
1 6           0.0253  1.01}
\out{<hr>}
\code{bt = alpha * dsob^beta * rwd^beta_1}
\itemize{
\item{\code{bt [kg]}}{ - tree biomass}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
\item{\code{rwd [kg m-3]}}{ - wood specific gravity}
}
\bold{Model Parameters}
\preformatted{  equation_no  alpha  beta beta_1 
1 7           0.0525  2.40 0.38253}
\out{<hr>}
\code{bt = alpha * dsob^beta + hst^beta_1 + rwd^beta_2}
\itemize{
\item{\code{bt [kg]}}{ - tree biomass}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
\item{\code{hst [m]}}{ - total height of the stem}
\item{\code{rwd [kg m-3]}}{ - wood specific gravity}
}
\bold{Model Parameters}
\preformatted{  equation_no   alpha  beta beta_1  beta_2
1 8           0.00233  2.43 0.30576  0.499}
\out{<hr>}
\code{bt = alpha * (dsob^2 * hst * rwd)^beta}
\itemize{
\item{\code{bt [kg]}}{ - tree biomass}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
\item{\code{hst [m]}}{ - total height of the stem}
\item{\code{rwd [kg m-3]}}{ - wood specific gravity}
}
\bold{Model Parameters}
\preformatted{  equation_no   alpha  beta
1 9           0.00004 0.990}
\out{<hr>}
\code{bt = alpha * dsob^beta}
\itemize{
\item{\code{bt [kg]}}{ - tree biomass}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
}
\bold{Model Parameters}
\preformatted{  equation_no alpha  beta
1 10          0.106  2.57}
\out{<hr>}
\code{bt = alpha * hst^beta}
\itemize{
\item{\code{bt [kg]}}{ - tree biomass}
\item{\code{hst [m]}}{ - total height of the stem}
}
\bold{Model Parameters}
\preformatted{  equation_no   alpha  beta
1 11          0.00027  4.45}
\out{<hr>}
\code{bt = alpha * dc^beta}
\itemize{
\item{\code{bt [kg]}}{ - tree biomass}
\item{\code{dc [m]}}{ - variable not defined}
}
\bold{Model Parameters}
\preformatted{  equation_no alpha  beta
1 12           33.2  1.62}
\out{<hr>}
\code{bt = alpha * dsob^beta * dc^beta_1}
\itemize{
\item{\code{bt [kg]}}{ - tree biomass}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
\item{\code{dc [m]}}{ - variable not defined}
}
\bold{Model Parameters}
\preformatted{  equation_no alpha  beta beta_1
1 13           2.30  1.07 <NA>  }
\out{<hr>}
\code{bt = alpha * dsob^beta * hst^beta_1 * dc^beta_2}
\itemize{
\item{\code{bt [kg]}}{ - tree biomass}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
\item{\code{hst [m]}}{ - total height of the stem}
\item{\code{dc [m]}}{ - variable not defined}
}
\bold{Model Parameters}
\preformatted{  equation_no  alpha  beta beta_1  beta_2
1 14          0.0515  2.19 0.54648  0.117}
\out{<hr>}
\code{bt = alpha * (dsob^2 * hst * dc)^beta}
\itemize{
\item{\code{bt [kg]}}{ - tree biomass}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
\item{\code{hst [m]}}{ - total height of the stem}
\item{\code{dc [m]}}{ - variable not defined}
}
\bold{Model Parameters}
\preformatted{  equation_no alpha  beta
1 15          0.196 0.680}
\out{<hr>}
\code{bt = alpha * dsob^beta * hst^beta_1 * rwd^beta_2 * dc^beta_3}
\itemize{
\item{\code{bt [kg]}}{ - tree biomass}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
\item{\code{hst [m]}}{ - total height of the stem}
\item{\code{rwd [kg m-3]}}{ - wood specific gravity}
\item{\code{dc [m]}}{ - variable not defined}
}
\bold{Model Parameters}
\preformatted{  equation_no   alpha  beta beta_1  beta_2 beta_3
1 16          0.00079  2.07 0.69202  0.603  0.180}
\out{<hr>}
\code{bt = alpha * (dsob^2 * hst * rwd * dc)^beta}
\itemize{
\item{\code{bt [kg]}}{ - tree biomass}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
\item{\code{hst [m]}}{ - total height of the stem}
\item{\code{rwd [kg m-3]}}{ - wood specific gravity}
\item{\code{dc [m]}}{ - variable not defined}
}
\bold{Model Parameters}
\preformatted{  equation_no   alpha  beta
1 17          0.00156 0.699}
\out{<hr>}
\code{bt = alpha * vc^beta}
\itemize{
\item{\code{bt [kg]}}{ - tree biomass}
\item{\code{vc [cm3]}}{ - crown volume}
}
\bold{Model Parameters}
\preformatted{  equation_no alpha  beta
1 18           15.4 0.539}
\out{<hr>}
\code{bt = alpha * dsob^beta * vc^beta_1}
\itemize{
\item{\code{bt [kg]}}{ - tree biomass}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
\item{\code{vc [cm3]}}{ - crown volume}
}
\bold{Model Parameters}
\preformatted{  equation_no  alpha  beta beta_1  
1 19          0.0988  2.61 ?0.01109}
\out{<hr>}
\code{bt = alpha * dsob^beta * hst^beta_1 * vc^beta_2}
\itemize{
\item{\code{bt [kg]}}{ - tree biomass}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
\item{\code{hst [m]}}{ - total height of the stem}
\item{\code{vc [cm3]}}{ - crown volume}
}
\bold{Model Parameters}
\preformatted{  equation_no  alpha  beta beta_1 beta_2
1 20          0.0487  2.19 0.5465 0.0391}
\out{<hr>}
\code{bt = alpha * (dsob^2 * hst * vc)^beta}
\itemize{
\item{\code{bt [kg]}}{ - tree biomass}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
\item{\code{hst [m]}}{ - total height of the stem}
\item{\code{vc [cm3]}}{ - crown volume}
}
\bold{Model Parameters}
\preformatted{  equation_no alpha  beta
1 21          0.954 0.383}
\out{<hr>}
\code{bt = alpha * dsob^beta * hst^beta_1 * rwd^beta_2 * vc^beta_3}
\itemize{
\item{\code{bt [kg]}}{ - tree biomass}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
\item{\code{hst [m]}}{ - total height of the stem}
\item{\code{rwd [kg m-3]}}{ - wood specific gravity}
\item{\code{vc [cm3]}}{ - crown volume}
}
\bold{Model Parameters}
\preformatted{  equation_no   alpha  beta beta_1  beta_2 beta_3
1 22          0.00072  2.07 0.69205  0.603 0.0600}
\out{<hr>}
\code{bt = alpha * (dsob^2 * hst * rwd * vc)^beta}
\itemize{
\item{\code{bt [kg]}}{ - tree biomass}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
\item{\code{hst [m]}}{ - total height of the stem}
\item{\code{rwd [kg m-3]}}{ - wood specific gravity}
\item{\code{vc [cm3]}}{ - crown volume}
}
\bold{Model Parameters}
\preformatted{  equation_no  alpha  beta
1 23          0.0658 0.389}
\out{<hr>}}
