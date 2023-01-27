\name{chittester_1984}
\alias{chittester_1984}
\title{Chittester and MacLean (1984)}
\description{Allometric models from Chittester and MacLean (1984)}
\section{Stem Volume Models}{\code{vsa = ba * f * hst * (hst/(hst - 4.5))^2}
\itemize{
\item{\code{vsa [ft3]}}{ - volume of the entire stem, including top and stump}
\item{\code{dsob [in]}}{ - diameter of the stem, outside bark at breast height}
\item{\code{hst [ft]}}{ - total height of the stem}
}
\bold{Model Parameters}
\preformatted{      a       b       c
1 0.307 0.00086 -0.0037}
\out{<hr>}}
\section{Stem Volume Models}{\code{vsm = (vsa + a)/(b + c * exp(-0.1 * dsob)) - d}
\itemize{
\item{\code{vsm [ft3]}}{ - volume of the merchantable portion of the stem}
\item{\code{vsa [ft3]}}{ - volume of the entire stem, including top and stump}
\item{\code{dsob [in]}}{ - diameter of the stem, outside bark at breast height}
}
\bold{Model Parameters}
\preformatted{      a     b     c     d
1  3.48  1.18 0.327  2.95}
\out{<hr>}}
