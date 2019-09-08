Introduction to dplyr
=====================

When working with data you must:

* Figure out what you want to do.

* Describe those tasks in the form of a computer program.

* Execute the program.

The dplyr package makes these steps fast and easy:

* By constraining your options, it helps you think about your data manipulation 
  challenges.

* It provides simple "verbs", functions that correspond to the most common data 
  manipulation tasks, to help you translate your thoughts into code.

* It uses efficient backends, so you spend less time waiting for the computer.

This document introduces you to dplyr's basic set of tools, and shows you how to apply them to data frames. dplyr also supports databases via the dbplyr package, once you've installed, read `vignette("dbplyr")` to learn more.

## Data: nycflights13

To explore the basic data manipulation verbs of dplyr, we'll use `nycflights13::flights`. This dataset contains all 336776 flights that departed from New York City in 2013. The data comes from the US [Bureau of Transportation Statistics](http://www.transtats.bts.gov/DatabaseInfo.asp?DB_ID=120&Link=0), and is documented in `?nycflights13`


```r
library(nycflights13)
dim(flights)
```

```
## [1] 336776     19
```

```r
flights
```

```
## # A tibble: 336,776 x 19
##     year month   day dep_time sched_dep_time dep_delay arr_time
##    <int> <int> <int>    <int>          <int>     <dbl>    <int>
##  1  2013     1     1      517            515         2      830
##  2  2013     1     1      533            529         4      850
##  3  2013     1     1      542            540         2      923
##  4  2013     1     1      544            545        -1     1004
##  5  2013     1     1      554            600        -6      812
##  6  2013     1     1      554            558        -4      740
##  7  2013     1     1      555            600        -5      913
##  8  2013     1     1      557            600        -3      709
##  9  2013     1     1      557            600        -3      838
## 10  2013     1     1      558            600        -2      753
## # ... with 336,766 more rows, and 12 more variables: sched_arr_time <int>,
## #   arr_delay <dbl>, carrier <chr>, flight <int>, tailnum <chr>,
## #   origin <chr>, dest <chr>, air_time <dbl>, distance <dbl>, hour <dbl>,
## #   minute <dbl>, time_hour <dttm>
```

Note that `nycflights13::flights` is a tibble, a modern reimagining of the data frame. It's particularly useful for large datasets because it only prints the first few rows. You can learn more about tibbles at <http://tibble.tidyverse.org>; in particular you can convert data frames to tibbles with `as_tibble()`.

## Single table verbs

Dplyr aims to provide a function for each basic verb of data manipulation:

* `filter()` to select cases based on their values.
* `arrange()` to reorder the cases.
* `select()` and `rename()` to select variables based on their names.
* `mutate()` and `transmute()` to add new variables that are functions of existing variables.
* `summarise()` to condense multiple values to a single value.
* `sample_n()` and `sample_frac()` to take random samples.

### Filter rows with `filter()`

`filter()` allows you to select a subset of rows in a data frame. Like all single verbs, the first argument is the tibble (or data frame). The second and subsequent arguments refer to variables within that data frame, selecting rows where the expression is `TRUE`.

For example, we can select all flights on January 1st with:





























































