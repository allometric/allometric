\name{rustagi_1991}
\alias{rustagi_1991}
\title{Rustagi and Loveless Jr (1991)}
\description{Allometric models from Rustagi and Loveless Jr (1991)}
\section{Stem Volume Models}{\code{vso = kb_0 * (dsib)^2 * hso + kb_1 * (dsib)^2 * (hsdip75 - 1.37)}
\itemize{
\item{\code{vso [m3]}}{ - volume of the stem above breast height}
\item{\code{dsib [cm]}}{ - diameter of the stem, inside bark at breast height}
\item{\code{hso [m]}}{ - height of the stem above breast height}
\item{\code{hsdip75 [m]}}{ - height to a diameter that is 0.75 times the diameter inside bark at breast height}
}
\bold{Model Parameters}
\preformatted{       kb_0      kb_1
1 0.0000146 0.0000528}
\out{<hr>}
\code{vso = kb_0 * (dsib)^2 * hso + kb_1 * (dsib)^2 * (hsdop67 - 1.37)}
\itemize{
\item{\code{vso [m3]}}{ - volume of the stem above breast height}
\item{\code{dsib [cm]}}{ - diameter of the stem, inside bark at breast height}
\item{\code{hso [m]}}{ - height of the stem above breast height}
\item{\code{hsdop67 [m]}}{ - height to a diameter that is 0.67 times the diameter outside bark at breast height}
}
\bold{Model Parameters}
\preformatted{       kb_0      kb_1
1 0.0000109 0.0000516}
\out{<hr>}
\code{vso = k * (a * hso + b * dsob * hso + c * dsob^2 * hso + d * (hsdop67 - 1.37)) + e * dsob * (hsdop67 - 1.37) + f * dsob^2 * (hsdop67 - 1.37)}
\itemize{
\item{\code{vso [m3]}}{ - volume of the stem above breast height}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
\item{\code{hso [m]}}{ - height of the stem above breast height}
\item{\code{hsdop67 [m]}}{ - height to a diameter that is 0.67 times the diameter outside bark at breast height}
}
\bold{Model Parameters}
\preformatted{          k       a       b      c      d      e     f
1 0.0000785 0.00678 -0.0428 0.0676 0.0656 -0.414 0.654}
\out{<hr>}}
