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
\preformatted{   family        genus        species          b_1    b_2         b_3   b_4
 1 Pinaceae      Pinus        resinosa       123.  0.415  -0.0000240   2.72
 2 Pinaceae      Pinus        strobus        123.  0.415  -0.0000240   2.72
 3 Pinaceae      Pinus        banksiana      123.  0.415  -0.0000240   2.72
 4 Pinaceae      Pinus        sylvestris     123.  0.415  -0.0000240   2.72
 5 Pinaceae      Pinus        echinata       123.  0.207  -0.0000577   2.77
 6 Pinaceae      Pinus        virginiana     123.  0.207  -0.0000577   2.77
 7 Pinaceae      Pinus        taeda          123.  0.207  -0.0000577   2.77
 8 Cupressaceae  Thuja        occidentalis   454.  0.137  -0.0000255   2.62
 9 Pinaceae      Larix        laricina       454.  0.137  -0.0000255   2.62
10 Pinaceae      Tsuga        canadensis     454.  0.137  -0.0000255   2.62
11 Pinaceae      Abies        balsamea       454.  0.137  -0.0000255   2.62
12 Pinaceae      Picea        glauca         454.  0.137  -0.0000255   2.62
13 Pinaceae      Picea        mariana        454.  0.137  -0.0000255   2.62
14 Cupressaceae  Taxodium     distichum      337.  0.116  -0.00000818  3.2 
15 Cupressaceae  Juniperus    virginiana     113.  0.125  -0.000106    2.63
16 Fagaceae      Quercus      alba           139.  0.177  -0.0000704   2.67
17 Fagaceae      Quercus      macrocarpa     139.  0.177  -0.0000704   2.67
18 Fagaceae      Quercus      muehlenbergii  139.  0.177  -0.0000704   2.67
19 Fagaceae      Quercus      bicolor        139.  0.177  -0.0000704   2.67
20 Fagaceae      Quercus      michauxii      139.  0.177  -0.0000704   2.67
21 Fagaceae      Quercus      stellata       146.  0.242  -0.0000527   2.63
22 Fagaceae      Quercus      prinus         146.  0.242  -0.0000527   2.63
23 Fagaceae      Quercus      lyrata         146.  0.242  -0.0000527   2.63
24 Fagaceae      Quercus      rubra          168.  0.283  -0.0000462   2.59
25 Fagaceae      Quercus      pagoda         168.  0.283  -0.0000462   2.59
26 Fagaceae      Quercus      shumardii      168.  0.283  -0.0000462   2.59
27 Fagaceae      Quercus      velutina       152.  0.260  -0.0000441   2.67
28 Fagaceae      Quercus      coccinea       152.  0.260  -0.0000441   2.67
29 Fagaceae      Quercus      palustris      152.  0.260  -0.0000441   2.67
30 Fagaceae      Quercus      marilandica    152.  0.260  -0.0000441   2.67
31 Fagaceae      Quercus      imbricaria     152.  0.260  -0.0000441   2.67
32 Fagaceae      Quercus      falcata        152.  0.260  -0.0000441   2.67
33 Fagaceae      Quercus      ellipsoidalis  152.  0.260  -0.0000441   2.67
34 Fagaceae      Quercus      phellos        152.  0.260  -0.0000441   2.67
35 Juglandaceae  Carya        ovata           84.2 0.245  -0.0000648   2.82
36 Juglandaceae  Carya        alba            84.2 0.245  -0.0000648   2.82
37 Juglandaceae  Carya        laciniosa       84.2 0.245  -0.0000648   2.82
38 Juglandaceae  Carya        illinoinensis   84.2 0.245  -0.0000648   2.82
39 Juglandaceae  Carya        glabra          60.6 0.296  -0.0000654   2.87
40 Juglandaceae  Carya        cordiformis     60.6 0.296  -0.0000654   2.87
41 Juglandaceae  Carya        texana          60.6 0.296  -0.0000654   2.87
42 Malvaceae     Tilia        americana      195.  0.174  -0.0000451   2.73
43 Fagaceae      Fagus        grandifolia    195.  0.174  -0.0000451   2.73
44 Betulaceae    Betula       alleghaniensis 195.  0.174  -0.0000451   2.73
45 Sapindaceae   Acer         saccharum      119.  0.211  -0.0000718   2.72
46 Sapindaceae   Acer         nigrum         119.  0.211  -0.0000718   2.72
47 Sapindaceae   Acer         saccharinum    431.  0.0194 -0.0000466   2.68
48 Sapindaceae   Acer         rubrum         431.  0.0194 -0.0000466   2.68
49 Ulmaceae      Ulmus        americana      191.  0.161  -0.0000421   2.75
50 Ulmaceae      Ulmus        rubra          191.  0.161  -0.0000421   2.75
51 Cannabaceae   Celtis       occidentalis   191.  0.161  -0.0000421   2.75
52 Ulmaceae      Ulmus        alata          191.  0.161  -0.0000421   2.75
53 Ulmaceae      Ulmus        thomasii       191.  0.161  -0.0000421   2.75
54 Oleaceae      Fraxinus     americana       73.7 0.228  -0.0000808   2.8 
55 Oleaceae      Fraxinus     pennsylvanica   73.7 0.228  -0.0000808   2.8 
56 Oleaceae      Fraxinus     nigra           73.7 0.228  -0.0000808   2.8 
57 Oleaceae      Fraxinus     quadrangulata   73.7 0.228  -0.0000808   2.8 
58 Platanaceae   Platanus     occidentalis   326.  0.198  -0.0000324   2.67
59 Salicaceae    Populus      deltoides      480.  0.110  -0.0000305   2.65
60 Salicaceae    Salix        nigra           39.0 0.385  -0.0000878   2.77
61 Salicaceae    Populus      tremuloides     61.2 0.284  -0.000118    2.63
62 Salicaceae    Populus      grandidentata   61.2 0.284  -0.000118    2.63
63 Salicaceae    Populus      balsamifera     61.2 0.284  -0.000118    2.63
64 Magnoliaceae  Liriodendron tulipifera     233.  0.209  -0.0000338   2.76
65 Juglandaceae  Juglans      nigra          137.  0.140  -0.0000743   2.7 
66 Rosaceae      Prunus       serotina        95.0 0.241  -0.0000495   2.84
67 Lauraceae     Sassafras    albidum         95.0 0.241  -0.0000495   2.84
68 Altingiaceae  Liquidambar  styraciflua     95.0 0.241  -0.0000495   2.84
69 Sapindaceae   Acer         negundo         95.0 0.241  -0.0000495   2.84
70 Fabaceae      Gleditsia    triacanthos     95.0 0.241  -0.0000495   2.84
71 Betulaceae    Betula       nigra           95.0 0.241  -0.0000495   2.84
72 Fabaceae      Robinia      pseudoacacia    95.0 0.241  -0.0000495   2.84
73 Nyssaceae     Nyssa        biflora         95.0 0.241  -0.0000495   2.84
74 Ebenaceae     Diospyros    kaki            95.0 0.241  -0.0000495   2.84
75 Moraceae      Maclura      pomifera        95.0 0.241  -0.0000495   2.84
76 Juglandaceae  Juglans      cinerea         95.0 0.241  -0.0000495   2.84
77 Cornaceae     Cornus       florida         95.0 0.241  -0.0000495   2.84
78 Moraceae      Morus        rubra           95.0 0.241  -0.0000495   2.84
79 Sapindaceae   Aesculus     glabra          95.0 0.241  -0.0000495   2.84
80 Fabaceae      Gymnocladus  dioicus         95.0 0.241  -0.0000495   2.84
81 Betulaceae    Ostrya       virginiana      95.0 0.241  -0.0000495   2.84
82 Betulaceae    Betula       papyrifera      95.0 0.241  -0.0000495   2.84
83 Fabaceae      Cercis       canadensis      95.0 0.241  -0.0000495   2.84
84 Rosaceae      Crataegus    NA              95.0 0.241  -0.0000495   2.84
85 Bignoniaceae  Catalpa      speciosa        95.0 0.241  -0.0000495   2.84
86 Cannabaceae   Celtis       laevigata       95.0 0.241  -0.0000495   2.84
87 Magnoliaceae  Magnolia     acuminata       95.0 0.241  -0.0000495   2.84
88 Moraceae      Morus        alba            95.0 0.241  -0.0000495   2.84
89 Betulaceae    Carpinus     caroliniana     95.0 0.241  -0.0000495   2.84
90 Simaroubaceae Ailanthus    NA              95.0 0.241  -0.0000495   2.84
91 Simaroubaceae Ailanthus    altissima       95.0 0.241  -0.0000495   2.84
92 Rosaceae      Malus        NA              95.0 0.241  -0.0000495   2.84
93 Nyssaceae     Nyssa        sylvatica       95.0 0.241  -0.0000495   2.84}
\out{<hr>}
\code{vsa = b_1 * hstix^b_2 * (1 - exp(b_3 * dsob^b_4))}
\itemize{
\item{\code{vsa [board_foot]}}{ - volume of the entire stem, including top and stump}
\item{\code{hstix [ft]}}{ - Site index at an un-specified base age.}
\item{\code{dsob [in]}}{ - diameter of the stem, outside bark at breast height}
}
\bold{Model Parameters}
\preformatted{   family        genus        species          b_1    b_2         b_3   b_4
 1 Pinaceae      Pinus        resinosa       123.  0.415  -0.0000240   2.72
 2 Pinaceae      Pinus        strobus        123.  0.415  -0.0000240   2.72
 3 Pinaceae      Pinus        banksiana      123.  0.415  -0.0000240   2.72
 4 Pinaceae      Pinus        sylvestris     123.  0.415  -0.0000240   2.72
 5 Pinaceae      Pinus        echinata       123.  0.207  -0.0000577   2.77
 6 Pinaceae      Pinus        virginiana     123.  0.207  -0.0000577   2.77
 7 Pinaceae      Pinus        taeda          123.  0.207  -0.0000577   2.77
 8 Cupressaceae  Thuja        occidentalis   454.  0.137  -0.0000255   2.62
 9 Pinaceae      Larix        laricina       454.  0.137  -0.0000255   2.62
10 Pinaceae      Tsuga        canadensis     454.  0.137  -0.0000255   2.62
11 Pinaceae      Abies        balsamea       454.  0.137  -0.0000255   2.62
12 Pinaceae      Picea        glauca         454.  0.137  -0.0000255   2.62
13 Pinaceae      Picea        mariana        454.  0.137  -0.0000255   2.62
14 Cupressaceae  Taxodium     distichum      337.  0.116  -0.00000818  3.2 
15 Cupressaceae  Juniperus    virginiana     113.  0.125  -0.000106    2.63
16 Fagaceae      Quercus      alba           139.  0.177  -0.0000704   2.67
17 Fagaceae      Quercus      macrocarpa     139.  0.177  -0.0000704   2.67
18 Fagaceae      Quercus      muehlenbergii  139.  0.177  -0.0000704   2.67
19 Fagaceae      Quercus      bicolor        139.  0.177  -0.0000704   2.67
20 Fagaceae      Quercus      michauxii      139.  0.177  -0.0000704   2.67
21 Fagaceae      Quercus      stellata       146.  0.242  -0.0000527   2.63
22 Fagaceae      Quercus      prinus         146.  0.242  -0.0000527   2.63
23 Fagaceae      Quercus      lyrata         146.  0.242  -0.0000527   2.63
24 Fagaceae      Quercus      rubra          168.  0.283  -0.0000462   2.59
25 Fagaceae      Quercus      pagoda         168.  0.283  -0.0000462   2.59
26 Fagaceae      Quercus      shumardii      168.  0.283  -0.0000462   2.59
27 Fagaceae      Quercus      velutina       152.  0.260  -0.0000441   2.67
28 Fagaceae      Quercus      coccinea       152.  0.260  -0.0000441   2.67
29 Fagaceae      Quercus      palustris      152.  0.260  -0.0000441   2.67
30 Fagaceae      Quercus      marilandica    152.  0.260  -0.0000441   2.67
31 Fagaceae      Quercus      imbricaria     152.  0.260  -0.0000441   2.67
32 Fagaceae      Quercus      falcata        152.  0.260  -0.0000441   2.67
33 Fagaceae      Quercus      ellipsoidalis  152.  0.260  -0.0000441   2.67
34 Fagaceae      Quercus      phellos        152.  0.260  -0.0000441   2.67
35 Juglandaceae  Carya        ovata           84.2 0.245  -0.0000648   2.82
36 Juglandaceae  Carya        alba            84.2 0.245  -0.0000648   2.82
37 Juglandaceae  Carya        laciniosa       84.2 0.245  -0.0000648   2.82
38 Juglandaceae  Carya        illinoinensis   84.2 0.245  -0.0000648   2.82
39 Juglandaceae  Carya        glabra          60.6 0.296  -0.0000654   2.87
40 Juglandaceae  Carya        cordiformis     60.6 0.296  -0.0000654   2.87
41 Juglandaceae  Carya        texana          60.6 0.296  -0.0000654   2.87
42 Malvaceae     Tilia        americana      195.  0.174  -0.0000451   2.73
43 Fagaceae      Fagus        grandifolia    195.  0.174  -0.0000451   2.73
44 Betulaceae    Betula       alleghaniensis 195.  0.174  -0.0000451   2.73
45 Sapindaceae   Acer         saccharum      119.  0.211  -0.0000718   2.72
46 Sapindaceae   Acer         nigrum         119.  0.211  -0.0000718   2.72
47 Sapindaceae   Acer         saccharinum    431.  0.0194 -0.0000466   2.68
48 Sapindaceae   Acer         rubrum         431.  0.0194 -0.0000466   2.68
49 Ulmaceae      Ulmus        americana      191.  0.161  -0.0000421   2.75
50 Ulmaceae      Ulmus        rubra          191.  0.161  -0.0000421   2.75
51 Cannabaceae   Celtis       occidentalis   191.  0.161  -0.0000421   2.75
52 Ulmaceae      Ulmus        alata          191.  0.161  -0.0000421   2.75
53 Ulmaceae      Ulmus        thomasii       191.  0.161  -0.0000421   2.75
54 Oleaceae      Fraxinus     americana       73.7 0.228  -0.0000808   2.8 
55 Oleaceae      Fraxinus     pennsylvanica   73.7 0.228  -0.0000808   2.8 
56 Oleaceae      Fraxinus     nigra           73.7 0.228  -0.0000808   2.8 
57 Oleaceae      Fraxinus     quadrangulata   73.7 0.228  -0.0000808   2.8 
58 Platanaceae   Platanus     occidentalis   326.  0.198  -0.0000324   2.67
59 Salicaceae    Populus      deltoides      480.  0.110  -0.0000305   2.65
60 Salicaceae    Salix        nigra           39.0 0.385  -0.0000878   2.77
61 Salicaceae    Populus      tremuloides     61.2 0.284  -0.000118    2.63
62 Salicaceae    Populus      grandidentata   61.2 0.284  -0.000118    2.63
63 Salicaceae    Populus      balsamifera     61.2 0.284  -0.000118    2.63
64 Magnoliaceae  Liriodendron tulipifera     233.  0.209  -0.0000338   2.76
65 Juglandaceae  Juglans      nigra          137.  0.140  -0.0000743   2.7 
66 Rosaceae      Prunus       serotina        95.0 0.241  -0.0000495   2.84
67 Lauraceae     Sassafras    albidum         95.0 0.241  -0.0000495   2.84
68 Altingiaceae  Liquidambar  styraciflua     95.0 0.241  -0.0000495   2.84
69 Sapindaceae   Acer         negundo         95.0 0.241  -0.0000495   2.84
70 Fabaceae      Gleditsia    triacanthos     95.0 0.241  -0.0000495   2.84
71 Betulaceae    Betula       nigra           95.0 0.241  -0.0000495   2.84
72 Fabaceae      Robinia      pseudoacacia    95.0 0.241  -0.0000495   2.84
73 Nyssaceae     Nyssa        biflora         95.0 0.241  -0.0000495   2.84
74 Ebenaceae     Diospyros    kaki            95.0 0.241  -0.0000495   2.84
75 Moraceae      Maclura      pomifera        95.0 0.241  -0.0000495   2.84
76 Juglandaceae  Juglans      cinerea         95.0 0.241  -0.0000495   2.84
77 Cornaceae     Cornus       florida         95.0 0.241  -0.0000495   2.84
78 Moraceae      Morus        rubra           95.0 0.241  -0.0000495   2.84
79 Sapindaceae   Aesculus     glabra          95.0 0.241  -0.0000495   2.84
80 Fabaceae      Gymnocladus  dioicus         95.0 0.241  -0.0000495   2.84
81 Betulaceae    Ostrya       virginiana      95.0 0.241  -0.0000495   2.84
82 Betulaceae    Betula       papyrifera      95.0 0.241  -0.0000495   2.84
83 Fabaceae      Cercis       canadensis      95.0 0.241  -0.0000495   2.84
84 Rosaceae      Crataegus    NA              95.0 0.241  -0.0000495   2.84
85 Bignoniaceae  Catalpa      speciosa        95.0 0.241  -0.0000495   2.84
86 Cannabaceae   Celtis       laevigata       95.0 0.241  -0.0000495   2.84
87 Magnoliaceae  Magnolia     acuminata       95.0 0.241  -0.0000495   2.84
88 Moraceae      Morus        alba            95.0 0.241  -0.0000495   2.84
89 Betulaceae    Carpinus     caroliniana     95.0 0.241  -0.0000495   2.84
90 Simaroubaceae Ailanthus    NA              95.0 0.241  -0.0000495   2.84
91 Simaroubaceae Ailanthus    altissima       95.0 0.241  -0.0000495   2.84
92 Rosaceae      Malus        NA              95.0 0.241  -0.0000495   2.84
93 Nyssaceae     Nyssa        sylvatica       95.0 0.241  -0.0000495   2.84}
\out{<hr>}}
