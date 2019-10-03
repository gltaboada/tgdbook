#' Manipulación de datos con R
#' ===========================
#'
#' La mayoría de los estudios estadísticos
#' requieren disponer de un conjunto de datos.
#'
#' Lectura, importación y exportación de datos
#' -------------------------------------------
#'
#' Además de la introducción directa, R es capaz de
#' importar datos externos en múltiples formatos:
#'
#' -   bases de datos disponibles en librerías de R
#'
#' -   archivos de texto en formato ASCII
#'
#' -   archivos en otros formatos: Excel, SPSS, ...
#'
#' -   bases de datos relacionales: MySQL, Oracle, ...
#'
#' -   formatos web: HTML, XML, JSON, ...
#'
#' -   ....
#'
#' ### Formato de datos de R
#'
#' El formato de archivo en el que habitualmente se almacena objetos (datos)
#' R es binario y está comprimido (en formato `"gzip"` por defecto).
#' Para cargar un fichero de datos se emplea normalmente [`load()`](https://www.rdocumentation.org/packages/base/versions/3.6.1/topics/load):

res <- load("data/empleados.RData")
res
ls()

#' y para guardar [`save()`](https://www.rdocumentation.org/packages/base/versions/3.6.1/topics/save):

# Guardar
save(empleados, file = "data/empleados_new.RData")

#'
#' Aunque, como indica este comando en la ayuda (`?save`):
#'
#' > For saving single R objects, [`saveRDS()` ](https://www.rdocumentation.org/packages/base/versions/3.6.1/topics/saveRDS)
#' > is mostly preferable to save(),
#' > notably because of the functional nature of readRDS(), as opposed to load().
#'

saveRDS(empleados, file = "data/empleados_new.rds")
## restore it under a different name
empleados2 <- readRDS("data/empleados_new.rds")
identical(empleados, empleados2)

#'
#' El objeto empleado normalmente en R para almacenar datos en memoria
#' es el [`data.frame`](https://www.rdocumentation.org/packages/base/versions/3.6.1/topics/data.frame).'
#'
#' ### Acceso a datos en paquetes
#'
#' R dispone de múltiples conjuntos de datos en distintos paquetes, especialmente en el paquete `datasets`
#' que se carga por defecto al abrir R.
#' Con el comando `data()` podemos obtener un listado de las bases de datos disponibles.
#'
#' Para cargar una base de datos concreta se utiliza el comando
#' `data(nombre)` (aunque en algunos casos se cargan automáticamente al emplearlos).
#' Por ejemplo, `data(cars)` carga la base de datos llamada `cars` en el entorno de trabajo (`".GlobalEnv"`)
#' y `?cars` muestra la ayuda correspondiente con la descripición de la base de datos.
#'
#'
#' ### Lectura de archivos de texto {#cap2-texto}
#'
#' En R para leer archivos de texto se suele utilizar la función `read.table()`.
#' Supóngase, por ejemplo, que en el directorio actual está el fichero
#' *empleados.txt*. La lectura de este fichero vendría dada por el código:
#'

# Session > Set Working Directory > To Source...?
datos <- read.table(file = "data/empleados.txt", header = TRUE)
# head(datos)
str(datos)

#' Si el fichero estuviese en el directorio *c:\\datos* bastaría con especificar
#' `file = "c:/datos/empleados.txt"`.
#' Nótese también que para la lectura del fichero anterior se ha
#' establecido el argumento `header=TRUE` para indicar que la primera línea del
#' fichero contiene los nombres de las variables.
#'
#' Los argumentos utilizados habitualmente para esta función son:
#'
#' -   `header`: indica si el fichero tiene cabecera (`header=TRUE`) o no
#'     (`header=FALSE`). Por defecto toma el valor `header=FALSE`.
#'
#' -   `sep`: carácter separador de columnas que por defecto es un espacio
#'     en blanco (`sep=""`). Otras opciones serían: `sep=","` si el separador es
#'     un ";", `sep="*"` si el separador es un "\*", etc.
#'
#' -   `dec`: carácter utilizado en el fichero para los números decimales.
#'     Por defecto se establece `dec = "."`. Si los decimales vienen dados
#'     por "," se utiliza `dec = ","`
#'
#' Resumiendo, los (principales) argumentos por defecto de la función
#' `read.table` son los que se muestran en la siguiente línea:

