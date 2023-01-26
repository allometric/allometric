\name{hahn_1984}
\alias{hahn_1984}
\title{Hahn (1984)}
\description{Allometric models from Hahn (1984)}
\section{Stem Height Models}{\code{hst = 4.5 + b_1 * (1 - exp(b_2 * dsob))^b_3 * hstix^b_4 * T^b_5 * gn^b_6}
\itemize{
\item{\code{hst [ft]}}{ - total height of the stem}
\item{\code{dsob [in]}}{ - diameter of the stem, outside bark at breast height}
\item{\code{hstix [ft]}}{ - variable not defined}
\item{\code{d [in]}}{ - Top d.o.b., a value of 0 gives total height.}
\item{\code{gn [ft2 acre-1]}}{ - stand-level basal area}
}
\bold{Model Parameters}
\preformatted{   family       genus        species          b_1    b_2   b_3     b_4       b_5    b_6
 1 Pinaceae     Pinus        banksiana      16.9  0.130   1    0.209       0.778 0.129 
 2 Pinaceae     Pinus        resinosa       36.9  0.0830  1    0.00001     0.639 0.182 
 3 Pinaceae     Pinus        strobus        16.3  0.0862  1    0.162       0.868 0.233 
 4 Pinaceae     Pinus        ponderosa      36.9  0.0830  1    0.00001     0.639 0.182 
 5 Pinaceae     Picea        glauca         32.0  0.185   1.70 0           0.690 0.162 
 6 Pinaceae     Picea        mariana        20.0  0.190   1.29 0.178       0.573 0.102 
 7 Pinaceae     Abies        balsamea       14.3  0.199   1.42 0.233       0.769 0.124 
 8 Pinaceae     Tsuga        canadensis      5.31 0.104   1    0.685       0.714 0     
 9 Pinaceae     Larix        laricina       13.6  0.243   1.29 0.258       0.681 0.108 
10 Cupressaceae Juniperus    virginiana      8.21 0.197   1.31 0.340       0.762 0.117 
11 Cupressaceae Thuja        occidentalis    8.21 0.197   1.31 0.340       0.762 0.117 
12 Malvaceae    Tilia        americana       6.36 0.279   1.87 0.496       0.762 0.0584
13 Fagaceae     Fagus        grandifolia     7.19 0.284   1.44 0.389       0.822 0.114 
14 Betulaceae   Betula       alleghaniensis  7.19 0.284   1.44 0.389       0.822 0.114 
15 Oleaceae     Fraxinus     nigra          11.3  0.252   1.55 0.357       0.751 0.0686
16 Oleaceae     Fraxinus     americana       8.18 0.273   1.72 0.387       0.758 0.108 
17 Oleaceae     Fraxinus     pennsylvanica   8.18 0.273   1.72 0.387       0.758 0.108 
18 Platanaceae  Platanus     occidentalis    6.36 0.279   1.87 0.496       0.762 0.0584
19 Salicaceae   Populus      deltoides      13.6  0.287   1.61 0.307       1.03  0.0746
20 Salicaceae   Salix        nigra          13.6  0.287   1.61 0.307       1.03  0.0746
21 Salicaceae   Populus      balsamifera     6.43 0.235   1.34 0.474       0.734 0.0823
22 Salicaceae   Populus      grandidentata   5.53 0.226   1    0.469       0.725 0.118 
23 Salicaceae   Populus      tremuloides     6.43 0.235   1.34 0.474       0.734 0.0823
24 Betulaceae   Betula       papyrifera      7.28 0.227   1    0.412       0.765 0.110 
25 Betulaceae   Betula       nigra           7.28 0.227   1    0.412       0.765 0.110 
26 Altingiaceae Liquidambar  styraciflua     5.34 0.230   1.15 0.542       0.834 0.0637
27 Nyssaceae    Nyssa        biflora         5.34 0.230   1.15 0.542       0.834 0.0637
28 Rosaceae     Prunus       serotina        5.34 0.230   1.15 0.542       0.834 0.0637
29 Juglandaceae Juglans      nigra           6.36 0.279   1.87 0.496       0.762 0.0584
30 Juglandaceae Juglans      cinerea         6.36 0.279   1.87 0.496       0.762 0.0584
31 Magnoliaceae Liriodendron tulipifera      6.36 0.279   1.87 0.496       0.762 0.0584
32 Rosaceae     Crataegus    NA              6.96 0.266   1    0.487       0.770 0.0162
33 Pinaceae     Pinus        sylvestris     16.9  0.130   1    0.209       0.778 0.129 
34 Pinaceae     Pinus        nigra          16.9  0.130   1    0.209       0.778 0.129 
35 Pinaceae     Larix        decidua        16.9  0.130   1    0.209       0.778 0.129 
36 Pinaceae     Picea        abies          16.9  0.130   1    0.209       0.778 0.129 
37 Pinaceae     Pseudotsuga  menziesii      16.9  0.130   1    0.209       0.778 0.129 
38 Fagaceae     Quercus      alba            9.21 0.222   1    0.317       0.826 0.135 
39 Fagaceae     Quercus      bicolor         9.21 0.222   1    0.317       0.826 0.135 
40 Fagaceae     Quercus      macrocarpa      9.21 0.222   1    0.317       0.826 0.135 
41 Fagaceae     Quercus      muehlenbergii   9.21 0.222   1    0.317       0.826 0.135 
42 Fagaceae     Quercus      rubra           6.68 0.190   1    0.440       0.830 0.108 
43 Fagaceae     Quercus      velutina        3.80 0.392   2.91 0.556       0.843 0.0959
44 Fagaceae     Quercus      palustris       3.80 0.392   2.91 0.556       0.843 0.0959
45 Fagaceae     Quercus      ellipsoidalis   3.80 0.392   2.91 0.556       0.843 0.0959
46 Juglandaceae Carya        cordiformis     6.10 0.174   1    0.447       1.02  0.146 
47 Juglandaceae Carya        ovata           6.10 0.174   1    0.447       1.02  0.146 
48 Juglandaceae Carya        glabra          6.10 0.174   1    0.447       1.02  0.146 
49 Sapindaceae  Acer         nigrum          5.34 0.230   1.15 0.542   83440     0.0637
50 Sapindaceae  Acer         saccharum       5.34 0.230   1.15 0.542   83440     0.0637
51 Sapindaceae  Acer         rubrum          6.86 0.277   1.43 0.401       0.853 0.124 
52 Sapindaceae  Acer         saccharum       6.86 0.277   1.43 0.401       0.853 0.124 
53 Ulmaceae     Ulmus        americana       8.46 0.275   1.96 0.349       0.892 0.126 
54 Ulmaceae     Ulmus        rubra           8.46 0.275   1.96 0.349       0.892 0.126 
55 Ulmaceae     Ulmus        thomasii        8.46 0.275   1.96 0.349       0.892 0.126 
56 Cannabaceae  Celtis       occidentalis    6.86 0.277   1.43 0.401   85299     0.124 
57 Sapindaceae  Acer         pensylvanicum   6.96 0.266   1    0.487       0.770 0.0162
58 Sapindaceae  Acer         spicatum        6.96 0.266   1    0.487       0.770 0.0162
59 Betulaceae   Carpinus     caroliniana     6.96 0.266   1    0.487       0.770 0.0162
60 Betulaceae   Ostrya       virginiana      6.96 0.266   1    0.487       0.770 0.0162
61 Accipitridae Circus       canadensis      6.96 0.266   1    0.487       0.770 0.0162
62 Rosaceae     Prunus       pensylvanicum   6.96 0.266   1    0.487       0.770 0.0162
63 Rosaceae     Prunus       virginiana      6.96 0.266   1    0.487       0.770 0.0162
64 Rosaceae     Sorbus       americana       6.96 0.266   1    0.487       0.770 0.0162}
\out{<hr>}}
\section{Stem Volume Models}{\code{vsa = b_0 + b_1 * dsob^2 * hst}
\itemize{
\item{\code{vsa [ft3]}}{ - volume of the entire stem, including top and stump}
\item{\code{dsob [in]}}{ - diameter of the stem, outside bark at breast height}
\item{\code{hst [ft]}}{ - total height of the stem}
}
\bold{Model Parameters}
\preformatted{   family       genus        species          b_0     b_1
 1 Pinaceae     Pinus        banksiana      1.24  0.00216
 2 Pinaceae     Pinus        resinosa       2.08  0.00205
 3 Pinaceae     Pinus        strobus        0     0.00236
 4 Pinaceae     Pinus        ponderosa      2.08  0.00205
 5 Pinaceae     Picea        glauca         0.336 0.00260
 6 Pinaceae     Picea        mariana        0.263 0.00271
 7 Pinaceae     Abies        balsamea       0.251 0.00268
 8 Pinaceae     Tsuga        canadensis     0     0.00186
 9 Pinaceae     Larix        laricina       1.41  0.00223
10 Cupressaceae Juniperus    virginiana     0.590 0.00217
11 Cupressaceae Thuja        occidentalis   1.04  0.00241
12 Malvaceae    Tilia        americana      0.924 0.00221
13 Fagaceae     Fagus        grandifolia    2.28  0.00240
14 Betulaceae   Betula       alleghaniensis 0     0.00248
15 Oleaceae     Fraxinus     nigra          2.60  0.00179
16 Oleaceae     Fraxinus     americana      1.53  0.00202
17 Oleaceae     Fraxinus     pennsylvanica  1.53  0.00202
18 Platanaceae  Platanus     occidentalis   0     0.00248
19 Salicaceae   Populus      deltoides      0     0.00248
20 Salicaceae   Salix        nigra          0     0.00248
21 Salicaceae   Populus      balsamifera    0     0.00233
22 Salicaceae   Populus      grandidentata  0.946 0.00247
23 Salicaceae   Populus      tremuloides    2.08  0.00191
24 Betulaceae   Betula       papyrifera     2.30  0.00181
25 Betulaceae   Betula       nigra          0     0.00248
26 Altingiaceae Liquidambar  styraciflua    0     0.00248
27 Nyssaceae    Nyssa        biflora        0     0.00248
28 Rosaceae     Prunus       serotina       2.63  0.00189
29 Juglandaceae Juglans      nigra          2.63  0.00189
30 Juglandaceae Juglans      cinerea        2.63  0.00189
31 Magnoliaceae Liriodendron tulipifera     2.63  0.00189
32 Rosaceae     Crataegus    NA             0.867 0.00194
33 Pinaceae     Pinus        sylvestris     0.590 0.00217
34 Pinaceae     Pinus        nigra          0.590 0.00217
35 Pinaceae     Larix        decidua        0.590 0.00217
36 Pinaceae     Picea        abies          0.590 0.00217
37 Pinaceae     Pseudotsuga  menziesii      0.590 0.00217
38 Fagaceae     Quercus      alba           0.732 0.00195
39 Fagaceae     Quercus      bicolor        0.732 0.00195
40 Fagaceae     Quercus      macrocarpa     0.732 0.00195
41 Fagaceae     Quercus      muehlenbergii  0.732 0.00195
42 Fagaceae     Quercus      rubra          1.64  0.00203
43 Fagaceae     Quercus      velutina       0.755 0.00217
44 Fagaceae     Quercus      palustris      0.755 0.00217
45 Fagaceae     Quercus      ellipsoidalis  0.755 0.00217
46 Juglandaceae Carya        cordiformis    2.44  0.00188
47 Juglandaceae Carya        ovata          2.44  0.00188
48 Juglandaceae Carya        glabra         2.44  0.00188
49 Sapindaceae  Acer         nigrum         1.37  0.00221
50 Sapindaceae  Acer         saccharum      1.37  0.00221
51 Sapindaceae  Acer         rubrum         1.73  0.00219
52 Sapindaceae  Acer         saccharum      1.73  0.00219
53 Ulmaceae     Ulmus        americana      0     0.00232
54 Ulmaceae     Ulmus        rubra          0     0.00232
55 Ulmaceae     Ulmus        thomasii       0     0.00232
56 Cannabaceae  Celtis       occidentalis   0     0.00232
57 Sapindaceae  Acer         pensylvanicum  0.867 0.00194
58 Sapindaceae  Acer         spicatum       0.867 0.00194
59 Betulaceae   Carpinus     caroliniana    0.867 0.00194
60 Betulaceae   Ostrya       virginiana     0.867 0.00194
61 Accipitridae Circus       canadensis     0.867 0.00194
62 Rosaceae     Prunus       pensylvanicum  0.867 0.00194
63 Rosaceae     Prunus       virginiana     0.867 0.00194
64 Rosaceae     Sorbus       americana      0.867 0.00194}
\out{<hr>}
\code{vsa = b_0 + b_1 * dsob^2 * hst}
\itemize{
\item{\code{vsa [board_foot]}}{ - volume of the entire stem, including top and stump}
\item{\code{dsob [in]}}{ - diameter of the stem, outside bark at breast height}
\item{\code{hst [ft]}}{ - total height of the stem}
}
\bold{Model Parameters}
\preformatted{   family       genus        species          b_0    b_1
 1 Pinaceae     Pinus        banksiana      19.1  0.0131
 2 Pinaceae     Pinus        resinosa       24.8  0.0130
 3 Pinaceae     Pinus        strobus         0    0.0162
 4 Pinaceae     Pinus        ponderosa      24.8  0.0130
 5 Pinaceae     Picea        glauca          6.81 0.0161
 6 Pinaceae     Picea        mariana         0    0.0174
 7 Pinaceae     Abies        balsamea        4.66 0.0169
 8 Pinaceae     Tsuga        canadensis      0    0.0105
 9 Pinaceae     Larix        laricina       17.6  0.0143
10 Cupressaceae Juniperus    virginiana     17.2  0.0140
11 Cupressaceae Thuja        occidentalis   12.5  0.0156
12 Malvaceae    Tilia        americana      36.8  0.0144
13 Fagaceae     Fagus        grandifolia    56.5  0.0146
14 Betulaceae   Betula       alleghaniensis 14.6  0.0177
15 Oleaceae     Fraxinus     nigra          70.2  0.0102
16 Oleaceae     Fraxinus     americana      65.1  0.0112
17 Oleaceae     Fraxinus     pennsylvanica  65.1  0.0112
18 Platanaceae  Platanus     occidentalis   34.8  0.0146
19 Salicaceae   Populus      deltoides      34.8  0.0146
20 Salicaceae   Salix        nigra          34.8  0.0146
21 Salicaceae   Populus      balsamifera    18.0  0.0158
22 Salicaceae   Populus      grandidentata  31.8  0.0148
23 Salicaceae   Populus      tremuloides    29.3  0.0148
24 Betulaceae   Betula       papyrifera     37.6  0.0140
25 Betulaceae   Betula       nigra          34.8  0.0146
26 Altingiaceae Liquidambar  styraciflua    34.8  0.0146
27 Nyssaceae    Nyssa        biflora        34.8  0.0146
28 Rosaceae     Prunus       serotina       67.8  0.0111
29 Juglandaceae Juglans      nigra          67.8  0.0111
30 Juglandaceae Juglans      cinerea        67.8  0.0111
31 Magnoliaceae Liriodendron tulipifera     67.8  0.0111
32 Rosaceae     Crataegus    NA             36.3  0.0134
33 Pinaceae     Pinus        sylvestris     17.2  0.0140
34 Pinaceae     Pinus        nigra          17.2  0.0140
35 Pinaceae     Larix        decidua        17.2  0.0140
36 Pinaceae     Picea        abies          17.2  0.0140
37 Pinaceae     Pseudotsuga  menziesii      17.2  0.0140
38 Fagaceae     Quercus      alba           46.0  0.0117
39 Fagaceae     Quercus      bicolor        46.0  0.0117
40 Fagaceae     Quercus      macrocarpa     46.0  0.0117
41 Fagaceae     Quercus      muehlenbergii  46.0  0.0117
42 Fagaceae     Quercus      rubra          41.4  0.0133
43 Fagaceae     Quercus      velutina       34.7  0.0137
44 Fagaceae     Quercus      palustris      34.7  0.0137
45 Fagaceae     Quercus      ellipsoidalis  34.7  0.0137
46 Juglandaceae Carya        cordiformis    57.4  0.0112
47 Juglandaceae Carya        ovata          57.4  0.0112
48 Juglandaceae Carya        glabra         57.4  0.0112
49 Sapindaceae  Acer         nigrum         36.9  0.0153
50 Sapindaceae  Acer         saccharum      36.9  0.0153
51 Sapindaceae  Acer         rubrum         64.0  0.0122
52 Sapindaceae  Acer         saccharum      64.0  0.0122
53 Ulmaceae     Ulmus        americana      28.9  0.0147
54 Ulmaceae     Ulmus        rubra          28.9  0.0147
55 Ulmaceae     Ulmus        thomasii       28.9  0.0147
56 Cannabaceae  Celtis       occidentalis   28.9  0.0147
57 Sapindaceae  Acer         pensylvanicum  36.3  0.0134
58 Sapindaceae  Acer         spicatum       36.3  0.0134
59 Betulaceae   Carpinus     caroliniana    36.3  0.0134
60 Betulaceae   Ostrya       virginiana     36.3  0.0134
61 Accipitridae Circus       canadensis     36.3  0.0134
62 Rosaceae     Prunus       pensylvanicum  36.3  0.0134
63 Rosaceae     Prunus       virginiana     36.3  0.0134
64 Rosaceae     Sorbus       americana      36.3  0.0134}
\out{<hr>}}
\section{Stump Volume Models}{\code{vu = s * dsob^2}
\itemize{
\item{\code{vu [ft3]}}{ - volume of the stump}
\item{\code{dsob [in]}}{ - diameter of the stem, outside bark at breast height}
}
\bold{Model Parameters}
\preformatted{   family       genus        species              s
 1 Pinaceae     Pinus        banksiana      0.00702
 2 Pinaceae     Pinus        resinosa       0.00718
 3 Pinaceae     Pinus        strobus        0.00827
 4 Pinaceae     Pinus        ponderosa      0.00718
 5 Pinaceae     Picea        glauca         0.0107 
 6 Pinaceae     Picea        mariana        0.00888
 7 Pinaceae     Abies        balsamea       0.00997
 8 Pinaceae     Tsuga        canadensis     0.00858
 9 Pinaceae     Larix        laricina       0.00888
10 Cupressaceae Juniperus    virginiana     0.00888
11 Cupressaceae Thuja        occidentalis   0.0119 
12 Malvaceae    Tilia        americana      0.00964
13 Fagaceae     Fagus        grandifolia    0.0102 
14 Betulaceae   Betula       alleghaniensis 0.00997
15 Oleaceae     Fraxinus     nigra          0.0110 
16 Oleaceae     Fraxinus     americana      0.00873
17 Oleaceae     Fraxinus     pennsylvanica  0.00873
18 Platanaceae  Platanus     occidentalis   0.00898
19 Salicaceae   Populus      deltoides      0.0111 
20 Salicaceae   Salix        nigra          0.0111 
21 Salicaceae   Populus      balsamifera    0.00659
22 Salicaceae   Populus      grandidentata  0.00659
23 Salicaceae   Populus      tremuloides    0.00737
24 Betulaceae   Betula       papyrifera     0.00838
25 Betulaceae   Betula       nigra          0.00838
26 Altingiaceae Liquidambar  styraciflua    0.00898
27 Nyssaceae    Nyssa        biflora        0.00898
28 Rosaceae     Prunus       serotina       0.00898
29 Juglandaceae Juglans      nigra          0.00898
30 Juglandaceae Juglans      cinerea        0.00898
31 Magnoliaceae Liriodendron tulipifera     0.00898
32 Rosaceae     Crataegus    NA             0.00898
33 Pinaceae     Pinus        sylvestris     0.00888
34 Pinaceae     Pinus        nigra          0.00888
35 Pinaceae     Larix        decidua        0.00888
36 Pinaceae     Picea        abies          0.00888
37 Pinaceae     Pseudotsuga  menziesii      0.00888
38 Fagaceae     Quercus      alba           0.00973
39 Fagaceae     Quercus      bicolor        0.00973
40 Fagaceae     Quercus      macrocarpa     0.00973
41 Fagaceae     Quercus      muehlenbergii  0.00973
42 Fagaceae     Quercus      rubra          0.00891
43 Fagaceae     Quercus      velutina       0.00898
44 Fagaceae     Quercus      palustris      0.00898
45 Fagaceae     Quercus      ellipsoidalis  0.00898
46 Juglandaceae Carya        cordiformis    0.00898
47 Juglandaceae Carya        ovata          0.00898
48 Juglandaceae Carya        glabra         0.00898
49 Sapindaceae  Acer         nigrum         0.00889
50 Sapindaceae  Acer         saccharum      0.00889
51 Sapindaceae  Acer         rubrum         0.00848
52 Sapindaceae  Acer         saccharum      0.00848
53 Ulmaceae     Ulmus        americana      0.0104 
54 Ulmaceae     Ulmus        rubra          0.0104 
55 Ulmaceae     Ulmus        thomasii       0.0104 
56 Cannabaceae  Celtis       occidentalis   0.0104 
57 Sapindaceae  Acer         pensylvanicum  0.00898
58 Sapindaceae  Acer         spicatum       0.00898
59 Betulaceae   Carpinus     caroliniana    0.00898
60 Betulaceae   Ostrya       virginiana     0.00898
61 Accipitridae Circus       canadensis     0.00898
62 Rosaceae     Prunus       pensylvanicum  0.00898
63 Rosaceae     Prunus       virginiana     0.00898
64 Rosaceae     Sorbus       americana      0.00898}
\out{<hr>}}
\section{Stem Ratio Models}{\code{rsk = (b_0 + b_1 * dsob)/100}
\itemize{
\item{\code{rsk []}}{ - bark correction factor}
\item{\code{dsob [in]}}{ - diameter of the stem, outside bark at breast height}
}
\bold{Model Parameters}
\preformatted{   family       genus        species            b_0   b_1
 1 Pinaceae     Pinus        banksiana         91.3 0.325
 2 Pinaceae     Pinus        resinosa          90.4 0.325
 3 Pinaceae     Pinus        strobus           88.6 0.325
 4 Pinaceae     Pinus        ponderosa         90.4 0.325
 5 Pinaceae     Picea        glauca            99.7 0.325
 6 Pinaceae     Picea        mariana          100.  0.325
 7 Pinaceae     Abies        balsamea          97.5 0.325
 8 Pinaceae     Tsuga        canadensis        88.6 0.325
 9 Pinaceae     Larix        laricina         103.  0.325
10 Cupressaceae Juniperus    virginiana       100.  0.325
11 Cupressaceae Thuja        occidentalis     100.  0.325
12 Malvaceae    Tilia        americana         88.1 0.325
13 Fagaceae     Fagus        grandifolia    94853   0.325
14 Betulaceae   Betula       alleghaniensis    92.9 0.325
15 Oleaceae     Fraxinus     nigra             91.8 0.325
16 Oleaceae     Fraxinus     americana         91.8 0.325
17 Oleaceae     Fraxinus     pennsylvanica     91.8 0.325
18 Platanaceae  Platanus     occidentalis      89.6 0.325
19 Salicaceae   Populus      deltoides         91.9 0.325
20 Salicaceae   Salix        nigra             91.9 0.325
21 Salicaceae   Populus      balsamifera       89.6 0.325
22 Salicaceae   Populus      grandidentata     89.6 0.325
23 Salicaceae   Populus      tremuloides       92.8 0.325
24 Betulaceae   Betula       papyrifera        97.3 0.325
25 Betulaceae   Betula       nigra             97.3 0.325
26 Altingiaceae Liquidambar  styraciflua       89.6 0.325
27 Nyssaceae    Nyssa        biflora           89.6 0.325
28 Rosaceae     Prunus       serotina          88.7 0.325
29 Juglandaceae Juglans      nigra             88.7 0.325
30 Juglandaceae Juglans      cinerea           88.7 0.325
31 Magnoliaceae Liriodendron tulipifera        88.7 0.325
32 Rosaceae     Crataegus    NA                89.6 0.325
33 Pinaceae     Pinus        sylvestris        91.2 0.325
34 Pinaceae     Pinus        nigra             91.2 0.325
35 Pinaceae     Larix        decidua           91.2 0.325
36 Pinaceae     Picea        abies             91.2 0.325
37 Pinaceae     Pseudotsuga  menziesii         91.2 0.325
38 Fagaceae     Quercus      alba              87.4 0.325
39 Fagaceae     Quercus      bicolor           87.4 0.325
40 Fagaceae     Quercus      macrocarpa        87.4 0.325
41 Fagaceae     Quercus      muehlenbergii     87.4 0.325
42 Fagaceae     Quercus      rubra             90.1 0.325
43 Fagaceae     Quercus      velutina          89.5 0.325
44 Fagaceae     Quercus      palustris         89.5 0.325
45 Fagaceae     Quercus      ellipsoidalis     89.5 0.325
46 Juglandaceae Carya        cordiformis       85.1 0.597
47 Juglandaceae Carya        ovata             85.1 0.597
48 Juglandaceae Carya        glabra            85.1 0.597
49 Sapindaceae  Acer         nigrum            93.2 0.325
50 Sapindaceae  Acer         saccharum         93.2 0.325
51 Sapindaceae  Acer         rubrum            94.9 0.325
52 Sapindaceae  Acer         saccharum         94.9 0.325
53 Ulmaceae     Ulmus        americana         91.9 0.325
54 Ulmaceae     Ulmus        rubra             91.9 0.325
55 Ulmaceae     Ulmus        thomasii          91.9 0.325
56 Cannabaceae  Celtis       occidentalis      91.9 0.325
57 Sapindaceae  Acer         pensylvanicum     89.6 0.325
58 Sapindaceae  Acer         spicatum          89.6 0.325
59 Betulaceae   Carpinus     caroliniana       89.6 0.325
60 Betulaceae   Ostrya       virginiana        89.6 0.325
61 Accipitridae Circus       canadensis        89.6 0.325
62 Rosaceae     Prunus       pensylvanicum     89.6 0.325
63 Rosaceae     Prunus       virginiana        89.6 0.325
64 Rosaceae     Sorbus       americana         89.6 0.325}
\out{<hr>}}
