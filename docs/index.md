--- 
title: "Prácticas de Tecnologías de Gestión y Manipulación de Datos"
author: "Guillermo López Taboada (guillermo.lopez.taboada@udc.es) y Rubén F. Casal (ruben.fcasal@udc.es)"
date: "2019-11-07"
site: bookdown::bookdown_site
output: bookdown::gitbook
documentclass: book
bibliography: [book.bib, packages.bib]
biblio-style: apalike
link-citations: yes
github-repo: gltaboada/tgdbook
description: "Prácticas de la asignatura de Tecnologías de Gestión de Datos del Máster en Técnicas Estadísticas."
---

# Prólogo {-}

Este libro contiene algunas de las prácticas de la asignatura de [Tecnologías de Gestión de Datos](http://eamo.usc.es/pub/mte/index.php/es/?option=com_content&view=article&id=2202&idm=38&a%C3%B1o=2019) del [Máster interuniversitario en Técnicas Estadísticas](http://eio.usc.es/pub/mte)).

Este libro ha sido escrito en [R-Markdown](http://rmarkdown.rstudio.com) empleando el paquete [`bookdown`](https://bookdown.org/yihui/bookdown/) y está disponible en el repositorio Github: [gltaboada/tgdbook](https://github.com/gltaboada/tgdbook). 
Se puede acceder a la versión en línea a través del siguiente enlace:

<https://gltaboada.github.io/tgdbook>.

donde puede descargarse en formato [pdf](https://gltaboada.github.io/tgdbook/Practicas_de_TGD.pdf).


Para ejecutar los ejemplos mostrados en el libro será necesario tener instalados los siguientes paquetes:
[`dplyr`](https://dplyr.tidyverse.org) (colección [`tidyverse`](https://www.tidyverse.org/)),
[`tidyr`](https://tidyr.tidyverse.org),
[`stringr`](https://stringr.tidyverse.org),
[`readxl`](https://readxl.tidyverse.org) , 
[`openxlsx`](https://cran.r-project.org/web/packages/openxlsx/index.html), [`RODBC`](https://cran.r-project.org/web/packages/RODBC/index.html), 
[`sqldf`](https://cran.r-project.org/web/packages/sqldf/index.html),
[`RSQLite`](https://r-dbi.github.io/RSQLite), 
[`foreign`](https://cran.r-project.org/web/packages/foreign/index.html), 
[`SparkR`](https://cran.r-project.org/web/packages/SparkR/index.html), 
[`magrittr`](https://cran.r-project.org/web/packages/magrittr/index.html), 
[`knitr`](https://yihui.name/knitr) 
Por ejemplo mediante los comandos:

```r
pkgs <- c('dplyr', 'tidyr', 'stringr', 'readxl', 'openxlsx', 'magrittr', 
          'RODBC', 'sqldf', 'RSQLite', 'foreign', 'SparkR', 'knitr')
# install.packages(pkgs, dependencies=TRUE)
install.packages(setdiff(pkgs, installed.packages()[,'Package']), dependencies = TRUE)
```

Para generar el libro (compilar) se recomendaría consultar el libro de ["Escritura de libros con bookdown" ](https://rubenfcasal.github.io/bookdown_intro) en castellano.

![](images/by-nc-nd-88x31.png)<!-- --> 

Este obra está bajo una licencia de [Creative Commons Reconocimiento-NoComercial-SinObraDerivada 4.0 Internacional](https://creativecommons.org/licenses/by-nc-nd/4.0/deed.es_ES) 
(esperamos poder liberarlo bajo una licencia menos restrictiva más adelante...).


