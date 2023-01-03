setwd('D:\\Study Room\\Intro to Data Science\\Data Science Project') #setting up working directory 
dataset<- read.csv('dataset.csv') #reading data from csv file
dataset

any(is.na(dataset))

#Data Cleaning
data <- dataset                                                       # Duplicate data frame
data$Assault[is.na(data$Assault)] <- mean(data$Assault, na.rm = TRUE) # Replace NA in one column
data                                                                  # Print updated data frame


#Data Transformation
data$Assault<- round(data$Assault)                                    #rounding the figure of data$Assault


#Smothing Noisy Data

boxplot(data$Assault)              #finding outliers in the Assault column using box plot
boxplot(data$Urban.population....) #finding outliers in the Urban Population column using box plot
boxplot(data$Murder)               #finding outliers in the Murder column using box plot

#removing outliers
data2 <- data[data$Assault<400, ]    # Remove outliers for Assault column where we select the threshold value 400
boxplot(data2$Assault)               #checking if there is more outliers 

data3<- data2[(data$Urban.population....<101) & (data$Urban.population....>10), ] # Remove outliers for Assault column
boxplot(data3$Urban.population....)   #checking if there is more outliers 

#removed rows with NA
cleaned_data<- na.omit(data3)

###########################################    Data Integration   ####################################################################

new_data<- cbind(cleaned_data, Type=NA)  #adding a new empty column in the dataframe

for (i in 1:nrow(new_data)){            #assigning values to the column 'Type' according the given conditions
  if(new_data$Urban.population....[i]<50){
    new_data$Type[i] = 'small'
  }else if(new_data$Urban.population....[i]>=50 & new_data$Urban.population....[i]<60){
    new_data$Type[i] = 'medium'
  }else if(new_data$Urban.population....[i]>=60 & new_data$Urban.population....[i]<70){
    new_data$Type[i] = 'large'
  }else{
    new_data$Type[i] = 'extra large'
  }
}
for (i in 1:nrow(data)){
  if(data$Country=='N/A')
  {
    data$Country=NA
  }


#########################################  Data Discretization #######################################################################

#based on the murder and assault cases we will divide the risk factor of the areas in three categories, 
#which are less crime, more crime, average crime
#we will add a new column called danger_type

#murder number<=5 & assault number <=100 will define as less crime
#murder number >5 and <=10 & assault number <=200 define as average crime
#else the state will be more crime

discret_data<- cbind(new_data, danger_type=NA)  #adding a new column

for (i in 1:nrow(discret_data)){            #assigning values to the column 'danger_type' according to our classification
  if(discret_data$Murder[i]<=5 & discret_data$Assault[i]<=100)
  {
    discret_data$danger_type[i] = 'less crime'
  }else if(discret_data$Murder[i]>5 & discret_data$Murder[i]<=10 & discret_data$Assault[i]<=200){
    discret_data$danger_type[i] = 'average crime'
  }else{
    discret_data$danger_type[i] = 'more crime'
  }
}

final_data <- discret_data
final_data$Murder<- NULL
final_data$Assault<- NULL 

