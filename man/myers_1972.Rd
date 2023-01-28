\name{myers_1972}
\alias{myers_1972}
\title{Myers et al. (1972)}
\description{Allometric models from Myers et al. (1972)}
\section{Stem Volume Models}{\code{vsa = a + b * dsob^2 * hst}
\itemize{
\item{\code{vsa [ft3]}}{ - volume of the entire stem, including top and stump}
\item{\code{dsob [in]}}{ - diameter of the stem, outside bark at breast height}
\item{\code{hst [ft]}}{ - total height of the stem}
}
\bold{Model Parameters}
\preformatted{  top_dsib size_class       a       b
1        0 <= 22500    0.0644 0.00239
2        0 > 22500    10.4    0.00193
3        4 <= 27900   -8.30   0.00232
4        4 > 27900    13.1    0.00182}
\out{<hr>}}
\section{Stem Volume Models}{\code{vsm = a + b * dsob^2 * hsm}
\itemize{
\item{\code{vsm [board_foot]}}{ - volume of the merchantable portion of the stem}
\item{\code{dsob [in]}}{ - diameter of the stem, outside bark at breast height}
\item{\code{hsm []}}{ - Number of 16 foot logs to merchantable top}
}
\bold{Model Parameters}
\preformatted{  top_dsib bdft_rule              size_class     a     b
1        6 Scribner               <= 2530     5.38 0.235
2        6 Scribner               > 2530     16.1  0.231
3        8 Scribner               <= 1160     8.19 0.257
4        8 Scribner               > 1160     28.4  0.240
5        6 International 1/4-inch <= 1350     3.79 0.287
6        6 International 1/4-inch > 1350     66.4  0.236
7        8 International 1/4-inch <= 1060     8.14 0.309
8        8 International 1/4-inch > 1060     73.9  0.246}
\out{<hr>}
\code{vsm = a + b * dsob^2 * hst}
\itemize{
\item{\code{vsm [board_foot]}}{ - volume of the merchantable portion of the stem}
\item{\code{dsob [in]}}{ - diameter of the stem, outside bark at breast height}
\item{\code{hst [ft]}}{ - total height of the stem}
}
\bold{Model Parameters}
\preformatted{  top_dsib bdft_rule              size_class     a      b
1        6 Scribner               <= 12000   -15.1 0.0110
2        6 Scribner               > 12000    -27.9 0.0120
3        8 Scribner               NA         -39.0 0.0122
4        6 International 1/4-inch <= 27300   -25.6 0.0139
5        6 International 1/4-inch > 27300     17.0 0.0124
6        8 International 1/4-inch <= 18900   -44.1 0.0141
7        8 International 1/4-inch > 18900    -21.4 0.0129}
\out{<hr>}}
\section{Stem Ratio Models}{\code{rsvg = a * hst - b/dsob^2}
\itemize{
\item{\code{rsvg [ft3 ft-2]}}{ - volume to basal area ratio}
\item{\code{dsob [in]}}{ - diameter of the stem, outside bark at breast height}
\item{\code{hst [ft]}}{ - total height of the stem}
}
\bold{Model Parameters}
\preformatted{  top_dsib size_class     a     b
1        4 small      0.425 -152.
2        4 large      0.334 2404.}
\out{<hr>}
\code{rsvg = a * hst - b/dsob^2}
\itemize{
\item{\code{rsvg [ft3 ft-2]}}{ - volume to basal area ratio}
\item{\code{dsob [in]}}{ - diameter of the stem, outside bark at breast height}
\item{\code{hst [ft]}}{ - total height of the stem}
}
\bold{Model Parameters}
\preformatted{  top_dsib bdft_rule              size_class     a      b
1        6 Scribner               small       2.01 -2777.
2        6 Scribner               large       2.20 -5118.
3        8 Scribner               NA          2.23 -7145.
4        6 International 1/4-inch small       2.55  4696.
5        6 International 1/4-inch large       2.26  3121.
6        8 International 1/4-inch small       2.58 -8083.
7        8 International 1/4-inch large       2.36 -3930.}
\out{<hr>}
\code{rsvg = a * hsm + b/dsob^2}
\itemize{
\item{\code{rsvg [ft3 ft-2]}}{ - volume to basal area ratio}
\item{\code{dsob [in]}}{ - diameter of the stem, outside bark at breast height}
\item{\code{hsm []}}{ - Number of 16 foot logs to merchantable top}
}
\bold{Model Parameters}
\preformatted{  top_dsib bdft_rule              size_class     a      b
1        6 Scribner               small       43.1   986.
2        6 Scribner               large       42.3  2956.
3        8 Scribner               small       47.2  1502.
4        8 Scribner               large       44.0  5208.
5        6 International 1/4-inch small       51.8   696.
6        6 International 1/4-inch large       43.3 12183.
7        8 International 1/4-inch small       56.6  1493.
8        8 International 1/4-inch large       45.2 13554.}
\out{<hr>}}
