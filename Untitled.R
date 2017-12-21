library(shinydashboard)
library(leaflet)
library(shinydashboard)
library(leaflet)
library(dplyr)
library(curl) # make the jsonlite suggested dependency explicit
library(plotly)
#setwd("~/Documents/Courses/STAT425/Project/")
Chicago <- read.csv("Chicago_treated.csv",stringsAsFactors = F)
Chicago$X <- NULL
Chicago$host_since <- as.integer(Chicago$host_since/30)
library(dplyr)
a <- Chicago %>% group_by(neighbourhood_cleansed) %>% summarise(len = length(neighbourhood_cleansed))
sum(a[(a$len<70),2])

Chicago <- merge(Chicago,a,by = "neighbourhood_cleansed")
Chicago$neighbourhood_cleansed <- ifelse(Chicago$len<150,"Others",Chicago$neighbourhood_cleansed)
##########binning############################################################################

Chicago$accommodates_bin <- ifelse(Chicago$accommodates>=1 & Chicago$accommodates<=3,
                                   "1 to 3", ifelse(Chicago$accommodates>3 & Chicago$accommodates<=6,
                                                    "4 to 6", ifelse(Chicago$accommodates>6 & Chicago$accommodates<=9,
                                                                     "6 to 9", "More than 9")))
Chicago$bedrooms_bin <- ifelse(Chicago$bedrooms>=0 & Chicago$bedrooms<=1,
                               "0 to 1", ifelse(Chicago$bedrooms>1 & Chicago$bedrooms<=2,
                                                "1 to 2", "More than 2"))
Chicago$bathrooms_bin <- ifelse(Chicago$bathrooms>=0 & Chicago$bathrooms<=1,
                                "0 to 1", ifelse(Chicago$bathrooms>1 & Chicago$bathrooms<=2,
                                                 "1 to 2", "More than 2"))


