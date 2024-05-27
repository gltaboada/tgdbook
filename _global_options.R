# ················································
# Herramientas para crear documentos rmarkdown
# y opciones por defecto chunks
#
# Fecha modificación: 2023/03/27
# ················································
# NOTA: Ctrl + Shift + O para Document Outline

# Opciones knitr ---------------------------------
# ················································
knitr::opts_chunk$set(
  fig.width = 7, fig.height = 6, fig.align = "center", fig.pos = "!htb",
  out.width = "80%",
  cache = TRUE, cache.path = 'cache/',
  echo = TRUE, warning = FALSE, message = FALSE
)

# Directorio figuras
# ················································
fig.path <- "figuras/"
# fig.path <- ""

# Funciones auxiliares rmarkdown -----------------
# ················································

# Output bookdown
# ················································
is_latex <- function(...) knitr:::is_latex_output(...)
is_html <- function(...) knitr:::is_html_output(...)

# Rmd code:
# ················································
inline <- function(x = "") paste0("`` `r ", x, "` ``")
inline2 <- function(x = "") paste0("`r ", x, "`")


# Citas Figuras ----------------------------------
# ················································

# (ver Figura/figuras ...)
cite_fig <- function(..., text = "(ver ") {
    x <- list(...)
    paste0(text, if(length(x)>1) "figuras: " else "Figura ",
      paste0("\\@ref(fig:", x, ")", collapse = ", "),
    ")")
}

# [Figura/s: ...]
cite_fig2 <- function(..., text = "") {
    x <- list(...)
    paste0(text, if(length(x)>1) "[Figuras: " else "[Figura ",
      paste0("\\@ref(fig:", x, ")", collapse = ", "),
    "]")
}

# [Figura/s: ...] si latex/pdf
latexfig <- function(..., output = is_latex())
    if (output) citefig2(..., text = " ") else ""


# Citas paquetes y funciones ---------------------
# ················································

# Cita paquete CRAN
cite_cran <- function(pkg) {
    pkg <- as.character(substitute(pkg))
    paste0("[`", pkg, "`](https://CRAN.R-project.org/package=", pkg, ")")
}

## Citas paquetes --------------------------------
# ················································

cite_pkg_ <- function(pkg, url = sapply(pkg, downlit::href_package)) {
    paste0("[`", pkg, "`](", url, ")",  collapse = ", ")
}

# cite_pkg_(c("dplyr", "tidyr"))
# "[`dplyr`](https://dplyr.tidyverse.org), [`tidyr`](https://tidyr.tidyverse.org)"
# Pendiente: cite_pkg_("Rcmdr")
# "[`Rcmdr`](https://www.r-project.org)" Fallo downlit?
# ················································

cite_pkg <- function(pkg, ...) {
    cite_pkg_(as.character(substitute(pkg)), ...)
}

# Pendente: cite_pkg(c(dplyr, tidyr))
# "[`c`](NA), [`dplyr`](https://dplyr.tidyverse.org), [`tidyr`](https://tidyr.tidyverse.org)"
# ················································


## Citas funciones -------------------------------
# ················································

cite_fun_ <- function(fun, pkg, url, full = FALSE) {
    fun_full <- if (!missing(pkg))
        paste(pkg, fun, sep = "::") else fun
    if (missing(url)) url <- downlit::autolink_url(fun_full)
    if (full) fun <- fun_full
    paste0("[`", fun, "`](", url, ")", collapse = ", ")
}

# cite_fun_("subset()")
# "[`subset()`](https://rdrr.io/r/base/subset.html)"
# cite_fun_("group_by()", "dplyr")
# "[`group_by()`](https://dplyr.tidyverse.org/reference/group_by.html)"
# Pendente: cite_fun_(c("summarise", "group_by"), "dplyr")
# ················································

cite_fun <- function(fun, pkg, ...) {
    fun <- paste0(substitute(fun),"()")
    if (missing(pkg)) return(cite_fun_(fun, ...))
    cite_fun_(fun, as.character(substitute(pkg)), ...)

}

# cite_fun(subset)
# "[`subset()`](https://rdrr.io/r/base/subset.html)"
# cite_fun(group_by, dplyr)
# "[`group_by()`](https://dplyr.tidyverse.org/reference/group_by.html)"
# Pendente: cite_fun(remotes::install_version)
# ················································

# PENDENTE:
# ················································
# rmd.lines <- function(l = 1) paste0("<br> \vspace{0.5cm}\n")
#     cat(rep("<br>", l), "\n") # 0.5*l



