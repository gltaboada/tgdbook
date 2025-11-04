# ----------------
# Ejemplo WoS data
# ----------------

# library(dplyr)
# library(stringr)
# library(scimetr)

# Establecer como directorio de trabajo el correspondiente al fichero de código:
# Menú: Session > Set Working Directory > To Source...
# o clic con botón derecho en pestaña y seleccionar: Set Working Directory

source("wos.R")

# Importar datos en archivos de texto
dir(pattern='*.txt')
# Se combinan los ficheros:
wosdf <- ImportSources.wos(other = FALSE)

# Abrir datos filtrados
load("wosdf.RData") # 856 registros filtrados
as.data.frame(attr(wosdf, "variable.labels"))

# Genera tablas (lista de data.frames)
# Se crea la base de datos:
# db <- CreateDB.wos(wosdf)

db <- readRDS("db_udc_2015.rds")
str(db, 1)

#' Puede ser recomendable añadir a los datos un atributo `variable.labels` que
#' contenga un vector de etiquetas de las variables y empleando como nombres de
#' las componentes las propias variables:

variable.labels <- attr(db, "variable.labels")
knitr::kable(head(as.data.frame(variable.labels)),
             caption = "Variable labels")

#' Las tablas de datos con este atributo son compatibles con RStudio.
#' Por ejemplo, también se mostrarán las etiquetas al abrirla con `View()`

Docs <- db$Docs # No copia los datos (crea otro objeto que apunta a los mismos datos)
attr(Docs, "variable.labels") <- variable.labels[names(Docs)]
View(Docs)

#'
#' Para combinar tablas podemos emplear `match(x, table)`.
#' Por ejemplo, el siguiente código permite añadir el nombre de la revista a la
#' tabla de documentos, combinándola con la de revistas:

str(Docs)
str(db$Journals) # View(db$Journals)
ii <- match(Docs$idj, db$Journals$idj)
docs2 <- Docs[, c("PY", "TI")]
docs2$Journal <- db$Journals$SO[ii]
head(docs2)

#' Si solo nos interesa hacer un filtrado puede resultar más cómodo emplear
#' el operador `%in%` (`?'%in%'`).
#' Por ejemplo, podemos buscar los documentos correspondientes a revistas (que
#' contengan `"Chem"` en el nombre ISO de la revista).
#' Para ello utilizamos la función `grepl()` que busca las coincidencias de
#' un patrón dentro de cada elemento de un vector de caracteres:

iidj <- with(db$Journals, idj[grepl('Chem', JI)])
db$Journals$JI[iidj]

idd <- with(Docs, idj %in% iidj)
which(idd)

# View(Docs[idd, ])
head(Docs[idd, 1:3])


#'
#' Como ejemplo adicional, se buscan los documentos correspondientes a autores
#' (que contiene `"Abad"` en su nombre):

# View(db$Authors)
iida <- with(db$Authors, ida[grepl('Abad', AF)])
db$Authors$AF[iida]

idd <- with(db$AutDoc, idd[ida %in% iida])
idd

# View(Docs[idd, ])
head(Docs[idd, 1:3])
