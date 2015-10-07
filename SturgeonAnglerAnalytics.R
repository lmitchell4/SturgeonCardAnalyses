
# Began: 05-Oct-2015

# This file creates a dataframe of all purchased sturgeon cards from desired
# years (e.g., 2013 to 2015). Anglers are classified as "avid" when an angler
# has purchased a sturgeon card in at least 2 consecutive years. Data are
# analyzed to show for which years anglers did not return to the Department
# his/her report card.

# Libraries and Source Files ----------------------------------------------

library(RODBC)
#library()

source_dir <- "C:/Data/jdubois/RSourcedCode/"

source(file = paste0(source_dir, "functions_data_import_export.R"))
source(file = paste0(source_dir, "functions_stucard_avidity.R"))

# clean up
rm(source_dir)

# SQL Queries -------------------------------------------------------------

# create a list of sql queries; list must be named and dataframe(s) will be
# added to the global environment using that name
stu_angler_query_list <- list(
  PurchasedCards = ReadSqlFile(sql_file = "PurchasedReportCards.sql")#,
  
  # below might work but need to preserve the name when evaluating
  #AvidCustomers = substitute(ReadSqlFileParam(
  #  param = "@ID", value = x,
  #  sql_file = "testParamQuery.sql"))
  #ParamQuery = ReadSqlFile(sql_file = "testParamQuery.sql", dir = "sql")
)

# Data Connection and Data Import -----------------------------------------

# This section opens connection to SQL Server database that houses sturgeon 
# report card data from 2012 to present. The database is queried, and for each 
# query a dataframe is created in the global environment. The connection is 
# closed and dataframes are available for analyses.

# will prompt for user ID and password
QuerySqlServerDb(queries = stu_angler_query_list["PurchasedCards"],
                 server_name = "74.120.125.240",
                 database = "CA", trusted = FALSE)

# Data Analytics ----------------------------------------------------------

head(PurchasedCards)

nrow(PurchasedCards[PurchasedCards$StatusCodeID != 165, ])
head(PurchasedCards[PurchasedCards$StatusCodeID != 165, ])

AnglerAvidity <- GetAvidityData(card_data = PurchasedCards, only_avid = TRUE)

# result should be 0
length(unique(AnglerAvidity$CustomerID)) - length(AnglerAvidity$CustomerID)

# run if only_avid = FALSE
table(AnglerAvidity$IsAvid)

# just FIO
nrow(AnglerAvidity[AnglerAvidity$IsAvid == "yes" &
                     AnglerAvidity$nYearsNotRet > 0 &
                     AnglerAvidity$YearsNotRet != "2015", ])

# Get customer names contact ----------------------------------------------

# add to query list the parameter query to get customer names contact based on
# customer ID (05-Oct-2015)

# parameter is too big - does not work see 
# https://msdn.microsoft.com/en-us/library/ms177682.aspx; somewhere between 30K 
# and 33K records is where things seem to go sideways (06-Oct-2015); the quick 
# work around will be to run 30K records and then run the rest rbinding one to 
# the other (J. DuBois 06-Oct-2015)

# Duh!!!! Didn't even think of getting random number of records first AND then
# querying the database for customer info!!! There's really no point to getting
# contact information for all anglers and then randomly choosing from that list!
# Might reconfigure this soon (J. DuBois 06-Oct-2015)

# prior to below will also need to subset AnglerAvidity dataframe to remove
# anglers where nYearsNotRet = 0; no point in calling these folks since they've
# returned their Cards

n_records <- length(AnglerAvidity$CustomerID)
sample_size <- 1000 # change as desired, but not to exceed 30K

# get random numers (row numbers) for subsetting AnglerAvidity CustomerID
random_row_nums <- sample.int(n = n_records, size = sample_size)

# query below errored when number of records exceeded ~30K; because we want a
# random sample of anglers, the thinking now is to perform the random sample AND
# THEN query the database for angler name, contact info of the randomly sampled
# CustomerIDs (J. DuBois 07-Oct-2015)
stu_angler_query_list$AvidCustomers <- ReadSqlFileParam(
  param = "@cust", value = AnglerAvidity$CustomerID[random_row_nums],
  sql_file = "CardCustomers.sql")

# using listname["item"] preserves list name needed for function below
QuerySqlServerDb(queries = stu_angler_query_list["AvidCustomers"],
                 server_name = "74.120.125.240",
                 database = "CA", trusted = FALSE)

# clean up
rm(random_row_nums, n_records, sample_size)

# below merges both dataframes and then from the merged dataframe outputs a
# random selection of records from which the phone survey can be conducted; this
# is not the best design, but for now it does work and I may tweak with it in
# the future (J. DuBois, 06-Oct-2015)

# merge AnglerAvidity and AvidCustomers; convert AnglerAvidity$CustomerID to
# integer before merging
AnglerAvidity <- within(data = AnglerAvidity, expr = {
  CustomerID <- as.numeric(as.character(CustomerID))
})

# create angler call list - may output to Excel or .csv file for convenience
AnglerCallList <- merge(x = AvidCustomers, y = AnglerAvidity,
                        by = "CustomerID", all = FALSE)

# if TRUE, OK, otherwise remove records of deceased
all(is.na(AnglerCallList$DeceasedDate))

# clean up
rm(AnglerAvidity, AvidCustomers)
