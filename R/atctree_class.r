
###############################################################################################

#' @export
#' @title class to represent a tree from the ATC  hierarchy
#' @slot node node id
#' @slot pnode parent node id
#' @slot lab ATC code
#' @slot plab parent ATC code
#' @slot text ATC textual info
#' @slot lev level of each node (root node is 0)
#' @slot schema one of 'none', 'full', 'anatomical', 'therapeutic', 'chemical'
#' @slot whichlevs subset of integers 1:5; should correspond to schema
#' @slot Nnode number of nodes in the tree excluding root node
#' @slot Nlev number of levels in the tree excluding root node
setClass("atctree",
         representation( node="numeric",
                         pnode="numeric",
                         lab="character",
                         text="character",
                         plab="character",
                         lev="numeric",
                         whichlevs="numeric",
                         schema="character",
                         Nnode="numeric",
                         Nlev="numeric"
         )
)

###############################################################################################

setValidity("atctree",
            function(object) {

              if (!all(object@whichlevs %in% 1:5)) {
                message("Specified levels should be in 1:5")
                return(FALSE)
              }

              #             if (!5 %in% object@whichlevs) {
              #                message("Specified levels need to include 5")
              #               return(FALSE)
              #            }

              return(TRUE)
            }
)

###########################################################


setOldClass("plot")

#############################################################
## use plotly
## main benefit is hovering!

#' @export
#' @title plot the tree as a network graph
#' @param x an object of class atctree
#' @param circle whether or not to arrange graph over a circle (default = FALSE)
#' @param ATC_text whether or not to label with ATC textual info (default=FALSE)
#' @param leaf_label whether or not leaf nodes will be labelled (default=TRUE)
#' @param stem_label whether or not stem nodes will be labelled (default=TRUE)
#' @param text_size annotation text size (default=10)
#' @param text_angle annotation text angle (default=45)
#' @param width graph width
#' @param height graph height
#' @details
#' Each node is labelled with its ATC code, and by hovering the cursor over any node the ATC desciption is displayed.
#' The ATC tree can be displayed as a network in layers or on a circle (with radii corresponding to ATC level).
#' It is evident that a plot the full ATC tree is too cluttered.
#' Some subsetting (link), pruning (link) or cutting (link) of the tree is likely to help visualisation.
#' @aliases plot
#' @examples
#' # create an ATC tree and plot the whole thing:
#' h <- atctree(schema="full")
#' # you could plot this with plot(h) but it takes a while 
#' # large network so not easy to read
#'
#' # take cutting above node B ; plot all its descendants:
#' plot(cutting(h,"B"))
#'
#' # plot siblings of node A03
#' plot(h["A03",0])
#'
#' # plot node B down to its grandchildren:
#' plot(h["B",-2])
#' # or use a circular layout
#' plot(h["B",-2], circle=TRUE, stem_label=T)
#'
setMethod("plot",
          signature=c("atctree"),

          function(x, circle=NULL, ATC_text=NULL,
                   leaf_label=NULL, stem_label=NULL,
                   text_size=10, text_angle=45,
                   width=500, height=500) {

            message("Remember you can hover over nodes to see text")

            # define defaults if function arguments not specified:
            if (x@schema %in% c("therapeutic","anatomical")) {
              circle <- ifelse(is.null(circle), FALSE, circle)
              ATC_text <- ifelse(is.null(ATC_text), TRUE, ATC_text)
              stem_label <- ifelse(is.null(stem_label), TRUE, stem_label)
              leaf_label <- ifelse(is.null(leaf_label), FALSE, leaf_label)
            }
            if (x@schema %in% "none") {
              circle <- ifelse(is.null(circle), FALSE, circle)
              ATC_text <- ifelse(is.null(ATC_text), FALSE, ATC_text)
              leaf_label <- ifelse(is.null(leaf_label), TRUE, leaf_label)
              stem_label <- ifelse(is.null(stem_label), TRUE, stem_label)
            }
            if (x@schema %in% c("full","chemical")) {
              circle <- ifelse(is.null(circle), FALSE, circle)
              ATC_text <- ifelse(is.null(ATC_text), FALSE, ATC_text)
              leaf_label <- ifelse(is.null(leaf_label), FALSE, leaf_label)
              stem_label <- ifelse(is.null(stem_label), FALSE, stem_label)
            }

            if (ATC_text==FALSE) {
              labvec <- x@lab
            } else {
              labvec <- x@text
            }

            if (leaf_label==FALSE) {
              labvec[x@lev==max(unique(x@lev))] <- ""
            }
            if (stem_label==FALSE) {
              labvec[x@lev!=max(unique(x@lev))] <- ""
            }

            nV <- length(x@node) #, na.rm=TRUE) #number of vertices
            #        V <- 1:nV #vertices

            A <- matrix(0,nrow=nV, ncol=nV)
            for (ii in 1:nV) {
              A[ii, which(x@node==x@pnode[ii])] <- 1
            }
            #create adjacency matrix

            G <- igraph::graph.adjacency(A)

            if (circle) {
              #            L <- igraph::layout_as_tree(G,circular=TRUE)
              L <- graphlayouts::layout_with_centrality(G, cent=5-x@lev)
              Xn <- L[,1]
              Yn <- L[,2]

            } else {
              L <- igraph::layout_with_sugiyama(G, layers=x@lev)
              Xn <- L$layout[,1]
              Yn <- L$layout[,2]
            }

            es <- as.data.frame(igraph::get.edgelist(G))

            if (nrow(es)==0) stop("Nothing to plot")

            edge_shapes <- list()
            for(i in 1:nrow(es)) {
              v0 <- es[i,]$V1
              v1 <- es[i,]$V2

              edge_shape = list(
                type = "line",
                opacity=0.25,
                line = list(color = "#030303", width = 0.3),
                x0 = Xn[v0],
                y0 = Yn[v0],
                x1 = Xn[v1],
                y1 = Yn[v1]
              )

              edge_shapes[[i]] <- edge_shape
            }


            network <- plotly::plot_ly(x = ~Xn, y = ~Yn,
                                       width = width,
                                       height = height,
                                       type="scatter",
                                       mode = "markers+text",
                                       hovertext = paste(x@lab,x@text,sep=":"),
                                       hoverinfo = "text"
            )

            axis <- list(title = "", showgrid = FALSE, showticklabels = FALSE, zeroline = FALSE)



            fig <- plotly::layout(
              autosize = F,
              network,
              shapes = edge_shapes,
              xaxis=axis,
              yaxis=axis,
              margin=list(
                l = 0,
                r = 0,
                b = 0,
                t = 0
              )
              #font=list(size=text_size)
              ) |>

              #        plotly::add_text(text=x@lab,
              #                 textfont = list(size = 8, textposition=2)
              #                 ) |>

              plotly::add_annotations(
                text=labvec,
                showarrow=leaf_label & stem_label,
                arrowsize=0.3,
                arrowwidth=0.1,
                ax=-10,
                ay=-10,
                font=list(size=text_size),
                #showarrow=FALSE,
                textangle=text_angle)
            # if wish to rotate the bottom nodes need to do this


            fig
          }
)


