library(tidyverse) #This package helps import spreadsheet-formatted data, primarily from Excel
library(data.table) #Helps with data management
library(dbplyr) #This package will help interface with databases by translating R code into database-specific variants
library(RODBC)
library(odbc)
library(DBI)
# library(sqldf)


### with RODBC
connection_access <- odbcConnectAccess() ## only available for 32-bit version of Windows.
connection <- odbcConnect("<DSN>")
query <- "<SQL Query>"
data <- sqlQuery(connection, query, )
str(data)
odbcCloseAll() # At the end of an R session please remember to close the connection. 

#ODBC -  Open Database Connectivity  a standard application programming interface (API) for accessing database management systems
#DSN - File data sources store the connection information in a text file  not the Windos registry 


# Finding your ODBC drivers https://support.office.com/en-us/article/administer-odbc-data-sources-b19f856b-5b9b-48c9-8b93-07484bfab5a7


### with odbc
odbcListDrivers()
# 

# 
# con <- dbConnect(odbc::odbc(), dsn = "Microsoft Access Driver (*.mdb, *.accdb)")
# odbc_result <- dbReadTable(con, "Fish_Abundance")
# as_tibble(odbc_result)
# 
# # pass MS Access file path to connection string
file_path <- "~/CREP/Database/CREP_Database.accdb"
accdb_con <- dbConnect(drv = odbc(), Driver="{Microsoft Access Driver (*.mdb, *.accdb)}",
                       Database="~/CREP/Database/CREP_Database.accdb")

#########
con2 <- dbConnect(odbc::odbc(), 
                  Driver= "MS Access Database"
                  Data)


#######
con <- dbConnect(odbc::odbc(), "2019_CREP_Database")
dbListTables(con) # To get the list of tables in the database

odbc_result <- DBI::dbReadTable(con, "Fish_Abundance") #The dbReadTable() command will return the data table from the database as class: "data.frame"
result_dbi<- as_tibble(odbc_result) # Use as_tibble() turn the dataframe as a tibble to continue with queries using the dplyr syntax

result_dplyr <- as_tibble(tbl(con, "Fish_Abundance")) # OR directly return the data table from the database as a tibble

dbGetQuery() # Use this for SELECT queries only

# If you want conduct more sophistcated queries use the tbL() function along with sql() both are from dplyr()
# tbl() this is a generic method for creating a table from a datasource
# sql() allows you to write SQL queries directly


fish_locations <- as_tibble(tbl(con, sql("SELECT DISTINCT Fish_Abundance.PU_Gap_Code, Fish_Abundance.Reach_Name, Fish_Abundance.Event_Date, 
                                          Established_Locations.Site_Type, Established_Locations.Latitude, 
                                          Established_Locations.Longitude, Established_Locations.Stream_Name 
                                       FROM Fish_Abundance LEFT JOIN Established_Locations 
                                       ON (Fish_Abundance.PU_Gap_Code = Established_Locations.PU_Gap_Code) 
                                       AND (Fish_Abundance.Reach_Name = Established_Locations.Reach_Name)")))



odbcCloseAll()
dbDisconnect()
