# put scraped wikipedia data
# in /data folder
# alternative to direct WHO data (see save_who_atc.r) which is the default source


scrape_wiki_atc <- function() {

  #tmp <- read_html("https://en.wikipedia.org/wiki/Anatomical_Therapeutic_Chemical_Classification_System")
  #test <- tmp |> html_elements("td") |> html_text()

  l1 <- c("A", "B", "C", "D", "G", "H", "J", "L", "M", "N", "P", "R", "S", "V")
  names(l1) <- c(
    "Alimentary tract and metabolism",
    "Blood and blood forming organs",
    "Cardiovascular system",
    "Dermatologicals",
    "Genito-urinary system and sex hormones",
    "Systemic hormonal preparations, excluding sex hormones and insulins",
    "Antiinfectives for systemic use",
    "Antineoplastic and immunomodulating agents",
    "Musculo-skeletal system",
    "Nervous system",
    "Antiparasitic products, insecticides and repellents",
    "Respiratory system",
    "Sensory organs",
    "Various"
  )

  ##############################
  AA <- list()
  l2 <- vector()

  for (ii in 1:length(l1)) {

    tmp <- rvest::read_html(paste0("https://en.wikipedia.org/wiki/ATC_code_",l1[ii]))
    AA[[ii]] <- tmp |> rvest::html_elements(".plainlist li") |> rvest::html_text()

    AA[[ii]] <- AA[[ii]][grep("^[[:alpha:]]{2}", AA[[ii]], invert=T)]
    # remove veterinary elements (extra Q prefix)

    #x <- grep(paste0("^", ATC_LETS[ii],"[[:digit:]]{2}"), AA[[ii]])
    #  substring(AA[[ii]][length(x)], first=x[length(x)], last=(x[length(x)]+attr(x,"match.length")[length(x)]-1) )

    x <-  substring(AA[[ii]], first=1, last=3 )

    names(x) <- substring(AA[[ii]], first=5)

    l2 <- c(l2, x)

  }

  ################################
  l3 <- l4 <- l5 <- vector()

  for (ii in 1:length(l2)) {
    tmp <- rvest::read_html(paste0("https://en.wikipedia.org/wiki/ATC_code_",l2[ii]))
    x <- tmp |> rvest::html_elements("dd") |> rvest::html_text()
    x <- grep("^[[:upper:]]{1}[[:digit:]]",x, value=T) #remove elements that aren't 1 xuppercase followed by digit
    l5 <- c(l5, x)
    x <- tmp |> rvest::html_elements("h3") |> rvest::html_text()
    x <- grep("^[[:upper:]]{1}[[:digit:]]",x, value=T)
    l4 <- c(l4, x)
    x <- tmp |> rvest::html_elements("h2") |> rvest::html_text()
    x <- grep("^[[:upper:]]{1}[[:digit:]]",x, value=T)
    l3 <- c(l3, x)
    print(length(l2)-ii)
  }

  l3 <- grep("^Q",l3,value=T, invert=T)
  l4 <- grep("^Q",l4,value=T, invert=T)
  l5 <- grep("^Q",l5,value=T, invert=T)
  # remove veterinary drugs

  ##################################
  # special corrections
  indx <- grep("^AA10XX",l4)
  l4[indx] <- "^A10XX" #16/7/26

  ###################################

  if (any(grepl("^[[:upper:]]{2}",c(l3,l4,l5)))) {

    print("Error trapping:")
    print("L3:")
    print(grep("^[[:upper:]]{2}",l3, value=T))
    print("L4:")
    print(grep("^[[:upper:]]{2}",l4, value=T))
    print("L5:")
    print(grep("^[[:upper:]]{2}",l5, value=T))
  stop("Errors detected")

  }
  ###################################

  tmp <- substring(l3, first=6)
  l3 <- substring(l3, first=1, last=4)
  names(l3) <- tmp

  tmp <- substring(l4, first=7)
  l4 <- substring(l4, first=1, last=5)
  names(l4) <- tmp

  tmp <- substring(l5, first=9)
  l5 <- substring(l5, first=1, last=7)
  names(l5) <- tmp

  ATCdata <- c(l1,l2,l3,l4,l5)

  usethis::use_data(ATCdata,  overwrite = TRUE)

}

