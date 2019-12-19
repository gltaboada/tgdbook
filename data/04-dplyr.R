#' ---
#' title: "Manipulación de datos con `dplyr`"
#' author: "Tecnologías de Gestión de Datos"
#' date: "Curso 2019/2020"
#' output: 
#'   bookdown::html_document2:
#'     pandoc_args: ["--number-offset", "4,0"]
#'     toc: yes 
#'     # mathjax: local            # emplea una copia local de MathJax, hay que establecer:
#'     # self_contained: false     # las dependencias se guardan en ficheros externos 
#' ---
#' 
#' 
#' 
#' 
#' El paquete **dplyr**
#' --------------------
#' 

library(dplyr)

#' 
#' [`dplyr`](https://dplyr.tidyverse.org/index.html) 
#' permite sustituir funciones base de R (como `split()`, `subset()`, 
#' `apply()`, `sapply()`, `lapply()`, `tapply()` y `aggregate()`)
#' mediante una "gramática" más sencilla para la manipulación de datos:
#' 
#' - `select()` seleccionar variables/columnas (también `rename()`).
#' 
#' - `mutate()` crear variables/columnas (también `transmute()`).
#' 
#' - `filter()` seleccionar casos/filas (también `slice()`).
#' 
#' - `arrange()`  ordenar o organizar casos/filas.
#' 
#' - `summarise()` resumir valores.
#' 
#' - `group_by()` permite operaciones por grupo empleando el concepto
#' "dividir-aplicar-combinar" (`ungroup()` elimina el agrupamiento).
#' 
#' Puede trabajar con conjuntos de datos en distintos formatos:
#'      
#' - `data.frame`, `data.table`, `tibble`, ...
#' 
#' - bases de datos relacionales (lenguaje SQL); paquete [dbplyr](https://dbplyr.tidyverse.org), ...
#' 
#' - bases de datos *Hadoop*:
#' 
#'     - [`plyrmr`](https://github.com/RevolutionAnalytics/plyrmr/blob/master/docs/tutorial.md), 
#'     
#'     - [`sparklyr`](https://spark.rstudio.com)
#'     
#'     - ...
#' 
#' En lugar de operar sobre vectores como las funciones base,
#' opera sobre objetos de este tipo (solo nos centraremos en `data.frame`).
#' 
#' ### Datos de ejemplo
#' 
#' El fichero *empleados.RData* contiene datos de empleados de un banco.
#' Supongamos por ejemplo que estamos interesados en estudiar si hay
#' discriminación por cuestión de sexo o raza.
#' 

load("empleados.RData")

# Listamos las etiquetas
# data.frame(Etiquetas = attr(empleados, "variable.labels"))  
# Eliminamos las etiquetas para que no molesten...
# attr(empleados, "variable.labels") <- NULL                  

#' 
#' Operaciones con variables (columnas)
#' ------------------------------------
#' 
#' ### Seleccionar variables con **select()**
#' 

emplea2 <- select(empleados, id, sexo, minoria, tiempemp, salini, salario)
head(emplea2)

#' 
#' Se puede cambiar el nombre (ver también *?rename()*)
#' 

head(select(empleados, sexo, noblanca = minoria, salario))

#' 
#' Se pueden emplear los nombres de variables como índices:
#' 

head(select(empleados, sexo:salario))
head(select(empleados, -(sexo:salario)))

#' 
#' Hay opciones para considerar distintos criterios: `starts_with()`, `ends_with()`, 
#' `contains()`, `matches()`, `one_of()` (ver *?select*).
#' 

head(select(empleados, starts_with("s")))

#' 
#' ### Generar nuevas variables con **mutate()**
#' 

head(mutate(emplea2, incsal = salario - salini, tsal = incsal/tiempemp ))

#' 
#' 
#' Operaciones con casos (filas)
#' -----------------------------
#' 
#' ### Seleccionar casos con **filter()**
#' 

head(filter(emplea2, sexo == "Mujer", minoria == "Sí"))

#' 
#' ### Organizar casos con **arrange()**
#' 

head(arrange(emplea2, salario))
head(arrange(emplea2, desc(salini), salario))

