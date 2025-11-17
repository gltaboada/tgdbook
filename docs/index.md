---
title: "Prácticas de Tecnologías de Gestión y Manipulación de Datos"
author: 
  - "Guillermo López Taboada (guillermo.lopez.taboada@udc.es)"
  - "Diego Darriba (diego.darriba@udc.es)"
  - "Rubén Fernández Casal (ruben.fcasal@udc.es)"
  - "Manuel Oviedo de la Fuente (manuel.oviedo@udc.es)"
date: "Edición: Octubre de 2025. Impresión: 2025-11-18"
site: bookdown::bookdown_site
output: bookdown::gitbook
documentclass: book
bibliography: [book.bib, packages.bib]
biblio-style: apalike
link-citations: yes
github-repo: gltaboada/tgdbook
description: "Prácticas de la asignatura de Tecnologías de Gestión de Datos del Máster en Técnicas Estadísticas."
editor_options: 
  markdown: 
    wrap: 72
---

# Prólogo {.unnumbered}

Este libro contiene algunas de las prácticas de la asignatura de
[Tecnologías de Gestión de
Datos](http://eamo.usc.es/pub/mte/index.php/es/?option=com_content&view=article&id=2202&idm=38&a%C3%B1o=2020)
del [Máster interuniversitario en Técnicas
Estadísticas](http://eio.usc.es/pub/mte)).

En este libro se asume que se dispone de conocimientos básicos de [`R`](https://www.r-project.org), un lenguaje de programación interpretado y un entorno estadístico desarrollado específicamente para el análisis de datos. 
Para instalar R se recomienda seguir los pasos descritos en el post [*https://rubenfcasal.github.io/post/instalacion-de-r*](https://rubenfcasal.github.io/post/instalacion-de-r).
Para el desarrollo de código e informes se sugiere emplear *RStudio Desktop*, que se puede instalar y configurar siguiendo las indicaciones proporcionadas en el post [*https://rubenfcasal.github.io/post/instalacion-de-rstudio*](https://rubenfcasal.github.io/post/instalacion-de-rstudio).

Para una introducción a la programación en [`R`](https://www.r-project.org) se puede consultar el libro Fernández-Casal et al. (2022): *[Introducción al Análisis de Datos con R](https://rubenfcasal.github.io/intror)* ([github](https://github.com/rubenfcasal/intror)). 
Adicionalmente, en el post [*https://rubenfcasal.github.io/post/ayuda-y-recursos-para-el-aprendizaje-de-r*](https://rubenfcasal.github.io/post/ayuda-y-recursos-para-el-aprendizaje-de-r) se proporcionan enlaces a recursos adicionales, incluyendo bibliografía y cursos.
También puede ser de utilidad el libro Fernández-Casal (2023): *[Notas de Programación en R](https://rubenfcasal.github.io/book_notasr)*   ([github](https://github.com/rubenfcasal/book_notasr)).

Este libro ha sido escrito en [R-Markdown](http://rmarkdown.rstudio.com)
empleando el paquete [`bookdown`](https://bookdown.org/yihui/bookdown/)
y está disponible en el repositorio Github:
[gltaboada/tgdbook](https://github.com/gltaboada/tgdbook). Se puede
acceder a la versión en línea a través del siguiente enlace:

<https://gltaboada.github.io/tgdbook>.

donde puede descargarse en formato
[pdf](https://gltaboada.github.io/tgdbook/Practicas_de_TGD.pdf).

Para ejecutar los ejemplos mostrados en el libro será necesario tener
instalados los siguientes paquetes:
[`dplyr`](https://dplyr.tidyverse.org) (colección
[`tidyverse`](https://www.tidyverse.org/)),
[`tidyr`](https://tidyr.tidyverse.org),
[`stringr`](https://stringr.tidyverse.org),
[`readxl`](https://readxl.tidyverse.org) ,
[`openxlsx`](https://cran.r-project.org/web/packages/openxlsx/index.html),
[`naniar`](https://naniar.njtierney.com),
[`RODBC`](https://cran.r-project.org/web/packages/RODBC/index.html),
[`sqldf`](https://cran.r-project.org/web/packages/sqldf/index.html),
[`RSQLite`](https://r-dbi.github.io/RSQLite),
[`foreign`](https://cran.r-project.org/web/packages/foreign/index.html),
[`magrittr`](https://cran.r-project.org/web/packages/magrittr/index.html),
[`knitr`](https://yihui.name/knitr) Por ejemplo mediante los comandos:


``` r
pkgs <- c('dplyr', 'tidyr', 'stringr', 'readxl', 'openxlsx', 'magrittr', 
          'naniar', 'RODBC', 'sqldf', 'RSQLite', 'foreign', 'knitr')
# install.packages(pkgs, dependencies=TRUE)
install.packages(setdiff(pkgs, installed.packages()[,'Package']), dependencies = TRUE)
```

Para generar el libro (compilar) se recomendaría consultar el libro de
["Escritura de libros con
bookdown"](https://rubenfcasal.github.io/bookdown_intro) en castellano.


\includegraphics[width=1.22in]{images/by-nc-nd-88x31} 

Este obra está bajo una licencia de [Creative Commons
Reconocimiento-NoComercial-SinObraDerivada 4.0
Internacional](https://creativecommons.org/licenses/by-nc-nd/4.0/deed.es_ES)
(esperamos poder liberarlo bajo una licencia menos restrictiva más
adelante...).


