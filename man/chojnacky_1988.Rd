\name{chojnacky_1988}
\alias{chojnacky_1988}
\title{Chojnacky (1988)}
\description{Allometric models from Chojnacky (1988)}
\section{Stem Volume Models}{\code{vsa = beta_0 + beta_1 * X + beta_2 * X^2}
\itemize{
\item{\code{vsa [ft3]}}{ - volume of the entire stem, including top and stump}
\item{\code{dsoc [in]}}{ - diameter outside bark above the root collar}
\item{\code{hst [ft]}}{ - total height of the stem}
}
\bold{Model Parameters}
\preformatted{   species_group X_threshold single_stem family       genus     species      beta_0 beta_1 beta_2
 1 juniper       <= 6        FALSE       Cupressaceae Juniperus osteosperma  -0.129   2.03  0.101
 2 juniper       <= 6        TRUE        Cupressaceae Juniperus osteosperma  -0.032   2.11  0.145
 3 juniper       <= 6        FALSE       Cupressaceae Juniperus monosperma   -0.129   2.03  0.101
 4 juniper       <= 6        TRUE        Cupressaceae Juniperus monosperma   -0.032   2.11  0.145
 5 pinyon        <= 3        NA          Pinaceae     Pinus     edulis       -0.06    2.51  0.147
 6 pinyon        <= 3        NA          Pinaceae     Pinus     cembroides   -0.06    2.51  0.147
 7 mesquite      <= 2        FALSE       Fabaceae     Prosopis  velutina      0.02    1.90  0.576
 8 mesquite      <= 2        TRUE        Fabaceae     Prosopis  velutina     -0.043   2.34  0.802
 9 mesquite      <= 2        FALSE       Fabaceae     Senegalia gregii        0.02    1.90  0.576
10 mesquite      <= 2        TRUE        Fabaceae     Senegalia gregii       -0.043   2.34  0.802
11 mesquite      <= 2        FALSE       Fabaceae     Olneya    tesota        0.02    1.90  0.576
12 mesquite      <= 2        TRUE        Fabaceae     Olneya    tesota       -0.043   2.34  0.802
13 oak           <= 4        FALSE       Fagaceae     Quercus   emoryi       -0.028   1.95  0.14 
14 oak           <= 4        TRUE        Fagaceae     Quercus   emoryi       -0.068   2.40  0.138
15 oak           <= 4        FALSE       Fagaceae     Quercus   arizonica    -0.028   1.95  0.14 
16 oak           <= 4        TRUE        Fagaceae     Quercus   arizonica    -0.068   2.40  0.138
17 oak           <= 4        FALSE       Fagaceae     Quercus   oblongifolia -0.028   1.95  0.14 
18 oak           <= 4        TRUE        Fagaceae     Quercus   oblongifolia -0.068   2.40  0.138
19 oak           <= 4        FALSE       Fagaceae     Quercus   gambelii     -0.028   1.95  0.14 
20 oak           <= 4        TRUE        Fagaceae     Quercus   gambelii     -0.068   2.40  0.138
21 oak           <= 4        FALSE       Fagaceae     Quercus   turbinella   -0.028   1.95  0.14 
22 oak           <= 4        TRUE        Fagaceae     Quercus   turbinella   -0.068   2.40  0.138
23 oak           <= 4        FALSE       Fagaceae     Quercus   chysolepis   -0.028   1.95  0.14 
24 oak           <= 4        TRUE        Fagaceae     Quercus   chysolepis   -0.068   2.40  0.138}
\out{<hr>}
\code{vsa = beta_3 + beta_1 * X + beta_4/X}
\itemize{
\item{\code{vsa [ft3]}}{ - volume of the entire stem, including top and stump}
\item{\code{dsoc [in]}}{ - diameter outside bark above the root collar}
\item{\code{hst [ft]}}{ - total height of the stem}
}
\bold{Model Parameters}
\preformatted{   species_group X_threshold single_stem family       genus     species      beta_3 beta_1 beta_4
 1 juniper       > 6         FALSE       Cupressaceae Juniperus osteosperma   10.8    2.03 -43.7 
 2 juniper       > 6         TRUE        Cupressaceae Juniperus osteosperma   15.7    2.11 -62.8 
 3 juniper       > 6         FALSE       Cupressaceae Juniperus monosperma    10.8    2.03 -43.7 
 4 juniper       > 6         TRUE        Cupressaceae Juniperus monosperma    15.7    2.11 -62.8 
 5 pinyon        > 3         NA          Pinaceae     Pinus     edulis         3.90   2.51  -7.92
 6 pinyon        > 3         NA          Pinaceae     Pinus     cembroides     3.90   2.51  -7.92
 7 mesquite      > 2         FALSE       Fabaceae     Prosopis  velutina       6.93   1.90  -9.21
 8 mesquite      > 2         TRUE        Fabaceae     Prosopis  velutina       9.59   2.34 -12.8 
 9 mesquite      > 2         FALSE       Fabaceae     Senegalia gregii         6.93   1.90  -9.21
10 mesquite      > 2         TRUE        Fabaceae     Senegalia gregii         9.59   2.34 -12.8 
11 mesquite      > 2         FALSE       Fabaceae     Olneya    tesota         6.93   1.90  -9.21
12 mesquite      > 2         TRUE        Fabaceae     Olneya    tesota         9.59   2.34 -12.8 
13 oak           > 4         FALSE       Fagaceae     Quercus   emoryi         6.69   1.95 -17.9 
14 oak           > 4         TRUE        Fagaceae     Quercus   emoryi         6.57   2.40 -17.7 
15 oak           > 4         FALSE       Fagaceae     Quercus   arizonica      6.69   1.95 -17.9 
16 oak           > 4         TRUE        Fagaceae     Quercus   arizonica      6.57   2.40 -17.7 
17 oak           > 4         FALSE       Fagaceae     Quercus   oblongifolia   6.69   1.95 -17.9 
18 oak           > 4         TRUE        Fagaceae     Quercus   oblongifolia   6.57   2.40 -17.7 
19 oak           > 4         FALSE       Fagaceae     Quercus   gambelii       6.69   1.95 -17.9 
20 oak           > 4         TRUE        Fagaceae     Quercus   gambelii       6.57   2.40 -17.7 
21 oak           > 4         FALSE       Fagaceae     Quercus   turbinella     6.69   1.95 -17.9 
22 oak           > 4         TRUE        Fagaceae     Quercus   turbinella     6.57   2.40 -17.7 
23 oak           > 4         FALSE       Fagaceae     Quercus   chysolepis     6.69   1.95 -17.9 
24 oak           > 4         TRUE        Fagaceae     Quercus   chysolepis     6.57   2.40 -17.7 }
\out{<hr>}}
