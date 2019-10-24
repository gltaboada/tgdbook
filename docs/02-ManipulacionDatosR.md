Manipulación de datos con R
===========================




La mayoría de los estudios estadísticos
requieren disponer de un conjunto de datos. 

Lectura, importación y exportación de datos
-------------------------------------------

Además de la introducción directa, R es capaz de
importar datos externos en múltiples formatos:

-   bases de datos disponibles en librerías de R

-   archivos de texto en formato ASCII

-   archivos en otros formatos: Excel, SPSS, ...

-   bases de datos relacionales: MySQL, Oracle, ...

-   formatos web: HTML, XML, JSON, ...

-   ....

### Formato de datos de R

El formato de archivo en el que habitualmente se almacena objetos (datos)
R es binario y está comprimido (en formato `"gzip"` por defecto).
Para cargar un fichero de datos se emplea normalmente [`load()`](https://www.rdocumentation.org/packages/base/versions/3.6.1/topics/load):

```r
res <- load("data/empleados.RData")
res
```

```
## [1] "empleados"
```

```r
ls()
```

```
##  [1] "citefig"   "citefig2"  "empleados" "fig.path"  "inline"   
##  [6] "inline2"   "is_html"   "is_latex"  "latexfig"  "latexfig2"
## [11] "res"
```
y para guardar [`save()`](https://www.rdocumentation.org/packages/base/versions/3.6.1/topics/save):

```r
# Guardar
save(empleados, file = "data/empleados_new.RData")
```

Aunque, como indica este comando en la ayuda (`?save`):

> For saving single R objects, [`saveRDS()` ](https://www.rdocumentation.org/packages/base/versions/3.6.1/topics/saveRDS) 
> is mostly preferable to save(), 
> notably because of the functional nature of readRDS(), as opposed to load(). 


```r
saveRDS(empleados, file = "data/empleados_new.rds")
## restore it under a different name
empleados2 <- readRDS("data/empleados_new.rds")
# identical(empleados, empleados2)
```

El objeto empleado normalmente en R para almacenar datos en memoria 
es el [`data.frame`](https://www.rdocumentation.org/packages/base/versions/3.6.1/topics/data.frame).


### Acceso a datos en paquetes

R dispone de múltiples conjuntos de datos en distintos paquetes, especialmente en el paquete `datasets` 
que se carga por defecto al abrir R. 
Con el comando `data()` podemos obtener un listado de las bases de datos disponibles.

Para cargar una base de datos concreta se utiliza el comando
`data(nombre)` (aunque en algunos casos se cargan automáticamente al emplearlos). 
Por ejemplo, `data(cars)` carga la base de datos llamada `cars` en el entorno de trabajo (`".GlobalEnv"`)
y `?cars` muestra la ayuda correspondiente con la descripición de la base de datos.


### Lectura de archivos de texto {#cap2-texto}

En R para leer archivos de texto se suele utilizar la función `read.table()`.
Supóngase, por ejemplo, que en el directorio actual está el fichero
*empleados.txt*. La lectura de este fichero vendría dada por el código:


```r
# Session > Set Working Directory > To Source...?
datos <- read.table(file = "data/empleados.txt", header = TRUE)
# head(datos)
str(datos)
```

```
## 'data.frame':	474 obs. of  10 variables:
##  $ id      : int  1 2 3 4 5 6 7 8 9 10 ...
##  $ sexo    : Factor w/ 2 levels "Hombre","Mujer": 1 1 2 2 1 1 1 2 2 2 ...
##  $ fechnac : Factor w/ 462 levels " ","1/10/1964",..: 166 275 362 228 176 397 240 290 36 143 ...
##  $ educ    : int  15 16 12 8 15 15 15 12 15 12 ...
##  $ catlab  : Factor w/ 3 levels "Administrativo",..: 2 1 1 1 1 1 1 1 1 1 ...
##  $ salario : num  57000 40200 21450 21900 45000 ...
##  $ salini  : int  27000 18750 12000 13200 21000 13500 18750 9750 12750 13500 ...
##  $ tiempemp: int  98 98 98 98 98 98 98 98 98 98 ...
##  $ expprev : int  144 36 381 190 138 67 114 0 115 244 ...
##  $ minoria : Factor w/ 2 levels "No","Sí": 1 1 1 1 1 1 1 1 1 1 ...
```
Si el fichero estuviese en el directorio *c:\\datos* bastaría con especificar
`file = "c:/datos/empleados.txt"`.
Nótese también que para la lectura del fichero anterior se ha
establecido el argumento `header=TRUE` para indicar que la primera línea del
fichero contiene los nombres de las variables.

Los argumentos utilizados habitualmente para esta función son:

-   `header`: indica si el fichero tiene cabecera (`header=TRUE`) o no
    (`header=FALSE`). Por defecto toma el valor `header=FALSE`.

-   `sep`: carácter separador de columnas que por defecto es un espacio
    en blanco (`sep=""`). Otras opciones serían: `sep=","` si el separador es
    un ";", `sep="*"` si el separador es un "\*", etc.

-   `dec`: carácter utilizado en el fichero para los números decimales.
    Por defecto se establece `dec = "."`. Si los decimales vienen dados
    por "," se utiliza `dec = ","`

Resumiendo, los (principales) argumentos por defecto de la función
`read.table` son los que se muestran en la siguiente línea:


```r
read.table(file, header = FALSE, sep = "", dec = ".")  
```

Para más detalles sobre esta función véase
`help(read.table)`.

Estan disponibles otras funciones con valores por defecto de los parámetros 
adecuados para otras situaciones. Por ejemplo, para ficheros separados por tabuladores 
se puede utilizar `read.delim()` o `read.delim2()`:

```r
read.delim(file, header = TRUE, sep = "\t", dec = ".")
read.delim2(file, header = TRUE, sep = "\t", dec = ",")
```

### Alternativa `tidyverse`

Para leer archivos de texto en distintos formatos también se puede emplear el paquete [`readr`](https://readr.tidyverse.org) 
(colección [`tidyverse`](https://www.tidyverse.org/)), para lo que se recomienda
consultar el [Capítulo 11](https://r4ds.had.co.nz/data-import.html) del libro [R for Data Science](http://r4ds.had.co.nz).


### Importación desde SPSS

El programa R permite
lectura de ficheros de datos en formato SPSS (extensión *.sav*) sin
necesidad de tener instalado dicho programa en el ordenador. Para ello
se necesita:

-   cargar la librería `foreign`

-   utilizar la función `read.spss`

Por ejemplo:


```r
library(foreign)
datos <- read.spss(file = "data/Employee data.sav", to.data.frame = TRUE)
# head(datos)
str(datos)
```

```
## 'data.frame':	474 obs. of  10 variables:
##  $ id      : num  1 2 3 4 5 6 7 8 9 10 ...
##  $ sexo    : Factor w/ 2 levels "Hombre","Mujer": 1 1 2 2 1 1 1 2 2 2 ...
##  $ fechnac : num  1.17e+10 1.19e+10 1.09e+10 1.15e+10 1.17e+10 ...
##  $ educ    : Factor w/ 10 levels "8","12","14",..: 4 5 2 1 4 4 4 2 4 2 ...
##  $ catlab  : Factor w/ 3 levels "Administrativo",..: 3 1 1 1 1 1 1 1 1 1 ...
##  $ salario : Factor w/ 221 levels "15750","15900",..: 179 137 28 31 150 101 121 31 71 45 ...
##  $ salini  : Factor w/ 90 levels "9000","9750",..: 60 42 13 21 48 23 42 2 18 23 ...
##  $ tiempemp: Factor w/ 36 levels "63","64","65",..: 36 36 36 36 36 36 36 36 36 36 ...
##  $ expprev : Factor w/ 208 levels "Ausente","10",..: 38 131 139 64 34 181 13 1 14 91 ...
##  $ minoria : Factor w/ 2 levels "No","Sí": 1 1 1 1 1 1 1 1 1 1 ...
##  - attr(*, "variable.labels")= Named chr  "Código de empleado" "Sexo" "Fecha de nacimiento" "Nivel educativo" ...
##   ..- attr(*, "names")= chr  "id" "sexo" "fechnac" "educ" ...
##  - attr(*, "codepage")= int 1252
```

**Nota**: Si hay fechas, puede ser recomendable emplear la función `spss.get()` del paquete `Hmisc`.


### Importación desde Excel

Se pueden leer fichero de
Excel (con extensión *.xlsx*) utilizando por ejemplo los paquetes [`openxlsx`](https://cran.r-project.org/web/packages/openxlsx/index.html), [`readxl`](https://readxl.tidyverse.org) (colección [`tidyverse`](https://www.tidyverse.org/)), `XLConnect` o 
[`RODBC`](https://cran.r-project.org/web/packages/RODBC/index.html) (este paquete se empleará más adelante para acceder a bases de datos),
entre otros.

Por ejemplo el siguiente código implementa una función que permite leer todos
los archivos en formato *.xlsx* en un directorio:


```r
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
```

Para combinar los archivos (suponiendo que tienen las mismas columnas), podríamos ejecutar una llamada a [`rbind()` ](https://www.rdocumentation.org/packages/base/versions/3.6.1/topics/rbind)
o emplear la función [`bind_rows()` ](https://www.rdocumentation.org/packages/dplyr/versions/0.7.8/topics/bind)
del paquete [`dplyr`](https://dplyr.tidyverse.org):


```r
df <- do.call('rbind', file.list)

df <- dplyr::bind_rows(file.list)
```

Sin embargo, un procedimiento sencillo consiste en  exportar los datos desde Excel a un archivo
de texto separado por tabuladores (extensión *.csv*).
Por ejemplo, supongamos que queremos leer el fichero *coches.xls*:

-   Desde Excel se selecciona el menú
    `Archivo -> Guardar como -> Guardar como` y en `Tipo` se escoge la opción de
    archivo CSV. De esta forma se guardarán los datos en el archivo
    *coches.csv*.

-   El fichero *coches.csv* es un fichero de texto plano (se puede
    editar con Notepad), con cabecera, las columnas separadas por ";", y
    siendo "," el carácter decimal.

-   Por lo tanto, la lectura de este fichero se puede hacer con:

    
    ```r
    datos <- read.table("coches.csv", header = TRUE, sep = ";", dec = ",")
    ```

Otra posibilidad es utilizar la función `read.csv2`, que es
una adaptación de la función general `read.table` con las siguientes
opciones:

```r
read.csv2(file, header = TRUE, sep = ";", dec = ",")
```

Por lo tanto, la lectura del fichero *coches.csv* se puede hacer de modo
más directo con:

```r
datos <- read.csv2("coches.csv")
```

### Exportación de datos

Puede ser de interés la
exportación de datos para que puedan leídos con otros programas. Para
ello, se puede emplear la función `write.table()`. Esta función es
similar, pero funcionando en sentido inverso, a `read.table()` 
(Sección \@ref(cap2-texto)).

Veamos un ejemplo:


```r
tipo <- c("A", "B", "C")
longitud <- c(120.34, 99.45, 115.67)
datos <- data.frame(tipo, longitud)
datos
```

```
##   tipo longitud
## 1    A   120.34
## 2    B    99.45
## 3    C   115.67
```
Para guardar el data.frame `datos` en un fichero de texto se
puede utilizar:

```r
write.table(datos, file = "datos.txt")
```
Otra posibilidad es utilizar la función:

```r
write.csv2(datos, file = "datos.csv")
```
que dará lugar al fichero *datos.csv* importable directamente desde Excel.


Manipulación de datos
---------------------

Una vez cargada una (o varias) bases
de datos hay una series de operaciones que serán de interés para el
tratamiento de datos: 

-   Operaciones con variables: 
    - crear
    - recodificar (e.g. categorizar)
    - ...

-   Operaciones con casos:
    - ordenar
    - filtrar
    - ...

-   Operaciones con tablas de datos:
    - unir
    - combinar
    - consultar
    - ...


A continuación se tratan algunas operaciones *básicas*.

### Operaciones con variables

#### Creación (y eliminación) de variables

Consideremos de nuevo la
base de datos `cars` incluida en el paquete `datasets`:

```r
data(cars)
# str(cars)
head(cars)
```

```
##   speed dist
## 1     4    2
## 2     4   10
## 3     7    4
## 4     7   22
## 5     8   16
## 6     9   10
```

Utilizando el comando `help(cars)`
se obtiene que `cars` es un data.frame con 50 observaciones y dos
variables:

-   `speed`: Velocidad (millas por hora)

-   `dist`: tiempo hasta detenerse (pies)

Recordemos que, para acceder a la variable `speed` se puede
hacer directamente con su nombre o bien utilizando notación
"matricial".

```r
cars$speed
```

```
##  [1]  4  4  7  7  8  9 10 10 10 11 11 12 12 12 12 13 13 13 13 14 14 14 14
## [24] 15 15 15 16 16 17 17 17 18 18 18 18 19 19 19 20 20 20 20 20 22 23 24
## [47] 24 24 24 25
```

```r
cars[, 1]  # Equivalente
```

```
##  [1]  4  4  7  7  8  9 10 10 10 11 11 12 12 12 12 13 13 13 13 14 14 14 14
## [24] 15 15 15 16 16 17 17 17 18 18 18 18 19 19 19 20 20 20 20 20 22 23 24
## [47] 24 24 24 25
```
Supongamos ahora que queremos transformar la variable original `speed`
(millas por hora) en una nueva variable `velocidad` (kilómetros por
hora) y añadir esta nueva variable al data.frame `cars`.
La transformación que permite pasar millas a kilómetros es
`kilómetros=millas/0.62137` que en R se hace directamente con:


```r
cars$speed/0.62137
```

 Finalmente, incluimos la nueva variable que llamaremos
`velocidad` en `cars`:

```r
cars$velocidad <- cars$speed / 0.62137
head(cars)
```

```
##   speed dist velocidad
## 1     4    2  6.437388
## 2     4   10  6.437388
## 3     7    4 11.265430
## 4     7   22 11.265430
## 5     8   16 12.874777
## 6     9   10 14.484124
```

También transformaremos la variable `dist` (en pies) en una nueva
variable `distancia` (en metros). Ahora la transformación deseada es
`metros=pies/3.2808`:


```r
cars$distancia <- cars$dis / 3.2808
head(cars)
```

```
##   speed dist velocidad distancia
## 1     4    2  6.437388 0.6096074
## 2     4   10  6.437388 3.0480371
## 3     7    4 11.265430 1.2192148
## 4     7   22 11.265430 6.7056815
## 5     8   16 12.874777 4.8768593
## 6     9   10 14.484124 3.0480371
```

 Ahora, eliminaremos las variables originales `speed` y
`dist`, y guardaremos el data.frame resultante con el nombre `coches`.
En primer lugar, veamos varias formas de acceder a las variables de
interés:

```r
cars[, c(3, 4)]
cars[, c("velocidad", "distancia")]
cars[, -c(1, 2)]
```

Utilizando alguna de las opciones anteriores se obtiene el `data.frame`
deseado:

```r
coches <- cars[, c("velocidad", "distancia")]
# head(coches)
str(coches)
```

```
## 'data.frame':	50 obs. of  2 variables:
##  $ velocidad: num  6.44 6.44 11.27 11.27 12.87 ...
##  $ distancia: num  0.61 3.05 1.22 6.71 4.88 ...
```

Finalmente los datos anteriores podrían ser guardados en un fichero
exportable a Excel con el siguiente comando:

```r
write.csv2(coches, file = "coches.csv")
```

### Operaciones con casos

#### Ordenación

Continuemos con el data.frame `cars`. 
Se puede comprobar que los datos disponibles están ordenados por
los valores de `speed`. A continuación haremos la ordenación utilizando
los valores de `dist`. Para ello utilizaremos el conocido como vector de
índices de ordenación.
Este vector establece el orden en que tienen que ser elegidos los
elementos para obtener la ordenación deseada. 
Veamos un ejemplo sencillo:

```r
x <- c(2.5, 4.3, 1.2, 3.1, 5.0) # valores originales
ii <- order(x)
ii    # vector de ordenación
```

```
## [1] 3 1 4 2 5
```

```r
x[ii] # valores ordenados
```

```
## [1] 1.2 2.5 3.1 4.3 5.0
```
En el caso de vectores, el procedimiento anterior se podría
hacer directamente con: 

```r
sort(x)
```

Sin embargo, para ordenar data.frames será necesario la utilización del
vector de índices de ordenación. A continuación, los datos de `cars`
ordenados por `dist`:

```r
ii <- order(cars$dist) # Vector de índices de ordenación
cars2 <- cars[ii, ]    # Datos ordenados por dist
head(cars2)
```

```
##    speed dist velocidad distancia
## 1      4    2  6.437388 0.6096074
## 3      7    4 11.265430 1.2192148
## 2      4   10  6.437388 3.0480371
## 6      9   10 14.484124 3.0480371
## 12    12   14 19.312165 4.2672519
## 5      8   16 12.874777 4.8768593
```

#### Filtrado

El filtrado de datos consiste en
elegir una submuestra que cumpla determinadas condiciones. Para ello se
puede utilizar la función [`subset()` ](https://www.rdocumentation.org/packages/base/versions/3.6.1/topics/subset) 
(que además permite seleccionar variables).

A continuación se muestran un par de ejemplos:

```r
subset(cars, dist > 85) # datos con dis>85
```

```
##    speed dist velocidad distancia
## 47    24   92  38.62433  28.04194
## 48    24   93  38.62433  28.34674
## 49    24  120  38.62433  36.57644
```

```r
subset(cars, speed > 10 & speed < 15 & dist > 45) # speed en (10,15) y dist>45
```

```
##    speed dist velocidad distancia
## 19    13   46  20.92151  14.02097
## 22    14   60  22.53086  18.28822
## 23    14   80  22.53086  24.38430
```

También se pueden hacer el filtrado empleando directamente los
correspondientes vectores de índices:


```r
ii <- cars$dist > 85
cars[ii, ]   # dis>85
```

```
##    speed dist velocidad distancia
## 47    24   92  38.62433  28.04194
## 48    24   93  38.62433  28.34674
## 49    24  120  38.62433  36.57644
```

```r
ii <- cars$speed > 10 & cars$speed < 15 & cars$dist > 45
cars[ii, ]  # speed en (10,15) y dist>45
```

```
##    speed dist velocidad distancia
## 19    13   46  20.92151  14.02097
## 22    14   60  22.53086  18.28822
## 23    14   80  22.53086  24.38430
```

En este caso puede ser de utilidad la función [`which()` ](https://www.rdocumentation.org/packages/base/versions/3.6.1/topics/which):


```r
it <- which(ii)
str(it)
```

```
##  int [1:3] 19 22 23
```

```r
cars[it, 1:2]
```

```
##    speed dist
## 19    13   46
## 22    14   60
## 23    14   80
```

```r
# rownames(cars[it, 1:2])

id <- which(!ii)
str(cars[id, 1:2])
```

```
## 'data.frame':	47 obs. of  2 variables:
##  $ speed: num  4 4 7 7 8 9 10 10 10 11 ...
##  $ dist : num  2 10 4 22 16 10 18 26 34 17 ...
```

```r
# Se podría p.e. emplear cars[id, ] para predecir cars[it, ]$speed
# ?which.min
```

### Funciones `apply`


#### La función `apply`

Una forma de evitar la
utilización de bucles es utilizando la sentencia `apply` que permite
evaluar una misma función en todas las filas, columnas, etc. de un array
de forma simultánea.

La sintaxis de esta función es:

```r
apply(X, MARGIN, FUN, ...)
```
-   `X`: matriz (o array)
-   `MARGIN`: Un vector indicando las dimensiones donde se aplicará
    la función. 1 indica filas, 2 indica columnas, y `c(1,2)` indica
    filas y columnas.
-   `FUN`: función que será aplicada.
-   `...`: argumentos opcionales que serán usados por `FUN`.

Veamos la utilización de la función `apply` con un ejemplo:

```r
x <- matrix(1:9, nrow = 3)
x
```

```
##      [,1] [,2] [,3]
## [1,]    1    4    7
## [2,]    2    5    8
## [3,]    3    6    9
```

```r
apply(x, 1, sum)    # Suma por filas
```

```
## [1] 12 15 18
```

```r
apply(x, 2, sum)    # Suma por columnas
```

```
## [1]  6 15 24
```

```r
apply(x, 2, min)    # Mínimo de las columnas
```

```
## [1] 1 4 7
```

```r
apply(x, 2, range)  # Rango (mínimo y máximo) de las columnas
```

```
##      [,1] [,2] [,3]
## [1,]    1    4    7
## [2,]    3    6    9
```

#### Variantes de la función `apply`

[`lapply()`](https://www.rdocumentation.org/packages/base/versions/3.6.1/topics/lapply):


```r
# lista con las medianas de las variables
list <- lapply(cars, median)
str(list)
```

```
## List of 4
##  $ speed    : num 15
##  $ dist     : num 36
##  $ velocidad: num 24.1
##  $ distancia: num 11
```

[`sapply()`](https://www.rdocumentation.org/packages/base/versions/3.6.1/topics/sapply):


```r
# matriz con las medias, medianas y desv. de las variables
res <- sapply(cars, 
          function(x) c(mean = mean(x), median = median(x), sd = sd(x)))
# str(res)
res
```

```
##            speed     dist velocidad distancia
## mean   15.400000 42.98000 24.783945 13.100463
## median 15.000000 36.00000 24.140206 10.972933
## sd      5.287644 25.76938  8.509655  7.854602
```

```r
knitr::kable(t(res), digits = 1)
```


\begin{tabular}{l|r|r|r}
\hline
  & mean & median & sd\\
\hline
speed & 15.4 & 15.0 & 5.3\\
\hline
dist & 43.0 & 36.0 & 25.8\\
\hline
velocidad & 24.8 & 24.1 & 8.5\\
\hline
distancia & 13.1 & 11.0 & 7.9\\
\hline
\end{tabular}



```r
cfuns <- function(x, funs = c(mean, median, sd))
            sapply(funs, function(f) f(x))
x <- 1:10
cfuns(x)
```

```
## [1] 5.50000 5.50000 3.02765
```

```r
sapply(cars, cfuns)
```

```
##          speed     dist velocidad distancia
## [1,] 15.400000 42.98000 24.783945 13.100463
## [2,] 15.000000 36.00000 24.140206 10.972933
## [3,]  5.287644 25.76938  8.509655  7.854602
```

```r
nfuns <- c("mean", "median", "sd")
sapply(nfuns, function(f) eval(parse(text = paste0(f, "(x)"))))
```

```
##    mean  median      sd 
## 5.50000 5.50000 3.02765
```

<!-- 
añadir nombres a cfuns 
cfuns <- function(x, funs = c(mean, median, sd)){
  # nfuns <- deparse(substitute(funs))
  res <- sapply(funs, function(f) f(x))
  names(res) <- nfuns
  return(res)
}

-->

#### La función `tapply`

La function [`tapply()`](https://www.rdocumentation.org/packages/base/versions/3.6.1/topics/tapply) es
similar a la función `apply()` y permite aplicar una función a los datos desagregados,
utilizando como criterio los distintos niveles de una variable factor. 
La sintaxis de esta función es como sigue:

```r
    tapply(X, INDEX, FUN, ...,)
```
-   `X`: matriz (o array).
-   `INDEX`: factor indicando los grupos (niveles).
-   `FUN`: función que será aplicada.
-   `...`: argumentos opcionales .

Consideremos, por ejemplo, el data.frame `ChickWeight` con datos de un
experimento relacionado con la repercusión de varias dietas en el peso
de pollos.

```r
data(ChickWeight)
# str(ChickWeight)
head(ChickWeight)
```

```
##   weight Time Chick Diet
## 1     42    0     1    1
## 2     51    2     1    1
## 3     59    4     1    1
## 4     64    6     1    1
## 5     76    8     1    1
## 6     93   10     1    1
```

```r
peso <- ChickWeight$weight
dieta <- ChickWeight$Diet
levels(dieta) <- c("Dieta 1", "Dieta 2", "Dieta 3", "Dieta 4")
tapply(peso, dieta, mean)  # Peso medio por dieta
```

```
##  Dieta 1  Dieta 2  Dieta 3  Dieta 4 
## 102.6455 122.6167 142.9500 135.2627
```

```r
tapply(peso, dieta, summary)
```

```
## $`Dieta 1`
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   35.00   57.75   88.00  102.65  136.50  305.00 
## 
## $`Dieta 2`
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##    39.0    65.5   104.5   122.6   163.0   331.0 
## 
## $`Dieta 3`
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##    39.0    67.5   125.5   142.9   198.8   373.0 
## 
## $`Dieta 4`
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   39.00   71.25  129.50  135.26  184.75  322.00
```

Otro ejemplo:

```r
provincia <- as.factor(c(1, 3, 4, 2, 4, 3, 2, 1, 4, 3, 2))
levels(provincia) = c("A Coruña", "Lugo", "Orense", "Pontevedra")
hijos <- c(1, 2, 0, 3, 4, 1, 0, 0, 2, 3, 1)
data.frame(provincia, hijos)
```

```
##     provincia hijos
## 1    A Coruña     1
## 2      Orense     2
## 3  Pontevedra     0
## 4        Lugo     3
## 5  Pontevedra     4
## 6      Orense     1
## 7        Lugo     0
## 8    A Coruña     0
## 9  Pontevedra     2
## 10     Orense     3
## 11       Lugo     1
```

```r
tapply(hijos, provincia, mean) # Número medio de hijos por provincia
```

```
##   A Coruña       Lugo     Orense Pontevedra 
##   0.500000   1.333333   2.000000   2.000000
```

### Operaciones con tablas de datos

Ver ejemplo [*wosdata.R*](data/wosdata.zip)

***Unir tablas***:

[`rbind()` ](https://www.rdocumentation.org/packages/base/versions/3.6.1/topics/rbind)

[`cbind()` ](https://www.rdocumentation.org/packages/base/versions/3.6.1/topics/cbind)

***Combinar tablas***:

[`match()`](https://www.rdocumentation.org/packages/base/versions/3.6.1/topics/match)

`match(x, table)` devuelve un vector (de la misma longitud que `x`) 
con las (primeras) posiciones de coincidencia de `x` en `table`
(o `NA`, por defecto, si no hay coincidencia).
Para combinar tablas puede ser más cómodo el operador `%in%` (`?'%in%'`).

[`pmatch()`](https://www.rdocumentation.org/packages/base/versions/3.6.1/topics/match)


