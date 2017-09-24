# Contains the variables 'pg_pass' and 'pg_user'
source('postgres_pw.R')
library(RPostgreSQL)

hurr_db_connect <- function() {
  # Return a connection to the Postgres hurricane database
  driver <- dbDriver("PostgreSQL")
  return(dbConnect(driver, user=pg_user, password=pg_pass, dbname="us_wth"))
}