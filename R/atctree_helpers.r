setGeneric("treelevs",  function(h,  ...){print(NULL)})
setGeneric("leaves",  function(h,  ...){print(NULL)})
setGeneric("nlevs",  function(h,  ...){print(NULL)})
setGeneric("intree",  function(h,  ...){print(NULL)})


#' @export
#' @title helper functions for atctrees
#' @description treelevs: return levels within tree (excluding 0)
#' @param h an object of class atctree
#' @rdname helpers
#' @aliases treelevs
#' @returns a vector of the level of each node
#' @examples
#' h <- atctree(schema="therapeutic")
#' # get the levels of the nodes in a tree:
#' cutting(h,"P01A") |> treelevs()
#' 
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


#' @export
#' @description leaves: return labels of terminal elements (leaves) of tree
#' @param h an object of class atctree
#' @rdname helpers
#' @aliases leaves
#' @returns vector of labels of the leaf nodes
#' @examples
#' h <- atctree(schema="full")
#' # get the leaf nodes for the tree:
#' cutting(h,"P01A") |> leaves()
#' 
setMethod("leaves", "atctree",
          function(h) {
            return(h@lab[h@lev==max(h@lev)])
          }
)

###########################


#' @export
#' @description nlevs: number of levels in tree (excluding 0)
#' @param h an object of class atctree
#' @rdname helpers
#' @aliases nlevs
#' @returns vector of number of levels in the tree
#' @examples
#' h <- atctree(schema="anatomical")
#' nlevs(h)
#' 
#' h2 <- atctree(whichlevs=c(1,2,5))
#' nlevs(h2)
setMethod("nlevs", "atctree",
          function(h)  length(unique(setdiff(h@lev,0)))
)

####################


#' @export
#' @description nlevs: number of levels in tree (excluding 0)
#' @param h an object of class atctree
#' @rdname helpers
#' @aliases nlevs
#' @returns vector of number of levels in the tree
#' @examples
#' h <- atctree(schema="chemical")
#' intree(h, "A01")
#' intree(h, "A01AA")

setMethod("intree", "atctree", 
          function(h,node) {
            ifelse (node %in% h@lab, TRUE, FALSE)
          }
)

