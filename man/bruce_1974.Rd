\name{bruce_1974}
\alias{bruce_1974}
\title{Bruce and DeMars (1974)}
\description{Allometric models from Bruce and DeMars (1974)}
\section{Stem Volume Models}{\code{vsa = d * fos * (dsob^2 * hst)}
\itemize{
\item{\code{vsa [ft^3]}}{ - volume of the entire stem, including top and stump}
\item{\code{hst [ft]}}{ - total height of the stem}
\item{\code{dsob [in]}}{ - diameter of the stem, outside bark at breast height}
}
\bold{Model Parameters}
\preformatted{  hst              a      b       c       d
1 <= 18 ft hst 0.406 0.0763 0.00263 0.00545}
\out{<hr>}
\code{vsa = f * fol * (dsob^2 * hst)}
\itemize{
\item{\code{vsa [ft^3]}}{ - volume of the entire stem, including top and stump}
\item{\code{hst [ft]}}{ - total height of the stem}
\item{\code{dsob [in]}}{ - diameter of the stem, outside bark at breast height}
}
\bold{Model Parameters}
\preformatted{  hst             a     b     c     d       e       f
1 > 18 ft hst 0.481  42.5  11.0 0.108 0.00409 0.00545}
\out{<hr>}}
