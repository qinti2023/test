# I certify that I have complied with the University of Pennsylvania's [Code of Academic Integrity]
# (https://catalog.upenn.edu/pennbook/code-of-academic-integrity/) in completing this final exam.


### 1. Setup the data, load the libraries, and inspect the data

# 1a. (2 points)
library(lubridate)
library(sf)
library(dplyr)
load("./finaldata2023.RData")
# 1b. (2 points)
dim(incidents)
# 1c. (2 points)
head(incidents,7)
tail(persons,7)
# 1d. (2 points)
incidents[26650,]
incidents[26650,c("OFFENSE","BEAT")]
# 1e. (2 points)
incidents[200:205, c("INCIDENT_ID", "INCIDENT_DATE", "WEAPONS")]
# 1f. (3 points)
length(unique(incidents$INCIDENT_ID))
length(unique(incidents$INCIDENT_ID)) == length(unique(persons$INCIDENT_ID))
# 1g. (3 points)
names(tail(sort(table(incidents$OFFENSE)), 10))
# 1h. (3 points)
names(table(incidents$OFFENSE)[table(incidents$OFFENSE)==1])
# 1i. (3 points)
table(incidents$BEAT)
names(which.max(table(incidents$BEAT)))

### 2. Create a New Dataset, Fix Data Errors, and Wrangle the Data

# 2a. (4 points)
cpd = merge(incidents,persons,by = "INCIDENT_ID")
# 2b. (3 points)
cpd[cpd$OFFENSE == "WIRE FRAUD",c("VICTIM_RACE", "VICTIM_ETHNICITY", "VICTIM_GENDER", "VICTIM_AGE")]
# 2c. (3 points)
unique(cpd$VICTIM_GENDER)
table(!cpd$VICTIM_GENDER %in% c( "FEMALE","MALE", "M - MALE","F - FEMALE"))
# 2d. (3 points)
cpd$VICTIM_GENDER = gsub("F - FEMALE","FEMALE",cpd$VICTIM_GENDER)
cpd$VICTIM_GENDER = gsub("M - MALE","FEMALE",cpd$VICTIM_GENDER)
cpd$VICTIM_GENDER[!cpd$VICTIM_GENDER %in% c("MALE", "FEMALE")] <- "UNKNOWN"
table(cpd$VICTIM_GENDER)
# 2e. (4 points)
cpd$WEAPONS_CODE <- gsub("^(\\d{2,3}).*$", "\\1", cpd$WEAPONS)
# 2f. (4 points)
cpd$ASSAULT_ANY <- ifelse(grepl("assault", tolower(cpd$OFFENSE), fixed = TRUE), 1, 0)
mean(cpd$ASSAULT_ANY) * 100


### 3. Working with Dates and Times

# 3a. (2 points)

# 3b. (4 points)

# 3c. (3 points)

# 3d. (5 points) 

# 3e. (6 points)

# 3f. (4 points)

# 3g. (4 points)


### 4. Maps

# 4a. (2 points)

# 4b. (4 points)

# 4c. (4 points)

# 4d. (4 points)

# 4e. (3 points)

# 4f. (4 points)

# 4g. (4 points)

# 4h. (4 points)

# 4i. (4 points)

# 4j. (5 points)
