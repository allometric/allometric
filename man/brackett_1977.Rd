\name{brackett_1977}
\alias{brackett_1977}
\title{Brackett (1977)}
\description{Allometric models from Brackett (1977)}
\section{Stem Volume Models}{\code{vsa = 10^a * dsob^b * hst^c}
\itemize{
\item{\code{vsa [ft^3]}}{ - volume of the entire stem, including top and stump}
\item{\code{dsob [in]}}{ - diameter of the stem, outside bark at breast height}
\item{\code{hst [ft]}}{ - total height of the stem}
}
\bold{Model Parameters}
\preformatted{   family       genus       species      geographic_…¹ age_c…²     a     b     c
 1 Pinaceae     Pseudotsuga menziesii    coastal       < 140 … -2.66  1.74 1.13 
 2 Pinaceae     Pseudotsuga menziesii    coastal       >= 80 … -2.71  1.66 1.20 
 3 Pinaceae     Pseudotsuga menziesii    interior      <NA>    -2.73  1.74 1.17 
 4 Pinaceae     Tsuga       heterophylla coastal       < 140 … -2.70  1.84 1.12 
 5 Pinaceae     Tsuga       heterophylla coastal       >= 80 … -2.66  1.79 1.12 
 6 Pinaceae     Tsuga       heterophylla interior      <NA>    -2.57  1.97 0.977
 7 Cupressaceae Thuja       plicata      coastal       < 140 … -2.44  1.72 1.05 
 8 Cupressaceae Thuja       plicata      coastal       >= 80 … -2.38  1.68 1.04 
 9 Cupressaceae Thuja       plicata      interior      <NA>    -2.46  1.70 1.07 
10 Pinaceae     Abies       balsamea     coastal       <NA>    -2.58  1.81 1.09 
11 Pinaceae     Abies       balsamea     interior      <NA>    -2.50  1.86 1.00 
12 Pinaceae     Picea       stichensis   <NA>          < 140 … -2.55  1.84 1.04 
13 Pinaceae     Picea       stichensis   <NA>          >= 140… -2.70  1.75 1.16 
14 Pinaceae     Picea       stichensis   interior      <NA>    -2.54  1.84 1.03 
15 Pinaceae     Pinus       ponderosa    <NA>          <NA>    -2.73  1.91 1.09 
16 Pinaceae     Pinus       contorta     <NA>          <NA>    -2.62  1.85 1.09 
17 Pinaceae     Pinus       monticola    <NA>          <NA>    -2.48  1.87 0.994
18 Pinaceae     Larix       occidentalis <NA>          <NA>    -2.62  1.85 1.04 
19 Cupressaceae Cupressus   nootkatensis <NA>          <NA>    -2.45  1.74 1.06 
20 Betulaceae   Alnus       rubra        <NA>          <NA>    -2.67  1.92 1.07 
21 Aceraceae    Acer        <NA>         <NA>          <NA>    -2.77  1.89 1.12 
22 Salicaceae   Populus     tremuloides  <NA>          <NA>    -2.64  1.95 1.02 
23 Betulaceae   Betula      <NA>         <NA>          <NA>    -2.76  1.91 1.11 
24 Salicaceae   Populus     <NA>         <NA>          <NA>    -2.95  2    1.24 
# … with abbreviated variable names ¹​geographic_region, ²​age_class}
\out{<hr>}}
