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
cpd$INCIDENT_DATE <- mdy(cpd$INCIDENT_DATE)
cpd$CLEARANCE_DATE <- mdy(cpd$CLEARANCE_DATE)
# 3b. (4 points)
cpd$TIME_TO_CLEAR <- as.numeric(cpd$CLEARANCE_DATE - cpd$INCIDENT_DATE)
mean_time_to_clear <- aggregate(TIME_TO_CLEAR ~ BEAT, data = cpd, mean, na.rm = TRUE)
mean_time_to_clear[which.max(mean_time_to_clear$TIME_TO_CLEAR), ]
# 3c. (3 points)
cpd[which.max(cpd$TIME_TO_CLEAR), c("INCIDENT_ID", "TIME_TO_CLEAR")]
# 3d. (5 points) 
cpd$TIME_TO_CLEAR_CATS <- cut(cpd$TIME_TO_CLEAR,
                              breaks = c(0, 364, 729, Inf),
                              labels = c("0 years", "1 year", "2+ years"),
                              right = FALSE)

# 3e. (6 points)
offense_stats = aggregate(TIME_TO_CLEAR ~ OFFENSE, data = cpd, function(x) {
  c(mean = round(mean(x, na.rm = TRUE), 1),
    median = median(x, na.rm = TRUE),
    count = length(na.omit(x)))
})
offense_stats
# 3f. (4 points)
cpd$DAY_OF_WEEK <- weekdays(cpd$INCIDENT_DATE)
library(ggplot2)
ggplot(cpd, aes(DAY_OF_WEEK)) +
  geom_bar() +
  xlab("Day of the Week") +
  ylab("Count of Crime Incidents") +
  ggtitle("Total Count of Crime Incidents by Day of the Week")
# 3g. (4 points)
max_clearance_time <- function(offense) {
  max(cpd$TIME_TO_CLEAR[cpd$OFFENSE == offense], na.rm = TRUE)
}
max_clearance_time("ARSON")


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
