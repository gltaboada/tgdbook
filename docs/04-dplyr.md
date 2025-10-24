# Manipulación de datos con tidyverse {#tidyverse}

Este la primera parte de este capítulo (Sección \@ref(introTidyverse)), se pretende realizar una breve introducción al *ecosistema* [**Tidyverse**](https://dplyr.tidyverse.org), una colección de paquetes diseñados de forma uniforme (con la misma filosofía y estilo) para trabajar conjuntamente.

La referencia recomendada para usuarios de R que deseen iniciarse en el uso de estos paquetes es: 

Wickham, H., y Grolemund, G. (2016). *[R for data science: import, tidy, transform, visualize, and model data](http://r4ds.had.co.nz)*, [online-castellano](https://es.r4ds.hadley.nz), [O'Reilly](http://shop.oreilly.com/product/0636920034407.do).

En las consecutivas secciones se presentan las alternativas *tidyverse* a la lectura, manipulacióin y escritura de datos tratadas en Capítulo \@ref(manipR).

Más adelante, en la Sección \@ref(dplyr) se realiza una breve introducción al paquete  [`dplyr`](https://dplyr.tidyverse.org) y en la Sección \@ref(tidyr-pkg) se comentan algunas de las utilidades del paquete [`tidyr`](https://tidyr.tidyverse.org) que pueden resultar de interés^[Otra alternativa (más rápida) es [`data.table`](https://rdatatable.gitlab.io/data.table) pero en versiones recientes ya se puede emplear desde `dplyr`, como se comenta más adelante.]. Finalmente, las secciones \@ref(dplyr-join) y \@ref(dbplyr) se muestra las utilizades para tratar tablas y bases de datos respectivamente.



## Introducción al ecosistema tidyverse {#introTidyverse}


El paquete [`tidyverse`](https://tidyverse.tidyverse.org) está diseñado para facilitar la instalación y carga de los paquetes principales de la colección tidyverse con un solo comando.
Al instalar este paquete se instalan paquetes que forman el denominado núcleo de tidyverse (se cargan con `library(tidyverse)`):

- [`ggplot2`](https://ggplot2.tidyverse.org): visualización de datos.
- [`dplyr`](https://dplyr.tidyverse.org): manipulación de datos.
- [`tidyr`](https://tidyr.tidyverse.org): reorganización (limpieza) de datos.
- [`readr`](https://readr.tidyverse.org): importación de datos.
- [`tibble`](https://tibble.tidyverse.org): tablas de datos (extensión de `data.frame`).
- [`purrr`](https://purrr.tidyverse.org): programación funcional.
- [`stringr`](https://github.com/tidyverse/stringr): manipulación de cadenas de texto.
- [`forcats`](https://github.com/tidyverse/forcats): manipulación de factores.
- [`lubridate`](https://github.com/tidyverse/lubridate): manipulación de fechas y horas.

y un conjunto de paquetes recomendados:  
- [`feather`](https://github.com/wesm/feather): almacenamiento efeciente de data frames.
- [`haven`](https://github.com/tidyverse/haven): lectura y escritura de datos de SPSS, Stata y SAS en R 
- [`modelr`](https://github.com/tidyverse/modelr):  crear pipelines^[serie de pasos conectados (tuberías) que procesan datos y los transforman en un formato deseado para su análisis o modelado] elegantes al modelar datos en R (obsoleto). [`broom`](https://github.com/tidymodels/broom)...): resumenes estadísticos en formato Tidy

Otros paquetes de interés son:

- [`readxl`](https://github.com/tidyverse/readxl): lectura de archivos Excel.
- [`readxl`](https://github.com/ropensci/writexl): exportación a Excel.
- [`hms`](https://github.com/tidyverse/hms): manipulación de medidas de tiempo.
- [`httr`](https://github.com/r-lib/httr): interactuar con web APIs.
- [`jsonlite`](https://github.com/jeroen/jsonlite): Lectura y escritura de archivos JSON (*JavaScript Object Notation*).
- [`rvest`](https://github.com/tidyverse/rvest): extraación de datos (estructurados) de páginas web *web scraping*.
- [`xml2`](https://github.com/r-lib/xml2): lectura y escritura de archivos XML.
- [`vroom`](https://github.com/tidyverse/vroom): lectura eficiente de archivos delimitados



``` r
library(tidyverse)
```

También hay paquetes "asociados":

- [`rlang`](https://rlang.r-lib.org): herramientas para programación funcional.
- [`tidyselect`](https://tidyselect.r-lib.org) Sintaxis seleccionar variables (columnas).
- [`tune`](https://tune.tidymodels.org/): hiperparámetros en modelos estadísticos
- [`tidymodels`](https://tidymodels.tidymodels.org)  meta-paquete para todo el  proceso de modelado.

Muchos otros paquetes están adaptando este estilo, por ejemplo, el meta paquete [`tidyverts`](https://tidyverts.org/)) para el análisis de series temporales (*time series*, TS), que incluye, por ejemplo:

- [`tsibble`](https://tsibble.tidyverts.org/) (infra)estructuras de datos. 
- [`fable`](https://fable.tidyverts.org/)  predicción (*forecasting*). 
- [`feasts`](https://feasts.tidyverts.org/) extracción de características (predictores).

El paquete [`fpp3`](https://github.com/robjhyndman/fpp3package) asociado al libro [**Forecasting: Principles and Practice**](https://otexts.com/fpp3/) también sigue una filosofía *tidy*.

Otro ejemplo, en este caso, para el tratamiento de datos espaciales, sería el paquete [`sf`](https://github.com/r-spatial/sf/),  para más detalles ver [Sección 2.2 Introducción al paquete sf ](https://rubenfcasal.github.io/estadistica_espacial/sf-intro.html) del libro **Estadística Espacial con R**


<!--
Hacer una lista para un apéndice.
[`infer`](https://infer.netlify.app/)  pruebas de hipótesis no paramétricas 

[`moderndive`](https://github.com/moderndive/moderndive/)  introducción amigable a la inferencia estadística (incluida la regresión lineal) 

[A ModernDive into R and the Tidyverse](https://moderndive.com/)

[`staks`](https://stacks.tidymodels.org/) combinación de modelos para generar un modelo ensamblado más preciso.
[`tidyfun`](https://tidyfun.github.io/tidyfun/) The goal of tidyfun is to provide accessible and well-documented software that makes functional data analysis in R easy 
- [`tinytable`](https://vincentarelbundock.github.io/tinytable/): herramientas para crear tablas (multiformato).
-->

Resumiendo, está muy de moda y puede terminar convirtiéndose en un dialecto del lenguaje R, todo lo que resulte de utilidad es bien venido... Aunque se recomienda evitar estos paquetes en las primeras etapas de formación en R.

El estilo de programación tiene como origen la gramática de [`ggplot2`](https://ggplot2.tidyverse.org) para crear gráficos de forma declarativa, basado a su vez en:

Wilkinson, L. (2005). *The Grammar of Graphics*. [Springer](https://www.google.es/books/edition/The_Grammar_of_Graphics/YGgUswEACAAJ?hl=es).

Este paquete se ha convertido en un sustituto de los gráficos [`lattice`](http://lattice.r-forge.r-project.org/), de utilidad en algunos informes finales, aplicaciones para empresas, o para gráficos muy especializados. Aunque, en condiciones normales, suele ser más rápido generar o programar gráficos estándar de R.

<!-- capítulo ggplot2? -->

Para iniciarse en este paquete lo recomendado es consultar los capítulos [Data     Visualización](https://r4ds.had.co.nz/data-visualisation.html) y [Graphics for communication](https://r4ds.had.co.nz/graphics-for-communication.html) de [R for Data Science](https://r4ds.had.co.nz). 
También puede resultar de interés la [chuleta](https://github.com/rstudio/cheatsheets/blob/master/data-visualization.pdf)).
La referencia que cubre con mayor profundidad este paquete es:

Wickham, H. (2016). *[ggplot2: Elegant graphics for Data Analysis](https://ggplot2-book.org)* (3ª edición, en desarrollo junto a Navarro, D. y Pedersen, T.L.). [Springer](https://www.amazon.com/gp/product/331924275X).

Otra alternativa sería:

Chang, W. (2023). *[The R Graphics Cookbook](https://r-graphics.org)*. [O’Reilly](https://www.amazon.com/dp/1491978600). 

En [`ggplot2`](https://ggplot2.tidyverse.org) se emplea el operador `+` para añadir componentes de los gráficos (ver , en *Tidyverse* se emplea un operador de redirección para añadir operaciones.


### Operador *pipe* (redirección) {#pipe}

El operador `%>%` (paquete [`magrittr`](https://magrittr.tidyverse.org)) permite canalizar la salida de una función a la entrada de otra. Se utiliza para mejorar la legibilidad y la claridad del código al encadenar múltiples operaciones en una secuencia fluida
Por ejemplo, `segundo(primero(datos))` se traduce en `datos %>% primero %>% segundo`, lo que facilita la lectura de operaciones al escribir las funciones de izquierda a derecha.

Desde la versión 4.1 de R está disponible un operador interno `|>`.
Por ejemplo, para el conjunto de datos `empleados.RData` que contiene datos de empleados de un banco.   Supongamos, por ejemplo, que estamos interesados en estudiar si hay discriminación por cuestión de sexo o raza.


``` r
load("data/empleados.RData")
# NOTA: Cuidado con la codificación latin1 (no declarada) 
# al abrir archivos creados en versiones anteriores de R < 4.2: 
# load("data/empleados.latin1.RData")

# Listamos las etiquetas
#knitr::kable(attr(empleados, "variable.labels"),
#             col.names = "Etiqueta")

# Eliminamos las etiquetas para que no molesten...
# attr(empleados, "variable.labels") <- NULL  

#empleados |>  
#  subset(catlab == "Directivo", catlab:sexoraza) |>
#  summary()
```

Para que una función sea compatible con este tipo de operadores el primer parámetro debería ser siempre los datos.
Sin embargo, el operador `%>%` permite redirigir el resultado de la operación anterior a un parámetro distinto mediante un `.`.
Por ejemplo:


``` r
# ?"|>"
# empleados |> subset(catlab != "Seguridad") |> droplevels |> 
#     boxplot(salario ~ sexo*catlab, data = .) # ERROR

library(magrittr)
empleados %>% 
  subset(catlab != "Seguridad") %>%
  droplevels() %>%
  boxplot(salario ~ sexo*catlab, data = .)
```



\begin{center}\includegraphics[width=0.8\linewidth]{04-dplyr_files/figure-latex/unnamed-chunk-3-1} \end{center}


### Lectura y escritura de archivos de texto {#readr}

En esta seccón la alternativa *tidyverse*, a la tradicional, vista en las secciones \@ref(cap2-texto) y \@ref(cap2-exporta) del Capítulo 2.

Para leer archivos de texto en distintos formatos se puede emplear el paquete [`readr`](https://readr.tidyverse.org), disponible en la colección de paquetes [`tidyverse`](https://tidyverse.tidyverse.org). Para más información, se recomienda consultar el [Capítulo 11](https://r4ds.had.co.nz/data-import.html) del libro [*R for Data Science*](http://r4ds.had.co.nz) [@wickham2023r]  o la versión en español "[*R Para Ciencia de Datos*](https://es.r4ds.hadley.nz/)".


``` r
library(readr)
# ?readr
datos <- read_csv2("./data/coches.csv")
class(datos) 
```

```
## [1] "spec_tbl_df" "tbl_df"      "tbl"         "data.frame"
```


También se puede importación desde Excel fácilmente:


``` r
library(readxl)
datos<-read_excel("./data/coches.xlsx")
class(datos)
```

```
## [1] "tbl_df"     "tbl"        "data.frame"
```

``` r
excel_sheets("./data/coches.xlsx") # listado de hojas
```

```
## [1] "coches"
```

Otra alternativa, sería emplear el paquete [`data.table`](https://r-datatable.com).
La función `fread()` puede considerarse como alternativa a `read_csv()` 
cuando el proceso de lectura resulta lento, especialmente con datos numéricos pesados. ESta función intenta *adivinar* automáticamente algunos argumentos sin tener que especificarse como, por ejemplo, el delimitador, las filas omitidas y la cabecera. Sin embargo, si requiere especificar el separador del decimal, como a continuación:


``` r
library(data.table)
# ?fread
datos <- fread(file = "./data/coches.csv", dec = ",")
class(datos) 
```

```
## [1] "data.table" "data.frame"
```

Para más información, se recomienda ver la viñeta [*Introduction to data.table*](https://rdatatable.gitlab.io/data.table/articles/datatable-intro.html).

### Escritura {#writer}

Con el ecosistema *tidyverse*, también con el paquete [`readr`](https://readr.tidyverse.org) se puede utilizar la función `write_csv2()`:

``` r
write_csv2(datos, file = "datos.csv")
```
y como opción más rápida, se podría usar `fwrite()` del paqute `data.table`:


``` r
# datos2 <- data.table(datos)
fwrite(datos2, file = "datos2.csv")
```



<!--  xxx
Manipulación de datos con `dplyr` {#dplyr}
=================================
-->

Working draft...

En este capítulo se realiza una breve introducción al paquete  [`dplyr`](https://dplyr.tidyverse.org/index.html). 
Para mas información, ver por ejemplo la 'vignette' del paquete   
[Introduction to dplyr](https://cran.rstudio.com/web/packages/dplyr/vignettes/dplyr.html),
o el Capítulo [5 Data transformation](http://r4ds.had.co.nz/transform.html) del libro 
[R for Data Science](http://r4ds.had.co.nz)^[Una alternativa (más rápida) es emplear
[data.table](https://rdatatable.gitlab.io/data.table).].




## Manipulación de datos con dplyr y tidyr {#dplyr}

<!--
# Introducción  {#dplyr}
-->
En esta sección se realiza una breve introducción al paquete  [`dplyr`](https://dplyr.tidyverse.org) y se comentan algunas de las utilidades del paquete [`tidyr`](https://tidyr.tidyverse.org) que pueden resultar de interés^[Otra alternativa (más rápida) es [`data.table`](https://rdatatable.gitlab.io/data.table) pero en versiones recientes ya se puede emplear desde `dplyr`, como se comenta más adelante.]. 

La referencia recomendada para iniciarse en esta herramienta es el Capítulo [5 Data transformation](http://r4ds.had.co.nz/transform.html) de 
[R for Data Science](http://r4ds.had.co.nz).
También puede resultar de utilidad la viñeta del paquete [Introduction to dplyr](https://dplyr.tidyverse.org/articles/dplyr.html) o la [chuleta](https://posit.co/wp-content/uploads/2022/10/data-transformation-1.pdf) (menú de RStudio *Help > Cheat Sheets > Data Transformation with dplyr*).


### El paquete dplyr {#dplyr-pkg}


``` r
library(dplyr)
```

La principal ventaja de [`dplyr`](https://dplyr.tidyverse.org/index.html) es que permite trabajar (de la misma forma) con datos en distintos formatos:
     
- `data.frame`, [`tibble`](https://tibble.tidyverse.org/).

- [`data.table`](https://rdatatable.gitlab.io/data.table): extensión (paquete *backend*) [`dtplyr`](https://dtplyr.tidyverse.org).

- conjuntos de datos más grandes que la memoria disponible: extensiones [`duckdb`](https://duckdb.org/docs/api/r) y [`arrow`](https://arrow.apache.org/docs/r/) (incluyendo almacenamiento en la nube, e.g. [AWS](https://aws.amazon.com/es/s3)). 

- bases de datos relacionales (lenguaje SQL, locales o remotas); extensión [`dbplyr`](https://dbplyr.tidyverse.org).

- grandes volúmenes de datos (incluso almacenados en múltiples servidores; ecosistema [Hadoop](http://hadoop.apache.org/)/[Spark](https://spark.apache.org/)): extensión [`sparklyr`](https://spark.rstudio.com) (ver menú de RStudio *Help > Cheat Sheets > Interfacing Spark with sparklyr*).


El paquete dplyr permite sustituir operaciones con funciones base de R (como [`subset`](NA), [`split`](NA), [`apply`](NA), [`sapply`](NA), [`lapply`](NA), [`tapply`](NA), [`aggregate`](NA)...) por una "gramática" más sencilla para la manipulación de datos.
En lugar de operar sobre vectores como la mayoría de las funciones base,
opera sobre conjuntos de datos (de forma que es compatible con el operador `%>%`).
Los principales "verbos" (funciones) son:

- [`select()`](https://dplyr.tidyverse.org/reference/select.html): seleccionar variables (ver también [`rename`](https://dplyr.tidyverse.org/reference/rename.html), [`relocate`](https://dplyr.tidyverse.org/reference/rename.html), [`pull`](https://dplyr.tidyverse.org/reference/rename.html)).

- [`mutate()`](https://dplyr.tidyverse.org/reference/mutate.html): crear variables (ver también `transmute()`).

- [`filter()`](https://dplyr.tidyverse.org/reference/filter.html): seleccionar casos/filas (ver también `slice()`).

- [`arrange()`](https://dplyr.tidyverse.org/reference/arrange.html): ordenar casos/filas.

- [`summarise()`](https://dplyr.tidyverse.org/reference/summarise.html): resumir valores.

- [`group_by()`](https://dplyr.tidyverse.org/reference/group_by.html): permite operaciones por grupo empleando el concepto "dividir-aplicar-combinar" (`ungroup()` elimina el agrupamiento).

NOTA: Para entender el funcionamiento de ciertas funciones (como [`rowwise()`](https://dplyr.tidyverse.org/reference/rowwise.html)) y las posibilidades en el manejo de datos, hay que tener en cuenta que un `data.frame` no es más que una lista cuyas componentes (variables) tienen la misma longitud.
Realmente las componentes también pueden ser listas de la misma longitud y, por tanto, podemos almacenar casi cualquier estructura de datos en un `data.frame`.

En la primera parte de este capítulo consideraremos solo  `data.frame` por comodidad.
Emplearemos como ejemplo los datos de empleados de banca almacenados en el fichero *empleados.RData* (y supondremos que estamos interesados en estudiar si hay discriminación por cuestión de sexo o raza).


``` r
load("data/empleados.RData")
attr(empleados, "variable.labels") <- NULL                  
```

En la Sección \@ref(dbplyr) final emplearemos una base de datos relacional como ejemplo.


### Operaciones con variables (columnas) {#dplyr-variables}

Podemos **seleccionar variables con [`select()`](https://dplyr.tidyverse.org/reference/select.html)**:

``` r
emplea2 <- empleados %>% select(id, sexo, minoria, tiempemp, 
                                salini, salario)
head(emplea2)
```

```
##   id   sexo minoria tiempemp salini salario
## 1  1 Hombre      No       98  27000   57000
## 2  2 Hombre      No       98  18750   40200
## 3  3  Mujer      No       98  12000   21450
## 4  4  Mujer      No       98  13200   21900
## 5  5 Hombre      No       98  21000   45000
## 6  6 Hombre      No       98  13500   32100
```

Se puede cambiar el nombre (ver también [`rename()`](https://dplyr.tidyverse.org/reference/rename.html)):

``` r
empleados %>% select(sexo, noblanca = minoria, salario) %>% head()
```

```
##     sexo noblanca salario
## 1 Hombre       No   57000
## 2 Hombre       No   40200
## 3  Mujer       No   21450
## 4  Mujer       No   21900
## 5 Hombre       No   45000
## 6 Hombre       No   32100
```

Se pueden emplear los nombres de variables como índices:

``` r
empleados %>% select(sexo:salario) %>% head()
```

```
##     sexo    fechnac educ         catlab salario
## 1 Hombre 1952-02-03   15      Directivo   57000
## 2 Hombre 1958-05-23   16 Administrativo   40200
## 3  Mujer 1929-07-26   12 Administrativo   21450
## 4  Mujer 1947-04-15    8 Administrativo   21900
## 5 Hombre 1955-02-09   15 Administrativo   45000
## 6 Hombre 1958-08-22   15 Administrativo   32100
```

``` r
# empleados %>% select(-(sexo:salario)) %>% head()
empleados %>% select(!(sexo:salario)) %>% head()
```

```
##   id salini tiempemp expprev minoria     sexoraza
## 1  1  27000       98     144      No Blanca varón
## 2  2  18750       98      36      No Blanca varón
## 3  3  12000       98     381      No Blanca mujer
## 4  4  13200       98     190      No Blanca mujer
## 5  5  21000       98     138      No Blanca varón
## 6  6  13500       98      67      No Blanca varón
```

Se pueden emplear distintas herramientas (*[selection helpers](https://tidyselect.r-lib.org/reference/language.html)*) para seleccionar variables (ver paquete [`tidyselect`](https://tidyselect.r-lib.org)):

- [`starts_with`](https://tidyselect.r-lib.org/reference/starts_with.html), [`ends_with`](https://tidyselect.r-lib.org/reference/starts_with.html), [`contains`](https://tidyselect.r-lib.org/reference/starts_with.html), [`matches`](https://tidyselect.r-lib.org/reference/starts_with.html), [`num_range`](https://tidyselect.r-lib.org/reference/starts_with.html): variables que coincidan con un patrón.

- [`all_of`](https://tidyselect.r-lib.org/reference/all_of.html), [`any_of`](https://tidyselect.r-lib.org/reference/all_of.html): variables de un vectores de caracteres.

- [`everything`](https://tidyselect.r-lib.org/reference/everything.html), [`last_col`](https://tidyselect.r-lib.org/reference/everything.html): todas las variables o la última variable.

- [`where()`](https://tidyselect.r-lib.org/reference/where.html): a partir de una función (e.g. `where(is.numeric)`)

Por ejemplo:

``` r
empleados %>% select(starts_with("s")) %>% head()
```

```
##     sexo salario salini     sexoraza
## 1 Hombre   57000  27000 Blanca varón
## 2 Hombre   40200  18750 Blanca varón
## 3  Mujer   21450  12000 Blanca mujer
## 4  Mujer   21900  13200 Blanca mujer
## 5 Hombre   45000  21000 Blanca varón
## 6 Hombre   32100  13500 Blanca varón
```

Podemos **crear variables con [`mutate()`](https://dplyr.tidyverse.org/reference/mutate.html)**:

``` r
emplea2 %>% 
  mutate(incsal = salario - salini, tsal = incsal/tiempemp) %>% 
  head()
```

```
##   id   sexo minoria tiempemp salini salario incsal      tsal
## 1  1 Hombre      No       98  27000   57000  30000 306.12245
## 2  2 Hombre      No       98  18750   40200  21450 218.87755
## 3  3  Mujer      No       98  12000   21450   9450  96.42857
## 4  4  Mujer      No       98  13200   21900   8700  88.77551
## 5  5 Hombre      No       98  21000   45000  24000 244.89796
## 6  6 Hombre      No       98  13500   32100  18600 189.79592
```


### Operaciones con casos (filas) {#dplyr-casos}

Podemos **seleccionar casos con [`filter()`](https://dplyr.tidyverse.org/reference/filter.html)**:

``` r
emplea2 %>% filter(sexo == "Mujer", minoria == "Sí") %>% head()
```

```
## [1] id       sexo     minoria  tiempemp salini   salario 
## <0 rows> (or 0-length row.names)
```

Podemos **reordenar casos con [`arrange()`](https://dplyr.tidyverse.org/reference/arrange.html)**:

``` r
emplea2 %>% arrange(salario) %>% head()
```

```
##    id  sexo minoria tiempemp salini salario
## 1 378 Mujer      No       70  10200   15750
## 2 338 Mujer      No       74  10200   15900
## 3  90 Mujer      No       92   9750   16200
## 4 224 Mujer      No       82  10200   16200
## 5 411 Mujer      No       68  10200   16200
## 6 448 Mujer   S\xed       66  10200   16350
```

``` r
emplea2 %>% arrange(desc(salini), salario) %>% head()
```

```
##    id   sexo minoria tiempemp salini salario
## 1  29 Hombre      No       96  79980  135000
## 2 343 Hombre      No       73  60000  103500
## 3 205 Hombre      No       83  52500   66750
## 4 160 Hombre      No       86  47490   66000
## 5 431 Hombre      No       66  45000   86250
## 6  32 Hombre      No       96  45000  110625
```

Podemos **resumir valores con [`summarise()`](https://dplyr.tidyverse.org/reference/summarise.html)**:

``` r
empleados %>% summarise(sal.med = mean(salario), n = n())
```

```
##    sal.med   n
## 1 34419.57 474
```

Para realizar **operaciones con múltiples variables podemos emplear [`across()`](https://dplyr.tidyverse.org/reference/across.html)** (admite selección de variables [`tidyselect`](https://tidyselect.r-lib.org)):

``` r
empleados %>% summarise(across(where(is.numeric), mean), n = n())
```

```
##      id     educ  salario   salini tiempemp  expprev   n
## 1 237.5 13.49156 34419.57 17016.09  81.1097 95.86076 474
```

``` r
# empleados %>% summarise(across(where(is.numeric) & !id, mean), n = n())
```

NOTA: Esta función sustituye a las "variantes de ámbito" `_at()`, `_if()` y  `_all()` de versiones anteriores de dplyr (como `summarise_at()`, `summarise_if()`, `summarise_all()`, `mutate_at()`, `mutate_if()`...) y también el uso de `vars()`.
En el caso de `filter()` se puede emplear [`if_any()`](https://dplyr.tidyverse.org/reference/across.html) e [`if_all()`](https://dplyr.tidyverse.org/reference/across.html).

Podemos **agrupar casos con [`group_by()`](https://dplyr.tidyverse.org/reference/group_by.html)**:

``` r
empleados %>% group_by(sexo, minoria) %>% 
    summarise(sal.med = mean(salario), n = n()) %>%
    ungroup()
```

```
## # A tibble: 4 x 4
##   sexo   minoria sal.med     n
##   <fct>  <fct>     <dbl> <int>
## 1 Hombre "No"     44475.   194
## 2 Hombre "S\xed"  32246.    64
## 3 Mujer  "No"     26707.   176
## 4 Mujer  "S\xed"  23062.    40
```

``` r
empleados %>% group_by(sexo, minoria) %>% 
    summarise(sal.med = mean(salario), n = n(), .groups = "drop")
```

```
## # A tibble: 4 x 4
##   sexo   minoria sal.med     n
##   <fct>  <fct>     <dbl> <int>
## 1 Hombre "No"     44475.   194
## 2 Hombre "S\xed"  32246.    64
## 3 Mujer  "No"     26707.   176
## 4 Mujer  "S\xed"  23062.    40
```

``` r
# dplyr >= 1.1.0 # packageVersion("dplyr")
# empleados %>% summarise(sal.med = mean(salario), n = n(), 
#                         .by = c(sexo, minoria))
```

Por defecto la agrupación se mantiene para el resto de operaciones, habría que emplear `ungroup()` (o el argumento `.groups = "drop"`) para eliminarla (se puede emplear `group_vars()` o `str()` para ver la agrupación).
Desde dplyr 1.1.0 (2023-01-29) está disponible un parámetro `.by/by` en `mutate()`, `summarise()`, `filter()` y `slice()` como alternativa a agrupar y desagrupar posteriormente.
Para más detalles ver [Per-operation grouping with .by/by](https://dplyr.tidyverse.org/reference/dplyr_by.html).

### Datos faltantes {#tidyr-missing}

Continuamos con el ejemplo de la Sección \@ref{missing}. 
*tidyverse* dispone de muchas herramientas para el tratamiento de los datos faltantes.


``` r
data("airquality")
datos <- airquality
library(visdat)
vis_dat(airquality)
# vis_miss(airquality)
```

Visualización (amigable) de la estrutura de datos:

``` r
library(naniar)
bind_shadow(airquality)
```

```
## # A tibble: 153 x 12
##    Ozone Solar.R  Wind  Temp Month   Day Ozone_NA Solar.R_NA Wind_NA Temp_NA
##    <int>   <int> <dbl> <int> <int> <int> <fct>    <fct>      <fct>   <fct>  
##  1    41     190   7.4    67     5     1 !NA      !NA        !NA     !NA    
##  2    36     118   8      72     5     2 !NA      !NA        !NA     !NA    
##  3    12     149  12.6    74     5     3 !NA      !NA        !NA     !NA    
##  4    18     313  11.5    62     5     4 !NA      !NA        !NA     !NA    
##  5    NA      NA  14.3    56     5     5 NA       NA         !NA     !NA    
##  6    28      NA  14.9    66     5     6 !NA      NA         !NA     !NA    
##  7    23     299   8.6    65     5     7 !NA      !NA        !NA     !NA    
##  8    19      99  13.8    59     5     8 !NA      !NA        !NA     !NA    
##  9     8      19  20.1    61     5     9 !NA      !NA        !NA     !NA    
## 10    NA     194   8.6    69     5    10 NA       !NA        !NA     !NA    
## # i 143 more rows
## # i 2 more variables: Month_NA <fct>, Day_NA <fct>
```

``` r
# nabular(airquality)
```

Distribución por variables de los datos faltantes:


``` r
miss_var_table(airquality) 
```

```
## # A tibble: 3 x 3
##   n_miss_in_var n_vars pct_vars
##           <int>  <int>    <dbl>
## 1             0      4     66.7
## 2             7      1     16.7
## 3            37      1     16.7
```

``` r
prop_miss_case(airquality)
```

```
## [1] 0.2745098
```

``` r
gg_miss_upset(airquality) 
```



\begin{center}\includegraphics[width=0.8\linewidth]{04-dplyr_files/figure-latex/unnamed-chunk-23-1} \end{center}

Distribución conjunta de los valores faltantes para la radiación solar y ozono:

``` r
library(naniar)
library(ggplot2)
ggplot(airquality, 
       aes(x = Solar.R, 
           y = Ozone)) + 
  geom_miss_point()
```



\begin{center}\includegraphics[width=0.8\linewidth]{04-dplyr_files/figure-latex/unnamed-chunk-24-1} \end{center}

Distribución mensual de los valores faltantes:

``` r
# gg_miss_var(airquality)
gg_miss_var(airquality, facet = Month)
```



\begin{center}\includegraphics[width=0.8\linewidth]{04-dplyr_files/figure-latex/unnamed-chunk-25-1} \end{center}

<!--
library(dplyr)
gg_miss_upset(pen) # Relacioese entre las variables en los datos ausentes
n_miss(penguins)
tidyr::replace_na: Missing values turns into a value (NA –> -99)
naniar::replace_with_na: Value becomes a missing value (-99 –> NA)
as_shadow(airquality)
aq_shadow <- bind_shadow(airquality)
aq_nab <- nabular(airquality)

glimpse(aq_shadow)
glimpse(aq_nab)
# Numerical summaries of missing values
dplyr::n_distinct(airquality)
## [1] 153
dplyr::n_distinct(airquality$Ozone)
prop_miss_case(airquality)
miss_case_summary(airquality)
Future development
Make naniar work with big data tools like sparklyr, and sparklingwater.
Provide tools for assessing goodness of fit for classical approaches of MCAR, MAR, and MNAR (graphical inference from nullabor package)
-->


## Herramientas tidyr {#tidyr-pkg}

Algunas funciones del paquete [`tidyr`](https://tidyr.tidyverse.org) que pueden resultar de especial interés son:

- [`pivot_wider()`](https://tidyr.tidyverse.org/reference/pivot_wider.html): permite transformar valores de grupos de casos a nuevas variables.
- [`pivot_longer()`](https://tidyr.tidyverse.org/reference/pivot_longer.html): realiza la transformación inversa, colapsar varias columnas en una. 

Ver la viñeta [Pivoting](https://tidyr.tidyverse.org/articles/pivot.html) para más detalles.

- [`separate()`](https://tidyr.tidyverse.org/reference/separate.html): permite separar una columna de texto en varias (ver también [`extract()`](https://tidyr.tidyverse.org/reference/extract.html)).

Ver [mortalidad.R](ejemplos/mortalidad/mortalidad.R) en [ejemplos](https://github.com/rubenfcasal/book_notasr/tree/main/ejemplos).


## Operaciones con tablas de datos {#dplyr-join}

Se emplean funciones `xxx_join()` (ver la documentación del paquete 
[Join two tbls together](https://dplyr.tidyverse.org/reference/join.html),
o la vignette [Two-table verbs](https://dplyr.tidyverse.org/articles/two-table.html)):

- `inner_join()`: devuelve las filas de `x` que tienen valores coincidentes en `y`, 
  y todas las columnas de `x` e `y`. Si hay varias coincidencias entre `x` e `y`, 
  se devuelven todas las combinaciones.
  
- `left_join()`: devuelve todas las filas de `x` y todas las columnas de `x` e `y`. 
  Las filas de `x` sin correspondencia en `y` contendrán `NA` en las nuevas columnas. 
  Si hay varias coincidencias entre `x` e `y`, se devuelven todas las combinaciones
  (duplicando las filas).

    `right_join()` hace lo contrario, devuelve todas las filas de `y`.
    
    `full_join()` devuelve todas las filas de `x` e `y` (duplicando o asignando `NA` si es necesario).

- `semi_join()`: devuelve las filas de `x` que tienen valores coincidentes en `y`, 
  manteniendo sólo las columnas de `x` (al contrario que `inner_join()` no duplica filas).
  
    `anti_join()` hace lo contrario, devuelve las filas sin correspondencia. 

El parámetro `by` determina las variables clave para las correspondencias.
Si no se establece se considerarán todas las que tengan el mismo nombre en ambas tablas.
Se puede establecer a un vector de nombres coincidentes y en caso de que los nombres sean distintos a un vector con nombres de la forma `c("clave_x" = "clave_y")`.

Adicionalmente, si las tablas `x` e `y` tienen las mismas variables, se pueden combinar las observaciones con operaciones de conjuntos:

- `intersect(x, y)`: observaciones en `x` y en `y`.

- `union(x, y)`: observaciones en `x` o `y` no duplicadas.

- `setdiff(x, y)`: observaciones en `x` pero no en `y`.


## Bases de datos con dplyr {#dbplyr}

Para poder usar tablas en bases de datos relacionales con `dplyr` hay que emplear el paquete [dbplyr](https://dbplyr.tidyverse.org) (convierte automáticamente el código de dplyr en consultas SQL).

Algunos enlaces:

- [Best Practices in Working with Databases](https://solutions.posit.co/connections/db)

- [Introduction to dbplyr](https://dbplyr.tidyverse.org/articles/dbplyr.html)

- [Data Carpentry](https://datacarpentry.org/R-ecology-lesson/index.html):
  [SQL databases and R](https://datacarpentry.org/R-ecology-lesson/05-r-and-databases.html), 

- [R and Data – When Should we Use Relational Databases? ](https://intellixus.com/2018/06/29/r-and-data-when-should-we-use-relational-databases)


### Ejemplos

Como ejemplo emplearemos la base de datos de [SQLite Sample Database Tutorial](https://www.sqlitetutorial.net/sqlite-sample-database/), almacenada en el archivo [*chinook.db*](data/chinook.db).


``` r
# install.packages('dbplyr')
library(dplyr)
library(dbplyr)
```

En primer lugar hay que conectar la base de datos:

``` r
chinook <- DBI::dbConnect(RSQLite::SQLite(), "data/chinook.db")
```

Podemos listar las tablas:

``` r
src_dbi(chinook)
```

```
## src:  sqlite 3.47.1 [/home/diego/UDC/Teaching/MTE/TGD/tgdbook-guillermo/data/chinook.db]
## tbls: albums, artists, customers, employees, genres, invoice_items, invoices,
##   media_types, playlist_track, playlists, sqlite_sequence, sqlite_stat1, tracks
```

Para enlazar una tabla:

``` r
invoices <- tbl(chinook, "invoices")
invoices
```

```
## # Source:   table<`invoices`> [?? x 9]
## # Database: sqlite 3.47.1 [/home/diego/UDC/Teaching/MTE/TGD/tgdbook-guillermo/data/chinook.db]
##    InvoiceId CustomerId InvoiceDate      BillingAddress BillingCity BillingState
##        <int>      <int> <chr>            <chr>          <chr>       <chr>       
##  1         1          2 2009-01-01 00:0~ Theodor-Heuss~ Stuttgart   <NA>        
##  2         2          4 2009-01-02 00:0~ Ullevålsveien~ Oslo        <NA>        
##  3         3          8 2009-01-03 00:0~ Grétrystraat ~ Brussels    <NA>        
##  4         4         14 2009-01-06 00:0~ 8210 111 ST NW Edmonton    AB          
##  5         5         23 2009-01-11 00:0~ 69 Salem Stre~ Boston      MA          
##  6         6         37 2009-01-19 00:0~ Berger Straße~ Frankfurt   <NA>        
##  7         7         38 2009-02-01 00:0~ Barbarossastr~ Berlin      <NA>        
##  8         8         40 2009-02-01 00:0~ 8, Rue Hanovre Paris       <NA>        
##  9         9         42 2009-02-02 00:0~ 9, Place Loui~ Bordeaux    <NA>        
## 10        10         46 2009-02-03 00:0~ 3 Chatham Str~ Dublin      Dublin      
## # i more rows
## # i 3 more variables: BillingCountry <chr>, BillingPostalCode <chr>,
## #   Total <dbl>
```

Ojo `[?? x 9]`: de momento no conoce el número de filas.

``` r
nrow(invoices)
```

```
## [1] NA
```

1. Podemos mostrar la consulta SQL correspondiente a una operación:

``` r
show_query(head(invoices))
```

```
## <SQL>
## SELECT `invoices`.*
## FROM `invoices`
## LIMIT 6
```

``` r
# str(head(invoices))
```

Al trabajar con bases de datos, dplyr intenta ser lo más vago posible:

-  No exporta datos a R a menos que se pida explícitamente (`collect()`).

-  Retrasa cualquier operación lo máximo posible: 
   agrupa todo lo que se desea hacer y luego hace una única petición a la base de datos.
   

``` r
invoices %>% head %>% collect
```

```
## # A tibble: 6 x 9
##   InvoiceId CustomerId InvoiceDate       BillingAddress BillingCity BillingState
##       <int>      <int> <chr>             <chr>          <chr>       <chr>       
## 1         1          2 2009-01-01 00:00~ Theodor-Heuss~ Stuttgart   <NA>        
## 2         2          4 2009-01-02 00:00~ Ullevålsveien~ Oslo        <NA>        
## 3         3          8 2009-01-03 00:00~ Grétrystraat ~ Brussels    <NA>        
## 4         4         14 2009-01-06 00:00~ 8210 111 ST NW Edmonton    AB          
## 5         5         23 2009-01-11 00:00~ 69 Salem Stre~ Boston      MA          
## 6         6         37 2009-01-19 00:00~ Berger Straße~ Frankfurt   <NA>        
## # i 3 more variables: BillingCountry <chr>, BillingPostalCode <chr>,
## #   Total <dbl>
```

``` r
invoices %>% count # número de filas
```

```
## # Source:   SQL [?? x 1]
## # Database: sqlite 3.47.1 [/home/diego/UDC/Teaching/MTE/TGD/tgdbook-guillermo/data/chinook.db]
##       n
##   <int>
## 1   412
```

2. Por ejemplo, para obtener el importe mínimo, máximo y la media de las facturas:


``` r
res <- invoices %>% summarise(min = min(Total, na.rm = TRUE), 
                        max = max(Total, na.rm = TRUE), 
                        med = mean(Total, na.rm = TRUE))
# show_query(res)
res  %>% collect
```

```
## # A tibble: 1 x 3
##     min   max   med
##   <dbl> <dbl> <dbl>
## 1  0.99  25.9  5.65
```

3. Para obtener el total de las facturas de cada uno de los países:


``` r
res <- invoices %>% group_by(BillingCountry) %>% 
          summarise(n = n(), total = sum(Total, na.rm = TRUE))
# show_query(res)
res  %>% collect
```

```
## # A tibble: 24 x 3
##    BillingCountry     n total
##    <chr>          <int> <dbl>
##  1 Argentina          7  37.6
##  2 Australia          7  37.6
##  3 Austria            7  42.6
##  4 Belgium            7  37.6
##  5 Brazil            35 190. 
##  6 Canada            56 304. 
##  7 Chile              7  46.6
##  8 Czech Republic    14  90.2
##  9 Denmark            7  37.6
## 10 Finland            7  41.6
## # i 14 more rows
```

4. Para obtener un listado con Nombre y Apellidos de cliente y el importe de cada una de sus facturas (Hint: WHERE customer.CustomerID=invoices.CustomerID):


``` r
customers <- tbl(chinook, "customers")
tbl_vars(customers) 
```

```
## <dplyr:::vars>
##  [1] "CustomerId"   "FirstName"    "LastName"     "Company"      "Address"     
##  [6] "City"         "State"        "Country"      "PostalCode"   "Phone"       
## [11] "Fax"          "Email"        "SupportRepId"
```

``` r
res <- customers %>% 
  inner_join(invoices, by = "CustomerId") %>% 
  select(FirstName, LastName, Country, Total) 
show_query(res)
```

```
## <SQL>
## SELECT `FirstName`, `LastName`, `Country`, `Total`
## FROM `customers`
## INNER JOIN `invoices`
##   ON (`customers`.`CustomerId` = `invoices`.`CustomerId`)
```

``` r
res  %>% collect
```

```
## # A tibble: 412 x 4
##    FirstName LastName  Country Total
##    <chr>     <chr>     <chr>   <dbl>
##  1 Luís      Gonçalves Brazil   3.98
##  2 Luís      Gonçalves Brazil   3.96
##  3 Luís      Gonçalves Brazil   5.94
##  4 Luís      Gonçalves Brazil   0.99
##  5 Luís      Gonçalves Brazil   1.98
##  6 Luís      Gonçalves Brazil  13.9 
##  7 Luís      Gonçalves Brazil   8.91
##  8 Leonie    Köhler    Germany  1.98
##  9 Leonie    Köhler    Germany 13.9 
## 10 Leonie    Köhler    Germany  8.91
## # i 402 more rows
```

5. Para listar los 10 mejores clientes (aquellos a los que se les ha facturado más cantidad) indicando Nombre, Apellidos, Pais y el importe total de su facturación:


``` r
customers %>% inner_join(invoices, by = "CustomerId") %>% group_by(CustomerId) %>% 
    summarise(FirstName, LastName, country, total = sum(Total, na.rm = TRUE)) %>%  
    arrange(desc(total)) %>% head(10) %>% collect
```


6.  Listar los 10 mejores clientes (aquellos a los que se les ha facturado más cantidad) 
    indicando Nombre, Apellidos, Pais y el importe total de su facturación.

    
    ``` r
    customers %>% inner_join(invoices, by = "CustomerId") %>% group_by(CustomerId) %>% 
        summarise(FirstName, LastName, Country, total = sum(Total, na.rm = TRUE)) %>%  
        arrange(desc(total)) %>% head(10) %>% collect
    ```
    
    ```
    ## # A tibble: 10 x 5
    ##    CustomerId FirstName LastName   Country        total
    ##         <int> <chr>     <chr>      <chr>          <dbl>
    ##  1          6 Helena    Holý       Czech Republic  49.6
    ##  2         26 Richard   Cunningham USA             47.6
    ##  3         57 Luis      Rojas      Chile           46.6
    ##  4         45 Ladislav  Kovács     Hungary         45.6
    ##  5         46 Hugh      O'Reilly   Ireland         45.6
    ##  6         24 Frank     Ralston    USA             43.6
    ##  7         28 Julia     Barnett    USA             43.6
    ##  8         37 Fynn      Zimmermann Germany         43.6
    ##  9          7 Astrid    Gruber     Austria         42.6
    ## 10         25 Victor    Stevens    USA             42.6
    ```

7.  Listar los géneros musicales por orden decreciente de popularidad 
    (definida la popularidad como el número de canciones de ese género), 
    indicando el porcentaje de las canciones de ese género.

    
    ``` r
    tracks <- tbl(chinook, "tracks")
    tracks %>% inner_join(tbl(chinook, "genres"), by = "GenreId") %>% count(Name.y) %>% 
        arrange(desc(n)) %>% collect %>% mutate(freq = n / sum(n))
    ```
    
    ```
    ## # A tibble: 25 x 3
    ##    Name.y                 n   freq
    ##    <chr>              <int>  <dbl>
    ##  1 Rock                1297 0.370 
    ##  2 Latin                579 0.165 
    ##  3 Metal                374 0.107 
    ##  4 Alternative & Punk   332 0.0948
    ##  5 Jazz                 130 0.0371
    ##  6 TV Shows              93 0.0265
    ##  7 Blues                 81 0.0231
    ##  8 Classical             74 0.0211
    ##  9 Drama                 64 0.0183
    ## 10 R&B/Soul              61 0.0174
    ## # i 15 more rows
    ```

8.  Listar los 10 artistas con mayor número de canciones 
    de forma descendente según el número de canciones.

    
    ``` r
    tracks %>% inner_join(tbl(chinook, "albums"), by = "AlbumId") %>% 
        inner_join(tbl(chinook, "artists"), by = "ArtistId") %>% 
        count(Name.y) %>% arrange(desc(n)) %>% collect
    ```
    
    ```
    ## # A tibble: 204 x 2
    ##    Name.y              n
    ##    <chr>           <int>
    ##  1 Iron Maiden       213
    ##  2 U2                135
    ##  3 Led Zeppelin      114
    ##  4 Metallica         112
    ##  5 Lost               92
    ##  6 Deep Purple        92
    ##  7 Pearl Jam          67
    ##  8 Lenny Kravitz      57
    ##  9 Various Artists    56
    ## 10 The Office         53
    ## # i 194 more rows
    ```

Al finalizar hay que desconectar la base de datos:


``` r
DBI::dbDisconnect(chinook)            
```

