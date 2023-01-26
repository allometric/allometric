\name{hahn_1991}
\alias{hahn_1991}
\title{Hahn and Hansen (1991)}
\description{Allometric models from Hahn and Hansen (1991)}
\section{Stem Volume Models}{\code{vsa = b_1 * hstix^b_2 * (1 - exp(b_3 * dsob^b_4))}
\itemize{
\item{\code{vsa [ft3]}}{ - volume of the entire stem, including top and stump}
\item{\code{hstix [ft]}}{ - Site index at an un-specified base age.}
\item{\code{dsob [in]}}{ - diameter of the stem, outside bark at breast height}
}
\bold{Model Parameters}
\preformatted{   family        genus  species   b_1    b_2      b_3   b_4
 1 Pinaceae      Pinus  resino~ 123.  0.415  -2.40e-5  2.72
 2 Pinaceae      Pinus  strobus 123.  0.415  -2.40e-5  2.72
 3 Pinaceae      Pinus  banksi~ 123.  0.415  -2.40e-5  2.72
 4 Pinaceae      Pinus  sylves~ 123.  0.415  -2.40e-5  2.72
 5 Pinaceae      Pinus  echina~ 123.  0.207  -5.77e-5  2.77
 6 Pinaceae      Pinus  virgin~ 123.  0.207  -5.77e-5  2.77
 7 Pinaceae      Pinus  taeda   123.  0.207  -5.77e-5  2.77
 8 Cupressaceae  Thuja  occide~ 454.  0.137  -2.55e-5  2.62
 9 Pinaceae      Larix  larici~ 454.  0.137  -2.55e-5  2.62
10 Pinaceae      Tsuga  canade~ 454.  0.137  -2.55e-5  2.62
11 Pinaceae      Abies  balsam~ 454.  0.137  -2.55e-5  2.62
12 Pinaceae      Picea  glauca  454.  0.137  -2.55e-5  2.62
13 Pinaceae      Picea  mariana 454.  0.137  -2.55e-5  2.62
14 Cupressaceae  Taxod~ distic~ 337.  0.116  -8.18e-6  3.2 
15 Cupressaceae  Junip~ virgin~ 113.  0.125  -1.06e-4  2.63
16 Fagaceae      Querc~ alba    139.  0.177  -7.04e-5  2.67
17 Fagaceae      Querc~ macroc~ 139.  0.177  -7.04e-5  2.67
18 Fagaceae      Querc~ muehle~ 139.  0.177  -7.04e-5  2.67
19 Fagaceae      Querc~ bicolor 139.  0.177  -7.04e-5  2.67
20 Fagaceae      Querc~ michau~ 139.  0.177  -7.04e-5  2.67
21 Fagaceae      Querc~ stella~ 146.  0.242  -5.27e-5  2.63
22 Fagaceae      Querc~ prinus  146.  0.242  -5.27e-5  2.63
23 Fagaceae      Querc~ lyrata  146.  0.242  -5.27e-5  2.63
24 Fagaceae      Querc~ rubra   168.  0.283  -4.62e-5  2.59
25 Fagaceae      Querc~ pagoda  168.  0.283  -4.62e-5  2.59
26 Fagaceae      Querc~ shumar~ 168.  0.283  -4.62e-5  2.59
27 Fagaceae      Querc~ veluti~ 152.  0.260  -4.41e-5  2.67
28 Fagaceae      Querc~ coccin~ 152.  0.260  -4.41e-5  2.67
29 Fagaceae      Querc~ palust~ 152.  0.260  -4.41e-5  2.67
30 Fagaceae      Querc~ marila~ 152.  0.260  -4.41e-5  2.67
31 Fagaceae      Querc~ imbric~ 152.  0.260  -4.41e-5  2.67
32 Fagaceae      Querc~ falcata 152.  0.260  -4.41e-5  2.67
33 Fagaceae      Querc~ ellips~ 152.  0.260  -4.41e-5  2.67
34 Fagaceae      Querc~ phellos 152.  0.260  -4.41e-5  2.67
35 Juglandaceae  Carya  ovata    84.2 0.245  -6.48e-5  2.82
36 Juglandaceae  Carya  alba     84.2 0.245  -6.48e-5  2.82
37 Juglandaceae  Carya  lacini~  84.2 0.245  -6.48e-5  2.82
38 Juglandaceae  Carya  illino~  84.2 0.245  -6.48e-5  2.82
39 Juglandaceae  Carya  glabra   60.6 0.296  -6.54e-5  2.87
40 Juglandaceae  Carya  cordif~  60.6 0.296  -6.54e-5  2.87
41 Juglandaceae  Carya  texana   60.6 0.296  -6.54e-5  2.87
42 Malvaceae     Tilia  americ~ 195.  0.174  -4.51e-5  2.73
43 Fagaceae      Fagus  grandi~ 195.  0.174  -4.51e-5  2.73
44 Betulaceae    Betula allegh~ 195.  0.174  -4.51e-5  2.73
45 Sapindaceae   Acer   saccha~ 119.  0.211  -7.18e-5  2.72
46 Sapindaceae   Acer   nigrum  119.  0.211  -7.18e-5  2.72
47 Sapindaceae   Acer   saccha~ 431.  0.0194 -4.66e-5  2.68
48 Sapindaceae   Acer   rubrum  431.  0.0194 -4.66e-5  2.68
49 Ulmaceae      Ulmus  americ~ 191.  0.161  -4.21e-5  2.75
50 Ulmaceae      Ulmus  rubra   191.  0.161  -4.21e-5  2.75
51 Cannabaceae   Celtis occide~ 191.  0.161  -4.21e-5  2.75
52 Ulmaceae      Ulmus  alata   191.  0.161  -4.21e-5  2.75
53 Ulmaceae      Ulmus  thomas~ 191.  0.161  -4.21e-5  2.75
54 Oleaceae      Fraxi~ americ~  73.7 0.228  -8.08e-5  2.8 
55 Oleaceae      Fraxi~ pennsy~  73.7 0.228  -8.08e-5  2.8 
56 Oleaceae      Fraxi~ nigra    73.7 0.228  -8.08e-5  2.8 
57 Oleaceae      Fraxi~ quadra~  73.7 0.228  -8.08e-5  2.8 
58 Platanaceae   Plata~ occide~ 326.  0.198  -3.24e-5  2.67
59 Salicaceae    Popul~ deltoi~ 480.  0.110  -3.05e-5  2.65
60 Salicaceae    Salix  nigra    39.0 0.385  -8.78e-5  2.77
61 Salicaceae    Popul~ tremul~  61.2 0.284  -1.18e-4  2.63
62 Salicaceae    Popul~ grandi~  61.2 0.284  -1.18e-4  2.63
63 Salicaceae    Popul~ balsam~  61.2 0.284  -1.18e-4  2.63
64 Magnoliaceae  Lirio~ tulipi~ 233.  0.209  -3.38e-5  2.76
65 Juglandaceae  Jugla~ nigra   137.  0.140  -7.43e-5  2.7 
66 Rosaceae      Prunus seroti~  95.0 0.241  -4.95e-5  2.84
67 Lauraceae     Sassa~ albidum  95.0 0.241  -4.95e-5  2.84
68 Altingiaceae  Liqui~ styrac~  95.0 0.241  -4.95e-5  2.84
69 Sapindaceae   Acer   negundo  95.0 0.241  -4.95e-5  2.84
70 Fabaceae      Gledi~ triaca~  95.0 0.241  -4.95e-5  2.84
71 Betulaceae    Betula nigra    95.0 0.241  -4.95e-5  2.84
72 Fabaceae      Robin~ pseudo~  95.0 0.241  -4.95e-5  2.84
73 Nyssaceae     Nyssa  biflora  95.0 0.241  -4.95e-5  2.84
74 Ebenaceae     Diosp~ kaki     95.0 0.241  -4.95e-5  2.84
75 Moraceae      Maclu~ pomife~  95.0 0.241  -4.95e-5  2.84
76 Juglandaceae  Jugla~ cinerea  95.0 0.241  -4.95e-5  2.84
77 Cornaceae     Cornus florida  95.0 0.241  -4.95e-5  2.84
78 Moraceae      Morus  rubra    95.0 0.241  -4.95e-5  2.84
79 Sapindaceae   Aescu~ glabra   95.0 0.241  -4.95e-5  2.84
80 Fabaceae      Gymno~ dioicus  95.0 0.241  -4.95e-5  2.84
81 Betulaceae    Ostrya virgin~  95.0 0.241  -4.95e-5  2.84
82 Betulaceae    Betula papyri~  95.0 0.241  -4.95e-5  2.84
83 Fabaceae      Cercis canade~  95.0 0.241  -4.95e-5  2.84
84 Rosaceae      Crata~ NA       95.0 0.241  -4.95e-5  2.84
85 Bignoniaceae  Catal~ specio~  95.0 0.241  -4.95e-5  2.84
86 Cannabaceae   Celtis laevig~  95.0 0.241  -4.95e-5  2.84
87 Magnoliaceae  Magno~ acumin~  95.0 0.241  -4.95e-5  2.84
88 Moraceae      Morus  alba     95.0 0.241  -4.95e-5  2.84
89 Betulaceae    Carpi~ caroli~  95.0 0.241  -4.95e-5  2.84
90 Simaroubaceae Ailan~ NA       95.0 0.241  -4.95e-5  2.84
91 Simaroubaceae Ailan~ altiss~  95.0 0.241  -4.95e-5  2.84
92 Rosaceae      Malus  NA       95.0 0.241  -4.95e-5  2.84
93 Nyssaceae     Nyssa  sylvat~  95.0 0.241  -4.95e-5  2.84}
\out{<hr>}
\code{vsa = b_1 * hstix^b_2 * (1 - exp(b_3 * dsob^b_4))}
\itemize{
\item{\code{vsa [board_foot]}}{ - volume of the entire stem, including top and stump}
\item{\code{hstix [ft]}}{ - Site index at an un-specified base age.}
\item{\code{dsob [in]}}{ - diameter of the stem, outside bark at breast height}
}
\bold{Model Parameters}
\preformatted{   family        genus  species   b_1    b_2      b_3   b_4
 1 Pinaceae      Pinus  resino~  926. 0.264  -1.82e-5  2.93
 2 Pinaceae      Pinus  strobus  926. 0.264  -1.82e-5  2.93
 3 Pinaceae      Pinus  banksi~  926. 0.264  -1.82e-5  2.93
 4 Pinaceae      Pinus  sylves~  926. 0.264  -1.82e-5  2.93
 5 Pinaceae      Pinus  echina~  816. 0.133  -4.17e-5  2.93
 6 Pinaceae      Pinus  virgin~  816. 0.133  -4.17e-5  2.93
 7 Pinaceae      Pinus  taeda    816. 0.133  -4.17e-5  2.93
 8 Cupressaceae  Thuja  occide~  916. 0.272  -3.44e-5  2.64
 9 Pinaceae      Larix  larici~  916. 0.272  -3.44e-5  2.64
10 Pinaceae      Tsuga  canade~  916. 0.272  -3.44e-5  2.64
11 Pinaceae      Abies  balsam~  916. 0.272  -3.44e-5  2.64
12 Pinaceae      Picea  glauca   916. 0.272  -3.44e-5  2.64
13 Pinaceae      Picea  mariana  916. 0.272  -3.44e-5  2.64
14 Cupressaceae  Taxod~ distic~  860. 0.0028 -3.44e-6  3.50
15 Cupressaceae  Junip~ virgin~  629. 0.113  -2.29e-4  2.31
16 Fagaceae      Querc~ alba     749. 0.221  -4.85e-5  2.73
17 Fagaceae      Querc~ macroc~  749. 0.221  -4.85e-5  2.73
18 Fagaceae      Querc~ muehle~  749. 0.221  -4.85e-5  2.73
19 Fagaceae      Querc~ bicolor  749. 0.221  -4.85e-5  2.73
20 Fagaceae      Querc~ michau~  749. 0.221  -4.85e-5  2.73
21 Fagaceae      Querc~ stella~  416. 0.400  -3.86e-5  2.75
22 Fagaceae      Querc~ prinus   416. 0.400  -3.86e-5  2.75
23 Fagaceae      Querc~ lyrata   416. 0.400  -3.86e-5  2.75
24 Fagaceae      Querc~ rubra    744. 0.263  -3.49e-5  2.80
25 Fagaceae      Querc~ pagoda   744. 0.263  -3.49e-5  2.80
26 Fagaceae      Querc~ shumar~  744. 0.263  -3.49e-5  2.80
27 Fagaceae      Querc~ veluti~  904. 0.223  -2.81e-5  2.86
28 Fagaceae      Querc~ coccin~  904. 0.223  -2.81e-5  2.86
29 Fagaceae      Querc~ palust~  904. 0.223  -2.81e-5  2.86
30 Fagaceae      Querc~ marila~  904. 0.223  -2.81e-5  2.86
31 Fagaceae      Querc~ imbric~  904. 0.223  -2.81e-5  2.86
32 Fagaceae      Querc~ falcata  904. 0.223  -2.81e-5  2.86
33 Fagaceae      Querc~ ellips~  904. 0.223  -2.81e-5  2.86
34 Fagaceae      Querc~ phellos  904. 0.223  -2.81e-5  2.86
35 Juglandaceae  Carya  ovata    732. 0.226  -3.13e-5  2.93
36 Juglandaceae  Carya  alba     732. 0.226  -3.13e-5  2.93
37 Juglandaceae  Carya  lacini~  732. 0.226  -3.13e-5  2.93
38 Juglandaceae  Carya  illino~  732. 0.226  -3.13e-5  2.93
39 Juglandaceae  Carya  glabra   394. 0.327  -3.30e-5  3.00
40 Juglandaceae  Carya  cordif~  394. 0.327  -3.30e-5  3.00
41 Juglandaceae  Carya  texana   394. 0.327  -3.30e-5  3.00
42 Malvaceae     Tilia  americ~ 1325. 0.175  -2.80e-5  2.83
43 Fagaceae      Fagus  grandi~ 1325. 0.175  -2.80e-5  2.83
44 Betulaceae    Betula allegh~ 1325. 0.175  -2.80e-5  2.83
45 Sapindaceae   Acer   saccha~  585  0.259  -3.68e-5  2.92
46 Sapindaceae   Acer   nigrum   585  0.259  -3.68e-5  2.92
47 Sapindaceae   Acer   saccha~ 2374. 0.0291 -2.32e-5  2.88
48 Sapindaceae   Acer   rubrum  2374. 0.0291 -2.32e-5  2.88
49 Ulmaceae      Ulmus  americ~  751. 0.284  -2.69e-5  2.82
50 Ulmaceae      Ulmus  rubra    751. 0.284  -2.69e-5  2.82
51 Cannabaceae   Celtis occide~  751. 0.284  -2.69e-5  2.82
52 Ulmaceae      Ulmus  alata    751. 0.284  -2.69e-5  2.82
53 Ulmaceae      Ulmus  thomas~  751. 0.284  -2.69e-5  2.82
54 Oleaceae      Fraxi~ americ~  419. 0.23   -3.32e-5  3.09
55 Oleaceae      Fraxi~ pennsy~  419. 0.23   -3.32e-5  3.09
56 Oleaceae      Fraxi~ nigra    419. 0.23   -3.32e-5  3.09
57 Oleaceae      Fraxi~ quadra~  419. 0.23   -3.32e-5  3.09
58 Platanaceae   Plata~ occide~  819. 0.340  -1.63e-5  2.96
59 Salicaceae    Popul~ deltoi~  916  0.228  -2.03e-5  3.00
60 Salicaceae    Salix  nigra    104. 0.574  -3.99e-5  3.00
61 Salicaceae    Popul~ tremul~  117  0.371  -3.64e-5  3.36
62 Salicaceae    Popul~ grandi~  117  0.371  -3.64e-5  3.36
63 Salicaceae    Popul~ balsam~  117  0.371  -3.64e-5  3.36
64 Magnoliaceae  Lirio~ tulipi~  569. 0.350  -1.77e-5  3.06
65 Juglandaceae  Jugla~ nigra    527. 0.207  -4.31e-5  2.92
66 Rosaceae      Prunus seroti~  648. 0.201  -2.78e-5  3.01
67 Lauraceae     Sassa~ albidum  648. 0.201  -2.78e-5  3.01
68 Altingiaceae  Liqui~ styrac~  648. 0.201  -2.78e-5  3.01
69 Sapindaceae   Acer   negundo  648. 0.201  -2.78e-5  3.01
70 Fabaceae      Gledi~ triaca~  648. 0.201  -2.78e-5  3.01
71 Betulaceae    Betula nigra    648. 0.201  -2.78e-5  3.01
72 Fabaceae      Robin~ pseudo~  648. 0.201  -2.78e-5  3.01
73 Nyssaceae     Nyssa  biflora  648. 0.201  -2.78e-5  3.01
74 Ebenaceae     Diosp~ kaki     648. 0.201  -2.78e-5  3.01
75 Moraceae      Maclu~ pomife~  648. 0.201  -2.78e-5  3.01
76 Juglandaceae  Jugla~ cinerea  648. 0.201  -2.78e-5  3.01
77 Cornaceae     Cornus florida  648. 0.201  -2.78e-5  3.01
78 Moraceae      Morus  rubra    648. 0.201  -2.78e-5  3.01
79 Sapindaceae   Aescu~ glabra   648. 0.201  -2.78e-5  3.01
80 Fabaceae      Gymno~ dioicus  648. 0.201  -2.78e-5  3.01
81 Betulaceae    Ostrya virgin~  648. 0.201  -2.78e-5  3.01
82 Betulaceae    Betula papyri~  648. 0.201  -2.78e-5  3.01
83 Fabaceae      Cercis canade~  648. 0.201  -2.78e-5  3.01
84 Rosaceae      Crata~ NA       648. 0.201  -2.78e-5  3.01
85 Bignoniaceae  Catal~ specio~  648. 0.201  -2.78e-5  3.01
86 Cannabaceae   Celtis laevig~  648. 0.201  -2.78e-5  3.01
87 Magnoliaceae  Magno~ acumin~  648. 0.201  -2.78e-5  3.01
88 Moraceae      Morus  alba     648. 0.201  -2.78e-5  3.01
89 Betulaceae    Carpi~ caroli~  648. 0.201  -2.78e-5  3.01
90 Simaroubaceae Ailan~ NA       648. 0.201  -2.78e-5  3.01
91 Simaroubaceae Ailan~ altiss~  648. 0.201  -2.78e-5  3.01
92 Rosaceae      Malus  NA       648. 0.201  -2.78e-5  3.01
93 Nyssaceae     Nyssa  sylvat~  648. 0.201  -2.78e-5  3.01}
\out{<hr>}}
