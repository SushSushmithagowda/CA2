getwd()
#To create a dataframe and importing the NIPostCode dataset into it
NIPostCodes <- read.csv("NIPostCode.csv", header = FALSE, stringsAsFactors = FALSE, 
                     na.strings = c("","NA")) 
NIPostCodes

#To view the structure of the dataframe 
str(NIPostCodes)

#To assign the column names for the dataframe
Col_names <- c("OrganisationName", "SubBuildingName", "BuildingName", "Number", 
               "PrimaryThorfare", "AltThorfare", "SeconadryThorfare", "Locality",
               "Townland", "Town", "County", "Postcode", "xCoordinate", "yCoordinate",
               "PrimaryKey")

colnames(NIPostCodes) <- Col_names 
head(NIPostCodes) 

#To view the total number of rows in the NIPostCodes dataframe
nrow(NIPostCodes)
head(NIPostCodes, 10)
str(NIPostCodes)

#To find the sum and mean of each column
sapply(NIPostCodes, function(x) sum(is.na(x)))
sapply(NIPostCodes, function(x) mean(is.na(x)))

str(NIPostCodes)

#deleting all the missing values present in the columns of the dataframe
NA_count <- sapply(NIPostCodes, function(x) sum(is.na(x)))
NA_count
NIPostCodes$OrganisationName <- NULL 
NIPostCodes$SubBuildingName <- NULL 
NIPostCodes$BuildingName <- NULL 
NIPostCodes$AltThorfare <- NULL
NIPostCodes$SecondaryThorfare <- NULL
NIPostCodes

#To view structure
str(NIPostCodes)

#To modify the County attribute to categorising factor
attach(NIPostCodes) 
NI_County1 <- factor(County, order = FALSE) 
NIPostCodes$County <- NI_County1 
head(NIPostCodes) 
str(NIPostCodes) 

#Moving primaryKey identifier column to the start of the dataset
NIPostCodes = NIPostCodes[, c(10, 1:9)] 
str(NIPostCodes)
head(NIPostCodes) 

#Creating Limavady_data dataset and to store only only the information having locality, 
#townland and town containing the name Limavady and to store this information in an 
#external csv file called Limavady.
attach(NIPostCodes) 
Limavady_data <- subset(NIPostCodes, grepl("LIMAVADY",Locality) &
                          grepl("LIMAVADY",Townland) & grepl("LIMAVADY",Town)) 
str(Limavady_data) 
head(Limavady_data) 
write.csv(Limavady_data, file = "Limavady.csv ", quote = FALSE,row.names = FALSE) 
read.csv("Limavady.csv ") 

#Saving modified NIPostCode dataset in a csv file called “ CleanNIPostcodeData”
write.csv(NIPostCodes, file = "CleanNIPostcodeData.csv ", quote = FALSE, 
          row.names = FALSE) 
read.csv("CleanNIPostcodeData.csv ") 
CleanNI <- read.csv("CleanNIPostcodeData.csv")
head(CleanNI)

str(CleanNI) #To view the structure of CleanNI



        