#' @keywords internal
"_PACKAGE"

utils::globalVariables("ATCdata")

# to eliminate check NOTE
# see R packages 11.4.1.1
ignore_unused_imports <- function() {
  igraph::add.edges()
  tidyr::all_of()
  graphlayouts::annotate_circle()
  plotly::add_annotations()
}

#' @importFrom dplyr mutate
#' @importFrom dplyr filter
#' @importFrom dplyr bind_rows
#' @importFrom dplyr arrange
#' @importFrom dplyr rename
#' @importFrom dplyr select
#' @importFrom dplyr left_join
#' @importFrom dplyr inner_join
#' @importFrom dplyr if_else
#' @importFrom dplyr case_when
#' @importFrom methods show
#' @importFrom methods new
#' @importFrom utils data
#' @importFrom rlang .data
#' 
## usethis namespace: end
NULL