##############################################################

setGeneric("cutting",  function(h,  ...){print(NULL)})

#' @export
#' @title cutting from an ATC tree
#' @param h an object of class atctree
#' @param nodelabel identify node of interest
#' @description
#'  Cut out a branch with just the descendants of the specified node.
#'
#'  This will include the direct parent of the specified node as information - this is also useful for grafting.
#' @aliases cutting
#' @returns returns a (smaller) object of class atctree
#' @examples
#' h <- atctree(schema="therapeutic")
#' # Suppose we are interested in a branch of this tree; take a cutting and plot it:
#' plot(cutting(h, "P01"))
#'
#' # a different look:
#' plot(cutting(h, "P01"),  text_angle=0, circle=TRUE)
#'

setMethod("cutting",
          signature("atctree"),

          function (h, nodelabel=NULL) {

            if (is.null(nodelabel)) stop("No cutting node supplied")
            if (length(nodelabel)>1) stop("When cutting supply just one node")
            if (!nodelabel %in% h@lab) stop("This cutting node is not in the tree")

            indx <- grep(paste0("^",nodelabel),h@lab)
            #indices where label starts with same pattern

            if (any(grepl(paste0("^", parents(nodelabel), "$"),h@lab))) { # if parent exists in the source tree
              all_nodes <- c(h@lab[indx], parents(nodelabel)) #include parent
            } else {
              all_nodes <- c(h@lab[indx], "0") # include root
            }

            dataf <- make_ATC_df(whichlevs=h@whichlevs) |>
              filter(.data$ATC %in% all_nodes)

            if (!("ATC" %in% colnames(dataf))) {stop("no ATC codes using this filtering function")} # trap errors with filter

            h2 <- new("atctree",
                      pnode = dataf$pnode,
                      node = dataf$node,
                      lab = dataf$ATC,
                      text = dataf$text,
                      plab = dataf$pATC,
                      lev = dataf$lev,
                      Nnode = length(dataf$node)-1,
                      whichlevs = h@whichlevs,
                      schema = schema(h@whichlevs)
            )
            h2@Nlev <- nlevs(h2)


            #browser()
            return(h2)
          }

)

#removes all branches below this node (i.e. at lower levels of the upside-down tree)

########################################################################


setGeneric("pruning",  function(h,  ...){print(NULL)})

