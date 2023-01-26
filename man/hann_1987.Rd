\name{hann_1987}
\alias{hann_1987}
\title{Hann, Scrivani, and others (1987)}
\description{Allometric models from Hann, Scrivani, and others (1987)}
\section{Stem Height Models}{\code{hstix50 = 4.5 + (hst - 4.5) * exp(b_1 * (atb - 50) + b_2 * (atb - 50)^2 + b_3 * (atb - 50) * log(hst - 4.5) + b_4 * (atb - 50)^2 * log(hst - 4.5))}
\itemize{
\item{\code{hstix50 [ft]}}{ - site index at 50 year base age}
\item{\code{hst [ft]}}{ - total height of the stem}
\item{\code{atb [yr]}}{ - age of the tree at breast height}
}
\bold{Model Parameters}
\preformatted{  family   genus   species     b_1     b_2     b_3      b_4
1 Pinaceae Pseudo~ menzie~ -0.0522 7.15e-4 0.00797 -1.33e-4}
\out{<hr>}
\code{hstix50 = 4.5 + (hst - 4.5) * exp(b_1 * (atb - 50) + b_2 * (atb - 50)^2 + b_3 * (atb - 50) * log(hst - 4.5) + b_4 * (atb - 50)^2 * log(hst - 4.5))}
\itemize{
\item{\code{hstix50 [ft]}}{ - site index at 50 year base age}
\item{\code{hst [ft]}}{ - total height of the stem}
\item{\code{atb [yr]}}{ - age of the tree at breast height}
}
\bold{Model Parameters}
\preformatted{  family   genus species       b_1      b_2    b_3      b_4
1 Pinaceae Pinus ponderosa -0.0699 0.000360 0.0120 -7.18e-5}
\out{<hr>}}
