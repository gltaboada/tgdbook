Tecnologías para el Tratamiendo de Datos Masivos
================================================

Working draft...





El coste del almacenamiento cae en picado: hace posible guardar información de baja valor por byte.

Como consecuencia el volumen de información almacenado se duplicada cada 2 años. 

Fuentes de datos creciendo: no sólo datos generados por humanos sino datos de sensores y trazas de datos de sistemas. 

Los datos crecen más rápido que la capacidad de procesarlos y de extraer valor.

Algunos datos:
* Logs diarios de FaceBook: 60 TB
* 1000 genomas: 200 TB
* CERN: 25 PB anuales
* Indice web de Google: 10+ PB
* Coste de 1 TB de discoduro: ~35 ... 50€
* Tiempo de lectura de 1 TB: 3 horas !!!! (100 MB/s)


## Tecnologías Big Data (Hadoop, Spark, Hive, Rspark, Sparklyr)

Introducción a los conceptos básicos del ecosistema Hadoop

Descargar Spark de https://spark.apache.org/downloads.html
y disponer al menos de Java 7


```r
tar -xzf spark-1.5.2-bin-hadoop2.6.tgz
sudo mv spark-1.5.2-bin-hadoop2.6 /opt/spark
export SPARK_HOME=/opt/spark
export PATH=$SPARK_HOME/bin:$PATH
```

Ejecutar pyspark o sparkshell para saber si está correctamente instalado.



```r
spark-submit --class org.apache.spark.examples.SparkPi --master local $SPARK_HOME/examples/jars/spark-examples*.jar 10

Pi is roughly 3.140576
```

<!-- https://rpubs.com/wendyu/sparkr -->


Set system environment by pointing R session to the installed SparkR.


```r
Sys.setenv(SPARK_HOME = "/home/gltaboada/spark/")
.libPaths(c(file.path(Sys.getenv("SPARK_HOME"), "R", "lib"), .libPaths()))
library(SparkR)
```

Initialize Spark context and SQL context


```r
sc <- sparkR.session(master = "local",sparkEnvir = list(spark.driver.memory="2g"))
sqlContext <- sparkR.session(sc)
```

Dataframe Operations


Create data frame: Data frames can be created from a local R data frame, from direct data source, or from a Hive table. The easiest way is to convert a local R data frame into a SaprkR data frame. Here I used the famous Iris data frame as an example.


```r
#df <- createDataFrame(sqlContext, iris)
df <- createDataFrame(iris, schema=NULL)
head(df)
##   Sepal_Length Sepal_Width Petal_Length Petal_Width Species
## 1          5.1         3.5          1.4         0.2  setosa
## 2          4.9         3.0          1.4         0.2  setosa
## 3          4.7         3.2          1.3         0.2  setosa
## 4          4.6         3.1          1.5         0.2  setosa
## 5          5.0         3.6          1.4         0.2  setosa
## 6          5.4         3.9          1.7         0.4  setosa
```



Select and Filter:

selecting only the ‘Sepal_Length’ and ‘Species’ column


```r
head(select(df, df$Sepal_Length, df$Species )) 
##   Sepal_Length Species
## 1          5.1  setosa
## 2          4.9  setosa
## 3          4.7  setosa
## 4          4.6  setosa
## 5          5.0  setosa
## 6          5.4  setosa
```


selecting rows with ‘Sepal_Lenght’ greater than 5.5


```r
head(filter(df, df$Sepal_Length >5.5))
##   Sepal_Length Sepal_Width Petal_Length Petal_Width    Species
## 1          5.8         4.0          1.2         0.2     setosa
## 2          5.7         4.4          1.5         0.4     setosa
## 3          5.7         3.8          1.7         0.3     setosa
## 4          7.0         3.2          4.7         1.4 versicolor
## 5          6.4         3.2          4.5         1.5 versicolor
## 6          6.9         3.1          4.9         1.5 versicolor
```


selecting only the ‘Sepal_Length’ and ‘Species’ column with ‘Sepal_Lenght’ greater than 5.5


```r
head(select(filter(df, df$Sepal_Length >5.5), df$Sepal_Length, df$Species))
##   Sepal_Length    Species
## 1          5.8     setosa
## 2          5.7     setosa
## 3          5.7     setosa
## 4          7.0 versicolor
## 5          6.4 versicolor
## 6          6.9 versicolor`
```


Grouping and Aggregation
Calculating the mean of sepal length of each species, and also the number of observation of each species.


```r
df2<-summarize(groupBy(df, df$Species), mean=mean(df$Sepal_Length), count=n(df$Sepal_Length))
head(df2)
##      Species  mean count
## 1 versicolor 5.936    50
## 2     setosa 5.006    50
## 3  virginica 6.588    50
```

Sort the output data frame by the mean sepal length


```r
head(arrange(df2, desc(df2$mean)))
##      Species  mean count
## 1  virginica 6.588    50
## 2 versicolor 5.936    50
## 3     setosa 5.006    50
```

```r
Combine queries with Marittr
In R, we can combine Dataframe operations using library magrittr. Here is an example that combined the above operations into one.
```

```r
library(magrittr)
finaldf<-filter(df, df$Sepal_Length >5.5) %>%
  group_by(df$Species)%>%
  summarize(mean=mean(df$Sepal_Length))
