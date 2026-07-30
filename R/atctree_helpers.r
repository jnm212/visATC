setGeneric("treelevs",  function(h,  ...){print(NULL)})

#' @export
#' @title helper functions for atctrees
#' @description treelevs: return levels within tree (excluding 0)
#' @param h an object of class atctree
#' @rdname helpers
#' @aliases treelevs
#' @returns a vector of the level of each node
setMethod("treelevs", "atctree",
          function(h) {

            codelens <- c(1,3,4,5,7)
            lev <- sapply(h@lab, function(x) match(nchar(x), codelens))

            lev <- lev[-grep("^0$",names(lev))]
            # only want 'tree levels'; exclude root level 0

            return(lev)
          }
)

##########################

setGeneric("leaves",  function(h,  ...){print(NULL)})

#' @export
#' @description leaves: return labels of terminal elements (leaves) of tree
#' @param h an object of class atctree
#' @rdname helpers
#' @aliases leaves
#' @returns vector of labels of the leaf nodes
setMethod("leaves", "atctree",
          function(h) {
            return(h@lab[h@lev==max(h@lev)])
          }
)

###########################
setGeneric("nlevs",  function(h,  ...){print(NULL)})

#' @export
#' @description nlevs: number of levels in tree (excluding 0)
#' @param h an object of class atctree
#' @rdname helpers
#' @aliases nlevs
#' @returns vector of number of levels in the tree
setMethod("nlevs", "atctree",
          function(h)  length(unique(setdiff(h@lev,0)))
)
