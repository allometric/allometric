\name{poudel_2019}
\alias{poudel_2019}
\title{Poudel, Temesgen, Radtke, and Gray (2019)}
\description{Allometric models from Poudel, Temesgen, Radtke et al. (2019)}
\section{Stem Volume Models}{\code{vsa = exp(a + b * log(dsob) + c * log(hst))}
\itemize{
\item{\code{vsa [m3]}}{ - volume of the entire stem, including top and stump}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
\item{\code{hst [m]}}{ - total height of the stem}
}
\bold{Model Parameters}
\preformatted{   family       genus         species           a     b     c
 1 Pinaceae     Abies         concolor     -10.1   1.60 1.34 
 2 Pinaceae     Abies         grandis       -9.18  1.55 1.17 
 3 Pinaceae     Abies         lasiocarpa    -9.85  1.70 1.15 
 4 Pinaceae     Abies         magnifica    -10.3   1.69 1.31 
 5 Cupressaceae Chamaecyparis nootkatensis  -9.60  1.84 0.95 
 6 Pinaceae     Larix         occidentalis -11.3   1.93 1.33 
 7 Cupressaceae Calocedrus    decurrens     -9.64  1.66 1.08 
 8 Pinaceae     Picea         <NA>         -10.4   1.82 1.19 
 9 Pinaceae     Picea         engelmannii  -10.3   1.69 1.32 
10 Pinaceae     Picea         glauca       -10.6   2.12 0.894
11 Pinaceae     Picea         sitchensis   -10.1   1.86 1.08 
12 Pinaceae     Pinus         contorta     -10.0   1.86 1.06 
13 Pinaceae     Pinus         flexilis     -11.4   2.14 1.20 
14 Pinaceae     Pinus         jeffreyi     -10.5   2.03 0.941
15 Pinaceae     Pinus         lambertiana  -10.7   2.44 0.489
16 Pinaceae     Pinus         monticola     -9.60  1.40 1.41 
17 Pinaceae     Pinus         ponderosa    -10.6   2.11 0.912
18 Pinaceae     Pseudotsuga   menziesii     -9.55  1.74 1.02 
19 Cupressaceae Sequoia       sempervirens -10.8   2.05 0.947
20 Cupressaceae Thuja         plicata       -9.55  2.04 0.66 
21 Pinaceae     Tsuga         <NA>          -9.47  1.83 0.936
22 Pinaceae     Tsuga         heterophylla  -9.98  1.96 0.925
23 Pinaceae     Tsuga         mertensiana  -11.0   1.88 1.30 
24 Betulaceae   Alnus         rubra        -10.3   2.05 0.944
25 Salicaceae   Populus       tremuloides  -10.7   1.90 1.24 }
\out{<hr>}}
\section{Tree Biomass Models}{\code{bt = cf * exp(a + b * log(dsob) + c * log(hst))}
\itemize{
\item{\code{bt [kg]}}{ - tree biomass}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
\item{\code{hst [m]}}{ - total height of the stem}
}
\bold{Model Parameters}
\preformatted{   family       genus          species           a     b     c    cf
 1 Pinaceae     Abies          amabilis     -2.72   1.85 0.757  1   
 2 Pinaceae     Picea          engelmannii  -2.65   1.48 1.14   1   
 3 Pinaceae     Picea          glauca       -1.97   1.94 0.421  1   
 4 Pinaceae     Picea          mariana      -2.70   1.95 0.618  1   
 5 Pinaceae     Picea          sitchensis   -2.58   1.82 0.711  1.01
 6 Pinaceae     Pinus          contorta     -1.86   1.80 0.562  1   
 7 Pinaceae     Pinus          monophylla   -0.505  1.40 0.852  1   
 8 Pinaceae     Pseudotsuga    menziesii    -2.82   1.64 1.05   1   
 9 Cupressaceae Sequoia        sempervirens -3.05   1.94 0.688  1.02
10 Cupressaceae Sequoiadendron giganteum    -3.87   2.13 0.601  1.04
11 Cupressaceae Thuja          plicata      -2.54   1.57 0.916  1.02
12 Pinaceae     Tsuga          heterophylla -2.76   1.85 0.764  1.02
13 Betulaceae   Alnus          rubra        -3.85   2.32 0.628  1.03
14 Salicaceae   Populus        tremuloides  -3.04   2.03 0.642  1   
15 Salicaceae   Populus        balsamifera  -3.80   1.63 1.34   1   }
\out{<hr>}
\code{bt = cf * exp(a + b * log(dsob) + c * log(hst) + d * hst)}
\itemize{
\item{\code{bt [kg]}}{ - tree biomass}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
\item{\code{hst [m]}}{ - total height of the stem}
}
\bold{Model Parameters}
\preformatted{  family   genus species         a     b     c       d    cf
1 Pinaceae Abies lasiocarpa -5.52  2.68  1.28  -0.0759  1   
2 Pinaceae Pinus ponderosa  -0.662 0.829 0.213  0.414   1.02}
\out{<hr>}
\code{bt = cf * exp(a + b * log(dsob))}
\itemize{
\item{\code{bt [kg]}}{ - tree biomass}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
}
\bold{Model Parameters}
\preformatted{  family       genus     species          a     b    cf
1 Pinaceae     Abies     concolor    -1.58   2.23  1.01
2 Pinaceae     Abies     grandis     -2.21   2.43  1   
3 Cupressaceae Juniperus osteosperma -0.746  1.90  1   
4 Pinaceae     Pinus     jeffreyi    -3.19   3.22  1.03
5 Pinaceae     Tsuga     mertensiana -0.986  2.10  1   
6 Betulaceae   Betula    papyrifera  -2.58   2.53  1.02}
\out{<hr>}
\code{bt = cf * exp(a + b * log(vsa))}
\itemize{
\item{\code{bt [kg]}}{ - tree biomass}
\item{\code{vsa [m3]}}{ - volume of the entire stem, including top and stump}
}
\bold{Model Parameters}
\preformatted{   family       genus          species          a     b    cf
 1 Pinaceae     Abies          amabilis      6.34 0.869  1.03
 2 Pinaceae     Abies          concolor      6.44 0.840  1.02
 3 Pinaceae     Abies          grandis       6.32 1.01   1.03
 4 Pinaceae     Abies          lasiocarpa    6.24 0.818  1.04
 5 Pinaceae     Picea          engelmannii   6.10 0.742  1.05
 6 Pinaceae     Picea          glauca        6.31 0.789  1.03
 7 Pinaceae     Picea          mariana       6.19 0.766  1.04
 8 Pinaceae     Picea          sitchensis    6.15 0.849  1.01
 9 Pinaceae     Pinus          contorta      6.20 0.806  1.05
10 Pinaceae     Pinus          jeffreyi      6.66 0.95   1.01
11 Pinaceae     Pinus          ponderosa     6.47 0.757  1.05
12 Pinaceae     Pinus          monophylla    6.33 0.796  1.07
13 Pinaceae     Pseudotsuga    menziesii     6.43 0.959  1.02
14 Cupressaceae Sequoia        sempervirens  6.45 0.901  1.02
15 Cupressaceae Sequoiadendron giganteum     6.28 0.932  1.02
16 Cupressaceae Thuja          plicata       6.11 0.911  1.02
17 Pinaceae     Tsuga          heterophylla  6.32 0.908  1.02
18 Pinaceae     Tsuga          mertensiana   6.54 0.881  1.01
19 Betulaceae   Alnus          rubra         6.37 1.00   1.03
20 Betulaceae   Betula         papyrifera    6.31 0.952  1.02
21 Salicaceae   Populus        tremuloides   6.26 0.916  1.01
22 Salicaceae   Populus        balsamifera   6.31 0.952  1.02}
\out{<hr>}}
\section{Foliage Ratio Models}{\code{rfbt = exp(a_3 + b_3 * log(dsob) + c_3 * log(hst))/denom}
\itemize{
\item{\code{rfbt [kg kg-1]}}{ - ratio of foliage biomass to biomass of entire tree}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
\item{\code{hst [m]}}{ - total height of the stem}
}
\bold{Model Parameters}
\preformatted{  group      a_1   a_2   a_3   a_4    b_1    b_2     b_3    b_4   c_1   c_2    c_3    c_4
1 softwood -1.72 -1.41  1.94 0.886 -0.665 -0.180 -0.228  -0.382  1.54 0.753 -0.146  0.363
2 hardwood -3.60 -2.73  4.65 3.69  -1.92  -1.52   0.0086 -0.173  2.73 1.86  -0.994 -0.357}
\out{<hr>}}
\section{Bark Ratio Models}{\code{rkbt = exp(a_2 + b_2 * log(dsob) + c_2 * log(hst))/denom}
\itemize{
\item{\code{rkbt [kg kg-1]}}{ - ratio of bark biomass to biomass of entire tree}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
\item{\code{hst [m]}}{ - total height of the stem}
}
\bold{Model Parameters}
\preformatted{  group      a_1   a_2   a_3   a_4    b_1    b_2     b_3    b_4   c_1   c_2    c_3    c_4
1 softwood -1.72 -1.41  1.94 0.886 -0.665 -0.180 -0.228  -0.382  1.54 0.753 -0.146  0.363
2 hardwood -3.60 -2.73  4.65 3.69  -1.92  -1.52   0.0086 -0.173  2.73 1.86  -0.994 -0.357}
\out{<hr>}}
\section{Stem Ratio Models}{\code{rsbt = exp(a_1 + b_1 * log(dsob) + c_1 * log(hst))/denom}
\itemize{
\item{\code{rsbt [kg kg-1]}}{ - ratio of stem biomass to biomass of entire tree}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
\item{\code{hst [m]}}{ - total height of the stem}
}
\bold{Model Parameters}
\preformatted{  group      a_1   a_2   a_3   a_4    b_1    b_2     b_3    b_4   c_1   c_2    c_3    c_4
1 softwood -1.72 -1.41  1.94 0.886 -0.665 -0.180 -0.228  -0.382  1.54 0.753 -0.146  0.363
2 hardwood -3.60 -2.73  4.65 3.69  -1.92  -1.52   0.0086 -0.173  2.73 1.86  -0.994 -0.357}
\out{<hr>}}
\section{Branch Ratio Models}{\code{rbbt = exp(a_4 + b_4 * log(dsob) + c_4 * log(hst))/denom}
\itemize{
\item{\code{rbbt [kg kg-1]}}{ - ratio of branch biomass to biomass of entire tree}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
\item{\code{hst [m]}}{ - total height of the stem}
}
\bold{Model Parameters}
\preformatted{  group      a_1   a_2   a_3   a_4    b_1    b_2     b_3    b_4   c_1   c_2    c_3    c_4
1 softwood -1.72 -1.41  1.94 0.886 -0.665 -0.180 -0.228  -0.382  1.54 0.753 -0.146  0.363
2 hardwood -3.60 -2.73  4.65 3.69  -1.92  -1.52   0.0086 -0.173  2.73 1.86  -0.994 -0.357}
\out{<hr>}}
