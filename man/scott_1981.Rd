\name{scott_1981}
\alias{scott_1981}
\title{Scott (1981)}
\description{Allometric models from Scott (1981)}
\section{Stem Volume Models}{\code{vsa = b_0 + b_1 * dsob^b_2 + b_3 * dsob^(b_4) * hsm^b_5}
\itemize{
\item{\code{vsa [ft3]}}{ - volume of the entire stem, including top and stump}
\item{\code{dsob [in]}}{ - diameter of the stem, outside bark at breast height}
\item{\code{hsm [ft]}}{ - merchantable height of the stem}
}
\bold{Model Parameters}
\preformatted{   family       genus        species       b_0      b_1   b_2    b_3   b_4   b_5
 1 Pinaceae     Pinus        strobus      0.11 -0.0598   2.05 0.0496  2.02 0.347
 2 Pinaceae     Pinus        resinosa     0.11 -0.0598   2.05 0.0496  2.02 0.347
 3 Pinaceae     Picea        rubens       0.17 -0.0632   2.07 0.0512  2.03 0.351
 4 Pinaceae     Picea        glauca       0.17 -0.0632   2.07 0.0512  2.03 0.351
 5 Pinaceae     Picea        mariana      0.17 -0.0632   2.07 0.0512  2.03 0.351
 6 Pinaceae     Abies        balsamea    -0.1  -0.0544   2.12 0.0482  2.04 0.358
 7 Pinaceae     Tsuga        canadensis   0.24 -0.0590   2.04 0.0495  2.02 0.337
 8 Pinaceae     Larix        laricina    -0.03 -0.0560   2.05 0.0502  2.02 0.324
 9 Pinaceae     Picea        abies        0.19 -0.0590   1.99 0.0498  2.00 0.321
10 Sapindaceae  Acer         saccharum   -0.19 -0.0117   1.89 0.0134  1.99 0.647
11 Sapindaceae  Acer         saccharinum -0.45 -0.00523  2.23 0.0134  2.01 0.638
12 Magnoliaceae Liriodendron tulipifera  -0.45 -0.00523  2.23 0.0134  2.01 0.638
13 Rosaceae     Prunus       serotina    -0.04 -0.0178   1.81 0.0136  1.99 0.655
14 Fagaceae     Fagus        grandifolia -0.6  -0.00711  2.27 0.0140  2.02 0.652
15 Malvaceae    Tilia        americana   -0.39 -0.00622  2.01 0.0131  1.99 0.649
16 Altingiaceae Liquidambar  styraciflua -0.13 -0.00536  1.20 0.0113  2.00 0.655
17 Nyssaceae    Nyssa        sylvatica   -0.26  0.00038  2    0.0107  2.00 0.644
18 Fagaceae     Quercus      prinus      -0.26  0.00038  2    0.0107  2.00 0.644}
\out{<hr>}
\code{vsa = b_0 + b_1 * dsob^b_2 + b_3 * dsob^(b_4) * hsm^b_5}
\itemize{
\item{\code{vsa [ft3]}}{ - volume of the entire stem, including top and stump}
\item{\code{dsob [in]}}{ - diameter of the stem, outside bark at breast height}
\item{\code{hsm [ft]}}{ - merchantable height of the stem}
}
\bold{Model Parameters}
\preformatted{  species_group     b_0      b_1   b_2     b_3   b_4   b_5
1 hard pines      -0.03 -0.0560   2.05 0.0502   2.02 0.324
2 cedar            0.19 -0.0590   1.99 0.0498   2.00 0.321
3 ash              0.06 -0.0244   1.54 0.0130   1.99 0.645
4 aspen            0.06 -0.0244   1.54 0.0130   1.99 0.645
5 birch           -0.27 -0.00675  1.97 0.0133   2.00 0.641
6 red oaks        -0.13 -0.00536  1.20 0.0113   2.00 0.655
7 hickory         -0.27 -0.00466  2.16 0.0117   2.00 0.664
8 other hardwoods  0.13 -0.00183  2.36 0.00944  2.06 0.652}
\out{<hr>}}
