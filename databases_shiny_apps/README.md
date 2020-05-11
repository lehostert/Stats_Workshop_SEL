# Connecting R to a MS Access Database

## References
- R Studio- [Connect to a Database](https://db.rstudio.com/getting-started/connect-to-database)
- MS Office Drivers- [Adding an ODBC data source](https://support.office.com/en-us/article/administer-odbc-data-sources-b19f856b-5b9b-48c9-8b93-07484bfab5a7)

## Definitions
__ODBC__ : "Open Database Connectivity" this is a standard API (application programming interface) for accessing database management systems

__DSN__ : "Data Storage Name" this stores the connection information for your files in a text file not in the windows registry so that

## How to Connect your Access Database to R

### Create a MS Access Driver Specific for your Access DB
1. Click __Start__, and then click __Control Panel__  
  (You may need to search for __Control Panel__ in the Windows Start Menu)
2. In the __Control Panel__, click __Administrative Tools__
3. In the __Administrative Tools__ windows select __ODBC Data Sources (64-bit)__ unless you want to make a 32-bit driver. This will be dependant on which version (32-bit or 64-bit) you are running of Access.

4.  

### Install and load packages in R
- `library(ODBC)`
    - This is the library that will establish a connection between your
- `library(DBI)`
    - Once connected with the database this library will allow you to put things out of the database

### Connect to the database, Run your analysis, and Close the connection
`connection <- dbConnect(odbc::odbc(), "My_Database")`  
`odbc_result <- DBI::dbReadTable(connection, "Fish_Abundance")`  
`as_tibble(odbc_result)` <- You can now use
`odbcCloseAll()`
