\name{bluhm_2007}
\alias{bluhm_2007}
\title{Bluhm, Garber, and Hibbs (2007)}
\description{Allometric models from Bluhm, Garber, and Hibbs (2007)}
\section{Stem Diameter Models}{\code{dsih = z <- hsd/hst, p <- 4.5/hst, x <- (1 - sqrt(z))/(1 - sqrt(p)), a_1 * dsob^a_2 * x^(a_3 * (1.364409 * dsob^(1/3) * exp(a_4 * z) + exp(a_5 * rc^a_6 * (dsob/hst)^a_7 * z)))}
\itemize{
\item{\code{dsih [in]}}{ - diameter of the stem, inside bark at a specified height}
\item{\code{dsob [in]}}{ - diameter of the stem, outside bark at breast height}
\item{\code{hst [ft]}}{ - total height of the stem}
\item{\code{hsd [in]}}{ - height to a specified diameter (taper)}
\item{\code{rc [ft/ft]}}{ - crown ratio}
}
\bold{Model Parameters}
\preformatted{    a_1   a_2   a_3   a_4   a_5   a_6   a_7
1 0.911  1.02 0.262 -18.8  3.19 0.163 0.418}
\out{<hr>}}
