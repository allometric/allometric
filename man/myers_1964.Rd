\name{myers_1964}
\alias{myers_1964}
\title{Myers (1964)}
\description{Allometric models from Myers (1964)}
\section{Stem Volume Models}{\code{vsm = a + b * dsob^2 * hst}
\itemize{
\item{\code{vsm [ft3]}}{ - volume of the merchantable portion of the stem}
\item{\code{dsob [in]}}{ - diameter of the stem, outside bark at breast height}
\item{\code{hst [ft]}}{ - total height of the stem}
}
\bold{Model Parameters}
\preformatted{  d2h           a       b
1 <= 6000  0.0303 0.00221
2 > 6000  -1.56   0.00247}
\out{<hr>}
\code{vsm = a + b * dsob^2 * hst}
\itemize{
\item{\code{vsm [ft3]}}{ - volume of the merchantable portion of the stem}
\item{\code{dsob [in]}}{ - diameter of the stem, outside bark at breast height}
\item{\code{hst [ft]}}{ - total height of the stem}
}
\bold{Model Parameters}
\preformatted{  d2h         a       b
1 <= 6700 -1.03 0.00230
2 > 6700  -2.26 0.00241}
\out{<hr>}
\code{vsm = a + b * dsob^2 * hst}
\itemize{
\item{\code{vsm [board_foot]}}{ - volume of the merchantable portion of the stem}
\item{\code{dsob [in]}}{ - diameter of the stem, outside bark at breast height}
\item{\code{hst [ft]}}{ - total height of the stem}
}
\bold{Model Parameters}
\preformatted{  bdft_rule d2h          a      b
1 Scribner  <= 16000 -34.2 0.0123
2 Scribner  > 16000  -99.2 0.0163}
\out{<hr>}
\code{vsm = a + b * dsob^2 * hsm}
\itemize{
\item{\code{vsm [board_foot]}}{ - volume of the merchantable portion of the stem}
\item{\code{dsob [in]}}{ - diameter of the stem, outside bark at breast height}
\item{\code{hsm [ft]}}{ - Number of 16-foot logs to 8-inch top}
}
\bold{Model Parameters}
\preformatted{  bdft_rule d2h          a     b
1 Scribner  <= 1200   1.74 0.264
2 Scribner  > 1200  -56.2  0.313}
\out{<hr>}
\code{vsm = a + b * dsob^2 * hst}
\itemize{
\item{\code{vsm [board_foot]}}{ - volume of the merchantable portion of the stem}
\item{\code{dsob [in]}}{ - diameter of the stem, outside bark at breast height}
\item{\code{hst [ft]}}{ - total height of the stem}
}
\bold{Model Parameters}
\preformatted{  bdft_rule              d2h          a      b
1 International 1/4-inch <= 13000 -44.4 0.0150
2 International 1/4-inch > 13000  -68.8 0.0170}
\out{<hr>}
\code{vsm = a + b * dsob^2 * hsm}
\itemize{
\item{\code{vsm [board_foot]}}{ - volume of the merchantable portion of the stem}
\item{\code{dsob [in]}}{ - diameter of the stem, outside bark at breast height}
\item{\code{hsm [ft]}}{ - Number of 16-foot logs to 8-inch top}
}
\bold{Model Parameters}
\preformatted{  bdft_rule              d2h         a     b
1 International 1/4-inch <= 1100  2.34 0.313
2 International 1/4-inch > 1100  -5.94 0.319}
\out{<hr>}}
\section{Stem Ratio Models}{\code{rsvg = a * hst + b/dsob^2}
\itemize{
\item{\code{rsvg [ft3 ft-2]}}{ - volume to basal area ratio}
\item{\code{dsob [in]}}{ - diameter of the stem, outside bark at breast height}
\item{\code{hst [ft]}}{ - total height of the stem}
}
\bold{Model Parameters}
\preformatted{  tree_size     a     b
1 small     -189. 0.421
2 large     -414. 0.441}
\out{<hr>}
\code{rsvg = a * hst + b/dsob^2}
\itemize{
\item{\code{rsvg [board_foot ft-2]}}{ - volume to basal area ratio}
\item{\code{dsob [in]}}{ - diameter of the stem, outside bark at breast height}
\item{\code{hst [ft]}}{ - total height of the stem}
}
\bold{Model Parameters}
\preformatted{  bdft_rule tree_size     a       b
1 Scribner  small      2.61  -6265.
2 Scribner  large      2.99 -18191.}
\out{<hr>}
\code{rsvg = a * hsm + b/dsob^2}
\itemize{
\item{\code{rsvg [board_foot ft-2]}}{ - volume to basal area ratio}
\item{\code{dsob [in]}}{ - diameter of the stem, outside bark at breast height}
\item{\code{hsm [ft]}}{ - Number of 16-foot logs to 8-inch top}
}
\bold{Model Parameters}
\preformatted{  bdft_rule tree_size     a       b
1 Scribner  small      48.5    319.
2 Scribner  large      57.3 -10302.}
\out{<hr>}
\code{rsvg = a * hst + b/dsob^2}
\itemize{
\item{\code{rsvg [board_foot ft-2]}}{ - volume to basal area ratio}
\item{\code{dsob [in]}}{ - diameter of the stem, outside bark at breast height}
\item{\code{hst [ft]}}{ - total height of the stem}
}
\bold{Model Parameters}
\preformatted{  bdft_rule              tree_size     a       b
1 International 1/4-inch small      2.75  -8134.
2 International 1/4-inch large      3.12 -12605.}
\out{<hr>}
\code{rsvg = a * hsm + b/dsob^2}
\itemize{
\item{\code{rsvg [board_foot ft-2]}}{ - volume to basal area ratio}
\item{\code{dsob [in]}}{ - diameter of the stem, outside bark at breast height}
\item{\code{hsm [ft]}}{ - Number of 16-foot logs to 8-inch top}
}
\bold{Model Parameters}
\preformatted{  bdft_rule              tree_size     a      b
1 International 1/4-inch small      57.3   429.
2 International 1/4-inch large      58.4 -1089.}
\out{<hr>}}
