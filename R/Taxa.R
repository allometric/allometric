.Taxa <- setClass(
  "Taxa",
  contains = c("list")
)

Taxa <- function(...) {
  taxa <- .Taxa(.Data = list(...))
  taxa
}