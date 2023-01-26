\name{vibrans_2015}
\alias{vibrans_2015}
\title{Vibrans, Moser, Oliveira, and de
Maçaneiro (2015)}
\description{Allometric models from Vibrans, Moser, Oliveira et al. (2015)}
\section{Stem Volume Models}{\code{vsa = 1000 * exp(beta_0 + beta_1 * log(circ^2) + beta_2 * log(hst))}
\itemize{
\item{\code{vsa [m3]}}{ - volume of the entire stem, including top and stump}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
\item{\code{hst [m]}}{ - total height of the stem}
}
\bold{Model Parameters}
\preformatted{   forest_type        family          genus       species        beta_0 beta_1 beta_2
 1 seasonal deciduous Lauraceae       Nectandra   megapotamica    -17.7   0.95   0.69
 2 seasonal deciduous Lauraceae       Ocotea      puberula        -17.5   0.93   0.68
 3 seasonal deciduous Meliaceae       Cedrela     fissilis        -18.6   1.02   0.75
 4 mixed ombrophilous Clethraceae     Clethra     scabra          -18.3   0.99   0.76
 5 mixed ombrophilous Sapindaceae     Matayba     elaeagnoides    -18.0   0.99   0.61
 6 mixed ombrophilous Lauraceae       Ocotea      puberula        -18.3   1      0.74
 7 mixed ombrophilous Rosaceae        Prunus      myrtifolia      -18.5   1.02   0.74
 8 dense ombrophilous Euphorbiaceae   Alchornea   triplinervia    -18.1   1.05   0.51
 9 dense ombrophilous Meliaceae       Cedrela     fissilis        -17.8   1.03   0.46
10 dense ombrophilous Phyllanthaceae  Hieronyma   alchorneoides   -17.7   1.02   0.45
11 dense ombrophilous Melastomataceae Miconia     cinnamomifolia  -17.5   0.97   0.59
12 dense ombrophilous Lauraceae       Nectandra   oppositifolia   -17.9   0.99   0.64
13 dense ombrophilous Lauraceae       Ocotea      puberula        -17.9   1.01   0.58
14 dense ombrophilous Asteraceae      Piptocarpha angustifolia    -18.4   1.04   0.59
15 dense ombrophilous Anacardiaceae   Tapirira    guianensis      -17.9   0.95   0.82
16 dense ombrophilous Myristicaceae   Virola      bicuhyba        -18.0   0.98   0.64}
\out{<hr>}
\code{vsa = 1000 * exp(beta_0 + beta_1 * log(circ^2) + beta_2 * log(hst))}
\itemize{
\item{\code{vsa [m3]}}{ - volume of the entire stem, including top and stump}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
\item{\code{hst [m]}}{ - total height of the stem}
}
\bold{Model Parameters}
\preformatted{  forest_type forest_type_description beta_0 beta_1 beta_2
1 DEC         seasonal deciduous       -17.7   0.95   0.67
2 MIX         mixed ombrophilous       -18.0   0.96   0.76
3 DEN         dense ombrophilous       -17.8   0.98   0.57
4 ALL         overall generic          -17.8   0.96   0.69}
\out{<hr>}}
