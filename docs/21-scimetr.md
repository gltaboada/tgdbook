# El paquete scimetr {#scimetr}




Package `scimetr` implements tools for quantitative research in scientometrics and bibliometrics. 
It provides routines for importing bibliographic data from Thomson Reuters' Web of Science (http://www.webofknowledge.com) and performing bibliometric analysis. For more information visit https://rubenfcasal.github.io/scimetr/articles/scimetr.html. 


Instalación
-----------

Para instalar el paquete sería recomendable en primer lugar instalar las dependencias:


```r
install.packages(c('dplyr', 'lazyeval', 'stringr', 'ggplot2', 'openxlsx', 'tidyr'))
```

Como de momento no está disponible en CRAN, 
habría que instalar la versión de desarrollo en GitHub.
En Windows bastaría con instalar la versión binaria del paquete *scimetr_X.Y.Z.zip*
(disponible [aqui](https://github.com/rubenfcasal/scimetr/tree/master/docs)), 
alternativamente se puede instalar directamente de GitHub:

```r
# install.packages("devtools")
devtools::install_github("rubenfcasal/scimetr")
```

Una vez instalado ya podríamos cargar el paquete:


```r
library(scimetr)
```


Carga de datos
--------------

### Datos de ejemplo

En el paquete se incluyen dos conjuntos de datos de ejemplo 
correspondientes a la búsqueda en WoS
por el campo Organización-Nombre preferido de la UDC 
(Organization-Enhaced: OG = Universidade da Coruna):

- `wosdf`: año 2015.

- `wosdf2`:  área de investigación 'Mathematics', años 2008-2017.

Variables WoS:


```r
# View(wosdf2) # En RStudio...
variable.labels <- attr(wosdf, "variable.labels")
knitr::kable(as.data.frame(variable.labels)) # caption = "Variable labels"
```


\begin{tabular}{l|l}
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

Se puede crear una base de datos con la función `CreateDB.wos()`:


```r
db <- CreateDB.wos(wosdf2, label = "Mathematics_UDC_2008-2017 (01-02-2019)")
str(db, 1)
```

```
## List of 11
##  $ Docs      :'data.frame':	389 obs. of  26 variables:
##  $ Authors   :'data.frame':	611 obs. of  4 variables:
##  $ AutDoc    :'data.frame':	1260 obs. of  2 variables:
##  $ Categories:'data.frame':	46 obs. of  2 variables:
##  $ CatDoc    :'data.frame':	866 obs. of  2 variables:
##  $ Areas     :'data.frame':	26 obs. of  2 variables:
##  $ AreaDoc   :'data.frame':	771 obs. of  2 variables:
##  $ Addresses :'data.frame':	896 obs. of  5 variables:
##  $ AddAutDoc :'data.frame':	1328 obs. of  3 variables:
##  $ Journals  :'data.frame':	150 obs. of  12 variables:
##  $ label     : chr "Mathematics_UDC_2008-2017 (01-02-2019)"
##  - attr(*, "variable.labels")= Named chr [1:62] "Publication type" "Author" "Book authors" "Editor" ...
##   ..- attr(*, "names")= chr [1:62] "PT" "AU" "BA" "BE" ...
##  - attr(*, "class")= chr "wos.db"
```

### Cargar datos de directorio

Se pueden cargar automáticamente los archivos wos
(tienen una limitación de 500 registros) de un subdirectorio:


```r
dir("UDC_2008-2017 (01-02-2019)", pattern='*.txt')
```

```
##  [1] "savedrecs01.txt" "savedrecs02.txt" "savedrecs03.txt" "savedrecs04.txt"
##  [5] "savedrecs05.txt" "savedrecs06.txt" "savedrecs07.txt" "savedrecs08.txt"
##  [9] "savedrecs09.txt" "savedrecs10.txt" "savedrecs11.txt" "savedrecs12.txt"
## [13] "savedrecs13.txt" "savedrecs14.txt" "savedrecs15.txt"
```


Se pueden combinar los ficheros y crear la correspondiente base de datos con los siguientes comandos:


```r
wos.txt <- ImportSources.wos("UDC_2008-2017 (01-02-2019)", other = FALSE)
db.txt <- CreateDB.wos(wos.txt)
```


Sumarios
--------

### Sumario `summary.wos.db()`


```r
res1 <- summary(db)
options(digits = 5)
res1
```

```
## Number of documents: 389 
## Authors: 611 
## Period: 2008 - 2017 
## 
## Document types:
##                    Documents
## Article                  360
## Correction                 1
## Editorial Material         5
## Proceedings Paper         16
## Review                     7
## 
## Number of authors per document:
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##    1.00    2.00    3.00    3.24    4.00    8.00 
## 
## Number of documents per author:
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##    1.00    1.00    1.00    2.06    2.00   29.00 
## 
## Number of times cited:
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##     0.0     1.0     3.0    10.9     9.0  1139.0 
## 
## Indexes:
##  H  G 
## 24 54 
## 
## Top Categories:
##                                                  Documents
## Mathematics, Interdisciplinary Applications            134
## Mathematics, Applied                                   130
## Statistics & Probability                               121
## Mathematics                                             77
## Engineering, Multidisciplinary                          64
## Mechanics                                               59
## Computer Science, Interdisciplinary Applications        45
## Computer Science, Artificial Intelligence               20
## Social Sciences, Mathematical Methods                   17
## Automation & Control Systems                            16
## Others                                                 183
## 
## Top Areas:
##                                         Documents
## Mathematics                                   389
## Computer Science                               69
## Engineering                                    69
## Mechanics                                      59
## Physics                                        22
## Chemistry                                      17
## Mathematical Methods In Social Sciences        17
## Automation & Control Systems                   16
## Instruments & Instrumentation                  16
## Business & Economics                           15
## Others                                         82
## 
## Top Journals:
##                                     Documents
## Comput. Meth. Appl. Mech. Eng.             29
## J. Math. Anal. Appl.                       11
## Chemometrics Intell. Lab. Syst.            11
## Rev. Int. Metod. Numer. Calc. Dise.        11
## J. Comput. Appl. Math.                     10
## Comput. Stat. Data Anal.                    9
## Appl. Numer. Math.                          9
## Int. J. Numer. Methods Fluids               9
## Int. J. Numer. Methods Eng.                 8
## J. Nonparametr. Stat.                       8
## Others                                    274
## 
## Top Countries:
##         Documents
## Spain         389
## USA            49
## France         32
## Italy          13
## Mexico         11
## UK             11
## Germany        10
## Canada          8
## China           8
## Belgium         7
## Others         52
```

### Sumario por años `summary_year()`


```r
res2 <- summary_year(db)
res2
```

```
## 
## Annual Scientific Production:
## 
##      Documents
## 2008        42
## 2009        28
## 2010        40
## 2011        37
## 2012        44
## 2013        40
## 2014        38
## 2015        39
## 2016        47
## 2017        34
## 
## Annual Authors per Document:
## 
##          Avg Median
##  2008 2.8810    3.0
##  2009 3.3214    3.0
##  2010 3.3500    3.0
##  2011 3.3784    3.0
##  2012 2.8182    2.5
##  2013 3.3750    3.0
##  2014 3.2368    3.0
##  2015 3.0513    3.0
##  2016 3.5745    3.0
##  2017 3.4706    3.0
## 
## Annual Times Cited:
## 
##       Cites     Avg Median
##  2008   755 17.9762    5.0
##  2009   265  9.4643    6.0
##  2010   410 10.2500    5.0
##  2011  1422 38.4324    5.0
##  2012   335  7.6136    3.5
##  2013   271  6.7750    4.0
##  2014   336  8.8421    3.5
##  2015   215  5.5128    2.0
##  2016   192  4.0851    2.0
##  2017    55  1.6176    1.0
```


Gráficos
--------

Se emplea la librería [`ggplot2`](https://ggplot2.tidyverse.org)...


### Gráficos de la base de datos `plot.wos.db()`


```r
plot(db)
```



\begin{center}\includegraphics[width=0.7\linewidth]{21-scimetr_files/figure-latex/plotdb-1} \end{center}



\begin{center}\includegraphics[width=0.7\linewidth]{21-scimetr_files/figure-latex/plotdb-2} \end{center}



\begin{center}\includegraphics[width=0.7\linewidth]{21-scimetr_files/figure-latex/plotdb-3} \end{center}

### Gráficos sumario `plot.summary.wos.db()`


```r
plot(res1)
```



\begin{flushleft}\includegraphics[width=0.7\linewidth]{21-scimetr_files/figure-latex/unnamed-chunk-9-1} \end{flushleft}



\begin{flushleft}\includegraphics[width=0.7\linewidth]{21-scimetr_files/figure-latex/unnamed-chunk-9-2} \end{flushleft}



\begin{flushleft}\includegraphics[width=0.7\linewidth]{21-scimetr_files/figure-latex/unnamed-chunk-9-3} \end{flushleft}



\begin{flushleft}\includegraphics[width=0.7\linewidth]{21-scimetr_files/figure-latex/unnamed-chunk-9-4} \end{flushleft}



\begin{flushleft}\includegraphics[width=0.7\linewidth]{21-scimetr_files/figure-latex/unnamed-chunk-9-5} \end{flushleft}

```r
plot(res1, pie = TRUE)
```



\begin{flushleft}\includegraphics[width=0.7\linewidth]{21-scimetr_files/figure-latex/unnamed-chunk-9-6} \end{flushleft}



\begin{flushleft}\includegraphics[width=0.7\linewidth]{21-scimetr_files/figure-latex/unnamed-chunk-9-7} \end{flushleft}



\begin{flushleft}\includegraphics[width=0.7\linewidth]{21-scimetr_files/figure-latex/unnamed-chunk-9-8} \end{flushleft}



\begin{flushleft}\includegraphics[width=0.7\linewidth]{21-scimetr_files/figure-latex/unnamed-chunk-9-9} \end{flushleft}



\begin{flushleft}\includegraphics[width=0.7\linewidth]{21-scimetr_files/figure-latex/unnamed-chunk-9-10} \end{flushleft}

### Gráficos sumario por años `plot.summary.year()`


```r
plot(res2)
```



\begin{flushleft}\includegraphics[width=0.7\linewidth]{21-scimetr_files/figure-latex/unnamed-chunk-10-1} \end{flushleft}



\begin{flushleft}\includegraphics[width=0.7\linewidth]{21-scimetr_files/figure-latex/unnamed-chunk-10-2} \end{flushleft}



\begin{flushleft}\includegraphics[width=0.7\linewidth]{21-scimetr_files/figure-latex/unnamed-chunk-10-3} \end{flushleft}

```r
plot(res2, boxplot = TRUE)
```



\begin{flushleft}\includegraphics[width=0.7\linewidth]{21-scimetr_files/figure-latex/unnamed-chunk-10-4} \end{flushleft}



\begin{flushleft}\includegraphics[width=0.7\linewidth]{21-scimetr_files/figure-latex/unnamed-chunk-10-5} \end{flushleft}

Filtrado
--------

Se combinan las funciones `get.id<Tabla>()` 
(se puede emplear cualquier variable de la correspondiente tabla; 
multiple conditions are combined with `&`, see e.g. `dplyr::filter()`) 
con la función `get.idDocs()`.

### Funciones get

- `get.idAuthors()`: buscar id (códigos) de autores

    Buscar un autor concreto:
      
    
    ```r
    idAuthor <- get.idAuthors(db, AF == "Cao, Ricardo")
    idAuthor
    ```
    
    ```
    ## Cao, Ricardo 
    ##           16
    ```
      
    Buscar en nombres de autores:
      
    
    ```r
    idAuthors <- get.idAuthors(db, grepl('Cao', AF))
    idAuthors
    ```
    
    ```
    ##           Cao, Ricardo Cao-Rial, Maria Teresa 
    ##                     16                     69
    ```

- `get.idAreas()`: Devuelve códigos de las áreas

    
    ```r
    get.idAreas(db, SC == 'Mathematics')
    ```
    
    ```
    ## Mathematics 
    ##          16
    ```
    
    ```r
    get.idAreas(db, SC == 'Mathematics' | SC == 'Computer Science')
    ```
    
    ```
    ## Computer Science      Mathematics 
    ##                7               16
    ```

- `get.idCategories()`: códigos de las categorías

    
    ```r
    get.idCategories(db, grepl('Mathematics', WC))
    ```
    
    ```
    ##                                 Mathematics 
    ##                                          28 
    ##                        Mathematics, Applied 
    ##                                          29 
    ## Mathematics, Interdisciplinary Applications 
    ##                                          30
    ```

- `get.idJournals()` códigos de las revistas

    
    ```r
    ijss <- get.idJournals(db, SO == 'JOURNAL OF STATISTICAL SOFTWARE')
    ijss
    ```
    
    ```
    ## JOURNAL OF STATISTICAL SOFTWARE 
    ##                             134
    ```
    
    ```r
    knitr::kable(db$Journals[ijss, ], caption = "JSS")
    ```
    
    \begin{table}
    
    \caption{(\#tab:unnamed-chunk-15)JSS}
    \centering
    \begin{tabular}[t]{l|r|l|l|l|l|l|l|l|l|l|l|l}
    \hline
      & idj & SO & SE & BS & LA & PU & PI & PA & SN & EI & J9 & JI\\
    \hline
    2796 & 134 & JOURNAL OF STATISTICAL SOFTWARE &  &  & English & JOURNAL STATISTICAL SOFTWARE & LOS ANGELES & UCLA DEPT STATISTICS, 8130 MATH SCIENCES BLDG, BOX 951554, LOS ANGELES, CA 90095-1554 USA & 1548-7660 &  & J STAT SOFTW & J. Stat. Softw.\\
    \hline
    \end{tabular}
    \end{table}
    
    ```r
    get.idJournals(db, JI == 'J. Stat. Softw.')
    ```
    
    ```
    ## JOURNAL OF STATISTICAL SOFTWARE 
    ##                             134
    ```

### Obtener documentos (de autores, revistas, ...)

Los indices anteriores se pueden combinar en `get.idDocs()`


```r
idocs <- get.idDocs(db, idAuthors = idAuthor)
idocs
```

```
##  [1]  10  16  23  33  40  56 128 183 187 196 210 220 269 286 295 312 315 332 340
## [20] 346 347 350 359 362 372 375 384 385
```

Los índices de documentos se pueden utilizar como filtro p.e. en `summary.wos.db()`.

### Sumarios filtrados

Obtener sumario de autores:


```r
summary(db, idocs)
```

```
## Number of documents: 28 
## Authors: 40 
## Period: 2008 - 2017 
## 
## Document types:
##                    Documents
## Article                   26
## Editorial Material         1
## Proceedings Paper          1
## 
## Number of authors per document:
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##    2.00    2.00    3.00    3.14    4.00    6.00 
## 
## Number of documents per author:
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##     1.0     1.0     1.0     2.2     2.0    28.0 
## 
## Number of times cited:
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##    0.00    1.00    2.00    3.25    4.25   14.00 
## 
## Indexes:
## H G 
## 5 7 
## 
## Top Categories:
##                                                  Documents
## Statistics & Probability                                26
## Mathematics, Interdisciplinary Applications              4
## Computer Science, Interdisciplinary Applications         3
## Economics                                                2
## Mathematical & Computational Biology                     2
## Social Sciences, Mathematical Methods                    2
## Automation & Control Systems                             1
## Biochemistry & Molecular Biology                         1
## Biology                                                  1
## Business, Finance                                        1
## Others                                                   4
## 
## Top Areas:
##                                            Documents
## Mathematics                                       28
## Computer Science                                   4
## Business & Economics                               2
## Mathematical & Computational Biology               2
## Mathematical Methods In Social Sciences            2
## Automation & Control Systems                       1
## Biochemistry & Molecular Biology                   1
## Chemistry                                          1
## Instruments & Instrumentation                      1
## Life Sciences & Biomedicine - Other Topics         1
## Others                                             1
## 
## Top Journals:
##                          Documents
## J. Nonparametr. Stat.            4
## Comput. Stat. Data Anal.         3
## Comput. Stat.                    3
## Ann. Inst. Stat. Math.           2
## Test                             2
## Stat. Neerl.                     1
## J. Multivar. Anal.               1
## J. Time Ser. Anal.               1
## Stat. Probab. Lett.              1
## J. Appl. Stat.                   1
## Others                           9
## 
## Top Countries:
##           Documents
## Spain            28
## Belgium           6
## France            2
## Germany           2
## Argentina         1
## Canada            1
## India             1
## Mexico            1
## Norway            1
```

Obtener sumario de autores por años:


```r
summary_year(db, idocs)
```

```
## 
## Annual Scientific Production:
## 
##      Documents
## 2008         7
## 2009         4
## 2010         4
## 2011         1
## 2012         2
## 2013         3
## 2014         1
## 2016         2
## 2017         4
## 
## Annual Authors per Document:
## 
##          Avg Median
##  2008 2.4286    2.0
##  2009 3.7500    3.5
##  2010 3.5000    3.5
##  2011 4.0000    4.0
##  2012 3.0000    3.0
##  2013 3.6667    4.0
##  2014 2.0000    2.0
##  2016 2.5000    2.5
##  2017 3.5000    3.5
## 
## Annual Times Cited:
## 
##       Cites    Avg Median
##  2008    42 6.0000    6.0
##  2009    20 5.0000    3.0
##  2010     9 2.2500    2.0
##  2011     1 1.0000    1.0
##  2012     1 0.5000    0.5
##  2013     8 2.6667    2.0
##  2014     4 4.0000    4.0
##  2016     3 1.5000    1.5
##  2017     3 0.7500    0.5
```


Indices de autores
------------------

Obtener índices de múltiples autores


```r
TC.authors(db, idAuthors)
```

```
##                        H G
## Cao, Ricardo           5 7
## Cao-Rial, Maria Teresa 1 1
```

