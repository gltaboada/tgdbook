# ----------------
# Ejemplo WoS data
# ----------------

# library(dplyr)
# library(stringr)
# library(scimetr)

# Session > Set Working Directory > To Source...
source("wos.R")

# Importar datos en archivos de texto
dir(pattern='*.txt')
# Se combinan los ficheros:
wosdf <- ImportSources.wos(other = FALSE)

# Abrir datos filtrados
load("wosdf.RData") # 856 registros filtrados
as.data.frame(attr(wosdf, "variable.labels"))

# Generar tablas (lista de data.frames)
# Se crea la base de datos:
# db <- CreateDB.wos(wosdf)

db <- readRDS("db_udc_2015.rds")
str(db, 1)

variable.labels <- attr(db, "variable.labels")
as.data.frame(variable.labels)


#' Combinar la tabla de documentos con la de revistas

str(db$Docs) # View(db$Docs)
str(db$Journals) # View(db$Journals)
ii <- match(db$Docs$idj, db$Journals$idj)
docs2 <- db$Docs[, c("PY", "TI")]
docs2$Journal <- db$Journals$SO[ii]
head(docs2)


#' Documentos correspondientes a revistas:

iidj <- with(db$Journals, idj[grepl('Chem', JI)])
db$Journals$JI[iidj]

idd <- with(db$Docs, idj %in% iidj)
which(idd)

# View(db$Docs[idd, ])
head(db$Docs[idd, 1:3])


#' Documentos correspondientes a autores:

# View(db$Authors)
iida <- with(db$Authors, ida[grepl('Abad', AF)])
db$Authors$AF[iida]

idd <- with(db$AutDoc, idd[ida %in% iida])
idd

# View(db$Docs[idd, ])
head(db$Docs[idd, 1:3])
