\name{krisnawati_2016}
\alias{krisnawati_2016}
\title{Krisnawati (2016)}
\description{Allometric models from Krisnawati (2016)}
\section{Stem Volume Models}{\code{vsk = a * dsob^b * hst^c}
\itemize{
\item{\code{vsk [m3]}}{ - volume of the stem including bark}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
\item{\code{hst [m]}}{ - total height of the stem}
}
\bold{Model Parameters}
\preformatted{          a     b     c
1 0.0000636  1.74  1.07}
\out{<hr>}}
\section{Stem Volume Models}{\code{vsa = a * dsob^b * hst^c}
\itemize{
\item{\code{vsa [m3]}}{ - volume of the entire stem, including top and stump}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
\item{\code{hst [m]}}{ - total height of the stem}
}
\bold{Model Parameters}
\preformatted{          a     b     c
1 0.0000542  1.08  1.04}
\out{<hr>}}
\section{Stem Diameter Models}{\code{dsoh = a * dsob^b * hst^c * hsl^d}
\itemize{
\item{\code{dsoh [cm]}}{ - diameter of the stem, outside bark at a specified height}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
\item{\code{hst [m]}}{ - total height of the stem}
\item{\code{hsl [m]}}{ - distance from tip of stem to merchantibility limit}
}
\bold{Model Parameters}
\preformatted{      a     b      c     d
1  1.38 0.868 -0.639 0.676}
\out{<hr>}}
\section{Stem Diameter Models}{\code{dsih = a * dsob^b * hst^c * hsl^d}
\itemize{
\item{\code{dsih [cm]}}{ - diameter of the stem, inside bark at a specified height}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
\item{\code{hst [m]}}{ - total height of the stem}
\item{\code{hsl [m]}}{ - distance from tip of stem to merchantibility limit}
}
\bold{Model Parameters}
\preformatted{  volume_type                                              a     b      c     d
1 merchantable volume outside bark to specified height  1.26 0.889 -0.621 0.643}
\out{<hr>}}
\section{Stem Volume Models}{\code{vsm = a * dsob^b * hst^c * (hst^d - (e * dsoh^f * dsob^g * hst^h))}
\itemize{
\item{\code{vsm [m3]}}{ - volume of the merchantable portion of the stem}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
\item{\code{hst [m]}}{ - total height of the stem}
\item{\code{dsoh [cm]}}{ - diameter of the stem, outside bark at a specified height}
}
\bold{Model Parameters}
\preformatted{          a     b     c     d     e     f     g     h
1 0.0000636  1.74 -1.28  2.35 0.326  3.48 -3.02  2.22}
\out{<hr>}}
