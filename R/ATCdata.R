#' nodes of the ATC hierarchy
#'
#' This contains nodes of the ATC hierarchy at all 5 levels (e.g. A, A01, A01A ...),
#' and associated descriptive text (eg. for A: ALIMENTARY TRACT AND METABOLISM), used here for visualisation.

#' @format A named character vector for each node, where each entry is an ATC code and the name is a textual description
#'
#' @source
#'
#' The data is from the repository at <https://github.com/fabkury/atcd> and this release is at <https://github.com/fabkury/atcd/releases/tag/april2026>.
#'
#' The first two columns from the .csv file were selected to produce the named character vector
"ATCdata"