#' @export
#' @title prune an ATC tree
#' @param h an object of class atctree
#' @param nodelabels character vector of nodes of interest
#' @description
#' Pruning is specifying the removal of some unwanted branch of the tree (in contrast to taking a cutting, where it is the branch which is kept).
#' @returns a (smaller) object of class atctree
#' @aliases pruning
#' @examples
#' library(visATC)
#' h1 <- atctree(whichlevs=1:3)
#' h1A <- cutting(h1, "C")
#' # make a subtree cut at node C
#' plot(h1A, circle=TRUE)
#' # suppose we decide not to display some nodes:
#' plot(pruning(h1A, c("C01", "C05", "C10")), circle=TRUE)
#'

setMethod("pruning",
          signature("atctree"),

          function (h, nodelabels=NULL) {

            if (is.null(nodelabels)) stop("No labels supplied!")
            if (any(!nodelabels %in% h@lab)) stop("Pruning node(s) not in the tree")

            remove_nodes <- vector()
            for (node in nodelabels) {
              indx <- grep(paste("^",node,sep=""),h@lab)
              #indices where label starts with same pattern
              remove_nodes <- c(remove_nodes, indx)
            }

            h@lab <- h@lab[-remove_nodes]
            h@pnode <- h@pnode[-remove_nodes]
            h@text <- h@text[-remove_nodes]
            h@node <- h@node[-remove_nodes]
            h@lev <- h@lev[-remove_nodes]
            h@plab <- h@plab[-remove_nodes]

            h@Nnode <- length(h@node)-1
            # leave out the root node

            return(h)

          }
)

#removes all branches below this node (i.e. at lower levels of the upside-down tree)

########################################################################
# find relatives within a tree, from specified node or level
#

#' @export
#' @title find a subset of the tree
#' @param x object of class atctree
#' @param i label (ATC code) of focal node
#' @param j generation (integer). 0: siblings, -1: children, -2: grandchildren, 1: parents etc
#' @details
#' The subset method for objects of class atctree uses a focal node and a specification of how many generations to accrue.
#' The focal node is specified by an ATC code at any of the five levels (e.g. i="A01").
#' The generation is specified by integer j, signed positive for ancestors and negative for descendants.
#' @returns an object of class atctree
#' @aliases subset
#' @examples
#' h <- atctree(schema="full")
#' #more useful to use the full tree with this approach
#' # plot the siblings of C01:
#' plot(h["C01",0], ATC_text=TRUE, stem_label=TRUE, leaf_label=TRUE)
#' # plot descendents of P01 (as far as grandchildren):
#' plot(h["P01",-2], stem_label=TRUE, leaf_label=TRUE)
#' # plot descendents of P01 (as far as great grandchildren):
#' plot(h["P01",-3], stem_label=TRUE, leaf_label=TRUE)
#'
setMethod("[", "atctree",
          function(x,  i, j=0) {

            ret <- which(x@lab %in% i) # base node
            #print(ret)
            if (j<0) {
              ff <- function(node) unlist(sapply(node, function(n) which(x@plab==x@lab[n]))) #find child node
              for (ii in -1:j) {
                ret <- c(ret, ff(ret))
                #print(ret)
              }
              #labels of descendants; j=-1 is children etc
            }

            if (j>0) {
              ff <- function(node) unlist(sapply(node, function(n) which(x@lab==x@plab[n]))) #find parent node
              for (ii in 1:j) {
                ret <- c(ret, ff(ret))
                #print(ret)
              }
              #labels of ancestors; j=1 is parents etc
            }

            if (j==0) {
              ret <- which(x@plab==x@plab[ret]) #nodes with the same parent = siblings

              ret <- c(ret, which(x@lab==x@plab[ret[1]]))
              # include the parent node too in the tree, if it exists
            }

            if (length(ret)==0) return(NULL)


            # restrict the drug database:
            dataf <- make_ATC_df(whichlevs=x@whichlevs) |>
              filter(.data$ATC %in% x@lab[ret])
            if (!("ATC" %in% colnames(dataf))) {stop("no ATC codes using this filtering function")} # trap errors with filter

            h2 <- new("atctree",
                      pnode = dataf$pnode,
                      node = dataf$node,
                      lab = dataf$ATC,
                      text = dataf$text,
                      plab = dataf$pATC,
                      lev = dataf$lev,
                      Nnode = length(dataf$node)-1,
                      whichlevs = x@whichlevs,
                      schema = schema(x@whichlevs)
            )
            h2@Nlev <- nlevs(h2)

            return(h2)

          }
)

#####################################################
#' @export
#' @title summarise atctree object
#' @description shows schema, number of nodes and levels and a cross-table, excluding the root node.
#' @param object of class acttree
#' @returns prints summary to console
#' @examples
#' h <- atctree(whichlevs=1:4)
#' (h)
#'
setMethod("show", "atctree",
          function(object) {

            cat("\n schema: ", object@schema)
            cat("\n total number of nodes: ", object@Nnode)
            cat("\n total number of levels: ", object@Nlev)
            cat("\n number of nodes by level :")
            print(table(object@lev)[-1]) # leave out the root node
          }

)


