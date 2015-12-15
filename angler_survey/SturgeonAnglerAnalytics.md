# Sturgeon Report Card: Angler Analytics
CDFW  
October 5, 2015  

Began: 05-Oct-2015

This file creates a dataframe of all purchased sturgeon cards from desired years (e.g., 2013 to 2015). Anglers are classified as "avid" when an angler has purchased a sturgeon card in at least two consecutive years. Data are analyzed to show for which years anglers did not return to the Department his/her report card (non-reporting).











Between 2013 and 2015 (to present 2015-12-15), 92,496 anglers purchased a Sturgeon Fishing Report Card (Card) in one, two, or all three years. Of these, 33,404 were deemed "avid." Of these avid anglers, 26,091 non-reported in either 2013 or 2014 or both. From the non-reported subset, we randomly selected 1,000 to survey (see code example below).


```r
# get number of records from dataframe to be sampled
n_records <- nrow(AnglerAvidity)
sample_size <- 1000 # change as desired, but not to exceed 30K

# get random numers (row numbers) for subsetting AnglerAvidity CustomerID
random_row_nums <- sample.int(n = n_records, size = sample_size)

# Then used random_row_nums to get only those rows from (essentially)
# AnglerAvidity dataframe.
```

The AnglerAvidity dataframe is layed out as follows (example, with CustomerID and GOID removed):  


|   |CustomerID |GOID     |IsAvid |YearsPurch     |YearsNotRet    | nYearsNotRet|
|:--|:----------|:--------|:------|:--------------|:--------------|------------:|
|2  |X          |xxxx-xxx |yes    |2013;2014      |2013;2014      |            2|
|5  |X          |xxxx-xxx |yes    |2013;2014;2015 |2013;2014;2015 |            3|
|7  |X          |xxxx-xxx |yes    |2013;2014;2015 |2013;2014;2015 |            3|
|10 |X          |xxxx-xxx |yes    |2013;2014      |2013;2014      |            2|
|11 |X          |xxxx-xxx |yes    |2014;2015      |2014;2015      |            2|



End of report
