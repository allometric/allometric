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
\preformatted{  family      genus species   a_0   a_1   a_2   b_1     b_2
1 Pinaceae    Pseu~ menzie~ 1.02  0.888 1.00  0.951 -0.181 
2 Cupressace~ Thuja plicata 1.22  0.843 1.00  1.55  -0.397 
3 Pinaceae    Pinus contor~ 0.775 1.04  0.997 0.746 -0.130 
4 Salicaceae  Popu~ tricho~ 0.853 0.953 1.00  0.732 -0.0842
# ... with 4 more variables: b_3 <dbl>, b_4 <dbl>,
#   b_5 <dbl>, p <dbl>
# i Use `colnames()` to see all variable names}
\out{<hr>}}