arrange(finaldf, desc(finaldf$mean)) %>% head
##      Species     mean
## 1  virginica 6.622449
## 2 versicolor 6.120513
## 3     setosa 5.733333
```

```r
SQL Queries

We can register Spark Dataframe as sql table, which enables us to run SQL queries and return the output as a data frame.

Register Spark Dataframe as a table.
```

```r
registerTempTable(df,"df")
```

Run SQL expression using sqlContext


```r
dfSQL<-sql(sqlContext, "SELECT * FROM df WHERE Sepal_Length > 5.5")
```

Call collect to get a local dataframe


```r
dflocal<-collect(dfSQL)
print(dflocal[1:10,])
##    Sepal_Length Sepal_Width Petal_Length Petal_Width    Species
## 1           5.8         4.0          1.2         0.2     setosa
## 2           5.7         4.4          1.5         0.4     setosa
## 3           5.7         3.8          1.7         0.3     setosa
## 4           7.0         3.2          4.7         1.4 versicolor
## 5           6.4         3.2          4.5         1.5 versicolor
## 6           6.9         3.1          4.9         1.5 versicolor
## 7           6.5         2.8          4.6         1.5 versicolor
## 8           5.7         2.8          4.5         1.3 versicolor
## 9           6.3         3.3          4.7         1.6 versicolor
## 10          6.6         2.9          4.6         1.3 versicolor
```

Machine Learning - general linear regression
Here we continue to use Iris dataset. The goal is to predict sepal length.
1. Preparing a train/test data set
we want to randomly split the Iris dataframe into 20/80. 20% as test set, and 80% as train set.

There is no split function in SparkR. To split the Dataframe, I first created an ID column, then randomly select 20% of the data as the new test set. I matched the IDs from the test set with IDs from the original data frame, and then created a new column to indicate if the observations were assigned to the test set. Lastly, I selected the observations that are NOT in the test set, and assigned them as the new train set.

This method is very tedious. It is probably not very scalable to larger data set.


```r
#create an ID column
iris$ID<-c(1:nrow(iris))
df <- createDataFrame(sqlContext, iris)
#total number of observations
nrow(df)
## [1] 150
#20% data as test set
df_test<-sample(df, FALSE, 0.2)
nrow(df_test)  
## [1] 21
#80% data as train set
testID<-collect(select(df_test, "ID"))$ID
df$istest<-df$ID %in% testID
df_train<-subset(df, df$istest==FALSE)
nrow(df_train)
## [1] 129
```



Train a linear model


```r
#fit model
model<-glm(Sepal_Length ~ . - ID - istest , data=df_train, family="gaussian")
#look at model summary
summary(model)
## $coefficients
##                       Estimate
## (Intercept)          1.2303739
## Sepal_Width          0.5090809
## Petal_Length         0.7886571
## Petal_Width         -0.2781813
## Species__versicolor  0.3035921
## Species__setosa      0.9335554
```

Model evaluation using the test set
SparkR doesn’t have built-in functions to calculate model error. So I manually calculated the R-squared. By definition, R2= 1-(residual sum of squares/total sum of squares)


```r
#makde predictions 
prediction<-predict(model, newData=df_test)
head(select(prediction, "Sepal_Length", "prediction"))
##   Sepal_Length prediction
## 1          4.8   4.767474
## 2          5.4   5.063327
## 3          5.1   4.966378
## 4          4.9   4.869430
## 5          5.0   5.040655
## 6          5.3   5.174878
#mean of Sepal_Length
smean<-collect(agg(df_train, mean=mean(df_train$Sepal_Length)))$mean
smean
## [1] 5.805426
#Squared residual and squared total
prediction<-transform(
  prediction,
  s_res=(prediction$Sepal_Length - prediction$prediction)**2,
  s_tot=(prediction$Sepal_Length - smean)**2)
head(select(prediction, "Sepal_Length", "prediction", "s_res", "s_tot"))
##   Sepal_Length prediction        s_res     s_tot
## 1          4.8   4.767474 0.0010579455 1.0108822
## 2          5.4   5.063327 0.1133489344 0.1643705
## 3          5.1   4.966378 0.0178548042 0.4976263
## 4          4.9   4.869430 0.0009345497 0.8197969
## 5          5.0   5.040655 0.0016528408 0.6487116
## 6          5.3   5.174878 0.0156554755 0.2554558
#Sum of squares
res<-collect(agg(prediction, 
                 ss_res=sum(prediction$s_res),
                 ss_tot=sum(prediction$s_tot)))
res
##     ss_res   ss_tot
## 1 1.734297 18.25767
#R-squared
R2=1-(res$ss_res/res$ss_tot)
R2
## [1] 0.90501
```


Thoughts
SparkR is an easy way for me to transition from R to Spark. Dataframe API provides a very natural way to code. In this exercise, I practiced the basic Dataframe operations and building a simple linear regression model. However, I feel like there are some limitations in the current SparkR for machine learning. For example,
1. There should be an easier way to split train/test set.
2. The summary function of models doesn’t provide much information other than coefficients. It would be nice to have some errors and significant levels.
3. There needs to be more powerful models that can handle more complex formulas.
I think ML libraries for pyspark is more complete than SparkR and there are more documentations as well. My next step is to learn pyspark, and also start learning the fundamentals of Scala. 




## Visualización y Generación de Cuadros de Mando



## Introducción al Análisis de Datos Masivos