# read.table(file, header = FALSE, sep = "", dec = ".")

#' Para más detalles sobre esta función véase
help(read.table)

#' Estan disponibles otras funciones con valores por defecto de los parámetros
#' adecuados para otras situaciones. Por ejemplo, para ficheros separados por tabuladores
#' se puede utilizar `read.delim()` o `read.delim2()`:

# read.delim(file, header = TRUE, sep = "\t", dec = ".")
# read.delim2(file, header = TRUE, sep = "\t", dec = ",")

#'
#' ### Alternativa `tidyverse`
#'
#' Para leer archivos de texto en distintos formatos también se puede emplear el paquete [`readr`](https://readr.tidyverse.org)
#' (colección [`tidyverse`](https://www.tidyverse.org/)), para lo que se recomienda
#' consultar el [Capítulo 11](https://r4ds.had.co.nz/data-import.html) del libro [R for Data Science](http://r4ds.had.co.nz).
#'
#'
#' ### Importación desde SPSS
#'
#' El programa R permite
#' lectura de ficheros de datos en formato SPSS (extensión *.sav*) sin
#' necesidad de tener instalado dicho programa en el ordenador. Para ello
#' se necesita:
#'
#' -   cargar la librería `foreign`
#'
#' -   utilizar la función `read.spss`
#'
#' Por ejemplo:
#'

library(foreign)
datos <- read.spss(file = "data/Employee data.sav", to.data.frame = TRUE)
# head(datos)
str(datos)

#'
#' **Nota**: Si hay fechas, puede ser recomendable emplear la función `spss.get()` del paquete `Hmisc`.
#'
#'
#' ### Importación desde Excel
#'
#' Se pueden leer fichero de
#' Excel (con extensión *.xlsx*) utilizando por ejemplo los paquetes [`openxlsx`](https://cran.r-project.org/web/packages/openxlsx/index.html), [`readxl`](https://readxl.tidyverse.org) (colección [`tidyverse`](https://www.tidyverse.org/)), `XLConnect` o
#' [`RODBC`](https://cran.r-project.org/web/packages/RODBC/index.html) (este paquete se empleará más adelante para acceder a bases de datos),
#' entre otros.
#'
#' Por ejemplo el siguiente código implementa una función que permite leer todos
#' los archivos en formato *.xlsx* en un directorio:
#'

library(openxlsx)

read_xlsx <- function(path = '.') {
  files <- dir(path, pattern = '*.xlsx') # list.files
  # file.list <- lapply(files, readWorkbook)
  file.list <- vector(length(files), mode = 'list')
  for (i in seq_along(files))
      file.list[[i]] <- readWorkbook(files[i])
  file.names <- sub('\\.xlsx$', '', basename(files))
  names(file.list) <- file.names
  file.list
}

#' Para combinar los archivos (suponiendo que tienen las mismas columnas), podríamos ejecutar una llamada a [`rbind()` ](https://www.rdocumentation.org/packages/base/versions/3.6.1/topics/rbind)
#' o emplear la función [`bind_rows()` ](https://www.rdocumentation.org/packages/dplyr/versions/0.7.8/topics/bind)
#' del paquete [`dplyr`](https://dplyr.tidyverse.org):

# df <- do.call('rbind', file.list)

# df <- dplyr::bind_rows(file.list)

