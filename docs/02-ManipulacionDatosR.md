# Manipulación de datos con R {#manipR}







En el proceso de análisis de datos, al margen de su obtención y organización, una de las primeras etapas es el acceso y la manipulación de los datos (ver Figura \@ref(fig:esquema2)).
En este capítulo se repasarán brevemente las principales herramientas disponibles en el paquete base de R para ello.
Posteriormente en el Capítulo \@ref(tidyverse) se mostrará como alternativa el uso del paquete [`dplyr`](https://dplyr.tidyverse.org/index.html).

\begin{figure}[!htb]

{\centering \includegraphics[width=0.8\linewidth]{images/esquema2} 

}

\caption{Etapas del proceso}(\#fig:esquema2)
\end{figure}



## Lectura, importación y exportación de datos {#read}


Además de la introducción directa, R es capaz de
importar datos externos en múltiples formatos:

-   bases de datos disponibles en librerías de R

-   archivos de texto en formato ASCII

-   archivos en otros formatos: Excel, SPSS, Matlab...

-   bases de datos relacionales: MySQL, Oracle...

-   formatos web: HTML, XML, JSON...

-   otros lenguajes de programación: Python, Julia...

### Formato de datos de R

El formato de archivo en el que habitualmente se almacena objetos (datos)
R es binario y está comprimido (en formato `"gzip"` por defecto).
Para cargar un fichero de datos se emplea normalmente [`load()`](https://www.rdocumentation.org/packages/base/versions/3.6.1/topics/load).
A continuación se utiliza el fichero `empleados.RData` que contiene datos de empleados de un banco.


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
##  [1] "cite_cran" "cite_fig"  "cite_fig2" "cite_fun" 
##  [5] "cite_fun_" "cite_pkg"  "cite_pkg_" "citefig"  
##  [9] "citefig2"  "empleados" "fig.path"  "inline"   
## [13] "inline2"   "is_html"   "is_latex"  "latexfig" 
## [17] "latexfig2" "res"
```
y para guardar [`save()`](https://www.rdocumentation.org/packages/base/versions/3.6.1/topics/save):

```r
# Guardar
save(empleados, file = "data/empleados_new.RData")
```

Aunque, como indica este comando en la ayuda (`?save`):

> *For saving single R objects, [`saveRDS()` ](https://www.rdocumentation.org/packages/base/versions/3.6.1/topics/saveRDS)* 
> *is mostly preferable to save(),* 
> *notably because of the functional nature of readRDS(), as opposed to load().*


```r
saveRDS(empleados, file = "data/empleados_new.rds")
## restore it under a different name
empleados2 <- readRDS("data/empleados_new.rds")
# identical(empleados, empleados2)
```

Normalmente, el objeto empleado en R para almacenar datos en memoria 
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

En R, para leer archivos de texto se suele utilizar la función `read.table()`.
Suponinedo, por ejemplo, que en el directorio actual está el fichero
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
##  $ sexo    : chr  "Hombre" "Hombre" "Mujer" "Mujer" ...
##  $ fechnac : chr  "2/3/1952" "5/23/1958" "7/26/1929" "4/15/1947" ...
##  $ educ    : int  15 16 12 8 15 15 15 12 15 12 ...
##  $ catlab  : chr  "Directivo" "Administrativo" "Administrativo" "Administrativo" ...
##  $ salario : num  57000 40200 21450 21900 45000 ...
##  $ salini  : int  27000 18750 12000 13200 21000 13500 18750 9750 12750 13500 ...
##  $ tiempemp: int  98 98 98 98 98 98 98 98 98 98 ...
##  $ expprev : int  144 36 381 190 138 67 114 0 115 244 ...
##  $ minoria : chr  "No" "No" "No" "No" ...
```

```r
class(datos)
```

```
## [1] "data.frame"
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
    por "," se utiliza `dec = ","`.

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


### Importación desde SPSS

El programa R permite lectura de ficheros de datos en formato SPSS (extensión *.sav*) sin necesidad de tener instalado dicho programa en el ordenador. Para ello se necesita:

-   cargar la librería `foreign`

-   utilizar la función `read.spss`

Por ejemplo:

\small



```r
library(foreign)
datos <- read.spss(file = "data/Employee data.sav", 
                   to.data.frame = TRUE)
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
##  - attr(*, "variable.labels")= Named chr [1:10] "Código de empleado" "Sexo" "Fecha de nacimiento" "Nivel educativo" ...
##   ..- attr(*, "names")= chr [1:10] "id" "sexo" "fechnac" "educ" ...
##  - attr(*, "codepage")= int 1252
```
\normalsize



**Nota**: Si hay fechas, puede ser recomendable emplear la función `spss.get()` del paquete `Hmisc`.


### Importación desde Excel

Se pueden leer fichero de Excel (con extensión *.xlsx*) utilizando, por ejemplo, los paquetes:

+ [`openxlsx`](https://cran.r-project.org/web/packages/openxlsx/index.html), 


```r
library(openxlsx)
datos<-read.xlsx("./data/coches.xlsx")
class(datos)
```

```
## [1] "data.frame"
```


+ [`RODBC`](https://cran.r-project.org/web/packages/RODBC/index.html) (este paquete se empleará más adelante para acceder a bases de datos),
entre otros.

El siguiente código implementa una función que permite leer todos
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

Para combinar los archivos, suponiendo que tienen las mismas columnas, podríamos ejecutar una llamada a [`rbind()` ](https://www.rdocumentation.org/packages/base/versions/3.6.1/topics/rbind)(R base):

```r
df <- do.call('rbind', file.list)
```
o emplear la función [`bind_rows()` ](https://www.rdocumentation.org/packages/dplyr/versions/0.7.8/topics/bind)
del paquete [`dplyr`](https://dplyr.tidyverse.org), donde las columnas se emparejan por nombre, y cualquier columna que falte se rellenará con `NA`:


```r
df <- dplyr::bind_rows(file.list)
```
El Capítulo 4, provee de otras utilidades  para la manipulación de datos con `dplyr` [@R-dplyr]. 



Los datos cargados en R (usualmente un `data.frame`) se pueden exportar desde Excel fácilmente a un archivo de texto *separado por comas* (extensión *.csv*), evitando utilizar algunos de los paquetes mencionados anteriormente.
Por ejemplo, supongamos que queremos leer el fichero *coches.xls*:

-   Desde Excel, se selecciona el menú `Archivo -> Guardar como -> Guardar como`, y en `Tipo`, se escoge la opción de archivo CSV. De esta forma se guardarán los datos en el archivo *coches.csv*.

-   El fichero *coches.csv* es un fichero de texto plano (se puede
    editar con el bloc de notas, *Notepad*), con cabecera, las columnas separadas por ";", y siendo "," el carácter decimal.

-   Por lo tanto, la lectura de este fichero se puede hacer con:

    
    ```r
    datos <- read.table("coches.csv", header = TRUE, 
                        sep = ";", dec = ",")
    ```

Otra posibilidad, es utilizar la función `read.csv2`. Esta función no es más que una adaptación de la función general `read.table` con las siguientes
opciones:

```r
read.csv2(file, header = TRUE, sep = ";", dec = ",", ...)
```

Por lo tanto, la lectura del fichero *coches.csv* se puede hacer de modo
más directo con:

```r
datos <- read.csv2("coches.csv")
```

Esta forma de proceder, exportando a formato CSV, se puede emplear con otras hojas de cálculo o fuentes de datos. 
Hay que tener en cuenta que si estas fuentes emplean el formato anglosajón, el separador de campos será `sep = ","` y el de decimales `dec = "."`, las opciones por defecto en la función `read.csv()`.


### Exportación de datos  {#cap2-exporta}

Puede ser de interés la exportacifn de datos para que puedan ser leídos con otros programas. Para ello, se puede emplear la función `write.table()`. Esta función es similar, pero funcionando en sentido inverso, a `read.table()`, ver Sección \@ref(cap2-texto).

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
que dará lugar al fichero *datos.csv* importable directamente desde Excel. Las opciones anteriores sólo dependen del paquete `utils`, que se instala por defecto con R base.



### Python, Julia y otros lenguajes de programación
R es un lenguaje de programación libre (derivado del lenguaje S  en  los Laboratorios Bell) que se caracteriza por su capacidad para interactuar con otros lenguajes de programación, incluyendo Python [@python] y Julia [@julia]. 

En el ámbito de la Estadística (como en la denominada **Ciendica de Datos**), R destaca por su extensa y detallada documentación  (en muchos casos como resultado de aportaciones metodológicas y/o avances científicos). Por ejemplo, después de diez años de la primera edición del libro *An Introduction to Statistical Learning con aplicaciones en R (ISLR)* , @james2013introduction, algunos de los mismos autores publicaron la edición en Python (ISLP), @james2023introduction.  
Por otro lado, en 2015, se lanzó el paquete [`reticulate`](https://rstudio.github.io/reticulate/) disponible en [https://rstudio.github.io/reticulate/](https://rstudio.github.io/reticulate/), permitiendo la ejecución de código Python desde R (y en 2020 se completó la integración de Python en la interfaz de RStudio).  



```r
library(reticulate)
os <- import("os")
os$listdir(".")
```


Si queremos trabajar con Python de forma interactiva, podemos usar `repl_python()`. Los objetos creados en Python se pueden usar en R con `py`  de `reticulate`.

Recientemente, *Julia* se presenta también como una alternativa a considerar. 
El paquete  [`JuliaConnectoR`](NA) disponible en [https://cran.r-project.org/web/packages/JuliaConnectoR/](https://cran.r-project.org/web/packages/JuliaConnectoR/) facilita la importación de funciones y paquetes completos de Julia a R, es decir, permite el uso de funciones de Julia directamente en R.


R también permite el uso/comunicación de otros lenguajes de programación como Java, C, C++, Fortran, entre otros.


<!--
https://es.r4ds.hadley.nz/01-intro.html
-->


Manipulación de datos
---------------------

Una vez cargada una (o varias) bases de datos hay una series de operaciones que serán de interés para el tratamiento de datos: 

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

Consideremos de nuevo la base de datos `cars` incluida en el paquete `datasets`:

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

Utilizando el comando `help(cars)` se obtiene que `cars` es un data.frame con 50
observaciones y dos variables:

-   `speed`: Velocidad (en millas por hora)

-   `dist`: tiempo hasta detenerse (en pies)

Recordemos que, para acceder a la variable `speed` se puede
hacer directamente con su nombre o bien utilizando notación
"matricial" (se seleccionan las 6 primeras observaciones por comodidad).

```r
cars$speed
```

```
##  [1]  4  4  7  7  8  9 10 10 10 11 11 12 12 12 12 13 13 13
## [19] 13 14 14 14 14 15 15 15 16 16 17 17 17 18 18 18 18 19
## [37] 19 19 20 20 20 20 20 22 23 24 24 24 24 25
```

```r
# cars[, 1]       # Equivalente
# cars[,"speed"]  # Equivalente
```

Supongamos ahora que queremos transformar la variable original `speed`
(millas por hora) en una nueva variable `velocidad` (kilómetros por
hora) y añadir esta nueva variable al data.frame `cars`.
La transformación que permite pasar millas a kilómetros es
`kilómetros=millas/0.62137` que en R se hace directamente con:


```r
(cars$speed/0.62137)[1:10]
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
variable `distancia` (en metros), por lo que la transformación deseada es
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

Finalmente, los datos anteriores podrían ser guardados en un fichero
exportable a Excel con el siguiente comando:

```r
write.csv2(coches, file = "coches.csv")
```

#### Recodificación de variables

Con el comando `cut()` podemos crear variables categóricas a partir de variables numéricas.
El parámetro `breaks` permite especificar los intervalos para la discretización, puede ser un vector con los extremos de los intervalos o un entero con el número de intervalos.
Por ejemplo, para categorizar la variable `cars$speed` en tres intervalos equidistantes podemos emplear^[Aunque si el objetivo es obtener las frecuencias de cada intervalo puede ser más eficiente emplear `hist()` con `plot = FALSE`.]:


```r
fspeed <- cut(cars$speed, 3, labels = c("Baja", "Media", "Alta"))
table(fspeed)
```

```
## fspeed
##  Baja Media  Alta 
##    11    24    15
```

Para categorizar esta variable en tres niveles con aproximadamente el mismo número de observaciones podríamos combinar esta función con `quantile()`:


```r
breaks <- quantile(cars$speed, probs = 0:3/3)
etiquetas3 <- c("Baja", "Media", "Alta")
fspeed <- cut(cars$speed, breaks, labels = etiquetas3)
table(fspeed)
```

```
## fspeed
##  Baja Media  Alta 
##    17    16    15
```

Para otro tipo de recodificaciones podríamos emplear la función `ifelse()` vectorial:


```r
fspeed <- ifelse(cars$speed < 15, "Baja", "Alta")
etiquetas2 <- c("Baja", "Alta")
fspeed <- factor(fspeed, levels = etiquetas2)
table(fspeed)
```

```
## fspeed
## Baja Alta 
##   23   27
```

Alternativamente, en el caso de dos niveles podríamos emplear directamente la función `factor()`:


```r
fspeed <- factor(cars$speed >= 15, 
                 labels = etiquetas2) # levels = c("FALSE", "TRUE")
table(fspeed)
```

```
## fspeed
## Baja Alta 
##   23   27
```

En el caso de múltiples niveles, se podría emplear `ifelse()` anidados:


```r
fspeed <- ifelse(cars$speed < 10, "Baja",
                 ifelse(cars$speed < 20, "Media", "Alta"))
fspeed <- factor(fspeed, levels = etiquetas3)
table(fspeed)
```

```
## fspeed
##  Baja Media  Alta 
##     6    32    12
```

Otra alternativa, sería emplear la función [`recode()`](https://www.rdocumentation.org/packages/car/versions/3.0-9/topics/recode) del paquete `car`. 


```r
library(car)
fspeed <- recode(cars$speed, "0:10 = 'Baja'; 
                 10:20 = 'Media';
                 else='Alta'
                 ")
fspeed <- factor(fspeed, levels = c("Baja", "Media", "Alta"))
```

NOTA: Para acceder directamente a las variables de un `data.frame` podríamos emplear la función `attach()` para añadirlo a la ruta de búsqueda y `detach()` al finalizar.
Sin embargo esta forma de proceder puede causar numerosos inconvenientes, especialmente al modificar la base de datos, por lo que la recomendación sería emplear `with()`.
Por ejemplo, podríamos calcular el factor anterior empleando:


```r
fspeed <- with(cars, ifelse(speed < 10, "Baja",
                 ifelse(speed < 20, "Media", "Alta")))
fspeed <- factor(fspeed, levels = c("Baja", "Media", "Alta"))
table(fspeed)
```

```
## fspeed
##  Baja Media  Alta 
##     6    32    12
```


### Operaciones con casos

#### Ordenación

Continuemos con el data.frame `cars`. 
Se puede comprobar que los datos disponibles están ordenados por
los valores de `speed`. A continuación haremos la ordenación utilizando
los valores de `dist`. Para ello, utilizaremos el conocido como vector de
índices de ordenación.
Este vector establece el orden en que tienen que ser elegidos los
elementos para obtener la ordenación deseada. 
Veamos primero un ejemplo sencillo:

```r
x <- c(2.5, 4.3, 1.2, 3.1, 5.0) # valores originales
ii <- order(x)
ii    # vector de ordenación
```

```
## [1] 3 1 4 2 5
```

```r
x[ii] # valores ordenados (por defecto, ascendentemente)
```

```
## [1] 1.2 2.5 3.1 4.3 5.0
```
En el caso de vectores, el procedimiento anterior se podría
hacer directamente con: 

```r
sort(x)
```

Sin embargo, para ordenar tablas de datos será necesario la utilización del
vector de índices de ordenación. A continuación, se muestan los datos de `cars` ordenados por `dist`:


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

El filtrado de datos consiste en elegir una submuestra que cumpla determinadas condiciones. Para ello, se puede utilizar la función [`subset(x, subset, select, drop = FALSE, ...)` ](https://www.rdocumentation.org/packages/base/versions/3.6.1/topics/subset) , que además permite seleccionar variables con el argumento `select`.

A continuación se muestran un par de ejemplos:

```r
# datos con dis>85
subset(cars, dist > 85) 
```

```
##    speed dist velocidad distancia
## 47    24   92  38.62433  28.04194
## 48    24   93  38.62433  28.34674
## 49    24  120  38.62433  36.57644
```

```r
# datos con speed en (10,15) y dist > 45
subset(cars, speed > 10 & speed < 15 & dist > 45)
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

En este caso, puede ser de utilidad la función [`which()` ](https://www.rdocumentation.org/packages/base/versions/3.6.1/topics/which):


```r
it <- which(ii)
str(it)
```

```
##  int [1:3] 19 22 23
```

```r
cars[it, ]
```

```
##    speed dist velocidad distancia
## 19    13   46  20.92151  14.02097
## 22    14   60  22.53086  18.28822
## 23    14   80  22.53086  24.38430
```

```r
# rownames(cars[it, ])
id <- which(!ii)
str(cars[id, ])
```

```
## 'data.frame':	47 obs. of  4 variables:
##  $ speed    : num  4 4 7 7 8 9 10 10 10 11 ...
##  $ dist     : num  2 10 4 22 16 10 18 26 34 17 ...
##  $ velocidad: num  6.44 6.44 11.27 11.27 12.87 ...
##  $ distancia: num  0.61 3.05 1.22 6.71 4.88 ...
```

```r
# Equivalentemente:
str(cars[-it, ])
```

```
## 'data.frame':	47 obs. of  4 variables:
##  $ speed    : num  4 4 7 7 8 9 10 10 10 11 ...
##  $ dist     : num  2 10 4 22 16 10 18 26 34 17 ...
##  $ velocidad: num  6.44 6.44 11.27 11.27 12.87 ...
##  $ distancia: num  0.61 3.05 1.22 6.71 4.88 ...
```

```r
# ?which.min
```

Si se realiza una selección de variables como en:

```r
cars[ii, "speed"]
```

```
## [1] 13 14 14
```
es posible que se quiera mantener la estructura original de los datos, para ello, 
bastaría con:

```r
cars[ii, "speed", drop=FALSE]
```

```
##    speed
## 19    13
## 22    14
## 23    14
```

```r
# subset(cars, ii, "speed") # equivalente
```

A veces puede ser necesario dividir (particionar) el conjunto de datos, uno para cada nivel de un grupo (factor), para ello se puede usar la función `split()`:


```r
speed2 <- factor(cars$speed > 20, labels = c("slow","fast"))
table(speed2)
```

```
## speed2
## slow fast 
##   43    7
```

```r
cars2 <- split(cars,speed2)
class(cars2) # lista con 2 data.frames
```

```
## [1] "list"
```

```r
sapply(cars2,class)
```

```
##         slow         fast 
## "data.frame" "data.frame"
```

```r
sapply(cars2,dim)
```

```
##      slow fast
## [1,]   43    7
## [2,]    4    4
```

```r
cars2$fast
```

```
##    speed dist velocidad distancia
## 44    22   66  35.40564  20.11704
## 45    23   54  37.01498  16.45940
## 46    24   70  38.62433  21.33626
## 47    24   92  38.62433  28.04194
## 48    24   93  38.62433  28.34674
## 49    24  120  38.62433  36.57644
## 50    25   85  40.23368  25.90832
```

De forma inversa, podríamos recuperar el  data.frame original con:


```r
unsplit(cars2,speed2)
```

## Datos faltantes {#missing}

La problemática originada por los datos faltantes (*missing data*) en cualquier conjunto de datos subyace cuando se desea
realizar un análisis estadístico, para más información en R, se puede consultar [CRAN Task View: Missing Data](https://cran.r-project.org/web/views/MissingData.html)


Vamos a ver un ejemplo, empleando el conjunto de datos `airquality` que contiene datos falntantes en sus dos primeras variables:

```r
data("airquality")
datos <- airquality[,1:3]
summary(datos)
```

```
##      Ozone           Solar.R           Wind       
##  Min.   :  1.00   Min.   :  7.0   Min.   : 1.700  
##  1st Qu.: 18.00   1st Qu.:115.8   1st Qu.: 7.400  
##  Median : 31.50   Median :205.0   Median : 9.700  
##  Mean   : 42.13   Mean   :185.9   Mean   : 9.958  
##  3rd Qu.: 63.25   3rd Qu.:258.8   3rd Qu.:11.500  
##  Max.   :168.00   Max.   :334.0   Max.   :20.700  
##  NA's   :37       NA's   :7
```

```r
nrow(datos)
```

```
## [1] 153
```

```r
# Datos faltantes por variable
sapply(datos, function(x) sum(is.na(x)))
```

```
##   Ozone Solar.R    Wind 
##      37       7       0
```
A continuación se muestra la distribución de los datos perdidos en el data.frame (a lo largo del tiempo, por mes):

<!--

```r
library(naniar)
vis_miss(airquality)
```



\begin{center}\includegraphics[width=0.7\linewidth]{02-ManipulacionDatosR_files/figure-latex/unnamed-chunk-48-1} \end{center}
-->

```r
plot(ts(airquality[,1:2]))
```



\begin{center}\includegraphics[width=0.7\linewidth]{02-ManipulacionDatosR_files/figure-latex/unnamed-chunk-49-1} \end{center}



¿Existe un patrón no aleatorio en los datos faltantes del ozono? Esta pregunta puede ser abordada parcialmente utilizando el test de Little [@little1998], disponible en la función `mcar_test()` del paquete `naniar`. Este test permite evaluar si los datos faltantes son generados por un mecanismo completamente aleatorio (MCAR). Si la hipótesis de MCAR es rechazada, esto sugiere que los datos faltantes podrían estar siguiendo un mecanismo MAR (*missing at random*) o MNAR (*non missing at random*).

<!--Esto,  si los datos faltantes son completamente aleatorios (MCAR) o no usando el test de Little [@little1998].


```r
mcar_test(airquality[,-2])
```

```
## # A tibble: 1 x 4
##   statistic    df p.value missing.patterns
##       <dbl> <dbl>   <dbl>            <int>
## 1      13.7     4 0.00829                2
```
-->

Sin embargo, en muchos estudios, se omite el paso anterior y se procede directamente con alguno de los siguientes métodos:

+ Análisis de casos completos (*complete cases*)
+ Análisis de casos disponibles (borrado por parejas *pairwise cases*)
+ Imputación de datos faltantes (por la media, mediana, último valor observado, vecino más cercano, valores predichos usando los datos observados....)

Siguiendo con el ejemplo, ante la presencia de datos faltantes, en R inicialmente no podemos conocer cómo se relacionan las tres primeras variables:"


```r
cor(datos[,1:3])
```

```
##         Ozone Solar.R Wind
## Ozone       1      NA   NA
## Solar.R    NA       1   NA
## Wind       NA      NA    1
```
y requiere indicar cómo tratar los datos perdidos. Por ejemplo, 
una opción sería realizar un análisis sólo de los casos completos, eliminando todas las observaciones (filas) con algún dato faltante de nuestro conjunto de datos:


```r
datosC <- na.omit(datos)
nrow(datosC) # n fija (sólo se utilizan 111 de las 153 de Wind)
```

```
## [1] 111
```

```r
cor(datosC[,1:3])
```

```
##              Ozone    Solar.R       Wind
## Ozone    1.0000000  0.3483417 -0.6124966
## Solar.R  0.3483417  1.0000000 -0.1271835
## Wind    -0.6124966 -0.1271835  1.0000000
```

```r
# otra forma de hacerlo sería:
# nrow(datos[complete.cases(datos),]) 
# cor(datos[,1:3], use ="complete.obs") 
```

También, se podría usar toda la información disponible. El tamaño muestral $n$ sería variable en función de los NA's de cada par de variables: 


```r
cor(datos[,1:3], use = "pairwise.complete.obs")
```

```
##              Ozone     Solar.R        Wind
## Ozone    1.0000000  0.34834169 -0.60154653
## Solar.R  0.3483417  1.00000000 -0.05679167
## Wind    -0.6015465 -0.05679167  1.00000000
```

Por ejmmplo, ahora la correlación usa los $146$ pares de observaciones disponibles para (`Solar.R`,`Wind`), en lugar de $111$ del primer caso.

Por último, también se podría realizar una imputación [@van2018flexible]. A modo de ejemplo, en el siguiente código, se utiliza la media:

```r
datosI <- datos
datosI$Ozone[is.na(datos$Ozone)] <- mean(datos$Ozone, na.rm = T)
datosI$Solar.R[is.na(datos$Solar.R)] <- mean(datosI$Solar.R, na.rm = T)
cor(datosI[,1:3])
```

```
##              Ozone     Solar.R        Wind
## Ozone    1.0000000  0.30296951 -0.53093584
## Solar.R  0.3029695  1.00000000 -0.05524488
## Wind    -0.5309358 -0.05524488  1.00000000
```
Notar que para el caso del ozono, se han sustituido los 37 *NA's* (24% de las observaciones) por un único valor (de ahí que ahora la varianza sea menor a la observada inicialmente, algo que en principio, no sería deseable).


```r
var(datos$Ozone,na.rm = T)
```

```
## [1] 1088.201
```

```r
var(datosI$Ozone)
```

```
## [1] 823.3096
```



Los datos faltantes son una realidad común en muchos estudios, aunque nadie los desea. Para tratarlos correctamente, es esencial comprender cómo se obtuvieron los datos observados y por qué algunos datos no fueron registrados antes de iniciar cualquier otro análisis. No abordar adecuadamente los datos faltantes puede tener un efecto perjudicial en nuestro estudio, ya que las conclusiones obtenidas podrían ser no representativas o contener sesgos.

<!--
https://search.r-project.org/CRAN/refmans/naniar/html/mcar_test.html
-->

### Funciones `apply`

#### La función `apply`

Una forma de evitar la utilización de bucles es utilizando la sentencia `apply` que permite evaluar una misma función en todas las filas, columnas, etc. de un array de forma simultánea.

La sintaxis de esta función es:

```r
apply(X, MARGIN, FUN, ...)
```
-   `X`: matriz (o array).
-   `MARGIN`: un vector indicando las dimensiones donde se aplicará
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
Alternativamente, se puede utilizar opciones más eficientes: `colSums()`, `rowSums()`, `colMeans()` y `rowMeans()`, como se muestra en el siguiente código de ejemplo:


```r
x <- matrix(1:1e8, ncol = 10, byrow = FALSE)
t1 <- proc.time()
out<-apply(x, 2, mean)   
proc.time() - t1
```

```
##    user  system elapsed 
##    0.83    0.12    0.95
```

```r
t2 <- proc.time()
out <- colMeans(x)
proc.time() - t2
```

```
##    user  system elapsed 
##    0.14    0.00    0.14
```


#### Variantes de la función `apply`



a. La función [`lapply(X, FUN, ...)`](https://www.rdocumentation.org/packages/base/versions/3.6.1/topics/lapply)
 aplica la función `FUN` a cada elemento de una lista en R y devuelve una lista como resultado (sin necesidad de especificar el argumento MARGIN). Notar  que todas las estructuras de datos en R pueden convertirse en listas, por lo que  `lapply()` puede utilizarse en más casos que `apply()`. 


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

b. La función 
[`sapply(X, FUN, ..., simplify = TRUE, USE.NAMES = TRUE) `](https://www.rdocumentation.org/packages/base/versions/3.6.1/topics/sapply) permite iterar sobre una lista o vector (alternativa más eficiente a un `for`):

```r
# matriz con las medias, medianas y desv. de las variables
res <- sapply(cars, 
          function(x) c(mean = mean(x), 
                        median = median(x), 
                        sd = sd(x)))
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
sapply(nfuns, 
       function(f) eval(parse(text = paste0(f, "(x)"))))
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

c. La función [`tapply()`](https://www.rdocumentation.org/packages/base/versions/3.6.1/topics/tapply) es
similar a la función `apply()` y permite aplicar una función a los datos desagregados,
utilizando como criterio los distintos niveles de una variable factor. Es decir, 
 facilita la creación de tablars resumen por grupos. La sintaxis de esta función es como sigue:

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

<!-- Otro ejemplo: -->
<!-- ```{r} -->
<!-- provincia <- as.factor(c(1, 3, 4, 2, 4, 3, 2, 1, 4, 3, 2)) -->
<!-- levels(provincia) = c("A Coruña", "Lugo", "Orense", "Pontevedra") -->
<!-- hijos <- c(1, 2, 0, 3, 4, 1, 0, 0, 2, 3, 1) -->
<!-- data.frame(provincia, hijos) -->
<!-- tapply(hijos, provincia, mean) # Número medio de hijos por provincia -->
<!-- ``` -->

Alternativamente, se podría emplear la función `aggregate()` que tiene las ventajas de admitir fórmulas y disponer de un método para series de tiempo.


```r
help(aggregate)
aggregate(peso,by=list(dieta=dieta),FUN = "mean" )
```

```
##     dieta        x
## 1 Dieta 1 102.6455
## 2 Dieta 2 122.6167
## 3 Dieta 3 142.9500
## 4 Dieta 4 135.2627
```

```r
aggregate(peso~dieta,FUN = "summary" ) # con formula
```

```
##     dieta peso.Min. peso.1st Qu. peso.Median peso.Mean
## 1 Dieta 1   35.0000      57.7500     88.0000  102.6455
## 2 Dieta 2   39.0000      65.5000    104.5000  122.6167
## 3 Dieta 3   39.0000      67.5000    125.5000  142.9500
## 4 Dieta 4   39.0000      71.2500    129.5000  135.2627
##   peso.3rd Qu. peso.Max.
## 1     136.5000  305.0000
## 2     163.0000  331.0000
## 3     198.7500  373.0000
## 4     184.7500  322.0000
```

### Tablas (para informes)

a. Tablas con `kable()`:

A continuación, se muestra un ejemplo, de tabla resumen, con las medias, medianas y desviación típica de las variables:


```r
res <- sapply(cars, 
          function(x) c(mean = mean(x), 
                        median = median(x), 
                        sd = sd(x)))
knitr::kable(t(res), digits = 1, 
             col.names = c("Media", "Mediana", "Desv. típica"))
```


\begin{tabular}{l|r|r|r}
\hline
  & Media & Mediana & Desv. típica\\
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

<!--
Consideremos, el conjunto de datos `iris`  

```r
data(iris)
iris2 <- head(iris)
knitr::kable(iris2, 
             col.names = gsub("[.]", " ", names(iris)))
```


\begin{tabular}{r|r|r|r|l}
\hline
Sepal Length & Sepal Width & Petal Length & Petal Width & Species\\
\hline
5.1 & 3.5 & 1.4 & 0.2 & setosa\\
\hline
4.9 & 3.0 & 1.4 & 0.2 & setosa\\
\hline
4.7 & 3.2 & 1.3 & 0.2 & setosa\\
\hline
4.6 & 3.1 & 1.5 & 0.2 & setosa\\
\hline
5.0 & 3.6 & 1.4 & 0.2 & setosa\\
\hline
5.4 & 3.9 & 1.7 & 0.4 & setosa\\
\hline
\end{tabular}
-->
Y en este segundo ejemplo, se muestra el resumen de un modelo de regresión lineal simple (distancia de frenado en función de la velocidad del vehículo):

```r
modelo <- lm(dist ~ speed, data = cars)
coefs <- coef(summary(modelo))
knitr::kable(coefs, escape = FALSE, digits = 5)
```


\begin{tabular}{l|r|r|r|r}
\hline
  & Estimate & Std. Error & t value & Pr(>|t|)\\
\hline
(Intercept) & -17.57909 & 6.75844 & -2.60106 & 0.01232\\
\hline
speed & 3.93241 & 0.41551 & 9.46399 & 0.00000\\
\hline
\end{tabular}

b. Tablas interactivas con `datatabe()` del paquete `DT`:

```r
library(DT)
datatable(iris,options = list(scrollX = TRUE))
```
<!--  options = list(scrollX = TRUE))-->



Hay muchos otros paquetes de R que se pueden utilizar para generar tablas como:
`kableExtra()`, `flextable()`, `reactable()`, `reactablefmtr()`, 
`formattable()`, `gt()` y `tinytable()`.

<!--https://bookdown.org/yihui/rmarkdown-cookbook/table-other.html-->
<!-- c. Tablas con `tt()` del paquete `tinytable`: -->
<!-- ```{r} -->
<!-- library(tinytable) -->
<!-- tt(data.frame(variables=rownames(res),res), digits = 3) -->
<!-- ``` -->


### Operaciones con tablas de datos


***Unir tablas***:

* [`rbind()` ](https://www.rdocumentation.org/packages/base/versions/3.6.1/topics/rbind): combina vectores, matrices, arrays o data.frames por filas.

* [`cbind()` ](https://www.rdocumentation.org/packages/base/versions/3.6.1/topics/cbind): Idem por columnas.

* [`merge()` ](https://www.rdocumentation.org/packages/base/versions/3.6.1/topics/merge): Fusiona dos data.frame por columnas o nombres de fila comunes.  También permite otras operaciones de unión (*join*) de bases de datos, algunas de ellas se verán con más detalle en el Capítulo 4.

***Combinar tablas***:


* [`match(x, table)`](https://www.rdocumentation.org/packages/base/versions/3.6.1/topics/match) devuelve un vector (de la misma longitud que `x`)  con las (primeras) posiciones de coincidencia de `x` en `table` (o `NA`, por defecto, si no hay coincidencia).

    Para realizar consultas combinando tablas puede ser más cómodo el operador `%in%` (`?'%in%'`).

* [`pmatch(x, table, ...)`](https://www.rdocumentation.org/packages/base/versions/3.6.1/topics/pmatch): similar al anterior pero con coincidencias parciales de cadenas de texto. 


## Ejemplo WoS data

Ejemplo [*wosdata.R*](data/wosdata.R) en [*wosdata.zip*](data/wosdata.zip).
Ver Apéndice \@ref(scimetr).


```r
# library(dplyr)
# library(stringr)
# https://rubenfcasal.github.io/scimetr/articles/scimetr.html
# library(scimetr)

db <- readRDS("data/wosdata/db_udc_2015.rds")
str(db, 1)
```

```
## List of 11
##  $ Docs      :'data.frame':	856 obs. of  26 variables:
##  $ Authors   :'data.frame':	4051 obs. of  4 variables:
##  $ AutDoc    :'data.frame':	5511 obs. of  2 variables:
##  $ Categories:'data.frame':	189 obs. of  2 variables:
##  $ CatDoc    :'data.frame':	1495 obs. of  2 variables:
##  $ Areas     :'data.frame':	121 obs. of  2 variables:
##  $ AreaDoc   :'data.frame':	1364 obs. of  2 variables:
##  $ Addresses :'data.frame':	3655 obs. of  5 variables:
##  $ AddAutDoc :'data.frame':	7751 obs. of  3 variables:
##  $ Journals  :'data.frame':	520 obs. of  12 variables:
##  $ label     : chr ""
##  - attr(*, "variable.labels")= Named chr [1:62] "Publication type" "Author" "Book authors" "Editor" ...
##   ..- attr(*, "names")= chr [1:62] "PT" "AU" "BA" "BE" ...
##  - attr(*, "class")= chr "wos.db"
```

```r
variable.labels <- attr(db, "variable.labels")
knitr::kable(as.data.frame(variable.labels),
             caption = "Variable labels")
```

\begin{table}

\caption{(\#tab:unnamed-chunk-69)Variable labels}
\centering
\begin{tabular}[t]{l|l}
\hline
  & variable.labels\\
\hline
PT & Publication type\\
\hline
AU & Author\\
\hline
BA & Book authors\\
\hline
BE & Editor\\
\hline
GP & Group author\\
\hline
AF & Author full\\
\hline
BF & Book authors fullname\\
\hline
CA & Corporate author\\
\hline
TI & Title\\
\hline
SO & Publication name\\
\hline
SE & Series title\\
\hline
BS & Book series\\
\hline
LA & Language\\
\hline
DT & Document type\\
\hline
CT & Conference title\\
\hline
CY & Conference year\\
\hline
CL & Conference place\\
\hline
SP & Conference sponsors\\
\hline
HO & Conference host\\
\hline
DE & Keywords\\
\hline
ID & Keywords Plus\\
\hline
AB & Abstract\\
\hline
C1 & Addresses\\
\hline
RP & Reprint author\\
\hline
EM & Author email\\
\hline
RI & Researcher id numbers\\
\hline
OI & Orcid numbers\\
\hline
FU & Funding agency and grant number\\
\hline
FX & Funding text\\
\hline
CR & Cited references\\
\hline
NR & Number of cited references\\
\hline
TC & Times cited\\
\hline
Z9 & Total times cited count\\
\hline
U1 & Usage Count (Last 180 Days)\\
\hline
U2 & Usage Count (Since 2013)\\
\hline
PU & Publisher\\
\hline
PI & Publisher city\\
\hline
PA & Publisher address\\
\hline
SN & ISSN\\
\hline
EI & eISSN\\
\hline
BN & ISBN\\
\hline
J9 & Journal.ISI\\
\hline
JI & Journal.ISO\\
\hline
PD & Publication date\\
\hline
PY & Year published\\
\hline
VL & Volume\\
\hline
IS & Issue\\
\hline
PN & Part number\\
\hline
SU & Supplement\\
\hline
SI & Special issue\\
\hline
MA & Meeting abstract\\
\hline
BP & Beginning page\\
\hline
EP & Ending page\\
\hline
AR & Article number\\
\hline
DI & DOI\\
\hline
D2 & Book DOI\\
\hline
PG & Page count\\
\hline
WC & WOS category\\
\hline
SC & Research areas\\
\hline
GA & Document delivery number\\
\hline
UT & Access number\\
\hline
PM & Pub Med ID\\
\hline
\end{tabular}
\end{table}

Veamos ahora un par de ejemplos, en el primero se buscan los documentos correspondientes a revistas (que contiene `Chem` en el título de la revista *journal*).  Para ello utilizamos la función  `grepl()` que busca las coincidencias con el patrón `Chem` dentro de cada elemento de un vector de caracteres.


```r
# View(db$Journals)
iidj <- with(db$Journals, idj[grepl('Chem', JI)])
db$Journals$JI[iidj]
```

```
##  [1] "J. Am. Chem. Soc."                 
##  [2] "Inorg. Chem."                      
##  [3] "J. Chem. Phys."                    
##  [4] "J. Chem. Thermodyn."               
##  [5] "J. Solid State Chem."              
##  [6] "Chemosphere"                       
##  [7] "Antimicrob. Agents Chemother."     
##  [8] "Trac-Trends Anal. Chem."           
##  [9] "Eur. J. Med. Chem."                
## [10] "J. Chem. Technol. Biotechnol."     
## [11] "J. Antimicrob. Chemother."         
## [12] "Food Chem."                        
## [13] "Cancer Chemother. Pharmacol."      
## [14] "Int. J. Chem. Kinet."              
## [15] "Chem.-Eur. J."                     
## [16] "J. Phys. Chem. A"                  
## [17] "New J. Chem."                      
## [18] "Chem. Commun."                     
## [19] "Chem. Eng. J."                     
## [20] "Comb. Chem. High Throughput Screen"
## [21] "Mini-Rev. Med. Chem."              
## [22] "Phys. Chem. Chem. Phys."           
## [23] "Org. Biomol. Chem."                
## [24] "J. Chem Inf. Model."               
## [25] "ACS Chem. Biol."                   
## [26] "Environ. Chem. Lett."              
## [27] "Anal. Bioanal. Chem."              
## [28] "J. Cheminformatics"                
## [29] "J. Mat. Chem. B"
```

```r
idd <- with(db$Docs, idj %in% iidj)
which(idd)
```

```
##  [1]   2   4  16  23  43  69 119 126 138 175 188 190 203 208
## [15] 226 240 272 337 338 341 342 357 382 385 386 387 388 394
## [29] 411 412 428 460 483 518 525 584 600 604 605 616 620 665
## [43] 697 751 753 775 784 796 806 808 847 848
```

```r
# View(db$Docs[idd, ])
head(db$Docs[idd, -3])
```

```
##    idd idj      PT      DT  NR TC Z9 U1 U2     PD   PY VL
## 2    2  37 Journal Article  45  5  5  0  0 DEC 21 2015 54
## 4    4 272 Journal Article  78  2  2  4 21 DEC 14 2015 21
## 16  16 195 Journal Article  34  2  2  0  0    DEC 2015 70
## 23  23 436 Journal Article  48  3  3  0  4    DEC 2015 10
## 43  43 455 Journal  Review 214  0  0  0  8    DEC 2015 13
## 69  69  37 Journal Article  86  2  2  8 28  NOV 2 2015 54
##    IS PN SU SI MA    BP    EP AR
## 2  24             11680 11687   
## 4  51             18662 18670   
## 16 12              3222  3229   
## 23 12              2850  2860   
## 43  4               413   430   
## 69 21             10342 10350   
##                               DI D2 PG           UT an
## 2  10.1021/acs.inorgchem.5b01652     8 367118100013  9
## 4         10.1002/chem.201502937     9 368280400026  8
## 16            10.1093/jac/dkv262     8 368246800008 10
## 23    10.1021/acschembio.5b00624    11 366875400020 10
## 43     10.1007/s10311-015-0526-2    18 365096700004  2
## 69 10.1021/acs.inorgchem.5b01719     9 364175000028  8
```

En este segundo ejemplo, se buscan los documentos correspondientes a autores (que contiene `Abad` en su nombre):


```r
# View(db$Authors)
iida <- with(db$Authors, ida[grepl('Abad', AF)])
db$Authors$AF[iida]
```

```
## [1] "Mato Abad, Virginia" "Abad, Maria-Jose"   
## [3] "Abad Vicente, J."    "Abada, Sabah"
```

```r
idd <- with(db$AutDoc, idd[ida %in% iida])
idd
```

```
## [1] 273 291 518 586
```

```r
# View(db$Docs[idd, ])
head(db$Docs[idd, -3])
```

```
##     idd idj      PT               DT  NR TC Z9 U1 U2     PD
## 273 273 282 Journal          Article 107  8  8  0  0    SEP
## 291 291 141 Journal Meeting Abstract   0  0  0  0  1  AUG 1
## 518 518 272 Journal          Article 103  4  4  0  0 APR 20
## 586 586 311 Journal          Article  32  2  2  2 19    APR
##       PY VL    IS PN SU SI   MA   BP   EP AR
## 273 2015 42 15-16               6205 6214   
## 291 2015 36           1    P167    9    9   
## 518 2015 21    17               6535 6546   
## 586 2015 26     4                369  375   
##                             DI D2 PG           UT an
## 273 10.1016/j.eswa.2015.03.011    10 355063700018  7
## 291                                1 361205101026 10
## 518     10.1002/chem.201500155    12 352796100030 10
## 586           10.1002/pat.3462     7 351472700012  6
```
