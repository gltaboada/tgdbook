# El paquete CITAN {#citan}






The practical usability of the CITation ANalysis package 
for R statistical computing environment, is shown.
The main aim of the software is to support bibliometricians
with a tool for preprocessing and cleaning bibliographic
data retrieved from SciVerse Scopus and for calculating 
the most popular indices of scientific impact.

https://cran.r-project.org/web/packages/CITAN/index.html

https://cran.r-project.org/web/packages/CITAN/CITAN.pdf

https://github.com/gagolews/CITAN

https://www.gagolewski.com/publications/2011citan.pdf


```r
library(CITAN)
```

```
## Loading required package: agop
## Loading required package: RSQLite
## Loading required package: RGtk2
```
Emplea el paquete [`RSQLite`](https://r-dbi.github.io/RSQLite).

Sin embargo, la función `Scopus_ReadCSV()` produce un error en Windows. Para corregirlo:


```r
# Session > Set Working Directory > To Source...
source("datos/citan/Scopus_ReadCSV2.R")
```


## Creación de la base de datos

Se generará el archivo:


```r
dbfilename <- "data/citan/UDC2015.db"
```


### Primera ejecución: Creación del modelo de DB

Creación del archivo de BD vacío:


```r
conn <- lbsConnect(dbfilename)
```

```
## Warning in lbsConnect(dbfilename): Your Local Bibliometric Storage is
## empty. Use lbsCreate(...) to establish one.
```
Creación del esquema con [`lbsCreate()`](https://www.rdocumentation.org/packages/CITAN/versions/2015.12-2/topics/lbsCreate):


```r
lbsCreate(conn) 
```

```
## Warning: RSQLite::dbGetInfo() is deprecated: please use individual metadata
## functions instead

## Creating table 'Biblio_Categories'... Done.
## Creating table 'Biblio_Sources'... Done.
## Creating index for 'Biblio_Sources'... Done.
## Creating table 'Biblio_SourcesCategories'... Done.
## Creating table 'Biblio_Documents'... Done.
## Creating table 'Biblio_Citations'... Done.
## Creating table 'Biblio_Surveys'... Done.
## Creating table 'Biblio_DocumentsSurveys'... Done.
## Creating table 'Biblio_Authors'... Done.
## Creating table 'Biblio_AuthorsDocuments'... Done.
## Creating view 'ViewBiblio_DocumentsSurveys'... Done.
## Creating view 'ViewBiblio_DocumentsCategories'... Done.
## Your Local Bibliometric Storage has been created.
##    Perhaps now you may wish to use Scopus_ImportSources(...) to import source information.

## [1] TRUE
```

Importar información de Scopus (descargada previamente...)
con la función [`Scopus_ImportSources()`](https://www.rdocumentation.org/packages/CITAN/versions/2015.12-2/topics/Scopus_ImportSources) ([código](https://github.com/gagolews/CITAN/blob/master/R/scopus.importsources.R)):


```r
Scopus_ImportSources(conn) # Cuidado con el tiempo de CPU...
```

```
## Importing Scopus ASJC codes... Done, 334 records added.
## Importing Scopus source list...

## Warning in doTryCatch(return(expr), name, parentenv, handler): No ASJC @
## row=510.

## Warnings... __TRUNCATED__

## Done, 30787 of 30794 records added; 55297 ASJC codes processed.
## Note: 7 records omitted @ rows=13847,15526,16606,17371,19418,24419,29365.

## [1] TRUE
```

### Incorporar nuevos datos 

Con la función `Scopus_ReadCSV()` se produce un error en Windows:


```r
data <-  Scopus_ReadCSV("udc_2015.csv")
```

```
## Error in Scopus_ReadCSV("udc_2015.csv") : Column not found: `Source'.
```

Empleando la versión modificada:


```r
data <-  Scopus_ReadCSV2("udc_2015.csv")
```

Añadir los documentos a la base de datos:


```r
lbsImportDocuments(conn, data) 
```

```
## Importing documents and their authors... Importing 1324 authors... 1324 new authors added.

## Warning in .lbsImportDocuments_Add_Get_idSource(conn, record$SourceTitle, :
## no source with sourceTitle=''Quaternary Science Reviews'' found for record
## 10. Setting IdSource=NA.

## Warnings... __TRUNCATED__

## Done, 363 of 363 new records added to Default survey/udc_2015.csv.

## [1] TRUE
```

Se podría añadir una descripción para trabajar con distintos grupos de documentos:


```r
lbsImportDocuments(conn, data, "udc_2015") 
```


## Extraer información de la BD

En siguientes ejecuciones bastará con conectar con la BD 


```r
conn <- lbsConnect(dbfilename)
```


### Estadísticos descriptivos



```r
lbsDescriptiveStats(conn)
```

```
## Number of sources in your LBS:           30787
## Number of documents in your LBS:         363
## Number of author records in your LBS:    1324
## Number of author groups in your LBS:     1
## Number of ungrouped authors in your LBS: 1324
## 
## You have chosen the following data restrictions:
## 	Survey:         <ALL>.
## 	Document types: <ALL>.
## 
## Surveys:
##   surveyDescription DocumentCount
## 1    Default survey           363
##   * Note that a document may belong to many surveys/files.
```



\begin{center}\includegraphics[width=0.7\linewidth]{22-CITAN_files/figure-latex/unnamed-chunk-13-1} \end{center}

```
## Document types:
## 
##  ar  cp  ip  re  le  no  sh  er 
## 256  52  24  15   6   2   2   1
```



\begin{center}\includegraphics[width=0.7\linewidth]{22-CITAN_files/figure-latex/unnamed-chunk-13-2} \end{center}

```
## Publication years:
## 
## 2014 2015 2016 
##    1  354    8
```



\begin{center}\includegraphics[width=0.7\linewidth]{22-CITAN_files/figure-latex/unnamed-chunk-13-3} \end{center}

```
## Citations per document:
## 
##   0   1   2   3   4   5   6   7   9  10  11  12  15 
## 223  73  25  17  14   2   1   2   1   2   1   1   1
```



\begin{center}\includegraphics[width=0.7\linewidth]{22-CITAN_files/figure-latex/unnamed-chunk-13-4} \end{center}



\begin{center}\includegraphics[width=0.7\linewidth]{22-CITAN_files/figure-latex/unnamed-chunk-13-5} \end{center}



\begin{center}\includegraphics[width=0.7\linewidth]{22-CITAN_files/figure-latex/unnamed-chunk-13-6} \end{center}

```
## Categories of documents:
##          Economics, Econometrics and Finance(all) 
##                                                 8 
##                                  Engineering(all) 
##                                                45 
##                          Arts and Humanities(all) 
##                                                 9 
##                                     Medicine(all) 
##                                                43 
##                         Chemical Engineering(all) 
##                                                10 
##                             Computer Science(all) 
##                                                35 
##   Pharmacology, Toxicology and Pharmaceutics(all) 
##                                                10 
##                                             Other 
##                                                33 
##                            Materials Science(all) 
##                                                22 
##         Agricultural and Biological Sciences(all) 
##                                                27 
##                                  Mathematics(all) 
##                                                30 
## Biochemistry, Genetics and Molecular Biology(all) 
##                                                32 
##                        Environmental Science(all) 
##                                                32 
##                              Social Sciences(all) 
##                                                32 
##                        Physics and Astronomy(all) 
##                                                19 
##                                       Energy(all) 
##                                                10 
##          Business, Management and Accounting(all) 
##                                                10 
##                                   Psychology(all) 
##                                                 8 
##                                    Chemistry(all) 
##                                                51
```



\begin{center}\includegraphics[width=0.7\linewidth]{22-CITAN_files/figure-latex/unnamed-chunk-13-7} \end{center}

```
## Documents per author:
## 
##    1    2    3    4    5    6    7    8    9   10   11   13   16 
## 1000  224   46   18   12    8    6    1    1    2    2    1    1
```


### Otra información

Se puede obtener información acerca de los documentos producidos y las citas
recibidas correspondientes a cada autor: 


```r
citseq <- lbsGetCitations(conn)
```

```
## Data set restrictions:
## 	Survey:         <ALL>.
## 	Document types: <ALL>.
## 
## Creating citation sequences... OK, 1322 of 1322 records read.
```

```r
# citseq <- lbsGetCitations(conn, surveyDescription="udc_2015")
```

Número de autores


```r
length(citseq) 
```

```
## [1] 1322
```

```r
head(names(citseq))
```

```
## [1] "LÓPEZ-GARCÍA X."   "MARWAH S."         "OTERO T.P."       
## [4] "IGLESIAS M.P."     "GONZÁLEZ-RIVAS D." "BARROS CASTRO J."
```

```r
citseq[[4]]
```

```
## 229  11 
##   1   0 
## attr(,"IdAuthor")
## [1] 4
```

Se pueden seleccionar autores:


```r
id <- lbsSearchAuthors(conn, c("Cao R.", "Naya S.", "Naya-Fernandez S."))
id
```

```
## [1]   46 1193
```

Obtener las citas de los trabajos de los autores seleccionados:


```r
citseq2 <- lbsGetCitations(conn, idAuthors=id)
```

```
## Data set restrictions:
## 	Survey:         <ALL>.
## 	Document types: <ALL>.
## 
## Creating citation sequences... OK, 2 of 2 records read.
```

```r
length(citseq2)
```

```
## [1] 2
```

Obtener los documentos relativos a los autores seleccionados:


```r
id_re  <-  lbsSearchDocuments(conn, idAuthors=id)
```

Obtener información acerca de los documentos:


```r
info_re <- lbsGetInfoDocuments(conn, id_re)
info_re
```

```
## [[1]]
## IdDocument:    16
## AlternativeId: 2-s2.0-84947552209
## Title:         Lifetime estimation applying a kinetic model based on the generalized logistic function to biopolymers
## BibEntry:      Journal of Thermal Analysis and Calorimetry,2015,122,3,,1203,1212
## Year:          2015
## Type:          Article
## Citations:     0
## Authors:       NAYA S./46/NA, ÁLVAREZ A./518/NA, LÓPEZ-BECEIRO J./565/NA, GARCÍA-PARDO S./624/NA, TARRÍO-SAAVEDRA J./631/NA, QUINTANA-PITA S./709/NA, GARCÍA-SABÁN F.J./978/NA
## 
## [[2]]
## IdDocument:    98
## AlternativeId: 2-s2.0-84928890357
## Title:         Bootstrap testing for cross-correlation under low firing activity
## BibEntry:      Journal of Computational Neuroscience,2015,38,3,,577,587
## Year:          2015
## Type:          Article
## Citations:     1
## Authors:       ESPINOSA N./779/NA, MARIÑO J./832/NA, CUDEIRO J./1096/NA, CAO R./1193/NA, GONZÁLEZ-MONTORO A.M./1294/NA
## 
## [[3]]
## IdDocument:    127
## AlternativeId: 2-s2.0-84939982743
## Title:         Classification of wood using differential thermogravimetric analysis
## BibEntry:      Journal of Thermal Analysis and Calorimetry,2015,120,1,,541,551
## Year:          2015
## Type:          Article
## Citations:     0
## Authors:       NAYA S./46/NA, LÓPEZ-BECEIRO J./565/NA, TARRÍO-SAAVEDRA J./631/NA, FRANCISCO-FERNÁNDEZ M./766/NA, ARTIAGA R./1112/NA
```

Obtener las citas de cada documento:


```r
cit_re  <-  sapply(info_re,  function(x)  x$Citations)
cit_re
```

```
## [1] 0 1 0
```

etc...

El último paso será desconectar la BD...

## Cerrar conexión


```r
lbsDisconnect(conn)
```