#' 
#' 
#' Resumir valores con **summarise()**
#' -----------------------------------
#' 

summarise(empleados, sal.med = mean(salario), n = n())

#' 
#' 
#' Agrupar casos con **group_by()**
#' -----------------------------
#' 

summarise(group_by(empleados, sexo, minoria), sal.med = mean(salario), n = n())

#' 
#' 
#' Operador *pipe* **%>%** (tubería, redirección)
#' -----------------------------
#' Este operador le permite canalizar la salida de una función a la entrada de otra función. 
#' `segundo(primero(datos))` se traduce en `datos %>% primero %>% segundo`
#' (lectura de funciones de izquierda a derecha).
#' 
#' Ejemplos:
#' 

empleados %>%  filter(catlab == "Directivo") %>%
          group_by(sexo, minoria) %>%
          summarise(sal.med = mean(salario), n = n())

empleados %>% select(sexo, catlab, salario) %>%
          filter(catlab != "Seguridad") %>%
          group_by(catlab) %>%
          mutate(saldif = salario - mean(salario)) %>%
          ungroup() %>%
          boxplot(saldif ~ sexo*droplevels(catlab), data = .)
abline(h = 0, lty = 2)

#' 
#' Operaciones con tablas de datos
#' -------------------------------
#' 
#' Se emplean funciones `xxx_join()` (ver la documentación del paquete 
#' [Join two tbls together](https://dplyr.tidyverse.org/reference/join.html),
#' o la vignette [Two-table verbs](https://dplyr.tidyverse.org/articles/two-table.html)):
#' 
#' - `inner_join()`: devuelve las filas de `x` que tienen valores coincidentes en `y`, 
#'   y todas las columnas de `x` e `y`. Si hay varias coincidencias entre `x` e `y`, 
#'   se devuelven todas las combinaciones.
#'   
#' - `left_join()`: devuelve todas las filas de `x` y todas las columnas de `x` e `y`. 
#'   Las filas de `x` sin correspondencia en `y` contendrán `NA` en las nuevas columnas. 
#'   Si hay varias coincidencias entre `x` e `y`, se devuelven todas las combinaciones
#'   (duplicando las filas).
#'   `right_join()` hace lo contrario, devuelve todas las filas de `y`, y `full_join()`
#'   devuelve todas las filas de `x` e `y` (duplicando o asignando `NA` si es necesario).
#' 
#' - `semi_join()`: devuelve las filas de `x` que tienen valores coincidentes en `y`, 
#'   manteniendo sólo las columnas de `x` (al contrario que `inner_join()` no duplica filas).
#'   `anti_join()` hace lo contrario, devuelve las filas sin correspondencia. 
#' 
#' El parámetro `by` determina las variables clave para las correspondencias.
#' Si no se establece se considerarán todas las que tengan el mismo nombre en ambas tablas.
#' Se puede establecer a un vector de nombres coincidentes y en caso de que los nombres sean
#' distintos a un vector con nombres de la forma `c("clave_x" = "clave_y")`.
#' 
#' Adicionalmente, si las tablas `x` e `y` tienen las mismas variables, se pueden combinar 
#' las observaciones con operaciones de conjuntos:
#' 
#' - `intersect(x, y)`: observaciones en `x` y en `y`.
#' 
#' - `union(x, y)`: observaciones en `x` o `y` no duplicadas.
#' 
#' - `setdiff(x, y)`: observaciones en `x` pero no en `y`.
#' 
#' 
#' Bases de datos con dplyr
#' ------------------------
#' 
#' ### Ejemplos (Práctica 1)
#' 
#' Como ejemplo emplearemos los ejercicios de la Práctica 1.
#' 

# install.packages('dbplyr')
library(dplyr)
library(dbplyr)

#' 
#' Conectar la base de datos:

chinook <- DBI::dbConnect(RSQLite::SQLite(), "chinook.db")

#' 
#' Listar tablas:

src_dbi(chinook)

#' 
#' Enlazar una tabla:

invoices <- tbl(chinook, "invoices")
invoices

#' 
#' Ojo `[?? x 9]`: de momento no conoce el número de filas.

