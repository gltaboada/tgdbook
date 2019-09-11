# ----------------
# Ejemplo WoS data
# ----------------

library(dplyr)
library(stringr)
# Session > Set Working Directory > To Source...
source("rwos.R")

# Importar datos en archivos de texto
dir(pattern='*.txt')
# Se combinan los ficheros:
wosdf <- wos_ImportSources(other = FALSE) # 976 registros sin filtrar ("OG = UDC")

# Abrir datos filtrados
load("wosdf.RData") # 856 registros filtrados
as.data.frame(attr(wosdf, "variable.labels"))

# Generar tablas (lista de data.frames)
# Se crea la base de datos:
db <- wos_CreateDB(wosdf)

# Guardar
save(db, file = "db_udc_2015.RData")

# ?save
# For saving single R objects, saveRDS() is mostly preferable to save(), 
# notably because of the functional nature of readRDS(), as opposed to load(). 
saveRDS(db, file = "db_udc_2015.rds")
## restore it under a different name
db2 <- readRDS("db_udc_2015.rds")
identical(db, db2)

# Listar artículos de autores

