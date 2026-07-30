
#' @export
#' @title constructor for atctree objects
#' @param schema a conceptual subset of the ATC hierarchy, or all of it ('full'), or something bespoke ('none')
#' @param whichlevs subset of levels to use from integers 1:5
#' @details
#' either schema or whichlevs should be specified; (e.g. `schema=full` corresponds to `whichlevs=1:5`)
#' @returns an object of class atctree
#' @examples
#' h <- atctree(schema="anatomical")
#' # tree will contain levels 1 and 5
#' h <- atctree(whichlevs=c(1,2,5))
#' # bespoke structure
#'
#'
atctree <-   function(
    whichlevs=NULL,
    schema=c("none", "full", "anatomical", "therapeutic", "chemical")) {

  schema <- match.arg(schema)

  if (schema=="none" && is.null(whichlevs)) stop("initialisation information needed")
  #if (!is.null(nodes_filt) && is.null(whichlevs)) stop("initialisation information needed")
  if (!is.null(whichlevs)) {
    if (schema(whichlevs) != schema) stop("whichlevs and schema do not correspond")
  }

    #############################
    ## priority 1 : use schema

    if (schema!="none") {

      if (schema=="full") whichlevs <- 1:5L
      if (schema=="anatomical") whichlevs <- as.integer(c(1,5))
      if (schema=="therapeutic") whichlevs <- as.integer(c(2,3,5))
      if (schema=="chemical") whichlevs <- as.integer(c(4,5))

      dataf <- make_ATC_df(whichlevs)

    } else {

      ###########################
      ## priority 2 : use whichlevs

      whichlevs <- as.integer(whichlevs)

      if (schema=="none") {

        if (any(whichlevs %in% 1:5)==FALSE) stop("levels must be subset of 1:5")

        dataf <- make_ATC_df(whichlevs)

      }
      ###########################
    }

#  whichlevs <- setdiff(unique(dataf$lev),0)
  whichlevs <- whichlevs[order(whichlevs)]

  .Object <- methods::new("atctree",
                 pnode = dataf$pnode,
                 node = dataf$node,
                 lab = dataf$ATC,
                 text = dataf$text,
                 plab = dataf$pATC,
                 lev = dataf$lev,
                 Nnode = length(dataf$node)-1,
                 # don't count the root node
                 whichlevs =whichlevs,
                 schema = schema(whichlevs)
  )
  .Object@Nlev <- nlevs(.Object)

  methods::validObject(.Object) #check validity
  return(.Object)
}
