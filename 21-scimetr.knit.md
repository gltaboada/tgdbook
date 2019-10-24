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








































