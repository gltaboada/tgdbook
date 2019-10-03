Scopus_ReadCSV2 <- function (filename, stopOnErrors = TRUE, dbIdentifier = "Scopus",
    alternativeIdPattern = "^.*\\id=|\\&.*$", ...)
{

# filename <- "udc_2015.csv"
# filename <- "udc_2015.csv"
# stopOnErrors = TRUE; dbIdentifier = "Scopus"; alternativeIdPattern = "^.*\\id=|\\&.*$"
#    datafile <- read.csv(filename, header = T, encoding = "UTF-8",
#        fileEncoding = "UTF-8", stringsAsFactors = FALSE, ...)

    datafile <- read.csv(filename, header = T, encoding = "UTF-8", stringsAsFactors = FALSE)
    names(datafile)[1] <- "Authors"

    if (!is.na(dbIdentifier) && is.null(datafile$Source))
        stop("Column not found: `Source'.")
    if (is.null(datafile$Authors))
        stop("Column not found: `Authors'.")
    if (is.null(datafile$Title))
        stop("Column not found: `Title'.")
    if (is.null(datafile$Year))
        stop("Column not found: `Year'.")
    if (is.null(datafile$Source.title))
        stop("Column not found: `Source.title'.")
    if (is.null(datafile$Volume))
        stop("Column not found: `Volume'.")
    if (is.null(datafile$Issue))
        stop("Column not found: `Issue'.")
    if (is.null(datafile$Page.start))
        stop("Column not found: `Page.start'.")
    if (is.null(datafile$Page.end))
        stop("Column not found: `Page.end'.")
    if (is.null(datafile$Cited.by))
        stop("Column not found: `Cited.by'.")
    if (is.null(datafile$Link))
        stop("Column not found: `Link'.")
    if (is.null(datafile$Document.Type))
        stop("Column not found: `Document.Type'.")
    if (!is.na(dbIdentifier) && any(datafile$Source != dbIdentifier)) {
        msg <- (sprintf("source database does not match 'dbIdentifier'. This may possibly indicate a parse error. Check records: %s.",
            paste(which(datafile$Source != dbIdentifier), collapse = ", ")))
        if (stopOnErrors)
            stop(msg)
        else warning(msg)
    }
    if (!is.na(alternativeIdPattern)) {
        datafile$AlternativeId <- gsub(alternativeIdPattern,
            "", datafile$Link)
    } else {
        datafile$AlternativeId <- datafile$Link
    }
    datafile$AlternativeId[datafile$AlternativeId == ""] <- NA
    naAlternativeId <- which(is.na(datafile$AlternativeId))
    if (length(naAlternativeId) > 0) {
        msg <- (sprintf("some documents do not have unique identifiers. Check line %s (or its neighborhood). \n   Perhaps somethings is wrong with the end page (check for ', ' nearby).",
            naAlternativeId[1] + 1))
        if (stopOnErrors)
            stop(msg)
        else warning(msg)
    }
    checkAlternativeId <- unique(datafile$AlternativeId, incomparables = NA)
    if (length(checkAlternativeId) != nrow(datafile)) {
        msg <- (sprintf("non-unique document identifiers at rows: %s.",
            paste((1:nrow(datafile))[-checkAlternativeId], collapse = ", ")))
        if (stopOnErrors)
            stop(msg)
        else warning(msg)
    }
    datafile$Cited.by[!is.na(gsub("^([[:digit:]]+)$", NA, datafile$Cited.by))] <- NA
    datafile$Cited.by <- as.numeric(datafile$Cited.by)
    checkCitations <- which(datafile$Cited.by < 0 | datafile$Cited.by >
        1e+05)
    if (length(checkCitations) > 0) {
        msg <- (sprintf("something is wrong with citation counts at rows: %s.",
            paste((1:nrow(datafile))[-checkCitations], collapse = ", ")))
        if (stopOnErrors)
            stop(msg)
        else warning(msg)
    }
    datafile$Page.start[!is.na(gsub("^([[:digit:]]+)$", NA, datafile$Page.start))] <- NA
    datafile$Page.end[!is.na(gsub("^([[:digit:]]+)$", NA, datafile$Page.end))] <- NA
    datafile$Page.start <- as.numeric(datafile$Page.start)
    datafile$Page.end <- as.numeric(datafile$Page.end)
    checkPages <- which((datafile$Page.start < 0) | (datafile$Page.end <
        datafile$Page.start) | (datafile$Page.end - datafile$Page.start >
        10000))
    if (length(checkPages) > 0) {
        msg <- (sprintf("some documents seem to have incorrect page numbers. Check line %s (or its neighborhood).",
            checkPages[1] + 1))
        if (stopOnErrors)
            stop(msg)
        else warning(msg)
    }
    datafile <- data.frame(Authors = as.character(datafile$Authors),
        Title = as.character(datafile$Title), Year = datafile$Year,
        AlternativeId = datafile$AlternativeId, SourceTitle = as.character(datafile$Source.title),
        Volume = datafile$Volume, Issue = datafile$Issue, PageStart = datafile$Page.start,
        PageEnd = datafile$Page.end, Citations = datafile$Cited.by,
        DocumentType = datafile$Document.Type)
    attr(datafile, "filename") <- filename
    return(datafile)
}
