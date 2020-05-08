library(tidyverse) #This package helps import spreadsheet-formatted data, primarily from Excel
library(data.table) #Helps with data management
library(dbplyr) #This package will help interface with databases by translating R code into database-specific variants
library(RODBC)
library(odbc)
library(DBI)

### with RODBC
connection_access <- odbcConnectAccess()
connection <- odbcConnect("<DSN>")
query <- "<SQL Query>"
data <- sqlQuery(connection, query, )
str(data)
odbcCloseAll() # At the end of an R session please remember to close the connection. 

#DSN - File data sources store the connection information in a text file  not the Windos registry 
#ODBC -  Open Database Connectivity  a standard application programming interface (API) for accessing database management systems


# Finding your ODBC drivers https://support.office.com/en-us/article/administer-odbc-data-sources-b19f856b-5b9b-48c9-8b93-07484bfab5a7


### with odbc
odbcListDrivers()
# 
# file_path <- "~/CREP/Database/CREP_Database.accdb"
# 
# con <- dbConnect(odbc::odbc(), dsn = "Microsoft Access Driver (*.mdb, *.accdb)")
# odbc_result <- dbReadTable(con, "Fish_Abundance")
# as_tibble(odbc_result)
# 
# # pass MS Access file path to connection string
# accdb_con <- dbConnect(drv = odbc(), .connection_string = paste0("Driver={Microsoft Access Driver (*.mdb, *.accdb)};DBQ=",file_path,";"))

con <- dbConnect(odbc::odbc(), "2019_CREP_Database")
odbc_result <- DBI::dbReadTable(con, "Fish_Abundance")
as_tibble(odbc_result)
odbcCloseAll()