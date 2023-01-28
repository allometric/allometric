\name{temesgen_2008}
\alias{temesgen_2008}
\title{Temesgen et al. (2008)}
\description{Allometric models from Temesgen et al. (2008)}
\section{Stem Height Models}{\code{hst = 1.37 + b_0 * (1 - exp(b_1 * dsob)^b_2)}
\itemize{
\item{\code{hst [m]}}{ - total height of the stem}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
}
\bold{Model Parameters}
\preformatted{    b_0     b_1   b_2
1  52.0 -0.0208  1.02}
\out{<hr>}
\code{hst = 1.37 + (beta_0 + b_i) * (1 - exp(beta_1 * dsob)^beta_2)}
\itemize{
\item{\code{hst [m]}}{ - total height of the stem}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
}
\bold{Model Parameters}
\preformatted{  beta_0  beta_1 beta_2 sigma_sq_b sigma_sq_epsilon
1   40.4 -0.0276  0.936       6.54             2.69}
\out{<hr>}
\code{hst = 1.37 + (beta_0 + b_0_i) * (1 - exp(beta_1 * dsob)^(beta_2 + b_2_i))}
\itemize{
\item{\code{hst [m]}}{ - total height of the stem}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
}
\bold{Model Parameters}
\preformatted{  beta_0  beta_1 beta_2
1   41.8 -0.0241  0.860}
\out{<hr>}
\code{hst = 1.37 + (beta_00 + beta_01 * ccfl + beta_02 * gn) * (1 - exp(beta_1 * dsob)^beta_2)}
\itemize{
\item{\code{hst [m]}}{ - total height of the stem}
\item{\code{ccfl [m2 ha-1]}}{ - crown competition factor of large trees}
\item{\code{gn [m2 ha-1]}}{ - stand-level basal area}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
}
\bold{Model Parameters}
\preformatted{  beta_00 beta_01 beta_02  beta_1 beta_2
1    43.7  0.0644   0.128 -0.0194   1.08}
\out{<hr>}
\code{hst = 1.37 + (beta_00 + beta_01 * ccfl + beta_02 * gn + b_i) * (1 - exp(beta_1 * dsob)^beta_2)}
\itemize{
\item{\code{hst [m]}}{ - total height of the stem}
\item{\code{ccfl [m2 ha-1]}}{ - crown competition factor of large trees}
\item{\code{gn [m2 ha-1]}}{ - stand-level basal area}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
}
\bold{Model Parameters}
\preformatted{  beta_00 beta_01 beta_02 beta_1 beta_2
1    32.5  0.0363   0.258 -0.021  0.991}
\out{<hr>}
\code{hst = 1.37 + (beta_00 + beta_01 * ccfl + beta_02 * gn + b_0_i) * (1 - exp(beta_1 * dsob)^(beta_2 + b_2_i))}
\itemize{
\item{\code{hst [m]}}{ - total height of the stem}
\item{\code{ccfl [m2 ha-1]}}{ - crown competition factor of large trees}
\item{\code{gn [m2 ha-1]}}{ - stand-level basal area}
\item{\code{dsob [cm]}}{ - diameter of the stem, outside bark at breast height}
}
\bold{Model Parameters}
\preformatted{  beta_00 beta_01 beta_02  beta_1 beta_2
1    35.7  0.0431   0.245 -0.0184  0.961}
\out{<hr>}}
