
make_ATC_df <- function(whichlevs=1:5L, incl.root=T) {

  if (!all(whichlevs %in% 1:5)) stop("levels must be subset of 1:5")

  #data(ATCdata, envir = environment())
  codelens <- c(1,3,4,5,7)[whichlevs]


  dataf <- data.frame(ATC=ATCdata, text=names(ATCdata)) |>
    dplyr::distinct()

  dataf <- dataf |>
    mutate(ATC = as.character(.data$ATC)) |>
    mutate(len=nchar(.data$ATC)) |>
    arrange(dplyr::desc(.data$len)) |>
    mutate(node=1:dplyr::n()) |>
    mutate(lev=as.numeric(factor(.data$len, labels=1:5)))

  # restrict to the specified levels:
  dataf <- dataf |>
    mutate(levindx = match(.data$lev, whichlevs)) |>
    filter(.data$lev %in% whichlevs)

  # parent nodes:
  dataf <- dataf |>
    mutate(plevindx = .data$levindx-1) |>
    mutate(plev=ifelse(.data$plevindx==0, 0 ,  whichlevs[.data$plevindx])) |>
    mutate(plen = ifelse(.data$plev==0, 0, codelens[.data$plevindx]))

  if (incl.root) {
    # add root node:
    rootn <- max(dataf$node)+1
    dataf <- dataf |>
      bind_rows(data.frame(ATC="0", text="root", len=0, lev=0, node=rootn, plev=NA, plen=NA))
  }

  # work out parent ATC:
  dataf <- dataf |>
    mutate(pATC = substr(.data$ATC, 1, .data$plen))

  # work out pnode:
  tmp <- select(dataf, .data$pATC) |>
    rename(ATC=.data$pATC) |>
    dplyr::distinct()

  dataf2 <- left_join(tmp, select(dataf, .data$ATC, .data$node), by="ATC" ) |>
    rename(pATC=.data$ATC, pnode=.data$node)

  dataf <- left_join(dataf, dataf2, by="pATC", relationship = "many-to-many")

  dataf <- dataf |>
    mutate(pATC = if_else(.data$plev==0, "root", .data$pATC))

  if (incl.root) {
    dataf <- dataf |>
      mutate(pnode = if_else(.data$plev==0, rootn, .data$pnode))
  }

#  dataf <- dataf |>
#    arrange(dplyr::desc(len), ATC)

  return(dataf)
}





