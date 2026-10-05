


# given a vector of levels, return the schema type if any
# levs is subset of integers 1:5
schema <- function(levs) {
  
  if (any(levs %in% 1:5)==FALSE) stop("levs needs to be a subset of 1:5")
  
  levs <- as.integer(levs)
  
  case_when(
    identical(levs, 1:5L) ~ "full",
    identical(levs, as.integer(c(1,5))) ~ "anatomical",
    identical(levs, as.integer(c(2,3,5))) ~ "therapeutic",
    identical(levs, as.integer(c(4,5))) ~"chemical",
    .default = "none")
}



########################################################################

#' @export
#' @title display drug name for ATC codes
#' @param x vector of ATC codes
#' @returns character vector of drug names
drugnames <- function(x) {
  sapply(x, function(codes) {names(grep(paste0("^",codes,"$"), ATCdata, value=T))})
}