nrow(invoices)

#' 
#' Mostrar la consulta SQL:

show_query(head(invoices))

str(head(invoices))

#' 
#' Al trabajar con bases de datos, dplyr intenta ser lo más vago posible:
#' 
#' -  No exporta datos a R a menos que se pida explícitamente (`colect()`).
#' 
#' -  Retrasa cualquier operación lo máximo posible: 
#'    agrupa todo lo que se desea hacer y luego hace una única petición a la base de datos.
#'    

invoices %>% head %>% collect
invoices %>% count # número de filas

#' 
#' 1.  Conocer el importe mínimo, máximo y la media de las facturas
#'     

res <- invoices %>% summarise(min = min(Total, na.rm = TRUE), 
                        max = max(Total, na.rm = TRUE), med = mean(Total, na.rm = TRUE))
show_query(res)
res  %>% collect

#' 
#' 2.  Conocer el total de las facturas de cada uno de los países.
#' 

res <- invoices %>% group_by(BillingCountry) %>% 
          summarise(n = n(), total = sum(Total, na.rm = TRUE))
show_query(res)
res  %>% collect

#' 
#' 3.  Obtener el listado de países junto con su facturación media, ordenado 
#'     (a) alfabéticamente por país
#' 

res <- invoices %>% group_by(BillingCountry) %>% 
          summarise(n = n(), med = mean(Total, na.rm = TRUE)) %>%
          arrange(BillingCountry)
show_query(res)
res  %>% collect

#' 
#' (b) decrecientemente por importe de facturación media
#'     

invoices %>% group_by(BillingCountry) %>% 
          summarise(n = n(), med = mean(Total, na.rm = TRUE)) %>%
          arrange(desc(med)) %>% collect

#' 
#' 4.  Obtener un listado con Nombre y Apellidos de cliente y el importe de cada una de sus facturas 
#'     (Hint: WHERE customer.CustomerID=invoices.CustomerID)
#' 

customers <- tbl(chinook, "customers")
tbl_vars(customers) 

res <- customers %>% inner_join(invoices, by = "CustomerId") %>% select(FirstName, LastName, Country, Total) 
show_query(res)
res  %>% collect

#' 
#' 5.  ¿Qué porcentaje de las canciones son video?
#' 

tracks <- tbl(chinook, "tracks")
head(tracks) 

tracks %>% group_by(MediaTypeId) %>% 
    summarise(n = n()) %>% collect %>% mutate(freq = n / sum(n))

media_types <- tbl(chinook, "media_types")
head(media_types)

tracks %>% inner_join(media_types, by = "MediaTypeId") %>% count(Name.y) %>% 
    collect %>% mutate(freq = n / sum(n)) %>% filter(grepl('video', Name.y))

#' 
#' 6.  Listar los 10 mejores clientes (aquellos a los que se les ha facturado más cantidad) 
#'     indicando Nombre, Apellidos, Pais y el importe total de su facturación.
#' 

customers %>% inner_join(invoices, by = "CustomerId") %>% group_by(CustomerId) %>% 
    summarise(FirstName, LastName, country, total = sum(Total, na.rm = TRUE)) %>%  
    arrange(desc(total)) %>% head(10) %>% collect

#' 
#' 7.  Listar los géneros musicales por orden decreciente de popularidad 
#'     (definida la popularidad como el número de canciones de ese género), 
#'     indicando el porcentaje de las canciones de ese género.
#' 

tracks %>% inner_join(tbl(chinook, "genres"), by = "GenreId") %>% count(Name.y) %>% 
    arrange(desc(n)) %>% collect %>% mutate(freq = n / sum(n))

#' 
#' 8.  Listar los 10 artistas con mayor número de canciones 
#'     de forma descendente según el número de canciones.
#' 

tracks %>% inner_join(tbl(chinook, "albums"), by = "AlbumId") %>% 
    inner_join(tbl(chinook, "artists"), by = "ArtistId") %>% 
    count(Name.y) %>% arrange(desc(n)) %>% collect

#' 
#' Desconectar la base de datos:
#' 

DBI::dbDisconnect(chinook)            

