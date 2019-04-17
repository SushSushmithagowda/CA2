#Amalgamating all the crime files from NICrime data into a single file
crime_files <- list.files(path = "NI Crime Data", pattern = "*.csv", recursive = TRUE) 
crime_files 

merge_files <- function(file_list) { 
  
  NIC_file <- NULL 
  for (i in file_list) {
    
    NI_file <- read.csv(header = TRUE, paste("NI Crime Data/", i, sep = ""), 
                        stringsAsFactors = FALSE)         
    NIC_file <- rbind(NIC_file, NI_file) 
    
  } 
  return(NIC_file) 
}
NIC_data <- merge_files(crime_files) 
str(NIC_data) 
write.csv(NIC_data, file = "AllNICrimeData.csv", quote = FALSE, na = "", 
          row.names = FALSE) 
AllNICrime_data <- read.csv("AllNICrimeData.csv") 



#To display the head count of AllNICrime_data
head(AllNICrime_data)

#To view the structure of the AllNICrime_data 
str(AllNICrime_data)


#To remove all the unwanted columns from AllNICrime_data
AllNICrime_data <- AllNICrime_data[, c(2, 5, 6, 7, 10)] 
str(AllNICrime_data) 
head(AllNICrime_data) 

#To factorize the crime_type attribute
type_crime <- factor(AllNICrime_data$Crime.type, order = FALSE) 
AllNICrime_data$Crime.type <- type_crime 
str(AllNICrime_data) 


#Location attribute is being modified
AllNICrime_data$Location <- gsub("On or near ", "", AllNICrime_data$Location) 
AllNICrime_data$Location[AllNICrime_data$Location == ""] <- NA 
AllNICrime_data$Location <- toupper(AllNICrime_data$Location) 
AllNICrime_data$Location
str(AllNICrime_data)

# Taking 1000 sample data from the AllNICrime dataset
attach(AllNICrime_data)
NA_removed_df <- na.omit(AllNICrime_data)
random_crime_sample <- NA_removed_df[sample(1:nrow(NA_removed_df), 1000, replace = TRUE),]
head(random_crime_sample)
nrow(random_crime_sample)
is.na(random_crime_sample)


library(dplyr)
read_postcode_read <- read.csv("CleanNIPostcodeData.csv", stringsAsFactors = FALSE)

read_postcode_dataset <- tbl_df(postcode_read[, c(3,9)])
read_postcode_dataset
str(read_postcode_dataset)
head(read_postcode_dataset)
is.na(read_postcode_dataset)

head(AllNICrime_data)


find_a_postcode <- function(Location) {
#Filtering the row matching the location using the filter function of dplyr library
filter_data <- filter(read_postcode_dataset, PrimaryThorfare == Location)
#Finding the most repeated value and extracting its postcode using which.names function
result <- names(which.max(table(filter_data$Postcode)))
return(result)
}



#Finding the postcode for each location using lapply the find_a_postcode function
postcodes_function <- lapply(random_crime_sample$Location, find_a_postcode)
head(postcodes_function)
is.na(postcodes_function)
str(postcodes_function)
nrow(read_postcode_dataset)
head(random_crime_sample)


# Storing postcode function results into random_crime_sample dataframe
postcodes_function <- sapply(postcodes_function, paste0, collapse = "") 
head(postcodes_function) 
random_crime_sample$Postcode <- postcodes_function 
head(random_crime_sample) 

str(random_crime_sample)
nrow(random_crime_sample)


#writing random_crime_sample into random_crime_sample.csv file
write.csv(random_crime_sample, file = "random_crime_sample.csv", 
          quote = FALSE, row.names = FALSE)
random_crime_sample
str(random_crime_sample)

updated_random_sample <- read.csv("random_crime_sample.csv", 
                                  header = FALSE, stringsAsFactors = FALSE)
head(updated_random_sample)

#To sort the chart_data dataframe by postcode
chart_data <- updated_random_sample
chart_data <- chart_data[order(chart_data$V6),]
chart_data
str(chart_data)



data<-chart_data(V1, V2, V3, V4, V5, V6)
library(reshape2)
datan<-acast(data,V1, V2, V3, V4, V5, V6)



detach(AllNICrime_data)





