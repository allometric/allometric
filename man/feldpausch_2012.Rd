\name{feldpausch_2012}
\alias{feldpausch_2012}
\title{Feldpausch et al. (2012)}
\description{Allometric models from Feldpausch et al. (2012)}
\section{Stem Height Models}{\code{hst = a * (1 - exp(-b * dsob^c))}
\itemize{
\item{\code{hst [m]}}{ - total height of the stem}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
}
\bold{Model Parameters}
\preformatted{# Groups:   continent, geographic_region, a, b [8]
  <chr>      <chr>             <dbl>  <dbl> <dbl> <list>   
1 Africa     C. Africa          50.4 0.0471 0.812 <chr [2]>
2 Africa     E. Africa          44.0 0.0334 0.855 <chr [1]>
3 Africa     W. Africa          53.1 0.0331 0.833 <chr [2]>
4 Asia       S.E. Asia          57.1 0.0332 0.847 <chr [2]>
5 Australia  N. Australia       41.7 0.0529 0.776 <chr [1]>
6 S. America Brazilian Shield  227.  0.0139 0.555 <chr [2]>
7 S. America E.C. Amazonia      48.1 0.0375 0.823 <chr [1]>
8 S. America W. Amazonia        46.3 0.0876 0.607 <chr [3]>}
\out{<hr>}
\code{hst = a * (1 - exp(-b * dsob^c))}
\itemize{
\item{\code{hst [m]}}{ - total height of the stem}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
}
\bold{Model Parameters}
\preformatted{  continent  country       a      b     c
1 Africa     <chr [5]>  50.1 0.0371 0.829
2 S. America <chr [6]>  42.6 0.0482 0.831}
\out{<hr>}
\code{hst = a * (1 - exp(-b * dsob^c))}
\itemize{
\item{\code{hst [m]}}{ - total height of the stem}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
}
\bold{Model Parameters}
\preformatted{  country        a     b     c
1 <chr [14]>  50.9 0.042 0.784}
\out{<hr>}}
\section{Tree Biomass Models}{\code{bt = cf * exp(a + b * log(dsob) + c * log(dsob)^2 + d * log(dsob)^3 + e * log(rwd))}
\itemize{
\item{\code{bt [kg]}}{ - tree biomass}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
\item{\code{rwd [g cm-3]}}{ - wood specific gravity}
}
\bold{Model Parameters}
\preformatted{  geographic_region     a     b     c       d     e   rse
1 pantropical       -1.82  2.34 0.163 -0.0248 0.979 0.360}
\out{<hr>}
\code{bt = cf * exp(a + b * log(dsob^2 * rwd * hst))}
\itemize{
\item{\code{bt [kg]}}{ - tree biomass}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
\item{\code{rwd [g cm-3]}}{ - wood specific gravity}
\item{\code{hst [m]}}{ - total height of the stem}
}
\bold{Model Parameters}
\preformatted{  geographic_region     a     b   rse
1 pantropical       -2.92 0.989 0.322}
\out{<hr>}}
