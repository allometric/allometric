\name{lambert_2005}
\alias{lambert_2005}
\title{Lambert et al. (2005)}
\description{Allometric models from Lambert et al. (2005)}
\section{Stem Biomass Models}{\code{bs = bwood1 * dsob^bwood2}
\itemize{
\item{\code{bs [kg]}}{ - stem biomass}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
}
\bold{Model Parameters}
\preformatted{   region    family       genus     species        bwood1 bwood2
 1 <chr [1]> Pinaceae     Abies     lasiocarpa     0.0528  2.43 
 2 <chr [7]> Pinaceae     Abies     balsamea       0.0534  2.40 
 3 <chr [5]> Salicaceae   Populus   balsamifera    0.051   2.45 
 4 <chr [1]> Malvaceae    Tilia     americana      0.0562  2.41 
 5 <chr [2]> Fagaceae     Fagus     grandifolia    0.148   2.30 
 6 <chr [2]> Oleaceae     Fraxinus  nigra          0.0941  2.35 
 7 <chr [1]> Rosaceae     Prunus    serotina       0.374   1.94 
 8 <chr [8]> Pinaceae     Picea     mariana        0.0477  2.51 
 9 <chr [2]> Pinaceae     Tsuga     canadensis     0.0619  2.38 
10 <chr [1]> Cupressaceae Juniperus virginiana     0.128   1.98 
11 <chr [2]> Cupressaceae Thuja     occidentalis   0.0654  2.21 
12 <chr [2]> Pinaceae     Pinus     strobus        0.0997  2.27 
13 <chr [1]> Betulaceae   Betula    populifolia    0.072   2.39 
14 <chr [2]> NA           Carya     NA             0.212   2.20 
15 <chr [1]> Betulaceae   Ostrya    virginiana     0.193   1.97 
16 <chr [7]> Pinaceae     Pinus     banksiana      0.0804  2.40 
17 <chr [1]> Salicaceae   Populus   grandidentata  0.0959  2.34 
18 <chr [2]> Pinaceae     Pinus     contorta       0.0475  2.54 
19 <chr [1]> Oleaceae     Fraxinus  pennsylvanica  0.157   2.18 
20 <chr [3]> Sapindaceae  Acer      rubra          0.101   2.34 
21 <chr [1]> Fagaceae     Quercus   rubra          0.175   2.16 
22 <chr [3]> Pinaceae     Pinus     resinosa       0.0564  2.45 
23 <chr [1]> Pinaceae     Picea     rubens         0.0989  2.28 
24 <chr [1]> Sapindaceae  Acer      saccharinum    0.232   2.1  
25 <chr [2]> Sapindaceae  Acer      saccharum      0.132   2.31 
26 <chr [8]> Pinaceae     Larix     laricina       0.0625  2.45 
27 <chr [9]> Salicaceae   Populus   tremuloids     0.0605  0.248
28 <chr [2]> Oleaceae     Fraxinus  americana      0.186   2.17 
29 <chr [7]> Betulaceae   Betula    papifera       0.186   2.17 
30 <chr [1]> Ulmaceae     Ulmus     americana      0.0402  2.58 
31 <chr [1]> Fagaceae     Quercus   alba           0.0762  2.33 
32 <chr [9]> Pinaceae     Picea     glauca         0.0359  2.58 
33 <chr [3]> Betulaceae   Betula    alleghaniensis 0.193   2.16 }
\out{<hr>}
\code{bs = bwood1 * dsob^bwood2 * hst^bwood3}
\itemize{
\item{\code{bs [kg]}}{ - stem biomass}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
\item{\code{hst [m]}}{ - total height of the stem}
}
\bold{Model Parameters}
\preformatted{   region    family       genus     species        bwood1 bwood2 bwood3
 1 <chr [1]> Pinaceae     Abies     lasiocarpa     0.0268   1.76  0.987
 2 <chr [7]> Pinaceae     Abies     balsamea       0.0294   1.84  0.864
 3 <chr [5]> Salicaceae   Populus   balsamifera    0.0117   1.78  1.26 
 4 <chr [1]> Malvaceae    Tilia     americana      0.0168   1.98  0.899
 5 <chr [2]> Fagaceae     Fagus     grandifolia    0.0432   2.04  0.7  
 6 <chr [2]> Oleaceae     Fraxinus  nigra          0.0306   2.18  0.574
 7 <chr [1]> Rosaceae     Prunus    serotina       0.0181   1.70  1.31 
 8 <chr [8]> Pinaceae     Picea     mariana        0.0309   1.75  1.00 
 9 <chr [2]> Pinaceae     Tsuga     canadensis     0.0257   1.93  0.858
10 <chr [1]> Cupressaceae Juniperus virginiana     0.052    1.77  0.705
11 <chr [2]> Cupressaceae Thuja     occidentalis   0.0295   1.70  0.943
12 <chr [2]> Pinaceae     Pinus     strobus        0.017    1.78  1.14 
13 <chr [1]> Betulaceae   Betula    populifolia    0.0295   1.91  0.914
14 <chr [2]> NA           Carya     NA             0.0139   1.59  1.51 
15 <chr [1]> Betulaceae   Ostrya    virginiana     0.0083   1.65  1.75 
16 <chr [7]> Pinaceae     Pinus     banksiana      0.0199   1.69  1.25 
17 <chr [1]> Salicaceae   Populus   grandidentata  0.0128   2.06  0.952
18 <chr [2]> Pinaceae     Pinus     contorta       0.0202   1.72  1.21 
19 <chr [1]> Oleaceae     Fraxinus  pennsylvanica  0.0224   1.78  1.07 
20 <chr [3]> Sapindaceae  Acer      rubra          0.0315   2.03  0.748
21 <chr [1]> Fagaceae     Quercus   rubra          0.0285   1.85  1.02 
22 <chr [3]> Pinaceae     Pinus     resinosa       0.0106   1.77  1.33 
23 <chr [1]> Pinaceae     Picea     rubens         0.0143   1.64  1.41 
24 <chr [1]> Sapindaceae  Acer      saccharinum    0.0274   1.71  1.11 
25 <chr [2]> Sapindaceae  Acer      saccharum      0.0301   2.03  0.817
26 <chr [8]> Pinaceae     Larix     laricina       0.0276   1.67  1.14 
27 <chr [9]> Salicaceae   Populus   tremuloids     0.0142   1.94  1.06 
28 <chr [2]> Oleaceae     Fraxinus  americana      0.0224   1.74  1.19 
29 <chr [7]> Betulaceae   Betula    papifera       0.0338   2.07  0.688
30 <chr [1]> Ulmaceae     Ulmus     americana      0.0207   2.23  0.649
31 <chr [1]> Fagaceae     Quercus   alba           0.0442   1.68  1.03 
32 <chr [9]> Pinaceae     Picea     glauca         0.0252   1.78  1.00 
33 <chr [3]> Betulaceae   Betula    alleghaniensis 0.0259   1.90  0.972}
\out{<hr>}
\code{bs = bwood1 * dsob^bwood2}
\itemize{
\item{\code{bs [kg]}}{ - stem biomass}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
}
\bold{Model Parameters}
\preformatted{  region    bwood1 bwood2 species_group
1 <chr [9]> 0.0871   2.37 hardwood     
2 <chr [9]> 0.0648   2.39 softwood     
3 <chr [9]> 0.0787   2.37 all          }
\out{<hr>}
\code{bs = bwood1 * dsob^bwood2 * hst^bwood3}
\itemize{
\item{\code{bs [kg]}}{ - stem biomass}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
\item{\code{hst [m]}}{ - total height of the stem}
}
\bold{Model Parameters}
\preformatted{  region    bwood1 bwood2 bwood3 species_group
1 <chr [9]> 0.0009   0.01 0.0168 hardwood     
2 <chr [9]> 0.0284   1.69 1.09   softwood     
3 <chr [9]> 0.0348   1.92 0.783  all          }
\out{<hr>}}
\section{Bark Biomass Models}{\code{bk = bbark1 * dsob^bbark2}
\itemize{
\item{\code{bk [kg]}}{ - bark biomass}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
}
\bold{Model Parameters}
\preformatted{   region    family       genus     species        bbark1 bbark2
 1 <chr [1]> Pinaceae     Abies     lasiocarpa     0.0108  2.39 
 2 <chr [7]> Pinaceae     Abies     balsamea       0.0115  2.35 
 3 <chr [5]> Salicaceae   Populus   balsamifera    0.0297  2.11 
 4 <chr [1]> Malvaceae    Tilia     americana      0.0302  2.10 
 5 <chr [2]> Fagaceae     Fagus     grandifolia    0.012   2.24 
 6 <chr [2]> Oleaceae     Fraxinus  nigra          0.0323  2.08 
 7 <chr [1]> Rosaceae     Prunus    serotina       0.0679  1.84 
 8 <chr [8]> Pinaceae     Picea     mariana        0.0153  2.24 
 9 <chr [2]> Pinaceae     Tsuga     canadensis     0.0139  2.33 
10 <chr [1]> Cupressaceae Juniperus virginiana     0.0377  1.61 
11 <chr [2]> Cupressaceae Thuja     occidentalis   0.0114  2.14 
12 <chr [2]> Pinaceae     Pinus     strobus        0.0192  2.20 
13 <chr [1]> Betulaceae   Betula    populifolia    0.0168  2.26 
14 <chr [2]> NA           Carya     NA             0.0365  2.11 
15 <chr [1]> Betulaceae   Ostrya    virginiana     0.0671  1.59 
16 <chr [7]> Pinaceae     Pinus     banksiana      0.0184  2.07 
17 <chr [1]> Salicaceae   Populus   grandidentata  0.0308  2.22 
18 <chr [2]> Pinaceae     Pinus     contorta       0.0186  2.08 
19 <chr [1]> Oleaceae     Fraxinus  pennsylvanica  0.0416  2.05 
20 <chr [3]> Sapindaceae  Acer      rubra          0.0291  2.09 
21 <chr [1]> Fagaceae     Quercus   rubra          0.0381  2.10 
22 <chr [3]> Pinaceae     Pinus     resinosa       0.0188  2.05 
23 <chr [1]> Pinaceae     Picea     rubens         0.022   2.09 
24 <chr [1]> Sapindaceae  Acer      saccharinum    0.0278  2.04 
25 <chr [2]> Sapindaceae  Acer      saccharum      0.0631  1.92 
26 <chr [8]> Pinaceae     Larix     laricina       0.0174  2.11 
27 <chr [9]> Salicaceae   Populus   tremuloids     0.0168  0.239
28 <chr [2]> Oleaceae     Fraxinus  americana      0.0406  1.99 
29 <chr [7]> Betulaceae   Betula    papifera       0.0406  1.99 
30 <chr [1]> Ulmaceae     Ulmus     americana      0.0073  2.49 
31 <chr [1]> Fagaceae     Quercus   alba           0.0338  1.98 
32 <chr [9]> Pinaceae     Picea     glauca         0.0116  2.30 
33 <chr [3]> Betulaceae   Betula    alleghaniensis 0.0192  2.25 }
\out{<hr>}
\code{bk = bbark1 * dsob^bbark2 * hst^bbark3}
\itemize{
\item{\code{bk [kg]}}{ - bark biomass}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
\item{\code{hst [m]}}{ - total height of the stem}
}
\bold{Model Parameters}
\preformatted{   region    family       genus     species        bbark1 bbark2 bbark3
 1 <chr [1]> Pinaceae     Abies     lasiocarpa     0.0009   1.45  1.88 
 2 <chr [7]> Pinaceae     Abies     balsamea       0.0053   2.09  0.584
 3 <chr [5]> Salicaceae   Populus   balsamifera    0.018    1.81  0.514
 4 <chr [1]> Malvaceae    Tilia     americana      0.0057   1.59  1.15 
 5 <chr [2]> Fagaceae     Fagus     grandifolia    0.0049   1.91  0.677
 6 <chr [2]> Oleaceae     Fraxinus  nigra          0.0897   2.26 -0.567
 7 <chr [1]> Rosaceae     Prunus    serotina       0.0101   1.60  0.919
 8 <chr [8]> Pinaceae     Picea     mariana        0.0115   1.74  0.659
 9 <chr [2]> Pinaceae     Tsuga     canadensis     0.0118   1.99  0.47 
10 <chr [1]> Cupressaceae Juniperus virginiana     0.0283   1.71  0    
11 <chr [2]> Cupressaceae Thuja     occidentalis   0.0076   1.79  0.613
12 <chr [2]> Pinaceae     Pinus     strobus        0.0069   1.66  0.958
13 <chr [1]> Betulaceae   Betula    populifolia    0.0148   1.84  0.502
14 <chr [2]> NA           Carya     NA             0.0081   1.49  1.13 
15 <chr [1]> Betulaceae   Ostrya    virginiana     0.0012   1.15  2.29 
16 <chr [7]> Pinaceae     Pinus     banksiana      0.0141   1.60  0.596
17 <chr [1]> Salicaceae   Populus   grandidentata  0.024    2.31  0    
18 <chr [2]> Pinaceae     Pinus     contorta       0.0099   1.60  0.746
19 <chr [1]> Oleaceae     Fraxinus  pennsylvanica  0.0219   1.42  0.896
20 <chr [3]> Sapindaceae  Acer      rubra          0.0283   2.09  0    
21 <chr [1]> Fagaceae     Quercus   rubra          0.0326   1.81  0.415
22 <chr [3]> Pinaceae     Pinus     resinosa       0.0277   1.52  0.464
23 <chr [1]> Pinaceae     Picea     rubens         0.0274   2.02  0    
24 <chr [1]> Sapindaceae  Acer      saccharinum    0.0123   1.82  0.501
25 <chr [2]> Sapindaceae  Acer      saccharum      0.0103   1.71  0.851
26 <chr [8]> Pinaceae     Larix     laricina       0.012    1.71  0.581
27 <chr [9]> Salicaceae   Populus   tremuloids     0.0063   2.08  0.662
28 <chr [2]> Oleaceae     Fraxinus  americana      0.0126   1.65  0.789
29 <chr [7]> Betulaceae   Betula    papifera       0.008    1.98  0.666
30 <chr [1]> Ulmaceae     Ulmus     americana      0.0078   2.45  0    
31 <chr [1]> Fagaceae     Quercus   alba           0.0308   1.75  0.350
32 <chr [9]> Pinaceae     Picea     glauca         0.0096   1.69  0.739
33 <chr [3]> Betulaceae   Betula    alleghaniensis 0.0069   2.08  0.537}
\out{<hr>}
\code{bk = bbark1 * dsob^bbark2}
\itemize{
\item{\code{bk [kg]}}{ - bark biomass}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
}
\bold{Model Parameters}
\preformatted{  region    bbark1 bbark2 species_group
1 <chr [9]> 0.0241   2.20 hardwood     
2 <chr [9]> 0.0162   2.20 softwood     
3 <chr [9]> 0.0185   2.22 all          }
\out{<hr>}
\code{bk = bbark1 * dsob^bbark2 * hst^bbark3}
\itemize{
\item{\code{bk [kg]}}{ - bark biomass}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
\item{\code{hst [m]}}{ - total height of the stem}
}
\bold{Model Parameters}
\preformatted{  region    bbark1 bbark2 bbark3 species_group
1 <chr [9]> 0.0005 0.0201 0.0327 hardwood     
2 <chr [9]> 0.01   1.85   0.562  softwood     
3 <chr [9]> 0.0139 1.54   0.819  all          }
\out{<hr>}}
\section{Branch Biomass Models}{\code{bb = bbranches1 * dsob^bbranches2}
\itemize{
\item{\code{bb [kg]}}{ - branch biomass}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
}
\bold{Model Parameters}
\preformatted{   region    family       genus     species        bbranches1 bbranches2
 1 <chr [1]> Pinaceae     Abies     lasiocarpa         0.0121      2.35 
 2 <chr [7]> Pinaceae     Abies     balsamea           0.007       2.54 
 3 <chr [5]> Salicaceae   Populus   balsamifera        0.012       2.42 
 4 <chr [1]> Malvaceae    Tilia     americana          0.023       2.24 
 5 <chr [2]> Fagaceae     Fagus     grandifolia        0.037       2.37 
 6 <chr [2]> Oleaceae     Fraxinus  nigra              0.0448      1.98 
 7 <chr [1]> Rosaceae     Prunus    serotina           0.0796      2.01 
 8 <chr [8]> Pinaceae     Picea     mariana            0.0278      2.08 
 9 <chr [2]> Pinaceae     Tsuga     canadensis         0.0217      2.27 
10 <chr [1]> Cupressaceae Juniperus virginiana         0.0254      2.29 
11 <chr [2]> Cupressaceae Thuja     occidentalis       0.0335      1.94 
12 <chr [2]> Pinaceae     Pinus     strobus            0.0056      2.60 
13 <chr [1]> Betulaceae   Betula    populifolia        0.0088      2.57 
14 <chr [2]> NA           Carya     NA                 0.0087      2.89 
15 <chr [1]> Betulaceae   Ostrya    virginiana         0.0278      2.13 
16 <chr [7]> Pinaceae     Pinus     banksiana          0.0079      2.42 
17 <chr [1]> Salicaceae   Populus   grandidentata      0.0047      2.65 
18 <chr [2]> Pinaceae     Pinus     contorta           0.0198      2.13 
19 <chr [1]> Oleaceae     Fraxinus  pennsylvanica      0.0177      2.34 
20 <chr [3]> Sapindaceae  Acer      rubra              0.0175      2.48 
21 <chr [1]> Fagaceae     Quercus   rubra              0.0085      2.78 
22 <chr [3]> Pinaceae     Pinus     resinosa           0.0033      2.75 
23 <chr [1]> Pinaceae     Picea     rubens             0.0005      3.28 
24 <chr [1]> Sapindaceae  Acer      saccharinum        0.0028      3.10 
25 <chr [2]> Sapindaceae  Acer      saccharum          0.033       2.37 
26 <chr [8]> Pinaceae     Larix     laricina           0.0196      2.27 
27 <chr [9]> Salicaceae   Populus   tremuloids         0.008       0.252
28 <chr [2]> Oleaceae     Fraxinus  americana          0.0461      2.23 
29 <chr [7]> Betulaceae   Betula    papifera           0.0461      2.23 
30 <chr [1]> Ulmaceae     Ulmus     americana          0.0401      2.18 
31 <chr [1]> Fagaceae     Quercus   alba               0.0113      2.62 
32 <chr [9]> Pinaceae     Picea     glauca             0.0283      2.08 
33 <chr [3]> Betulaceae   Betula    alleghaniensis     0.0305      2.40 }
\out{<hr>}
\code{bb = bbranches1 * dsob^bbranches2 * hst^bbranches3}
\itemize{
\item{\code{bb [kg]}}{ - branch biomass}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
\item{\code{hst [m]}}{ - total height of the stem}
}
\bold{Model Parameters}
\preformatted{   region    family       genus     species        bbranches1 bbranches2 bbranches3
 1 <chr [1]> Pinaceae     Abies     lasiocarpa         0.047        2.93     -1.16 
 2 <chr [7]> Pinaceae     Abies     balsamea           0.0117       3.51     -1.30 
 3 <chr [5]> Salicaceae   Populus   balsamifera        0.0112       3.09     -0.716
 4 <chr [1]> Malvaceae    Tilia     americana          0.0039       2.01      0.859
 5 <chr [2]> Fagaceae     Fagus     grandifolia        0.0355       2.37      0    
 6 <chr [2]> Oleaceae     Fraxinus  nigra              0.0994       2.16     -0.481
 7 <chr [1]> Rosaceae     Prunus    serotina           0.0005       2.80      0.860
 8 <chr [8]> Pinaceae     Picea     mariana            0.038        3.26     -1.42 
 9 <chr [2]> Pinaceae     Tsuga     canadensis         0.0215       2.66     -0.468
10 <chr [1]> Cupressaceae Juniperus virginiana         0.0219       2.36      0    
11 <chr [2]> Cupressaceae Thuja     occidentalis       0.0501       2.52     -0.877
12 <chr [2]> Pinaceae     Pinus     strobus            0.0184       3.20     -1.09 
13 <chr [1]> Betulaceae   Betula    populifolia        0.015        3.03     -0.763
14 <chr [2]> NA           Carya     NA                 0.005        3.05      0    
15 <chr [1]> Betulaceae   Ostrya    virginiana         0.0009       1.92      1.78 
16 <chr [7]> Pinaceae     Pinus     banksiana          0.0185       3.06     -0.982
17 <chr [1]> Salicaceae   Populus   grandidentata      0.0131       3.13     -0.838
18 <chr [2]> Pinaceae     Pinus     contorta           0.044        3.72     -2.04 
19 <chr [1]> Oleaceae     Fraxinus  pennsylvanica      0.0176       2.33      0    
20 <chr [3]> Sapindaceae  Acer      rubra              0.0225       2.41      0    
21 <chr [1]> Fagaceae     Quercus   rubra              0.0013       3.06      0.315
22 <chr [3]> Pinaceae     Pinus     resinosa           0.0125       3.39     -1.19 
23 <chr [1]> Pinaceae     Picea     rubens             0.0005       3.31      0    
24 <chr [1]> Sapindaceae  Acer      saccharinum        0.0543       3.73     -1.65 
25 <chr [2]> Sapindaceae  Acer      saccharum          0.0661       2.59     -0.493
26 <chr [8]> Pinaceae     Larix     laricina           0.0336       3.13     -1.16 
27 <chr [9]> Salicaceae   Populus   tremuloids         0.0137       2.93     -0.622
28 <chr [2]> Oleaceae     Fraxinus  americana          0.0354       2.30      0    
29 <chr [7]> Betulaceae   Betula    papifera           0.0257       3.18     -0.942
30 <chr [1]> Ulmaceae     Ulmus     americana          0.0393       2.19      0    
31 <chr [1]> Fagaceae     Quercus   alba               0.0022       2.02      1.40 
32 <chr [9]> Pinaceae     Picea     glauca             0.0322       2.90     -0.920
33 <chr [3]> Betulaceae   Betula    alleghaniensis     0.0325       2.39      0    }
\out{<hr>}
\code{bb = bbranches1 * dsob^bbranches2}
\itemize{
\item{\code{bb [kg]}}{ - branch biomass}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
}
\bold{Model Parameters}
\preformatted{  region    bbranches1 bbranches2 species_group
1 <chr [9]>     0.0167       2.48 hardwood     
2 <chr [9]>     0.0156       2.29 softwood     
3 <chr [9]>     0.023        2.27 all          }
\out{<hr>}
\code{bb = bbranches1 * dsob^bbranches2 * hst^bbranches3}
\itemize{
\item{\code{bb [kg]}}{ - branch biomass}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
\item{\code{hst [m]}}{ - total height of the stem}
}
\bold{Model Parameters}
\preformatted{  region    bbranches1 bbranches2 bbranches3 species_group
1 <chr [9]>     0.0024     0.0309     0.0461 hardwood     
2 <chr [9]>     0.0301     3.00      -1.05   softwood     
3 <chr [9]>     0.0346     2.67      -0.603  all          }
\out{<hr>}}
\section{Foliage Biomass Models}{\code{bf = bfoliage1 * dsob^bfoliage2}
\itemize{
\item{\code{bf [kg]}}{ - foliage biomass}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
}
\bold{Model Parameters}
\preformatted{   region    family       genus     species        bfoliage1 bfoliage2
 1 <chr [1]> Pinaceae     Abies     lasiocarpa        0.0251      2.04
 2 <chr [7]> Pinaceae     Abies     balsamea          0.084       1.67
 3 <chr [5]> Salicaceae   Populus   balsamifera       0.0276      1.62
 4 <chr [1]> Malvaceae    Tilia     americana         0.0288      1.64
 5 <chr [2]> Fagaceae     Fagus     grandifolia       0.0376      1.62
 6 <chr [2]> Oleaceae     Fraxinus  nigra             0.0538      1.36
 7 <chr [1]> Rosaceae     Prunus    serotina          0.084       1.23
 8 <chr [8]> Pinaceae     Picea     mariana           0.165       1.41
 9 <chr [2]> Pinaceae     Tsuga     canadensis        0.0776      1.70
10 <chr [1]> Cupressaceae Juniperus virginiana        0.055       1.87
11 <chr [2]> Cupressaceae Thuja     occidentalis      0.0499      1.73
12 <chr [2]> Pinaceae     Pinus     strobus           0.0284      1.94
13 <chr [1]> Betulaceae   Betula    populifolia       0.0099      1.90
14 <chr [2]> NA           Carya     NA                0.0173      1.98
15 <chr [1]> Betulaceae   Ostrya    virginiana        0.0293      1.95
16 <chr [7]> Pinaceae     Pinus     banksiana         0.0389      1.73
17 <chr [1]> Salicaceae   Populus   grandidentata     0.008       2.01
18 <chr [2]> Pinaceae     Pinus     contorta          0.0432      1.72
19 <chr [1]> Oleaceae     Fraxinus  pennsylvanica     0.104       1.22
20 <chr [3]> Sapindaceae  Acer      rubra             0.0515      1.16
21 <chr [1]> Fagaceae     Quercus   rubra             0.0373      1.67
22 <chr [3]> Pinaceae     Pinus     resinosa          0.0212      2.07
23 <chr [1]> Pinaceae     Picea     rubens            0.0066      2.42
24 <chr [1]> Sapindaceae  Acer      saccharinum       0.143       1.26
25 <chr [2]> Sapindaceae  Acer      saccharum         0.0393      1.69
26 <chr [8]> Pinaceae     Larix     laricina          0.0801      1.49
27 <chr [9]> Salicaceae   Populus   tremuloids        0.0261      1.63
28 <chr [2]> Oleaceae     Fraxinus  americana         0.111       1.23
29 <chr [7]> Betulaceae   Betula    papifera          0.111       1.23
30 <chr [1]> Ulmaceae     Ulmus     americana         0.075       1.34
31 <chr [1]> Fagaceae     Quercus   alba              0.0188      1.79
32 <chr [9]> Pinaceae     Picea     glauca            0.160       1.47
33 <chr [3]> Betulaceae   Betula    alleghaniensis    0.112       1.40}
\out{<hr>}
\code{bf = bfoliage1 * dsob^bfoliage2 * hst^bfoliage3}
\itemize{
\item{\code{bf [kg]}}{ - foliage biomass}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
\item{\code{hst [m]}}{ - total height of the stem}
}
\bold{Model Parameters}
\preformatted{   region    family       genus     species        bfoliage1 bfoliage2 bfoliage3
 1 <chr [1]> Pinaceae     Abies     lasiocarpa        0.0551      1.78     0    
 2 <chr [7]> Pinaceae     Abies     balsamea          0.124       2.52    -1.12 
 3 <chr [5]> Salicaceae   Populus   balsamifera       0.0617      1.86    -0.538
 4 <chr [1]> Malvaceae    Tilia     americana         0.0147      1.83     0    
 5 <chr [2]> Fagaceae     Fagus     grandifolia       0.0452      1.56     0    
 6 <chr [2]> Oleaceae     Fraxinus  nigra             0.0124      1.03     0.875
 7 <chr [1]> Rosaceae     Prunus    serotina          0.198       1.44    -0.526
 8 <chr [8]> Pinaceae     Picea     mariana           0.205       2.57    -1.37 
 9 <chr [2]> Pinaceae     Tsuga     canadensis        0.147       2.01    -0.608
10 <chr [1]> Cupressaceae Juniperus virginiana        0.258       2.51    -1.56 
11 <chr [2]> Cupressaceae Thuja     occidentalis      0.0813      2.22    -0.791
12 <chr [2]> Pinaceae     Pinus     strobus           0.0584      2.24    -0.597
13 <chr [1]> Betulaceae   Betula    populifolia       0.0455      2.64    -1.50 
14 <chr [2]> NA           Carya     NA                0.0121      2.09     0    
15 <chr [1]> Betulaceae   Ostrya    virginiana        0.0247      2.01     0    
16 <chr [7]> Pinaceae     Pinus     banksiana         0.0325      1.79     0    
17 <chr [1]> Salicaceae   Populus   grandidentata     0.0382      2.17    -0.684
18 <chr [2]> Pinaceae     Pinus     contorta          0.0785      2.54    -1.21 
19 <chr [1]> Oleaceae     Fraxinus  pennsylvanica     0.0761      1.31     0    
20 <chr [3]> Sapindaceae  Acer      rubra             0.0571      1.49     0    
21 <chr [1]> Fagaceae     Quercus   rubra             0.0582      1.54     0    
22 <chr [3]> Pinaceae     Pinus     resinosa          0.0731      2.34    -0.738
23 <chr [1]> Pinaceae     Picea     rubens            0.0106      2.27     0    
24 <chr [1]> Sapindaceae  Acer      saccharinum       6.68        2.11    -2.17 
25 <chr [2]> Sapindaceae  Acer      saccharum         2.50        2.45    -2.30 
26 <chr [8]> Pinaceae     Larix     laricina          0.132       2.11    -0.878
27 <chr [9]> Salicaceae   Populus   tremuloids        0.027       1.62     0    
28 <chr [2]> Oleaceae     Fraxinus  americana         0.0195      1.05     0.784
29 <chr [7]> Betulaceae   Betula    papifera          0.142       2.31    -1.12 
30 <chr [1]> Ulmaceae     Ulmus     americana         0.0516      1.45     0    
31 <chr [1]> Fagaceae     Quercus   alba              0.0053      1.28     1.13 
32 <chr [9]> Pinaceae     Picea     glauca            0.183       2.41    -1.09 
33 <chr [3]> Betulaceae   Betula    alleghaniensis    0.168       1.28     0    }
\out{<hr>}
\code{bf = bfoliage1 * dsob^bfoliage2}
\itemize{
\item{\code{bf [kg]}}{ - foliage biomass}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
}
\bold{Model Parameters}
\preformatted{  region    bfoliage1 bfoliage2 species_group
1 <chr [9]>    0.039       1.62 hardwood     
2 <chr [9]>    0.0861      1.63 softwood     
3 <chr [9]>    0.0767      1.57 all          }
\out{<hr>}
\code{bf = bfoliage1 * dsob^bfoliage2 * hst^bfoliage3}
\itemize{
\item{\code{bf [kg]}}{ - foliage biomass}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
\item{\code{hst [m]}}{ - total height of the stem}
}
\bold{Model Parameters}
\preformatted{  region    bfoliage1 bfoliage2 bfoliage3 species_group
1 <chr [9]>    0.0038    0.0266    0.0412 hardwood     
2 <chr [9]>    0.155     2.40     -1.10   softwood     
3 <chr [9]>    0.182     2.29     -1.12   all          }
\out{<hr>}}
