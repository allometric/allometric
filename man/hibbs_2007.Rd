\name{hibbs_2007}
\alias{hibbs_2007}
\title{Hibbs, Bluhm, and Garber (2007)}
\description{Allometric models from Hibbs, Bluhm, and Garber (2007)}
\section{Stem Diameter Models}{\code{dsih = z <- hsd/hst, x <- (1 - sqrt(z))/(1 - sqrt(p)), a_1 * dsob^a_2 * x^(a_3 * (1.364409 * dsob^(1/3) * exp(a_4 * z) + exp(a_5 * (dsob/hst)^a_6 * z)))}
\itemize{
\item{\code{dsih [in]}}{ - diameter of the stem, outside bark at a specified height}
\item{\code{dsob [in]}}{ - diameter of the stem, outside bark at breast height}
\item{\code{hst [ft]}}{ - total height of the stem}
\item{\code{hsd [in]}}{ - height to a specified diameter (taper)}
}
\bold{Model Parameters}
\preformatted{    a_1   a_2   a_3   a_4   a_5   a_6
1 0.900  1.02 0.263 -18.9  4.25 0.622}
\out{<hr>}}
