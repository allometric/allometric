\name{montero_2005}
\alias{montero_2005}
\title{Montero, Ruiz-Peinado, and Munoz (2005)}
\description{Allometric models from Montero, Ruiz-Peinado, and Munoz (2005)}
\section{Tree Biomass Models}{\code{bt = cf * exp(a) * dsob^b}
\itemize{
\item{\code{bt [kg]}}{ - tree biomass}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
}
\bold{Model Parameters}
\preformatted{# Groups:   family, genus, species, a, b [31]
   <chr>         <chr>    <chr>    <dbl> <dbl> <dbl> <list>
 1 Aquifoliaceae Ilex     canari~ -0.637  2.96  1.03 <chr> 
 2 Betulaceae    Alnus    glutin~ -0.825  2.90  1.05 <chr> 
 3 Betulaceae    Betula   NA      -1.61   2.27  1.01 <chr> 
 4 Cupressaceae  Juniper~ oxyced~ -0.520  2.29  1.05 <chr> 
 5 Cupressaceae  Juniper~ phoeni~ -0.606  2.69  1.00 <chr> 
 6 Cupressaceae  Juniper~ thurif~ -1.48   2.03  1.02 <chr> 
 7 Ericaceae     Erica    arborea -0.950  2.01  1.05 <chr> 
 8 Fabaceae      Ceraton~ siliqua -1.51   2.16  1.05 <chr> 
 9 Fagaceae      Castanea sativa  -1.71   2.22  1.03 <chr> 
10 Fagaceae      Fagus    sylvat~ -1.85   2.37  1.01 <chr> 
11 Fagaceae      Quercus  canari~ -1.41   2.11  1.06 <chr> 
12 Fagaceae      Quercus  faginea -2.89   2.52  1.01 <chr> 
13 Fagaceae      Quercus  ilex    -2.32   2.48  1.03 <chr> 
14 Fagaceae      Quercus  pyrena~ -2.60   2.53  1.03 <chr> 
15 Fagaceae      Quercus  robur   -2.31   2.50  1.02 <chr> 
16 Fagaceae      Quercus  suber   -3.37   2.61  1.09 <chr> 
17 Lauraceae     Laurus   azorica -1.93   2.49  1.02 <chr> 
18 Myricaceae    Myrica   faya    -1.18   2.18  1.02 <chr> 
19 Myrtaceae     Eucalyp~ NA      -1.33   2.19  1.01 <chr> 
20 Oleaceae      Fraxinus NA      -1.47   2.22  1.03 <chr> 
21 Oleaceae      Olea     europa~ -0.944  2.94  1.03 <chr> 
22 Pinaceae      Abies    pinsapo -2.53   2.31  1.02 <chr> 
23 Pinaceae      Pinus    canari~ -3.05   2.67  1.01 <chr> 
24 Pinaceae      Pinus    halepe~ -2.09   2.21  1.01 <chr> 
25 Pinaceae      Pinus    nigra   -2.78   2.52  1.01 <chr> 
26 Pinaceae      Pinus    pinast~ -3.00   2.50  1.02 <chr> 
27 Pinaceae      Pinus    pinea   -2.18   2.42  1.04 <chr> 
28 Pinaceae      Pinus    radiata -2.61   2.49  1.02 <chr> 
29 Pinaceae      Pinus    sylves~ -2.50   2.41  1.03 <chr> 
30 Pinaceae      Pinus    uncina~ -1.86   2.32  1.03 <chr> 
31 Salicaceae    Populus  eurame~ -2.94   2.57  1.00 <chr> }
\out{<hr>}
\code{bt = cf * exp(a) * dsob^b}
\itemize{
\item{\code{bt [kg]}}{ - tree biomass}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
}
\bold{Model Parameters}
\preformatted{  species_group     a     b    cf
1 conifers      -2.22  2.35  1.00
2 hardwoods     -1.88  2.30  1.00
3 subtropical   -1.36  2.26  1.00}
\out{<hr>}}
\section{Stem Biomass Models}{\code{bs = cf * exp(a) * dsob^b}
\itemize{
\item{\code{bs [kg]}}{ - stem biomass}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
}
\bold{Model Parameters}
\preformatted{# Groups:   family, genus, species, a, b [27]
   <chr>         <chr>    <chr>    <dbl> <dbl> <dbl> <list>
 1 Aquifoliaceae Ilex     canari~ -1.17   2.93  1.05 <chr> 
 2 Betulaceae    Alnus    glutin~ -1.38   2.98  1.09 <chr> 
 3 Betulaceae    Betula   NA      -2.09   2.33  1.01 <chr> 
 4 Cupressaceae  Juniper~ thurif~ -1.90   2.95  1.02 <chr> 
 5 Ericaceae     Erica    arborea -1.81   2.05  1.06 <chr> 
 6 Fabaceae      Ceraton~ siliqua -2.01   2.99  1.02 <chr> 
 7 Fagaceae      Castanea sativa  -2.43   2.15  1.03 <chr> 
 8 Fagaceae      Fagus    sylvat~ -1.64   2.21  1.03 <chr> 
 9 Fagaceae      Quercus  canari~ -0.820  2.73  1.05 <chr> 
10 Fagaceae      Quercus  faginea -2.89   2.29  1.02 <chr> 
11 Fagaceae      Quercus  ilex    -2.00   2.02  1.04 <chr> 
12 Fagaceae      Quercus  robur   -2.64   2.49  1.02 <chr> 
13 Fagaceae      Quercus  suber   -3.02   2.25  1.09 <chr> 
14 Lauraceae     Laurus   azorica -2.97   2.58  1.02 <chr> 
15 Myricaceae    Myrica   faya    -1.67   2.02  1.06 <chr> 
16 Oleaceae      Fraxinus NA      -1.42   2.95  1.06 <chr> 
17 Oleaceae      Olea     europa~ -1.04   2.61  1.05 <chr> 
18 Pinaceae      Abies    pinsapo -3.78   2.46  1.03 <chr> 
19 Pinaceae      Pinus    canari~ -3.05   2.59  1.01 <chr> 
20 Pinaceae      Pinus    halepe~ -2.52   2.14  1.03 <chr> 
21 Pinaceae      Pinus    nigra   -3.14   2.50  1.01 <chr> 
22 Pinaceae      Pinus    pinast~ -3.44   2.57  1.02 <chr> 
23 Pinaceae      Pinus    pinea   -3.36   2.52  1.02 <chr> 
24 Pinaceae      Pinus    radiata -3.03   2.56  1.02 <chr> 
25 Pinaceae      Pinus    sylves~ -3.81   2.71  1.04 <chr> 
26 Pinaceae      Pinus    uncina~ -3.45   2.71  1.04 <chr> 
27 Salicaceae    Populus  eurame~ -3.15   2.54  1.01 <chr> }
\out{<hr>}}
\section{Foliage Biomass Models}{\code{bf = cf * exp(a) * dsob^b}
\itemize{
\item{\code{bf [kg]}}{ - foliage biomass}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
}
\bold{Model Parameters}
\preformatted{# Groups:   family, genus, species, a, b [15]
   <chr>        <chr>      <chr>   <dbl> <dbl> <dbl> <list>
 1 Betulaceae   Alnus      glutin~ -3.01  2.45  1.14 <chr> 
 2 Betulaceae   Betula     NA      -3.28  2.59  1.08 <chr> 
 3 Cupressaceae Juniperus  thurif~ -2.49  2.68  1.05 <chr> 
 4 Fabaceae     Ceratonia  siliqua -2.19  2.63  1.06 <chr> 
 5 Fagaceae     Quercus    canari~ -4.57  2.67  1.18 <chr> 
 6 Fagaceae     Quercus    faginea -3.98  2.97  1.05 <chr> 
 7 Fagaceae     Quercus    ilex    -4.13  2.97  1.10 <chr> 
 8 Fagaceae     Quercus    robur   -3.70  2.73  1.04 <chr> 
 9 Fagaceae     Quercus    suber   -6.06  2.14  1.40 <chr> 
10 Myrtaceae    Eucalyptus NA      -2.06  2.62  1.06 <chr> 
11 Oleaceae     Olea       europa~ -3.53  2.53  1.07 <chr> 
12 Pinaceae     Pinus      pinea   -4.04  2.16  1.05 <chr> 
13 Pinaceae     Pinus      radiata -5.03  2.06  1.20 <chr> 
14 Pinaceae     Pinus      sylves~ -2.37  2.51  1.15 <chr> 
15 Salicaceae   Populus    eurame~ -3.37  2.60  1.12 <chr> }
\out{<hr>}}
\section{Root Biomass Models}{\code{br = cf * exp(a) * dsob^b}
\itemize{
\item{\code{br [kg]}}{ - root biomass}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
}
\bold{Model Parameters}
\preformatted{# Groups:   family, genus, species, a, b [25]
   <chr>        <chr>     <chr>    <dbl> <dbl> <dbl> <list>
 1 Betulaceae   Alnus     glutin~ -2.10   2.17  1.02 <chr> 
 2 Betulaceae   Betula    NA      -2.42   2.01  1.08 <chr> 
 3 Cupressaceae Juniperus oxyced~ -2.28   2.70  1.09 <chr> 
 4 Cupressaceae Juniperus phoeni~ -1.10   2.61  1.06 <chr> 
 5 Cupressaceae Juniperus thurif~ -1.68   2.74  1.05 <chr> 
 6 Fabaceae     Ceratonia siliqua -1.03   2.99  1.04 <chr> 
 7 Fagaceae     Castanea  sativa  -3.97   2.84  1.01 <chr> 
 8 Fagaceae     Fagus     sylvat~ -1.72   2.26  1.11 <chr> 
 9 Fagaceae     Quercus   canari~ -4.19   2.58  1.07 <chr> 
10 Fagaceae     Quercus   faginea -3.09   2.34  1.06 <chr> 
11 Fagaceae     Quercus   ilex    -0.730  2.79  1.13 <chr> 
12 Fagaceae     Quercus   pyrena~ -2.45   2.13  1.03 <chr> 
13 Fagaceae     Quercus   robur   -2.46   2.15  1.09 <chr> 
14 Fagaceae     Quercus   suber   -2.82   2.08  1.07 <chr> 
15 Oleaceae     Fraxinus  NA      -1.02   2.99  1.05 <chr> 
16 Oleaceae     Olea      europa~ -2.34   2.11  1.06 <chr> 
17 Pinaceae     Pinus     canari~ -4.62   2.73  1.05 <chr> 
18 Pinaceae     Pinus     halepe~ -3.68   2.30  1.13 <chr> 
19 Pinaceae     Pinus     nigra   -3.76   2.39  1.02 <chr> 
20 Pinaceae     Pinus     pinast~ -3.85   2.38  1.01 <chr> 
21 Pinaceae     Pinus     pinea   -4.02   2.47  1.02 <chr> 
22 Pinaceae     Pinus     radiata -2.78   2.14  1.05 <chr> 
23 Pinaceae     Pinus     sylves~ -4.56   2.63  1.04 <chr> 
24 Pinaceae     Pinus     uncina~ -4.51   2.76  1.04 <chr> 
25 Salicaceae   Populus   eurame~ -5.00   2.82  1.04 <chr> }
\out{<hr>}
\code{br = cf * exp(a) * dsob^b}
\itemize{
\item{\code{br [kg]}}{ - root biomass}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
}
\bold{Model Parameters}
\preformatted{  species_group     a     b    cf
1 conifers      -2.46  2.14  1.03
2 hardwoods     -1.38  1.97  1.00
3 subtropical   -1.38  2.06  1.00}
\out{<hr>}}
\section{Branch Biomass Models}{\code{bb = cf * exp(a) * dsob^b}
\itemize{
\item{\code{bb [kg]}}{ - branch biomass}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
}
\bold{Model Parameters}
\preformatted{# Groups:   family, genus, species, branch_size, a, b [56]
   <chr>   <chr> <chr>   <chr>     <dbl> <dbl> <dbl> <list>
 1 Aquifo~ Ilex  canari~ < 2 cm   -1.46   2.76  1.05 <chr> 
 2 Aquifo~ Ilex  canari~ > 7 cm   -2.54   2.75  1.01 <chr> 
 3 Betula~ Alnus glutin~ < 2 cm   -2.40   2.45  1.14 <chr> 
 4 Betula~ Alnus glutin~ > 7 cm   -7.22   2.74  1.24 <chr> 
 5 Betula~ Betu~ NA      < 2 cm   -2.66   2.65  1.07 <chr> 
 6 Betula~ Betu~ NA      > 7 cm   -7.84   2.25  1.26 <chr> 
 7 Cupres~ Juni~ thurif~ < 2 cm   -2.41   2.68  1.05 <chr> 
 8 Cupres~ Juni~ thurif~ > 7 cm  -13.5    2.60  1.11 <chr> 
 9 Ericac~ Erica arborea < 2 cm   -1.22   2.62  1.08 <chr> 
10 Ericac~ Erica arborea > 7 cm   -6.92   2.39  1.36 <chr> 
11 Fabace~ Cera~ siliqua < 2 cm   -1.82   2.63  1.07 <chr> 
12 Fabace~ Cera~ siliqua > 7 cm   -4.99   2.82  1.22 <chr> 
13 Fagace~ Cast~ sativa  < 2 cm   -1.55   2.69  1.05 <chr> 
14 Fagace~ Cast~ sativa  > 7 cm   -7.81   2.49  1.11 <chr> 
15 Fagace~ Fagus sylvat~ < 2 cm   -2.57   2.84  1.09 <chr> 
16 Fagace~ Fagus sylvat~ > 7 cm  -10.8    2.09  1.22 <chr> 
17 Fagace~ Quer~ canari~ < 2 cm   -3.21   2.67  1.18 <chr> 
18 Fagace~ Quer~ canari~ > 7 cm   -3.79   2.43  1.43 <chr> 
19 Fagace~ Quer~ faginea < 2 cm   -3.45   2.97  1.05 <chr> 
20 Fagace~ Quer~ faginea > 7 cm  -14.0    2.21  1.56 <chr> 
21 Fagace~ Quer~ ilex    < 2 cm   -2.66   2.97  1.10 <chr> 
22 Fagace~ Quer~ ilex    > 7 cm   -5.35   2.04  1.16 <chr> 
23 Fagace~ Quer~ pyrena~ < 2 cm   -4.85   2.39  1.17 <chr> 
24 Fagace~ Quer~ robur   < 2 cm   -2.47   2.62  1.06 <chr> 
25 Fagace~ Quer~ robur   > 7 cm  -13.2    2.84  1.33 <chr> 
26 Fagace~ Quer~ suber   < 2 cm   -5.34   2.10  1.33 <chr> 
27 Fagace~ Quer~ suber   > 7 cm   -6.43   2.21  1.18 <chr> 
28 Laurac~ Laur~ azorica < 2 cm   -2.25   2.09  1.07 <chr> 
29 Laurac~ Laur~ azorica > 7 cm   -3.98   2.54  1.33 <chr> 
30 Myrica~ Myri~ faya    < 2 cm   -1.67   2.89  1.04 <chr> 
31 Myrica~ Myri~ faya    > 7 cm   -6.67   2.49  1.07 <chr> 
32 Myrtac~ Euca~ NA      < 2 cm   -2.65   2.61  1.06 <chr> 
33 Oleace~ Frax~ NA      < 2 cm   -1.69   2.73  1.13 <chr> 
34 Oleace~ Frax~ NA      > 7 cm   -5.41   2.84  1.26 <chr> 
35 Oleace~ Olea  europa~ < 2 cm   -1.56   2.53  1.07 <chr> 
36 Oleace~ Olea  europa~ > 7 cm   -4.65   2.69  1.20 <chr> 
37 Pinace~ Abies pinsapo < 2 cm   -0.860  2.37  1.17 <chr> 
38 Pinace~ Abies pinsapo > 7 cm  -16.3    2.40  1.11 <chr> 
39 Pinace~ Pinus canari~ < 2 cm   -5.07   2.60  1.17 <chr> 
40 Pinace~ Pinus canari~ > 7 cm  -11.6    2.28  1.38 <chr> 
41 Pinace~ Pinus halepe~ < 2 cm   -2.74   2.04  1.03 <chr> 
42 Pinace~ Pinus halepe~ > 7 cm   -9.55   2.61  1.53 <chr> 
43 Pinace~ Pinus nigra   < 2 cm   -2.84   2.05  1.02 <chr> 
44 Pinace~ Pinus nigra   > 7 cm  -13.8    2.63  1.58 <chr> 
45 Pinace~ Pinus pinast~ < 2 cm   -4.67   2.38  1.15 <chr> 
46 Pinace~ Pinus pinast~ > 7 cm  -23.0    2.52  1.05 <chr> 
47 Pinace~ Pinus pinea   < 2 cm   -2.55   2.94  1.12 <chr> 
48 Pinace~ Pinus pinea   > 7 cm   -4.34   2.60  1.16 <chr> 
49 Pinace~ Pinus radiata < 2 cm   -3.54   2.76  1.21 <chr> 
50 Pinace~ Pinus radiata > 7 cm  -10.6    2.65  1.15 <chr> 
51 Pinace~ Pinus sylves~ < 2 cm   -2.08   2.51  1.15 <chr> 
52 Pinace~ Pinus sylves~ > 7 cm  -15.0    2.80  1.27 <chr> 
53 Pinace~ Pinus uncina~ < 2 cm   -2.63   2.79  1.12 <chr> 
54 Pinace~ Pinus uncina~ > 7 cm   -4.66   2.96  1.23 <chr> 
55 Salica~ Popu~ eurame~ < 2 cm   -2.42   2.61  1.12 <chr> 
56 Salica~ Popu~ eurame~ > 7 cm  -12.1    2.35  1.18 <chr> 
# ... with abbreviated variable name 1: branch_size}
\out{<hr>}}
