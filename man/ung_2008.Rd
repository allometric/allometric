\name{ung_2008}
\alias{ung_2008}
\title{Ung et al. (2008)}
\description{Allometric models from Ung et al. (2008)}
\section{Stem Biomass Models}{\code{bs = bwood1 * dsob^bwood2}
\itemize{
\item{\code{bs [kg]}}{ - stem biomass}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
}
\bold{Model Parameters}
\preformatted{   region     family       genus       species      bwood1 bwood2
 1 <chr [2]>  Pinaceae     Abies       lasiocarpa   0.0250   2.64
 2 <chr [10]> Pinaceae     Picea       mariana      0.0494   2.50
 3 <chr [2]>  Pinaceae     Pinus       contorta     0.0323   2.68
 4 <chr [10]> Salicaceae   Populus     tremuloides  0.0608   2.47
 5 <chr [8]>  Betulaceae   Betula      papyrifera   0.0604   2.50
 6 <chr [10]> Pinaceae     Picea       glauca       0.0334   2.60
 7 <chr [1]>  Pinaceae     Pseudotsuga menziesii    0.0204   2.70
 8 <chr [1]>  Pinaceae     Picea       engelmannii  0.0223   2.72
 9 <chr [1]>  Pinaceae     Abies       amabilis     0.0424   2.43
10 <chr [1]>  Salicaceae   Populus     trichocarpa  0.046    2.43
11 <chr [1]>  Betulaceae   Alnus       rubra        0.046    2.43
12 <chr [1]>  Pinaceae     Picea       sitchensis   0.0302   2.58
13 <chr [1]>  Pinaceae     Tsuga       heterophylla 0.0141   2.87
14 <chr [1]>  Cupressaceae Thuja       plicata      0.0111   2.80}
\out{<hr>}
\code{bs = bwood1 * dsob^bwood2 * hst^bwood3}
\itemize{
\item{\code{bs [kg]}}{ - stem biomass}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
\item{\code{hst [m]}}{ - total height of the stem}
}
\bold{Model Parameters}
\preformatted{   region     family       genus       species      bwood1 bwood2 bwood3
 1 <chr [2]>  Pinaceae     Abies       lasiocarpa   0.022    1.65 1.17  
 2 <chr [10]> Pinaceae     Picea       mariana      0.0335   1.74 0.984 
 3 <chr [2]>  Pinaceae     Pinus       contorta     0.0239   1.68 1.19  
 4 <chr [10]> Salicaceae   Populus     tremuloides  0.0143   1.94 1.06  
 5 <chr [8]>  Betulaceae   Betula      papyrifera   0.0333   2.08 0.681 
 6 <chr [10]> Pinaceae     Picea       glauca       0.0265   1.80 0.973 
 7 <chr [1]>  Pinaceae     Pseudotsuga menziesii    0.0191   1.54 1.36  
 8 <chr [1]>  Pinaceae     Picea       engelmannii  0.0133   1.33 1.69  
 9 <chr [1]>  Pinaceae     Abies       amabilis     0.0315   1.83 0.806 
10 <chr [1]>  Salicaceae   Populus     trichocarpa  0.0051   1.07 2.27  
11 <chr [1]>  Betulaceae   Alnus       rubra        0.0051   1.07 2.27  
12 <chr [1]>  Pinaceae     Picea       sitchensis   0.0237   2.58 0.0822
13 <chr [1]>  Pinaceae     Tsuga       heterophylla 0.0113   1.93 1.11  
14 <chr [1]>  Cupressaceae Thuja       plicata      0.0188   1.34 1.53  }
\out{<hr>}
\code{bs = bwood1 * dsob^bwood2}
\itemize{
\item{\code{bs [kg]}}{ - stem biomass}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
}
\bold{Model Parameters}
\preformatted{  region     bwood1 bwood2 species_group
1 <chr [10]> 0.0864   2.37 hardwood     
2 <chr [10]> 0.0564   2.43 softwood     
3 <chr [10]> 0.0741   2.39 all          }
\out{<hr>}
\code{bs = bwood1 * dsob^bwood2 * hst^bwood3}
\itemize{
\item{\code{bs [kg]}}{ - stem biomass}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
\item{\code{hst [m]}}{ - total height of the stem}
}
\bold{Model Parameters}
\preformatted{  region     bwood1 bwood2 bwood3 species_group
1 <chr [10]> 0.0353   2.02  0.705 hardwood     
2 <chr [10]> 0.0276   1.69  1.10  softwood     
3 <chr [10]> 0.0283   1.83  0.955 all          }
\out{<hr>}}
\section{Bark Biomass Models}{\code{bk = bbark1 * dsob^bbark2}
\itemize{
\item{\code{bk [kg]}}{ - bark biomass}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
}
\bold{Model Parameters}
\preformatted{   region     family       genus       species       bbark1 bbark2
 1 <chr [2]>  Pinaceae     Abies       lasiocarpa   0.00612   2.54
 2 <chr [10]> Pinaceae     Picea       mariana      0.0148    2.25
 3 <chr [2]>  Pinaceae     Pinus       contorta     0.0144    2.18
 4 <chr [10]> Salicaceae   Populus     tremuloides  0.0159    2.41
 5 <chr [8]>  Betulaceae   Betula      papyrifera   0.014     2.39
 6 <chr [10]> Pinaceae     Picea       glauca       0.0114    2.31
 7 <chr [1]>  Pinaceae     Pseudotsuga menziesii    0.0069    2.55
 8 <chr [1]>  Pinaceae     Picea       engelmannii  0.0118    2.27
 9 <chr [1]>  Pinaceae     Abies       amabilis     0.0057    2.48
10 <chr [1]>  Salicaceae   Populus     trichocarpa  0.0074    2.44
11 <chr [1]>  Betulaceae   Alnus       rubra        0.0074    2.44
12 <chr [1]>  Pinaceae     Picea       sitchensis   0.0066    2.44
13 <chr [1]>  Pinaceae     Tsuga       heterophylla 0.0025    2.81
14 <chr [1]>  Cupressaceae Thuja       plicata      0.0003    3.27}
\out{<hr>}
\code{bk = bbark1 * dsob^bbark2 * hst^bbark3}
\itemize{
\item{\code{bk [kg]}}{ - bark biomass}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
\item{\code{hst [m]}}{ - total height of the stem}
}
\bold{Model Parameters}
\preformatted{   region     family       genus       species      bbark1 bbark2 bbark3
 1 <chr [2]>  Pinaceae     Abies       lasiocarpa   0.0061   1.86  0.769
 2 <chr [10]> Pinaceae     Picea       mariana      0.0132   1.77  0.578
 3 <chr [2]>  Pinaceae     Pinus       contorta     0.0117   1.64  0.652
 4 <chr [10]> Salicaceae   Populus     tremuloides  0.0063   2.07  0.669
 5 <chr [8]>  Betulaceae   Betula      papyrifera   0.0079   1.99  0.655
 6 <chr [10]> Pinaceae     Picea       glauca       0.0124   1.70  0.649
 7 <chr [1]>  Pinaceae     Pseudotsuga menziesii    0.0083   2.48  0    
 8 <chr [1]>  Pinaceae     Picea       engelmannii  0.0086   1.62  0.819
 9 <chr [1]>  Pinaceae     Abies       amabilis     0.0067   2.70 -0.310
10 <chr [1]>  Salicaceae   Populus     trichocarpa  0.0009   1.31  2.01 
11 <chr [1]>  Betulaceae   Alnus       rubra        0.0009   1.31  2.01 
12 <chr [1]>  Pinaceae     Picea       sitchensis   0.0045   1.23  1.52 
13 <chr [1]>  Pinaceae     Tsuga       heterophylla 0.0019   2.34  0.637
14 <chr [1]>  Cupressaceae Thuja       plicata      0.0002   2.44  1.13 }
\out{<hr>}
\code{bk = bbark1 * dsob^bbark2}
\itemize{
\item{\code{bk [kg]}}{ - bark biomass}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
}
\bold{Model Parameters}
\preformatted{  region     bbark1 bbark2 species_group
1 <chr [10]> 0.0226   2.22 hardwood     
2 <chr [10]> 0.0153   2.21 softwood     
3 <chr [10]> 0.0182   2.22 all          }
\out{<hr>}
\code{bk = bbark1 * dsob^bbark2 * hst^bbark3}
\itemize{
\item{\code{bk [kg]}}{ - bark biomass}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
\item{\code{hst [m]}}{ - total height of the stem}
}
\bold{Model Parameters}
\preformatted{  region     bbark1 bbark2 bbark3 species_group
1 <chr [10]> 0.009    1.87  0.714 hardwood     
2 <chr [10]> 0.0101   1.85  0.552 softwood     
3 <chr [10]> 0.012    1.64  0.775 all          }
\out{<hr>}}
\section{Branch Biomass Models}{\code{bb = bbranches1 * dsob^bbranches2}
\itemize{
\item{\code{bb [kg]}}{ - branch biomass}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
}
\bold{Model Parameters}
\preformatted{   region     family       genus       species      bbranches1 bbranches2
 1 <chr [2]>  Pinaceae     Abies       lasiocarpa       0.0178       2.43
 2 <chr [10]> Pinaceae     Picea       mariana          0.0291       2.08
 3 <chr [2]>  Pinaceae     Pinus       contorta         0.0209       2.18
 4 <chr [10]> Salicaceae   Populus     tremuloides      0.0082       2.51
 5 <chr [8]>  Betulaceae   Betula      papyrifera       0.0147       2.52
 6 <chr [10]> Pinaceae     Picea       glauca           0.0302       2.09
 7 <chr [1]>  Pinaceae     Pseudotsuga menziesii        0.0404       2.14
 8 <chr [1]>  Pinaceae     Picea       engelmannii      0.0336       2.21
 9 <chr [1]>  Pinaceae     Abies       amabilis         0.0322       2.13
10 <chr [1]>  Salicaceae   Populus     trichocarpa      0.0086       2.73
11 <chr [1]>  Betulaceae   Alnus       rubra            0.0086       2.73
12 <chr [1]>  Pinaceae     Picea       sitchensis       0.0739       1.83
13 <chr [1]>  Pinaceae     Tsuga       heterophylla     0.0703       1.95
14 <chr [1]>  Cupressaceae Thuja       plicata          0.116        1.72}
\out{<hr>}
\code{bb = bbranches1 * dsob^bbranches2 * hst^bbranches3}
\itemize{
\item{\code{bb [kg]}}{ - branch biomass}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
\item{\code{hst [m]}}{ - total height of the stem}
}
\bold{Model Parameters}
\preformatted{   region     family       genus       species      bbranches1 bbranches2 bbranches3
 1 <chr [2]>  Pinaceae     Abies       lasiocarpa       0.0265       3.67     -1.60 
 2 <chr [10]> Pinaceae     Picea       mariana          0.0405       3.19     -1.37 
 3 <chr [2]>  Pinaceae     Pinus       contorta         0.0285       3.38     -1.44 
 4 <chr [10]> Salicaceae   Populus     tremuloides      0.015        2.91     -0.631
 5 <chr [8]>  Betulaceae   Betula      papyrifera       0.0253       3.15     -0.908
 6 <chr [10]> Pinaceae     Picea       glauca           0.0325       2.86     -0.913
 7 <chr [1]>  Pinaceae     Pseudotsuga menziesii        0.0351       2.24      0    
 8 <chr [1]>  Pinaceae     Picea       engelmannii      0.0428       2.80     -0.733
 9 <chr [1]>  Pinaceae     Abies       amabilis         0.042        2.03      0    
10 <chr [1]>  Salicaceae   Populus     trichocarpa      0.0131       2.58      0    
11 <chr [1]>  Betulaceae   Alnus       rubra            0.0131       2.58      0    
12 <chr [1]>  Pinaceae     Picea       sitchensis       0.0498       1.97      0    
13 <chr [1]>  Pinaceae     Tsuga       heterophylla     0.0609       2.00      0    
14 <chr [1]>  Cupressaceae Thuja       plicata          0.0611       1.92      0    }
\out{<hr>}
\code{bb = bbranches1 * dsob^bbranches2}
\itemize{
\item{\code{bb [kg]}}{ - branch biomass}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
}
\bold{Model Parameters}
\preformatted{  region     bbranches1 bbranches2 species_group
1 <chr [10]>     0.0186       2.45 hardwood     
2 <chr [10]>     0.0194       2.24 softwood     
3 <chr [10]>     0.0227       2.28 all          }
\out{<hr>}
\code{bb = bbranches1 * dsob^bbranches2 * hst^bbranches3}
\itemize{
\item{\code{bb [kg]}}{ - branch biomass}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
\item{\code{hst [m]}}{ - total height of the stem}
}
\bold{Model Parameters}
\preformatted{  region     bbranches1 bbranches2 bbranches3 species_group
1 <chr [10]>     0.0448       2.69     -0.591 hardwood     
2 <chr [10]>     0.0313       3.00     -1.04  softwood     
3 <chr [10]>     0.0338       2.66     -0.574 all          }
\out{<hr>}}
\section{Foliage Biomass Models}{\code{bf = bfoliage1 * dsob^bfoliage2}
\itemize{
\item{\code{bf [kg]}}{ - foliage biomass}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
}
\bold{Model Parameters}
\preformatted{   region     family       genus       species      bfoliage1 bfoliage2
 1 <chr [2]>  Pinaceae     Abies       lasiocarpa      0.0416      2.01
 2 <chr [10]> Pinaceae     Picea       mariana         0.163       1.42
 3 <chr [2]>  Pinaceae     Pinus       contorta        0.0584      1.64
 4 <chr [10]> Salicaceae   Populus     tremuloides     0.0235      1.67
 5 <chr [8]>  Betulaceae   Betula      papyrifera      0.0591      1.60
 6 <chr [10]> Pinaceae     Picea       glauca          0.152       1.50
 7 <chr [1]>  Pinaceae     Pseudotsuga menziesii       0.123       1.66
 8 <chr [1]>  Pinaceae     Picea       engelmannii     0.0683      1.80
 9 <chr [1]>  Pinaceae     Abies       amabilis        0.0645      1.94
10 <chr [1]>  Salicaceae   Populus     trichocarpa     0.0114      2.09
11 <chr [1]>  Betulaceae   Alnus       rubra           0.0114      2.09
12 <chr [1]>  Pinaceae     Picea       sitchensis      0.0157      2.31
13 <chr [1]>  Pinaceae     Tsuga       heterophylla    0.168       1.43
14 <chr [1]>  Cupressaceae Thuja       plicata         0.123       1.52}
\out{<hr>}
\code{bf = bfoliage1 * dsob^bfoliage2 * hst^bfoliage3}
\itemize{
\item{\code{bf [kg]}}{ - foliage biomass}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
\item{\code{hst [m]}}{ - total height of the stem}
}
\bold{Model Parameters}
\preformatted{   region     family       genus       species      bfoliage1 bfoliage2 bfoliage3
 1 <chr [2]>  Pinaceae     Abies       lasiocarpa      0.0509      2.99    -1.23 
 2 <chr [10]> Pinaceae     Picea       mariana         0.208       2.55    -1.35 
 3 <chr [2]>  Pinaceae     Pinus       contorta        0.0769      2.68    -1.25 
 4 <chr [10]> Salicaceae   Populus     tremuloides     0.0284      1.60     0    
 5 <chr [8]>  Betulaceae   Betula      papyrifera      0.136       2.30    -1.09 
 6 <chr [10]> Pinaceae     Picea       glauca          0.202       2.38    -1.11 
 7 <chr [1]>  Pinaceae     Pseudotsuga menziesii       0.0718      2.29    -0.474
 8 <chr [1]>  Pinaceae     Picea       engelmannii     0.0854      2.44    -0.763
 9 <chr [1]>  Pinaceae     Abies       amabilis        0.0453      2.49    -0.498
10 <chr [1]>  Salicaceae   Populus     trichocarpa     0.0224      1.84     0    
11 <chr [1]>  Betulaceae   Alnus       rubra           0.0224      1.84     0    
12 <chr [1]>  Pinaceae     Picea       sitchensis      0.014       3.13    -0.907
13 <chr [1]>  Pinaceae     Tsuga       heterophylla    0.266       2.01    -0.796
14 <chr [1]>  Cupressaceae Thuja       plicata         0.110       1.55     0    }
\out{<hr>}
\code{bf = bfoliage1 * dsob^bfoliage2}
\itemize{
\item{\code{bf [kg]}}{ - foliage biomass}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
}
\bold{Model Parameters}
\preformatted{  region     bfoliage1 bfoliage2 species_group
1 <chr [10]>    0.0385      1.63 hardwood     
2 <chr [10]>    0.0935      1.61 softwood     
3 <chr [10]>    0.0764      1.59 all          }
\out{<hr>}
\code{bf = bfoliage1 * dsob^bfoliage2 * hst^bfoliage3}
\itemize{
\item{\code{bf [kg]}}{ - foliage biomass}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
\item{\code{hst [m]}}{ - total height of the stem}
}
\bold{Model Parameters}
\preformatted{  region     bfoliage1 bfoliage2 bfoliage3 species_group
1 <chr [10]>    0.0869      1.85    -0.549 hardwood     
2 <chr [10]>    0.138       2.40    -1.04  softwood     
3 <chr [10]>    0.170       2.33    -1.13  all          }
\out{<hr>}}
