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
\preformatted{   family        genus      species           a     b    cf region   
 1 Aquifoliaceae Ilex       canariensis  -0.637  2.96  1.03 <chr [1]>
 2 Betulaceae    Alnus      glutinosa    -0.825  2.90  1.05 <chr [1]>
 3 Betulaceae    Betula     NA           -1.61   2.27  1.01 <chr [1]>
 4 Cupressaceae  Juniperus  oxycedrus    -0.520  2.29  1.05 <chr [1]>
 5 Cupressaceae  Juniperus  phoenicea    -0.606  2.69  1.00 <chr [1]>
 6 Cupressaceae  Juniperus  thurifera    -1.48   2.03  1.02 <chr [1]>
 7 Ericaceae     Erica      arborea      -0.950  2.01  1.05 <chr [1]>
 8 Fabaceae      Ceratonia  siliqua      -1.51   2.16  1.05 <chr [1]>
 9 Fagaceae      Castanea   sativa       -1.71   2.22  1.03 <chr [2]>
10 Fagaceae      Fagus      sylvatica    -1.85   2.37  1.01 <chr [2]>
11 Fagaceae      Quercus    canariensis  -1.41   2.11  1.06 <chr [1]>
12 Fagaceae      Quercus    faginea      -2.89   2.52  1.01 <chr [1]>
13 Fagaceae      Quercus    ilex         -2.32   2.48  1.03 <chr [3]>
14 Fagaceae      Quercus    pyrenaica    -2.60   2.53  1.03 <chr [4]>
15 Fagaceae      Quercus    robur        -2.31   2.50  1.02 <chr [1]>
16 Fagaceae      Quercus    suber        -3.37   2.61  1.09 <chr [1]>
17 Lauraceae     Laurus     azorica      -1.93   2.49  1.02 <chr [1]>
18 Myricaceae    Myrica     faya         -1.18   2.18  1.02 <chr [1]>
19 Myrtaceae     Eucalyptus NA           -1.33   2.19  1.01 <chr [1]>
20 Oleaceae      Fraxinus   NA           -1.47   2.22  1.03 <chr [2]>
21 Oleaceae      Olea       europaea     -0.944  2.94  1.03 <chr [1]>
22 Pinaceae      Abies      pinsapo      -2.53   2.31  1.02 <chr [1]>
23 Pinaceae      Pinus      canariensis  -3.05   2.67  1.01 <chr [1]>
24 Pinaceae      Pinus      halepensis   -2.09   2.21  1.01 <chr [1]>
25 Pinaceae      Pinus      nigra        -2.78   2.52  1.01 <chr [1]>
26 Pinaceae      Pinus      pinaster     -3.00   2.50  1.02 <chr [2]>
27 Pinaceae      Pinus      pinea        -2.18   2.42  1.04 <chr [2]>
28 Pinaceae      Pinus      radiata      -2.61   2.49  1.02 <chr [1]>
29 Pinaceae      Pinus      sylvestris   -2.50   2.41  1.03 <chr [2]>
30 Pinaceae      Pinus      uncinata     -1.86   2.32  1.03 <chr [1]>
31 Salicaceae    Populus    euramericana -2.94   2.57  1.00 <chr [3]>}
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
\preformatted{   family        genus     species           a     b    cf region   
 1 Aquifoliaceae Ilex      canariensis  -1.17   2.93  1.05 <chr [1]>
 2 Betulaceae    Alnus     glutinosa    -1.38   2.98  1.09 <chr [1]>
 3 Betulaceae    Betula    NA           -2.09   2.33  1.01 <chr [1]>
 4 Cupressaceae  Juniperus thurifera    -1.90   2.95  1.02 <chr [1]>
 5 Ericaceae     Erica     arborea      -1.81   2.05  1.06 <chr [1]>
 6 Fabaceae      Ceratonia siliqua      -2.01   2.99  1.02 <chr [1]>
 7 Fagaceae      Castanea  sativa       -2.43   2.15  1.03 <chr [2]>
 8 Fagaceae      Fagus     sylvatica    -1.64   2.21  1.03 <chr [2]>
 9 Fagaceae      Quercus   canariensis  -0.820  2.73  1.05 <chr [1]>
10 Fagaceae      Quercus   faginea      -2.89   2.29  1.02 <chr [1]>
11 Fagaceae      Quercus   ilex         -2.00   2.02  1.04 <chr [3]>
12 Fagaceae      Quercus   robur        -2.64   2.49  1.02 <chr [1]>
13 Fagaceae      Quercus   suber        -3.02   2.25  1.09 <chr [1]>
14 Lauraceae     Laurus    azorica      -2.97   2.58  1.02 <chr [1]>
15 Myricaceae    Myrica    faya         -1.67   2.02  1.06 <chr [1]>
16 Oleaceae      Fraxinus  NA           -1.42   2.95  1.06 <chr [2]>
17 Oleaceae      Olea      europaea     -1.04   2.61  1.05 <chr [1]>
18 Pinaceae      Abies     pinsapo      -3.78   2.46  1.03 <chr [1]>
19 Pinaceae      Pinus     canariensis  -3.05   2.59  1.01 <chr [1]>
20 Pinaceae      Pinus     halepensis   -2.52   2.14  1.03 <chr [1]>
21 Pinaceae      Pinus     nigra        -3.14   2.50  1.01 <chr [1]>
22 Pinaceae      Pinus     pinaster     -3.44   2.57  1.02 <chr [2]>
23 Pinaceae      Pinus     pinea        -3.36   2.52  1.02 <chr [2]>
24 Pinaceae      Pinus     radiata      -3.03   2.56  1.02 <chr [1]>
25 Pinaceae      Pinus     sylvestris   -3.81   2.71  1.04 <chr [2]>
26 Pinaceae      Pinus     uncinata     -3.45   2.71  1.04 <chr [1]>
27 Salicaceae    Populus   euramericana -3.15   2.54  1.01 <chr [3]>}
\out{<hr>}}
\section{Foliage Biomass Models}{\code{bf = cf * exp(a) * dsob^b}
\itemize{
\item{\code{bf [kg]}}{ - foliage biomass}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
}
\bold{Model Parameters}
\preformatted{   family       genus      species          a     b    cf region   
 1 Betulaceae   Alnus      glutinosa    -3.01  2.45  1.14 <chr [1]>
 2 Betulaceae   Betula     NA           -3.28  2.59  1.08 <chr [1]>
 3 Cupressaceae Juniperus  thurifera    -2.49  2.68  1.05 <chr [1]>
 4 Fabaceae     Ceratonia  siliqua      -2.19  2.63  1.06 <chr [1]>
 5 Fagaceae     Quercus    canariensis  -4.57  2.67  1.18 <chr [1]>
 6 Fagaceae     Quercus    faginea      -3.98  2.97  1.05 <chr [1]>
 7 Fagaceae     Quercus    ilex         -4.13  2.97  1.10 <chr [3]>
 8 Fagaceae     Quercus    robur        -3.70  2.73  1.04 <chr [1]>
 9 Fagaceae     Quercus    suber        -6.06  2.14  1.40 <chr [1]>
10 Myrtaceae    Eucalyptus NA           -2.06  2.62  1.06 <chr [1]>
11 Oleaceae     Olea       europaea     -3.53  2.53  1.07 <chr [1]>
12 Pinaceae     Pinus      pinea        -4.04  2.16  1.05 <chr [2]>
13 Pinaceae     Pinus      radiata      -5.03  2.06  1.20 <chr [1]>
14 Pinaceae     Pinus      sylvestris   -2.37  2.51  1.15 <chr [2]>
15 Salicaceae   Populus    euramericana -3.37  2.60  1.12 <chr [3]>}
\out{<hr>}}
\section{Root Biomass Models}{\code{br = cf * exp(a) * dsob^b}
\itemize{
\item{\code{br [kg]}}{ - root biomass}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
}
\bold{Model Parameters}
\preformatted{   family       genus     species           a     b    cf region   
 1 Betulaceae   Alnus     glutinosa    -2.10   2.17  1.02 <chr [1]>
 2 Betulaceae   Betula    NA           -2.42   2.01  1.08 <chr [1]>
 3 Cupressaceae Juniperus oxycedrus    -2.28   2.70  1.09 <chr [1]>
 4 Cupressaceae Juniperus phoenicea    -1.10   2.61  1.06 <chr [1]>
 5 Cupressaceae Juniperus thurifera    -1.68   2.74  1.05 <chr [1]>
 6 Fabaceae     Ceratonia siliqua      -1.03   2.99  1.04 <chr [1]>
 7 Fagaceae     Castanea  sativa       -3.97   2.84  1.01 <chr [2]>
 8 Fagaceae     Fagus     sylvatica    -1.72   2.26  1.11 <chr [2]>
 9 Fagaceae     Quercus   canariensis  -4.19   2.58  1.07 <chr [1]>
10 Fagaceae     Quercus   faginea      -3.09   2.34  1.06 <chr [1]>
11 Fagaceae     Quercus   ilex         -0.730  2.79  1.13 <chr [3]>
12 Fagaceae     Quercus   pyrenaica    -2.45   2.13  1.03 <chr [4]>
13 Fagaceae     Quercus   robur        -2.46   2.15  1.09 <chr [1]>
14 Fagaceae     Quercus   suber        -2.82   2.08  1.07 <chr [1]>
15 Oleaceae     Fraxinus  NA           -1.02   2.99  1.05 <chr [2]>
16 Oleaceae     Olea      europaea     -2.34   2.11  1.06 <chr [1]>
17 Pinaceae     Pinus     canariensis  -4.62   2.73  1.05 <chr [1]>
18 Pinaceae     Pinus     halepensis   -3.68   2.30  1.13 <chr [1]>
19 Pinaceae     Pinus     nigra        -3.76   2.39  1.02 <chr [1]>
20 Pinaceae     Pinus     pinaster     -3.85   2.38  1.01 <chr [2]>
21 Pinaceae     Pinus     pinea        -4.02   2.47  1.02 <chr [2]>
22 Pinaceae     Pinus     radiata      -2.78   2.14  1.05 <chr [1]>
23 Pinaceae     Pinus     sylvestris   -4.56   2.63  1.04 <chr [2]>
24 Pinaceae     Pinus     uncinata     -4.51   2.76  1.04 <chr [1]>
25 Salicaceae   Populus   euramericana -5.00   2.82  1.04 <chr [3]>}
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
\preformatted{   family        genus      species      branch_size       a     b    cf region   
 1 Aquifoliaceae Ilex       canariensis  < 2 cm       -1.46   2.76  1.05 <chr [1]>
 2 Aquifoliaceae Ilex       canariensis  > 7 cm       -2.54   2.75  1.01 <chr [1]>
 3 Betulaceae    Alnus      glutinosa    < 2 cm       -2.40   2.45  1.14 <chr [1]>
 4 Betulaceae    Alnus      glutinosa    > 7 cm       -7.22   2.74  1.24 <chr [1]>
 5 Betulaceae    Betula     NA           < 2 cm       -2.66   2.65  1.07 <chr [1]>
 6 Betulaceae    Betula     NA           > 7 cm       -7.84   2.25  1.26 <chr [1]>
 7 Cupressaceae  Juniperus  thurifera    < 2 cm       -2.41   2.68  1.05 <chr [1]>
 8 Cupressaceae  Juniperus  thurifera    > 7 cm      -13.5    2.60  1.11 <chr [1]>
 9 Ericaceae     Erica      arborea      < 2 cm       -1.22   2.62  1.08 <chr [1]>
10 Ericaceae     Erica      arborea      > 7 cm       -6.92   2.39  1.36 <chr [1]>
11 Fabaceae      Ceratonia  siliqua      < 2 cm       -1.82   2.63  1.07 <chr [1]>
12 Fabaceae      Ceratonia  siliqua      > 7 cm       -4.99   2.82  1.22 <chr [1]>
13 Fagaceae      Castanea   sativa       < 2 cm       -1.55   2.69  1.05 <chr [2]>
14 Fagaceae      Castanea   sativa       > 7 cm       -7.81   2.49  1.11 <chr [2]>
15 Fagaceae      Fagus      sylvatica    < 2 cm       -2.57   2.84  1.09 <chr [2]>
16 Fagaceae      Fagus      sylvatica    > 7 cm      -10.8    2.09  1.22 <chr [2]>
17 Fagaceae      Quercus    canariensis  < 2 cm       -3.21   2.67  1.18 <chr [1]>
18 Fagaceae      Quercus    canariensis  > 7 cm       -3.79   2.43  1.43 <chr [1]>
19 Fagaceae      Quercus    faginea      < 2 cm       -3.45   2.97  1.05 <chr [1]>
20 Fagaceae      Quercus    faginea      > 7 cm      -14.0    2.21  1.56 <chr [1]>
21 Fagaceae      Quercus    ilex         < 2 cm       -2.66   2.97  1.10 <chr [3]>
22 Fagaceae      Quercus    ilex         > 7 cm       -5.35   2.04  1.16 <chr [3]>
23 Fagaceae      Quercus    pyrenaica    < 2 cm       -4.85   2.39  1.17 <chr [4]>
24 Fagaceae      Quercus    robur        < 2 cm       -2.47   2.62  1.06 <chr [1]>
25 Fagaceae      Quercus    robur        > 7 cm      -13.2    2.84  1.33 <chr [1]>
26 Fagaceae      Quercus    suber        < 2 cm       -5.34   2.10  1.33 <chr [1]>
27 Fagaceae      Quercus    suber        > 7 cm       -6.43   2.21  1.18 <chr [1]>
28 Lauraceae     Laurus     azorica      < 2 cm       -2.25   2.09  1.07 <chr [1]>
29 Lauraceae     Laurus     azorica      > 7 cm       -3.98   2.54  1.33 <chr [1]>
30 Myricaceae    Myrica     faya         < 2 cm       -1.67   2.89  1.04 <chr [1]>
31 Myricaceae    Myrica     faya         > 7 cm       -6.67   2.49  1.07 <chr [1]>
32 Myrtaceae     Eucalyptus NA           < 2 cm       -2.65   2.61  1.06 <chr [1]>
33 Oleaceae      Fraxinus   NA           < 2 cm       -1.69   2.73  1.13 <chr [2]>
34 Oleaceae      Fraxinus   NA           > 7 cm       -5.41   2.84  1.26 <chr [2]>
35 Oleaceae      Olea       europaea     < 2 cm       -1.56   2.53  1.07 <chr [1]>
36 Oleaceae      Olea       europaea     > 7 cm       -4.65   2.69  1.20 <chr [1]>
37 Pinaceae      Abies      pinsapo      < 2 cm       -0.860  2.37  1.17 <chr [1]>
38 Pinaceae      Abies      pinsapo      > 7 cm      -16.3    2.40  1.11 <chr [1]>
39 Pinaceae      Pinus      canariensis  < 2 cm       -5.07   2.60  1.17 <chr [1]>
40 Pinaceae      Pinus      canariensis  > 7 cm      -11.6    2.28  1.38 <chr [1]>
41 Pinaceae      Pinus      halepensis   < 2 cm       -2.74   2.04  1.03 <chr [1]>
42 Pinaceae      Pinus      halepensis   > 7 cm       -9.55   2.61  1.53 <chr [1]>
43 Pinaceae      Pinus      nigra        < 2 cm       -2.84   2.05  1.02 <chr [1]>
44 Pinaceae      Pinus      nigra        > 7 cm      -13.8    2.63  1.58 <chr [1]>
45 Pinaceae      Pinus      pinaster     < 2 cm       -4.67   2.38  1.15 <chr [2]>
46 Pinaceae      Pinus      pinaster     > 7 cm      -23.0    2.52  1.05 <chr [2]>
47 Pinaceae      Pinus      pinea        < 2 cm       -2.55   2.94  1.12 <chr [2]>
48 Pinaceae      Pinus      pinea        > 7 cm       -4.34   2.60  1.16 <chr [2]>
49 Pinaceae      Pinus      radiata      < 2 cm       -3.54   2.76  1.21 <chr [1]>
50 Pinaceae      Pinus      radiata      > 7 cm      -10.6    2.65  1.15 <chr [1]>
51 Pinaceae      Pinus      sylvestris   < 2 cm       -2.08   2.51  1.15 <chr [2]>
52 Pinaceae      Pinus      sylvestris   > 7 cm      -15.0    2.80  1.27 <chr [2]>
53 Pinaceae      Pinus      uncinata     < 2 cm       -2.63   2.79  1.12 <chr [1]>
54 Pinaceae      Pinus      uncinata     > 7 cm       -4.66   2.96  1.23 <chr [1]>
55 Salicaceae    Populus    euramericana < 2 cm       -2.42   2.61  1.12 <chr [3]>
56 Salicaceae    Populus    euramericana > 7 cm      -12.1    2.35  1.18 <chr [3]>}
\out{<hr>}}