#' Sin embargo, un procedimiento sencillo consiste en  exportar los datos desde Excel a un archivo
#' de texto separado por tabuladores (extensión *.csv*).
#' Por ejemplo, supongamos que queremos leer el fichero *coches.xls*:
#'
#' -   Desde Excel se selecciona el menú
#'     `Archivo -> Guardar como -> Guardar como` y en `Tipo` se escoge la opción de
#'     archivo CSV. De esta forma se guardarán los datos en el archivo
#'     *coches.csv*.
#'
#' -   El fichero *coches.csv* es un fichero de texto plano (se puede
#'     editar con Notepad), con cabecera, las columnas separadas por ";", y
#'     siendo "," el carácter decimal.
#'
#' -   Por lo tanto, la lectura de este fichero se puede hacer con:
#'

datos <- read.table("coches.csv", header = TRUE, sep = ";", dec = ",")

#' Otra posibilidad es utilizar la función `read.csv2`, que es
#' una adaptación de la función general `read.table` con las siguientes
#' opciones:

# read.csv2(file, header = TRUE, sep = ";", dec = ",")

#'
#' Por lo tanto, la lectura del fichero *coches.csv* se puede hacer de modo
#' más directo con:

datos <- read.csv2("coches.csv")

#'
#' ### Exportación de datos
#'
#' Puede ser de interés la
#' exportación de datos para que puedan leídos con otros programas. Para
#' ello, se puede emplear la función `write.table()`. Esta función es
#' similar, pero funcionando en sentido inverso, a `read.table()`
#' (Sección \@ref(cap2-texto)).
#'
#' Veamos un ejemplo:

tipo <- c("A", "B", "C")
longitud <- c(120.34, 99.45, 115.67)
datos <- data.frame(tipo, longitud)
datos

#' Para guardar el data.frame `datos` en un fichero de texto se
#' puede utilizar:

write.table(datos, file = "datos.txt")

#' Otra posibilidad es utilizar la función:

write.csv2(datos, file = "datos.csv")

#' que dará lugar al fichero *datos.csv* importable directamente desde Excel.
#'
#'
#' Manipulación de datos
#' ---------------------
#'
#' Una vez cargada una (o varias) bases
#' de datos hay una series de operaciones que serán de interés para el
#' tratamiento de datos:
#'
#' -   Operaciones con variables:
#'     - crear
#'     - recodificar (e.g. categorizar)
#'     - ...
#'
#' -   Operaciones con casos:
#'     - ordenar
#'     - filtrar
#'     - ...
#'
#' -   Operaciones con tablas de datos:
#'     - unir
#'     - combinar
#'     - consultar
#'     - ...
#'
#'
#' A continuación se tratan algunas operaciones *básicas*.
#'
#' ### Operaciones con variables
#'
#' #### Creación (y eliminación) de variables
#'
#' Consideremos de nuevo la
#' base de datos `cars` incluida en el paquete `datasets`:

data(cars)
# str(cars)
head(cars)

#'
#' Utilizando el comando `help(cars)`
#' se obtiene que `cars` es un data.frame con 50 observaciones y dos
#' variables:
#'
#' -   `speed`: Velocidad (millas por hora)
#'
#' -   `dist`: tiempo hasta detenerse (pies)
#'
#' Recordemos que, para acceder a la variable `speed` se puede
#' hacer directamente con su nombre o bien utilizando notación
#' "matricial".

cars$speed
cars[, 1]  # Equivalente

#' Supongamos ahora que queremos transformar la variable original `speed`
#' (millas por hora) en una nueva variable `velocidad` (kilómetros por
#' hora) y añadir esta nueva variable al data.frame `cars`.
#' La transformación que permite pasar millas a kilómetros es
#' `kilómetros=millas/0.62137` que en R se hace directamente con:
#'

cars$speed/0.62137

#'  Finalmente, incluimos la nueva variable que llamaremos
#' `velocidad` en `cars`:

cars$velocidad <- cars$speed / 0.62137
head(cars)


#' También transformaremos la variable `dist` (en pies) en una nueva
#' variable `distancia` (en metros). Ahora la transformación deseada es
#' `metros=pies/3.2808`:

