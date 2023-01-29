\name{chojnacky_1994}
\alias{chojnacky_1994}
\title{Chojnacky (1994)}
\description{Allometric models from Chojnacky (1994)}
\section{Stem Volume Models}{\code{vsa = beta_0 + beta_1 * X + beta_2 * X^2}
\itemize{
\item{\code{vsa [ft3]}}{ - volume of the entire stem, including top and stump}
\item{\code{dsoc [in]}}{ - diameter outside bark above the root collar}
\item{\code{hst [ft]}}{ - total height of the stem}
}
\bold{Model Parameters}
\preformatted{   family       genus     species     min_branch_dia  beta_0 beta_1 beta_2   X_0
 1 Cupressaceae Juniperus deppeana               1.5  0.0255   1.75  0.199  4.00
 2 Cupressaceae Juniperus scopulorum             1.5  0.0255   1.75  0.199  4.00
 3 Cupressaceae Juniperus deppeana               3   -0.0601   1.38  0.157  5.21
 4 Cupressaceae Juniperus scopulorum             3   -0.0601   1.38  0.157  5.21
 5 Cupressaceae Juniperus monosperma             1.5 -0.0192   2.13  0.11   2.58
 6 Cupressaceae Juniperus osteosperma            1.5 -0.0192   2.13  0.11   2.58
 7 Cupressaceae Juniperus monosperma             3   -0.106    1.44  0.132  4.02
 8 Cupressaceae Juniperus osteosperma            3   -0.106    1.44  0.132  4.02
 9 Pinaceae     Pinus     edulis                 1.5 -0.0594   2.64  0.325  2.08
10 Pinaceae     Pinus     edulis                 3   -0.123    2.07  0.183  3.55}
\out{<hr>}
\code{vsa = beta_0 + beta_1 * X + beta_2 * (3 * X_0^2 - 2 * X_0^3/X)}
\itemize{
\item{\code{vsa [ft3]}}{ - volume of the entire stem, including top and stump}
\item{\code{dsoc [in]}}{ - diameter outside bark above the root collar}
\item{\code{hst [ft]}}{ - total height of the stem}
}
\bold{Model Parameters}
\preformatted{   family       genus     species     min_branch_dia  beta_0 beta_1 beta_2   X_0
 1 Cupressaceae Juniperus deppeana               1.5  0.0255   1.75  0.199  4.00
 2 Cupressaceae Juniperus scopulorum             1.5  0.0255   1.75  0.199  4.00
 3 Cupressaceae Juniperus deppeana               3   -0.0601   1.38  0.157  5.21
 4 Cupressaceae Juniperus scopulorum             3   -0.0601   1.38  0.157  5.21
 5 Cupressaceae Juniperus monosperma             1.5 -0.0192   2.13  0.11   2.58
 6 Cupressaceae Juniperus osteosperma            1.5 -0.0192   2.13  0.11   2.58
 7 Cupressaceae Juniperus monosperma             3   -0.106    1.44  0.132  4.02
 8 Cupressaceae Juniperus osteosperma            3   -0.106    1.44  0.132  4.02
 9 Pinaceae     Pinus     edulis                 1.5 -0.0594   2.64  0.325  2.08
10 Pinaceae     Pinus     edulis                 3   -0.123    2.07  0.183  3.55}
\out{<hr>}}
