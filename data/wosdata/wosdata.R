# ----------------
# Ejemplo WoS data
# ----------------

# library(dplyr)
# library(stringr)
# https://rubenfcasal.github.io/scimetr/articles/scimetr.html
library(scimetr)

# Session > Set Working Directory > To Source...
# Importar datos en archivos de texto
dir(pattern='*.txt')
# Se combinan los ficheros:
wosdf <- ImportSources.wos(other = FALSE) # 976 registros sin filtrar ("OG = UDC")
str(wosdf, vec.len = 2, nchar.max = 64)

# Abrir datos filtrados
load("wosdf.RData") # 856 registros filtrados
as.data.frame(attr(wosdf, "variable.labels"))

# Generar tablas (lista de data.frames)
# Se crea la base de datos:
db <- CreateDB.wos(wosdf)

# Guardar
save(db, file = "db_udc_2015.RData")

# ?save
# For saving single R objects, saveRDS() is mostly preferable to save(), 
# notably because of the functional nature of readRDS(), as opposed to load(). 
saveRDS(db, file = "db_udc_2015.rds")
## restore it under a different name
db2 <- readRDS("db_udc_2015.rds")
identical(db, db2)