cars$distancia <- cars$dis / 3.2808
head(cars)

#'  Ahora, eliminaremos las variables originales `speed` y
#' `dist`, y guardaremos el data.frame resultante con el nombre `coches`.
#' En primer lugar, veamos varias formas de acceder a las variables de
#' interés:

cars[, c(3, 4)]
cars[, c("velocidad", "distancia")]
cars[, -c(1, 2)]

#' Utilizando alguna de las opciones anteriores se obtiene el `data.frame`
#' deseado:

coches <- cars[, c("velocidad", "distancia")]
# head(coches)
str(coches)

#' Finalmente los datos anteriores podrían ser guardados en un fichero
#' exportable a Excel con el siguiente comando:

write.csv2(coches, file = "coches.csv")

#'
#' ### Operaciones con casos
#'
#' #### Ordenación
#'
#' Continuemos con el data.frame `cars`.
#' Se puede comprobar que los datos disponibles están ordenados por
#' los valores de `speed`. A continuación haremos la ordenación utilizando
#' los valores de `dist`. Para ello utilizaremos el conocido como vector de
#' índices de ordenación.
#' Este vector establece el orden en que tienen que ser elegidos los
#' elementos para obtener la ordenación deseada.
#' Veamos un ejemplo sencillo:

x <- c(2.5, 4.3, 1.2, 3.1, 5.0) # valores originales
ii <- order(x)
ii    # vector de ordenación
x[ii] # valores ordenados

#' En el caso de vectores, el procedimiento anterior se podría
#' hacer directamente con:

sort(x)

#' Sin embargo, para ordenar data.frames será necesario la utilización del
#' vector de índices de ordenación. A continuación, los datos de `cars`
#' ordenados por `dist`:

ii <- order(cars$dist) # Vector de índices de ordenación
cars2 <- cars[ii, ]    # Datos ordenados por dist
head(cars2)

#'
#' #### Filtrado
#'
#' El filtrado de datos consiste en
#' elegir una submuestra que cumpla determinadas condiciones. Para ello se
#' puede utilizar la función [`subset()` ](https://www.rdocumentation.org/packages/base/versions/3.6.1/topics/subset)
#' (que además permite seleccionar variables).
#'
#' A continuación se muestran un par de ejemplos:

subset(cars, dist > 85) # datos con dis>85
subset(cars, speed > 10 & speed < 15 & dist > 45) # speed en (10,15) y dist>45

#' También se pueden hacer el filtrado empleando directamente los
#' correspondientes vectores de índices:

ii <- cars$dist > 85
cars[ii, ]   # dis>85
ii <- cars$speed > 10 & cars$speed < 15 & cars$dist > 45
cars[ii, ]  # speed en (10,15) y dist>45

#' En este caso puede ser de utilidad la función [`which()` ](https://www.rdocumentation.org/packages/base/versions/3.6.1/topics/which):

it <- which(ii)
str(it)
cars[it, 1:2]
# rownames(cars[it, 1:2])

id <- which(!ii)
str(cars[id, 1:2])
# Se podría p.e. emplear cars[id, ] para predecir cars[it, ]$speed
# ?which.min

#'
#' ### Funciones `apply`
#'
#'
#' #### La función `apply`
#'
#' Una forma de evitar la
#' utilización de bucles es utilizando la sentencia `apply` que permite
#' evaluar una misma función en todas las filas, columnas, etc. de un array
#' de forma simultánea.
#'
#' La sintaxis de esta función es:

apply(X, MARGIN, FUN, ...)

#' -   `X`: matriz (o array)
#' -   `MARGIN`: Un vector indicando las dimensiones donde se aplicará
#'     la función. 1 indica filas, 2 indica columnas, y `c(1,2)` indica
#'     filas y columnas.
#' -   `FUN`: función que será aplicada.
#' -   `...`: argumentos opcionales que serán usados por `FUN`.
#'
#' Veamos la utilización de la función `apply` con un ejemplo:

