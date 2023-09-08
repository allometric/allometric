#' FIA Trees Data
#'
#' A subset of data from FIA plots located in Oregon.
#'
#' @format ## `fia_trees`
#' A data frame with 298 rows and 5 columns.
#' \describe{
#'  \item{PLOT}{A plot ID}
#'  \item{SPCD}{The FIA species code for the tree}
#'  \item{DIA}{The diameter of the tree in inches}
#'  \item{HT}{The height of the tree in feet}
#'  \item{TPA_UNADJ}{The unadjusted trees per acre of the tree}
#' }
#' @source https://experience.arcgis.com/experience/3641cea45d614ab88791aef54f3a1849/
"fia_trees"

#' Brackett Acer Volume Model
#'
#' An example allometric model that predicts volume for the genus *Acer*.
#' 
"brackett_acer"

#' An object of class `FixedEffectsModel`
#'
#' Brackett Rubra Volume Model
#'
#' An example allometric model that predicts volume for *Alnus rubra*.
#' 
"brackett_rubra"