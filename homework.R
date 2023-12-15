
library(sqldf)
library(lubridate)
library(tidyverse)
install.packages("sf")
library(sf)




con = dbConnect(SQLite(),dbname = "~/LAcrime.db")
crime_data = read.csv("./homework/Crime_Data_from_2010_to_2019.csv",header = T)
head(crime_data)
# set up input file and output file
infile  <- file("./homework/Crime_Data_from_2010_to_2019.csv",       'r')
outfile <- file("./homework/Crime_Data_from_2010_to_2019_clean.csv", 'w')

#   first get row #1 with the variable names
a <- readLines(infile, n=1)
a <- gsub(",", ";", a) # separate with ;
a <- gsub("[. -]", "", a)  # SQL doesn't like field names with .,-,space
writeLines(a, con=outfile)

c.lines <- 0
# loop through the rest of the data, 100,000 rows at a time
#  7,863,375 rows
while ((length(a <- readLines(infile, n=100000)) >  0))
{
  c.lines <- c.lines + length(a)
  print(format(c.lines, scientific = FALSE))
  # turn commas outside double quotes to semicolons
  #  use ?= to "lookahead" for paired quotes
  a <- gsub(",(?=([^\"]|\"[^\"]*\")*$)", ";", a,
            perl=TRUE)
  # write the cleaned up data to outfile
  writeLines(a, con=outfile)
}
close(infile)
close(outfile)

a <- read.table("./homework/Crime_Data_from_2010_to_2019_clean.csv",
                sep=";",nrows=30000,header=TRUE)
tail(a)
con <- dbConnect(SQLite(), dbname="~/chicagocrime.db")
variabletypes <- dbDataType(con, a)
dbWriteTable(con, "crime",
             "./homework/Crime_Data_from_2010_to_2019_clean.csv",
             row.names=FALSE,
             header=TRUE,
             field.types=variabletypes,
             sep=";") #" RSQLite doesn't handle commas in quotes
dbListFields(con,"crime")
dbDisconnect(con)
unemploy_data = read.csv("./homework/CALOSA7URN.csv",header = T)

LAmap = st_read("./homework/County_Boundary.shp")










