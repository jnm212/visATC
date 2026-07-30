
make_ATC_df <- function(whichlevs=1:5L, incl.root=T) {

  if (!all(whichlevs %in% 1:5)) stop("levels must be subset of 1:5")

#  data(ATCnames, envir = environment())
  codelens <- c(1,3,4,5,7)[whichlevs]
  #pcodelens <- c(0, codelens)

  dataf <- data.frame(ATC=ATCdata, text=names(ATCdata)) |>
    dplyr::distinct()

  dataf <- dataf |>
    mutate(ATC = as.character(ATC)) |>
    mutate(len=nchar(ATC)) |>
    arrange(dplyr::desc(len)) |>
    mutate(node=1:dplyr::n()) |>
    mutate(lev=as.numeric(factor(len, labels=1:5)))

  # restrict to the specified levels:
  dataf <- dataf |>
    mutate(levindx = match(dataf$lev, whichlevs)) |>
    filter(lev %in% whichlevs)

  # parent nodes:
  dataf <- dataf |>
    mutate(plevindx = levindx-1) |>
    mutate(plev=ifelse(plevindx==0, 0 ,  whichlevs[plevindx])) |>
    mutate(plen = ifelse(plev==0, 0, codelens[plevindx]))

  if (incl.root) {
    # add root node:
    rootn <- max(dataf$node)+1
    dataf <- dataf |>
      bind_rows(data.frame(ATC="0", text="root", len=0, lev=0, node=rootn, plev=NA, plen=NA))
  }

  # work out parent ATC:
  dataf <- dataf |>
    mutate(pATC = substr(ATC, 1, plen))

  # work out pnode:
  tmp <- select(dataf, pATC) |>
    rename(ATC=pATC) |>
    dplyr::distinct()

  dataf2 <- left_join(tmp, select(dataf, ATC, node), by="ATC" ) |>
    rename(pATC=ATC, pnode=node)

  dataf <- left_join(dataf, dataf2, by="pATC", relationship = "many-to-many")

  dataf <- dataf |>
    mutate(pATC = if_else(plev==0, "root", pATC))

  if (incl.root) {
    dataf <- dataf |>
      mutate(pnode = if_else(plev==0, rootn, pnode))
  }

#  dataf <- dataf |>
#    arrange(dplyr::desc(len), ATC)

  return(dataf)
}





