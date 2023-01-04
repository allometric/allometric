\name{poudel_2018}
\alias{poudel_2018}
\title{Poudel, Temesgen, and Gray (2018)}
\description{Allometric models from Poudel, Temesgen, and Gray (2018)}
\section{Stem Ratio Models}{\code{rsdodi = x <- (hst - hsd)/(hst - 1.3), b_1 + b_2 * x + b_3 * x^2 + b_4 * x^3 + b_5 * x^4}
\itemize{
\item{\code{rsdodi [cm/cm]}}{ - diameter of the stem inside bark at a height along the stem divided by diameter outside bark at breast height}
\item{\code{hst [m]}}{ - total height of the stem}
\item{\code{hsd [m]}}{ - height to a specified diameter (taper)}
}
\bold{Model Parameters}
\preformatted{  family   genus       species         b_1   b_2   b_3   b_4   b_5
1 Pinaceae Pseudotsuga menziesii    0.0244 0.858  2.57 -5.56  3.05
2 Pinaceae Tsuga       heterophylla 0.0308 0.430  4.12 -7.85  4.27}
\out{<hr>}
\code{rsdodi = t <- hsd/hst, ((log(sin(t * pi/2)))/(log(sin((1.37/hst) * pi/2))))^(b_1 + b_2 * sin(t * pi/2) + b_3 * cos(t * (3 * pi/2)) + b_4 * ((sin((pi/2) * t))/(t)) + b_5 * dsob + b_6 * t * sqrt(dsob) + b_7 * t * sqrt(hst))}
\itemize{
\item{\code{rsdodi [cm/cm]}}{ - diameter of the stem inside bark at a height along the stem divided by diameter outside bark at breast height}
\item{\code{hst [m]}}{ - total height of the stem}
\item{\code{hsd [m]}}{ - height to a specified diameter (taper)}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
}
\bold{Model Parameters}
\preformatted{  family   genus      species   b_1    b_2     b_3    b_4     b_5    b_6     b_7
1 Pinaceae Pseudotsu… menzie… 0.140 0.730  0.154   -0.121 0.00124 0.0268 -0.0958
2 Pinaceae Tsuga      hetero… 1.85  0.0101 0.00175 -1.05  0.0029  0.0348 -0.131 }
\out{<hr>}}
\section{Stem Diameter Models}{\code{dsih = t <- hsd/hst, k <- 1.3/hst, b_1 * dsob^b_2 * b_3^dsob * ((1 - sqrt(t))/(1 - sqrt(p)))^(b_4 * t^2 + b_5 * log(t + 0.001) + b_6 * sqrt(t) + b_7 * exp(t) + b_8 * (dsob/hst))}
\itemize{
\item{\code{dsih [cm]}}{ - diameter of the stem, outside bark at a specified height}
\item{\code{hst [m]}}{ - total height of the stem}
\item{\code{hsd [m]}}{ - height to a specified diameter (taper)}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
}
\bold{Model Parameters}
\preformatted{  family  genus species   b_1   b_2   b_3   b_4    b_5    b_6    b_7   b_8     p
1 Pinace… Pseu… menzie… 0.793  1.02 0.998  1.10 -0.180  1.19  -0.611 0.155  0.25
2 Pinace… Tsuga hetero… 0.923  1.01 0.998  1.05 -0.162 -0.244 -0.314 0.302  0.12}
\out{<hr>}
\code{dsih = k <- 1.3/hst, t <- hsd/hst, b_1 * dsob^b_2 * hst^b_3 * ((1 - t^(1/3))/(1 - k^(1/3)))^(b_4 * t^4 + b_5 * (1/exp(dsob/hst)) + b_6 * ((1 - t^(1/3))/(1 - k^(1/3)))^(0.1) + b_7 * (1/dsob) + b_8 * (hst^(1 - (hsd/hst)^(1/3))) + b_9 * ((1 - t^(1/3))/(1 - k^(1/3))))}
\itemize{
\item{\code{dsih [cm]}}{ - diameter of the stem, outside bark at a specified height}
\item{\code{hst [m]}}{ - total height of the stem}
\item{\code{hsd [m]}}{ - height to a specified diameter (taper)}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
}
\bold{Model Parameters}
\preformatted{  family genus species   b_1   b_2     b_3   b_4   b_5   b_6   b_7    b_8    b_9
1 Pinac… Pseu… menzie…  1.04 0.998 -0.0311 0.538 -1.01 0.568  4.96 0.0412 -0.344
2 Pinac… Tsuga hetero…  1.06 0.994 -0.0168 0.646 -1.57 0.743  4.76 0.0389 -0.194}
\out{<hr>}
\code{dsih = 2 * (((b_1 * dsob)/(1 - exp(b_3 * (1.3 - hst)))) + (dsob/2 - b_1 * dsob) * (1 - (1/(1 - exp(b_2 * (1.3 - hst))))) + exp(-b_2 * hsd) * ((dsob/2 - b_1 * dsob) * exp(1.3 * b_2)/(1 - exp(b_2 * (1.3 - hst)))) - exp(b_3 * hsd) * ((b_1 * dsob * exp(-b_3 * hst))/(1 - exp(b_3 * (1.3 - hst)))))}
\itemize{
\item{\code{dsih [cm]}}{ - diameter of the stem, outside bark at a specified height}
\item{\code{hst [m]}}{ - total height of the stem}
\item{\code{hsd [m]}}{ - height to a specified diameter (taper)}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
}
\bold{Model Parameters}
\preformatted{  family   genus       species         b_1     b_2     b_3
1 Pinaceae Pseudotsuga menziesii    0.309   0.0862  0.0777
2 Pinaceae Tsuga       heterophylla 0.0456 -0.0236 -0.866 }
\out{<hr>}}