x <- matrix(1:9, nrow = 3)
x
apply(x, 1, sum)    # Suma por filas
apply(x, 2, sum)    # Suma por columnas
apply(x, 2, min)    # Mínimo de las columnas
apply(x, 2, range)  # Rango (mínimo y máximo) de las columnas

#'
#' #### Variantes de la función `apply`
#'
#' [`lapply()`](https://www.rdocumentation.org/packages/base/versions/3.6.1/topics/lapply):
#'

# lista con las medianas de las variables
list <- lapply(cars, median)
str(list)

#'
#' [`sapply()`](https://www.rdocumentation.org/packages/base/versions/3.6.1/topics/sapply):
#'

# matriz con las medias, medianas y desv. de las variables
res <- sapply(cars,
          function(x) c(mean = mean(x), median = median(x), sd = sd(x)))
# str(res)
res
knitr::kable(t(res), digits = 1)

# Función externa

cfuns <- function(x, funs = c(mean, median, sd))
            sapply(funs, function(f) f(x))
x <- 1:10
cfuns(x)
sapply(cars, cfuns)

nfuns <- c("mean", "median", "sd")
sapply(nfuns, function(f) eval(parse(text = paste0(f, "(x)"))))

#'
#' #### La función `tapply`
#'
#' La function [`tapply()`](https://www.rdocumentation.org/packages/base/versions/3.6.1/topics/tapply) es
#' similar a la función `apply()` y permite aplicar una función a los datos desagregados,
#' utilizando como criterio los distintos niveles de una variable factor.
#' La sintaxis de esta función es como sigue:

    tapply(X, INDEX, FUN, ...,)

#' -   `X`: matriz (o array).
#' -   `INDEX`: factor indicando los grupos (niveles).
#' -   `FUN`: función que será aplicada.
#' -   `...`: argumentos opcionales .
#'
#' Consideremos, por ejemplo, el data.frame `ChickWeight` con datos de un
#' experimento relacionado con la repercusión de varias dietas en el peso
#' de pollos.

data(ChickWeight)
# str(ChickWeight)
head(ChickWeight)
peso <- ChickWeight$weight
dieta <- ChickWeight$Diet
levels(dieta) <- c("Dieta 1", "Dieta 2", "Dieta 3", "Dieta 4")
tapply(peso, dieta, mean)  # Peso medio por dieta
tapply(peso, dieta, summary)

#' Otro ejemplo:

provincia <- as.factor(c(1, 3, 4, 2, 4, 3, 2, 1, 4, 3, 2))
levels(provincia) = c("A Coruña", "Lugo", "Orense", "Pontevedra")
hijos <- c(1, 2, 0, 3, 4, 1, 0, 0, 2, 3, 1)
data.frame(provincia, hijos)
tapply(hijos, provincia, mean) # Número medio de hijos por provincia

#'
#' ### Operaciones con tablas de datos
#'
#' Ver ejemplo [*wosdata.zip*](data/wosdata.zip)
#'
#' ***Unir tablas***:
#'
#' [`rbind()` ](https://www.rdocumentation.org/packages/base/versions/3.6.1/topics/rbind)
#'
#' [`cbind()` ](https://www.rdocumentation.org/packages/base/versions/3.6.1/topics/cbind)
#'
#' ***Combinar tablas***:
#'
#' [`match()`](https://www.rdocumentation.org/packages/base/versions/3.6.1/topics/match)
#'
#' [`pmatch()`](https://www.rdocumentation.org/packages/base/versions/3.6.1/topics/match)
#'
#' ## Ejemplo WoS data
#'

# library(dplyr)
# library(stringr)
# Session > Set Working Directory > To Source...
# source("data/wosdata/rwos.R")

db <- readRDS("data/wosdata/db_udc_2015.rds")

#' Documentos correspondientes a revistas:

# View(db$Journals)
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
