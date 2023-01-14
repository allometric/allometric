\name{kozak_1988}
\alias{kozak_1988}
\title{Kozak (1988)}
\description{Allometric models from Kozak (1988)}
\section{Stem Diameter Models}{\code{dsih = a_0 * dsob^a_1 * a_2^dsob * x^(b_1 * z^2 + b_2 * log(z + 0.001) + b_3 * sqrt(z) + b_4 * exp(z) + b_5 * (dsob/hst))}
\itemize{
\item{\code{dsih [cm]}}{ - diameter of the stem, inside bark at a specified height}
\item{\code{hst [m]}}{ - total height of the stem}
\item{\code{hsd [m]}}{ - height to a specified diameter (taper)}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
}
\bold{Model Parameters}
\preformatted{  family       genus       species       a_0   a_1   a_2   b_1     b_2   b_3     b_4    b_5     p
1 Pinaceae     Pseudotsuga menziesii   1.02  0.888 1.00  0.951 -0.181  0.614 -0.351  0.0569  0.25
2 Cupressaceae Thuja       plicata     1.22  0.843 1.00  1.55  -0.397  2.11  -1.11   0.0942  0.3 
3 Pinaceae     Pinus       contorta    0.775 1.04  0.997 0.746 -0.130  0.559 -0.324  0.199   0.25
4 Salicaceae   Populus     trichocarpa 0.853 0.953 1.00  0.732 -0.0842 0.196 -0.0698 0.148   0.25}
\out{<hr>}}
