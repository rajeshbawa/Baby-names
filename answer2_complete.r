########Captial One Data Science Competition#########
########Answer2
#install.packages("maps")
#install.packages("data.table")
setwd("/work/hokiespeed/rajesh13/CO_datascience/CO_datascience/test_code")
####read the original 1945 data file for reference
file1_original<- read.table("1945", header = F, sep="\t")
####the summed and sorted names by gender file (perpared using awk)
file2 <- read.table("summed_names_1945.txt", sep=" ")
colnames(file2) <- c("Names", "Number")
#####split the new ids to get the original names using strsplit
names.file2 <- as.character(file2$Names)
tmp.file1945 <- t(as.data.frame(strsplit(names.file2, "_", fixed = T)))
colnames(tmp.file1945) <- c("Sex", "Name")
###combine the split name ids with their respective number
ornames.file2 <- data.frame(cbind(tmp.file1945, file2$Number))
row.names(ornames.file2) <- NULL
#####split the file by gender
male.file2 <- subset(ornames.file2, ornames.file2$Sex == 'M')
female.file2 <- subset(ornames.file2, ornames.file2$Sex == 'F')
####corresponding male and female columns###
####find the names which occur in both males and females
new_output1 <- na.omit(female.file2[match(male.file2$Name, female.file2$Name), ])
new_output2 <- na.omit(male.file2[match(female.file2$Name, male.file2$Name), ])
######sorting the data####
sort.output1 <- new_output1[order(new_output1$Name),] 
sort.output2 <- new_output2[order(new_output2$Name),]
##combine the sorted male and female data, to have corresponding columns of males and female
###names and their respective number,,,,, easy for visual scanning
new.dataset <- cbind(sort.output1, sort.output2)
colnames(new.dataset)[3] <- "Number_F"
colnames(new.dataset)[6] <- "Number_M"
###to convert the numbers from factors to numeric
new.dataset1 <- transform(new.dataset, Number_F = as.numeric(as.character(Number_F)), 
                          Number_M = as.numeric(as.character(Number_M)))
############
###Gender neutral names would be the ones, which would be high both in males and females
#### and not in total
####in order to apply this concept we calculate percentage by each name in both males and females
####function for percentage  of each name
percentage.females <- as.matrix(unlist(lapply(new.dataset1$Number_F, function(x, y) x/y, y = sum(new.dataset1$Number_F))))
percentage.males <- as.matrix(unlist(lapply(new.dataset1$Number_M, function(x,y) x/y, y=sum(new.dataset1$Number_M))))
new.dataset2 <- cbind(new.dataset1, percentage.females, percentage.males)
new.dataset2$totalNames <- new.dataset2$percentage.females + new.dataset2$percentage.males
sort.new.dataset <- new.dataset2[order(new.dataset2$totalNames, decreasing = T), ]
############after sorting the file by total percentage
###the bias still exists, now we want to choose the numbers which are equally high in both males and females
###and we use sorted file to get the order 
top_gender_neutral_names_1945 <- c()
for(i in 1:nrow(sort.new.dataset))
{
  if(sort.new.dataset$Number_F[i] > 100 && sort.new.dataset$Number_M[i] > 100)
  {
    top_gender_neutral_names_1945[i] <- as.character(sort.new.dataset$Name[i])
  }
}
top_gender_neutral_names_1945 <- na.omit(top_gender_neutral_names_1945)
cat("The most gender ambiguous name of 1945 is ", top_gender_neutral_names_1945[1], "\n")###gives you top gender neutral names in 2013
#####Most gender neutral name in 1945 was James and second is Robert
####which probably doesn't seem very correct
####I think its Jerry
#####################################
###########for year 2013#############
####read the summed names files, prepared using awk (all the duplicated were added here)
data.2013 <- read.table("summed_names_2013.txt", sep=" ")
colnames(data.2013) <- c("Names", "Number")
names.file2013 <- as.character(data.2013$Names)
####split the new ids of the summed file using str_split
tmp.file2013 <- t(as.data.frame(strsplit(names.file2013, "_", fixed = T)))
colnames(tmp.file2013) <- c("Sex", "Name")
###combine the original ids with the number of times the name occurs
ornames.file2013 <- data.frame(cbind(tmp.file2013, data.2013$Number))
row.names(ornames.file2013) <- NULL
#####split the file by gender
male.file2013 <- subset(ornames.file2013, ornames.file2013$Sex == 'M')
female.file2013 <- subset(ornames.file2013, ornames.file2013$Sex == 'F')
####corresponding male and female columns###
####find the names which occur in both males and females
new_output2013_1 <- na.omit(female.file2013[match(male.file2013$Name, female.file2013$Name), ])
new_output2013_2 <- na.omit(male.file2013[match(female.file2013$Name, male.file2013$Name), ])
######sorting the data####
sort.output2013_1 <- new_output2013_1[order(new_output2013_1$Name),] 
sort.output2013_2 <- new_output2013_2[order(new_output2013_2$Name),]
##combine the sorted male and female data, to have corresponding columns of males and female
###names and their respective number,,,,, easy for visual scanning
new.dataset2013 <- cbind(sort.output2013_1, sort.output2013_2)
colnames(new.dataset2013)[3] <- "Number_F"
colnames(new.dataset2013)[6] <- "Number_M"
###to convert the numbers from factors to numeric
new.dataset2013_1 <- transform(new.dataset2013, Number_F = as.numeric(as.character(Number_F)), 
                               Number_M = as.numeric(as.character(Number_M)))
###Gender neutral names would be the ones, which would be high both in males and females
#### and not in total
####in order to apply this concept we calculate percentage by each name in both males and females
####function for percentage  of each name
percentage.females2013 <- as.matrix(unlist(lapply(new.dataset2013_1$Number_F, function(x, y) x/y, y = sum(new.dataset2013_1$Number_F))))
percentage.males2013 <- as.matrix(unlist(lapply(new.dataset2013_1$Number_M, function(x,y) x/y, y=sum(new.dataset2013_1$Number_M))))
new.dataset2013_2 <- cbind(new.dataset2013_1, percentage.females2013, percentage.males2013)
new.dataset2013_2$totalNames <- new.dataset2013_2$percentage.females + new.dataset2013_2$percentage.males
sort.new.dataset2013 <- new.dataset2013_2[order(new.dataset2013_2$totalNames, decreasing = T), ]
############after sorting the file by total percentage
###the bias still exists, now we want to choose the numbers which are equally high in both males and females
###and we use sorted file to get the order 
top_gender_neutral_names_2013 <- c()
for(i in 1:nrow(sort.new.dataset2013))
{
  if(sort.new.dataset2013$Number_F[i] > 100 && sort.new.dataset2013$Number_M[i] > 100)
  {
    top_gender_neutral_names_2013[i] <- as.character(sort.new.dataset2013$Name[i])
  }
}
top_gender_neutral_names_2013 <- na.omit(top_gender_neutral_names_2013)
cat("The most gender ambiguous name of 2013 is ", top_gender_neutral_names_2013[1], "\n")###gives you top gender neutral names in 2013

###gives you top gender neutral names in 2013
#######top gender neutral names in 2013 are#############
#####Avery, Harper, Jayden, Logan##################
##################
#################
################
#################
###############answer2 part4##############################
#########################################################
#setwd("~/Documents/CO_datascience/year_datafiles")
data2014 <- read.table("summed_names_2014.txt", sep=" ")
data1980 <- read.table("summed_names_1980.txt", sep=" ")
colnames(data2014) <- c("Names", "Number")
colnames(data1980) <- c("Names", "Number")
###Find the names which have increased in popularity since 1980
common_names_1980 <- na.omit(data1980[match(data2014$Name, data1980$Name), ])
common_names_2014 <- na.omit(data2014[match(data1980$Name, data2014$Name), ])
####sorting the data
common_names_1980.sort <- common_names_1980[order(common_names_1980$Name),] 
common_names_2014.sort <- common_names_2014[order(common_names_2014$Name),]
###combine these two files together
common_names.data <- cbind(common_names_2014.sort, common_names_1980.sort)
names(common_names.data) <- c("Names_2014", "Num_2014", "Names_1980", "Num_1980")
#############assumption here is to only consider the names we have in the year 1980####
####and find the percentage increase and decrease of those numbers#####################
common_names.data$increase <- common_names.data$Num_2014 - common_names.data$Num_1980
common_names.data$decrease <- common_names.data$Num_1980 - common_names.data$Num_2014
#########
common_names.data$per_increase <- (common_names.data$increase/common_names.data$Num_1980)*100
common_names.data$per_decrease <- (common_names.data$decrease/common_names.data$Num_1980)*100
#######
common_names_perIncrease <- common_names.data[order(common_names.data$per_increase, decreasing = T),] 
common_names_perDecrease <- common_names.data[order(common_names.data$per_decrease, decreasing = T),] 
#####get the original name id's
names.increase <- as.character(common_names_perIncrease$Names_2014)
names.decrease <- as.character(common_names_perDecrease$Names_2014)
tmp.file1 <- t(as.data.frame(strsplit(names.increase, "_", fixed = T)))
tmp.file2 <- t(as.data.frame(strsplit(names.decrease, "_", fixed = T)))
###include them in the sorted increase and decrease file
common_names_perIncrease$origName <- tmp.file1[,2] 
common_names_perDecrease$origName <- tmp.file2[,2]
###########largest percent increase##########
cat("The largest increase is in the name = ", head(as.character(common_names_perIncrease$origName), n=1), "\n")
cat("The largest decrease is in the name = ", head(as.character(common_names_perDecrease$origName), n=1), "\n")
#############the other names which were very close in the decrease were 
####Beth, Misty, Jill and Michele
###############################################################
##########################################
#################################
#####Answer 5
################Names which could have increased or decreased more than these names since 1980
###the idea is that here we don't consider names by gender, but as such
#### since many names are assigned to both males and females
###this is bound to give a different result
data.2014.1 <- read.table("summed_names_noNewIDS_2014.txt", sep=" ")
data.1980.1 <- read.table("summed_names_noNewIDS_1980.txt", sep=" ")
colnames(data.1980.1) <- c("Names", "Number")
colnames(data.2014.1) <- c("Names", "Number")
##################
common_names_1980.1 <- na.omit(data.1980.1[match(data.2014.1$Names, data.1980.1$Names), ])
common_names_2014.1 <- na.omit(data.2014.1[match(data.1980.1$Names, data.2014.1$Names), ])
####sorting the data
common_names_1980.sort.1 <- common_names_1980.1[order(common_names_1980.1$Names),] 
common_names_2014.sort.1 <- common_names_2014.1[order(common_names_2014.1$Names),]
###combine these two files together
common_names.data.1 <- cbind(common_names_2014.sort.1, common_names_1980.sort.1)
names(common_names.data.1) <- c("Names_2014", "Num_2014", "Names_1980", "Num_1980")
#############assumption here is to only consider the names we have in the year 1980####
####and find the percentage increase and decrease of those numbers#####################
common_names.data.1$increase <- common_names.data.1$Num_2014 - common_names.data.1$Num_1980
common_names.data.1$decrease <- common_names.data.1$Num_1980 - common_names.data.1$Num_2014
#########
common_names.data.1$per_increase <- (common_names.data.1$increase/common_names.data.1$Num_1980)*100
common_names.data.1$per_decrease <- (common_names.data.1$decrease/common_names.data.1$Num_1980)*100
#######
common_names_perIncrease.1 <- common_names.data.1[order(common_names.data.1$per_increase, decreasing = T),] 
common_names_perDecrease.1 <- common_names.data.1[order(common_names.data.1$per_decrease, decreasing = T),] 
###########largest percent increase##########
cat("The largest increase is in the name when gender is not considered is = ", head(as.character(common_names_perIncrease.1$Names_2014), n=1), "\n")
cat("The largest decrease is in the name when gender is not considered is = ", head(as.character(common_names_perDecrease.1$Names_2014), n=1), "\n")
#####there isn't much difference in the percent decrease names, they are exactly the same
#########################################
###########
#####################
####################
#####################
#########################
####projecting the babynames on map
####comparing top 10 baby names rate in last 50 years (5 each males and females)
####Keep it gender restricted here
library(data.table)
#setwd("~/Documents/CO_datascience/names_dir")
###Downloaded from SSN Website (based on 1910-2014)######
topnames.male <- as.data.frame(c("James", "John", "Robert", "Michael", "William"))
topnames.female <- as.data.frame(c("Mary", "Patricia", "Jennifer", "Elizabeth", "Linda"))
colnames(topnames.male) <- "topname"                               
colnames(topnames.female) <- "topname"
file1 <- fread("ALLSTATES_BABYNAMES.txt", sep="\t") ####fread is way too faster and optimized for bigger files
colnames(file1) <- c("State", "Sex", "Year", "Name", "Number")
###split the file based on the decade
file1.2000 <- file1[grep("^20", file1$Year, perl=TRUE), ]
##split by gender
file1.2000.female <- subset(file1.2000, file1.2000$Sex == 'F')
file1.2000.male <- subset(file1.2000, file1.2000$Sex == 'M')
###add up the duplicates in each gender
file1.2000.female.sum <- aggregate(file1.2000.female$Number, by=list(Name=file1.2000.female$Name), FUN=sum)
file1.2000.male.sum <- aggregate(file1.2000.male$Number, by=list(Name=file1.2000.male$Name), FUN=sum)
###calculate percentages
file1.2000.male.sum$percent <- lapply(file1.2000.male.sum$x, function(x, y) x/y, y = sum(file1.2000.male.sum$x))
file1.2000.female.sum$percent <- lapply(file1.2000.female.sum$x, function(x, y) x/y, y = sum(file1.2000.female.sum$x))
###match it to the topnames
file1.2000.female.select <- file1.2000.female.sum[match(topnames.female$topname, file1.2000.female.sum$Name), ]
file1.2000.male.select <- file1.2000.male.sum[match(topnames.male$topname, file1.2000.male.sum$Name),]
####################
####################
file1.1990 <- file1[grep("^199", file1$Year, perl=TRUE), ]
##
##split by gender
file1.1990.female <- subset(file1.1990, file1.1990$Sex == 'F')
file1.1990.male <- subset(file1.1990, file1.1990$Sex == 'M')
###add up the duplicates in each gender
file1.1990.female.sum <- aggregate(file1.1990.female$Number, by=list(Name=file1.1990.female$Name), FUN=sum)
file1.1990.male.sum <- aggregate(file1.1990.male$Number, by=list(Name=file1.1990.male$Name), FUN=sum)
###calculate percentages
file1.1990.male.sum$percent <- lapply(file1.1990.male.sum$x, function(x, y) x/y, y = sum(file1.1990.male.sum$x))
file1.1990.female.sum$percent <- lapply(file1.1990.female.sum$x, function(x, y) x/y, y = sum(file1.1990.female.sum$x))
###match it to the topnames
file1.1990.female.select <- file1.1990.female.sum[match(topnames.female$topname, file1.1990.female.sum$Name), ]
file1.1990.male.select <- file1.1990.male.sum[match(topnames.male$topname, file1.1990.male.sum$Name),]
#################
################
###############
file1.1980 <- file1[grep("^198", file1$Year, perl=TRUE), ]
##
##split by gender
file1.1980.female <- subset(file1.1980, file1.1980$Sex == 'F')
file1.1980.male <- subset(file1.1980, file1.1980$Sex == 'M')
###add up the duplicates in each gender
file1.1980.female.sum <- aggregate(file1.1980.female$Number, by=list(Name=file1.1980.female$Name), FUN=sum)
file1.1980.male.sum <- aggregate(file1.1980.male$Number, by=list(Name=file1.1980.male$Name), FUN=sum)
###calculate percentages
file1.1980.male.sum$percent <- lapply(file1.1980.male.sum$x, function(x, y) x/y, y = sum(file1.1980.male.sum$x))
file1.1980.female.sum$percent <- lapply(file1.1980.female.sum$x, function(x, y) x/y, y = sum(file1.1980.female.sum$x))
###match it to the topnames
file1.1980.female.select <- file1.1980.female.sum[match(topnames.female$topname, file1.1980.female.sum$Name), ]
file1.1980.male.select <- file1.1980.male.sum[match(topnames.male$topname, file1.1980.male.sum$Name),]
###################
##################
##################
file1.1970 <- file1[grep("^197", file1$Year, perl=TRUE), ]
##
##split by gender
file1.1970.female <- subset(file1.1970, file1.1970$Sex == 'F')
file1.1970.male <- subset(file1.1970, file1.1970$Sex == 'M')
###add up the duplicates in each gender
file1.1970.female.sum <- aggregate(file1.1970.female$Number, by=list(Name=file1.1970.female$Name), FUN=sum)
file1.1970.male.sum <- aggregate(file1.1970.male$Number, by=list(Name=file1.1970.male$Name), FUN=sum)
###calculate percentages
file1.1970.male.sum$percent <- lapply(file1.1970.male.sum$x, function(x, y) x/y, y = sum(file1.1970.male.sum$x))
file1.1970.female.sum$percent <- lapply(file1.1970.female.sum$x, function(x, y) x/y, y = sum(file1.1970.female.sum$x))
###match it to the topnames
file1.1970.female.select <- file1.1970.female.sum[match(topnames.female$topname, file1.1970.female.sum$Name), ]
file1.1970.male.select <- file1.1970.male.sum[match(topnames.male$topname, file1.1970.male.sum$Name),]
#######################
######################
######################
file1.1960 <- file1[grep("^196", file1$Year, perl=TRUE), ]
##
##split by gender
file1.1960.female <- subset(file1.1960, file1.1960$Sex == 'F')
file1.1960.male <- subset(file1.1960, file1.1960$Sex == 'M')
###add up the duplicates in each gender
file1.1960.female.sum <- aggregate(file1.1960.female$Number, by=list(Name=file1.1960.female$Name), FUN=sum)
file1.1960.male.sum <- aggregate(file1.1960.male$Number, by=list(Name=file1.1960.male$Name), FUN=sum)
###calculate percentages
file1.1960.male.sum$percent <- lapply(file1.1960.male.sum$x, function(x, y) x/y, y = sum(file1.1960.male.sum$x))
file1.1960.female.sum$percent <- lapply(file1.1960.female.sum$x, function(x, y) x/y, y = sum(file1.1960.female.sum$x))
###match it to the topnames
file1.1960.female.select <- file1.1960.female.sum[match(topnames.female$topname, file1.1960.female.sum$Name), ]
file1.1960.male.select <- file1.1960.male.sum[match(topnames.male$topname, file1.1960.male.sum$Name),]
######################
########
######################
file1.1950 <- file1[grep("^195", file1$Year, perl=TRUE), ]
##
##split by gender
file1.1950.female <- subset(file1.1950, file1.1950$Sex == 'F')
file1.1950.male <- subset(file1.1950, file1.1950$Sex == 'M')
###add up the duplicates in each gender
file1.1950.female.sum <- aggregate(file1.1950.female$Number, by=list(Name=file1.1950.female$Name), FUN=sum)
file1.1950.male.sum <- aggregate(file1.1950.male$Number, by=list(Name=file1.1950.male$Name), FUN=sum)
###calculate percentages
file1.1950.male.sum$percent <- lapply(file1.1950.male.sum$x, function(x, y) x/y, y = sum(file1.1950.male.sum$x))
file1.1950.female.sum$percent <- lapply(file1.1950.female.sum$x, function(x, y) x/y, y = sum(file1.1950.female.sum$x))
###match it to the topnames
file1.1950.female.select <- file1.1950.female.sum[match(topnames.female$topname, file1.1950.female.sum$Name), ]
file1.1950.male.select <- file1.1950.male.sum[match(topnames.male$topname, file1.1950.male.sum$Name),]
############################
####merge the data from all the tables into single table
female_topnames_decades <- cbind(as.character(topnames.female$topname), file1.1950.female.select$percent, file1.1960.female.select$percent, file1.1970.female.select$percent, file1.1980.female.select$percent, file1.1990.female.select$percent, file1.2000.female.select$percent)
colnames(female_topnames_decades) <- c("Names", "1950", "1960", "1970", "1980", "1990", "2000")
male_topnames_decades <- cbind(as.character(topnames.male$topname), file1.1950.male.select$percent, file1.1960.male.select$percent, file1.1970.male.select$percent, file1.1980.male.select$percent, file1.1990.male.select$percent, file1.2000.male.select$percent)
colnames(male_topnames_decades) <- c("Names", "1950", "1960", "1970", "1980", "1990", "2000")
##############################
#########Stacked Barplot###########
jpeg("Female_percent_contribution_barplot.jpg",width=600,height=500,quality = 100)
female_topnames_decades.t <- t(female_topnames_decades)
barplot(female_topnames_decades.t[-1, ], names.arg = female_topnames_decades.t[1,], legend.text = T, args.legend = list(bty="n"), main = "Percentage contribution of top five names in females")
dev.off()
jpeg("Male_percent_contribution_barplot.jpg",width=600,height=500, quality=100)
male_topnames_decades.t <- t(male_topnames_decades)
barplot(male_topnames_decades.t[-1, ], names.arg = male_topnames_decades.t[1,], legend.text = T, args.legend = list(bty="n"), main = "Percentage contribution of top five names in males")
dev.off()
################
######Visualize Overall common male and female name in each state###########
#######results obtained from shell script, separately attached#####
####inspired by http://www.r-bloggers.com/us-names-by-state-part-i-mary-is-everywhere/
########################
library(maps)
datamap.female <- read.table("top_female_name_in_each_state.txt", sep=" ")
datamap.male <- read.table("top_male_name_in_each_state.txt", sep=" ")
###### State structure
####regions are obtained from maps package
####Alaska, Hawaii and DC are not available in package
###these are for the matching and arranging the dataframe
index.states=c("alabama","arkansas","arizona","california","colorado","connecticut","delaware",
               "florida","georgia","iowa","idaho","illinois","indiana","kansas",
               "kentucky","louisiana","massachusetts:main","maryland","maine","michigan:south","minnesota",
               "missouri","mississippi","montana","north carolina:main","north dakota","nebraska","new hampshire","new jersey",
               "new mexico","nevada","new york:main","ohio","oklahoma",
               "oregon","pennsylvania","rhode island","south carolina","south dakota","tennessee",
               "texas","utah","virginia:main","vermont","washington:main","wisconsin","west virginia","wyoming")
#######this is the order recommended by the maps package for plotting purposes
regions1=c("alabama","arizona","arkansas","california","colorado","connecticut","delaware",
           "florida","georgia","idaho","illinois","indiana","iowa","kansas",
           "kentucky","louisiana","maine","maryland","massachusetts:main","michigan:south","minnesota",
           "mississippi","missouri","montana","nebraska","nevada","new hampshire","new jersey",
           "new mexico","new york:main","north carolina:main","north dakota","ohio","oklahoma",
           "oregon","pennsylvania","rhode island","south carolina","south dakota","tennessee",
           "texas","utah","vermont","virginia:main","washington:main","west virginia",
           "wisconsin","wyoming")
mat<-as.data.frame(cbind(regions1,NA,NA))
#####removing the entries not available for states in the package
datamap.female1 <- datamap.female[-c(1,8,12), ]
datamap.male1 <- datamap.male[-c(1,8,12), ]
datamap.female1$Index <- index.states
datamap.male1$Index <- index.states
#####rearrange the dataframe according to region1 for plotting
regions.map <- as.data.frame(unlist(regions1))
colnames(regions.map) <- "States"
datamap.female1.match <- datamap.female1[match(regions.map$States, datamap.female1$Index), ]
datamap.male1.match <- datamap.male1[match(regions.map$States, datamap.male1$Index), ]
######converting numerics to character variables for plotting
mat$V1 <- regions1
mat$V2<-as.character(datamap.female1.match$V2)
mat$V3<-as.character(datamap.male1.match$V2)
####creating a map object
###for men
jpeg("Most_common_male_name_by_state.jpg",width=1300,height=700, quality=100)
usa <- map("state",fill=TRUE,col="skyblue")
map.text(add=T,"state",regions=mat$regions1,labels=mat$V3, cex = 1)
dev.off()
####for women
jpeg("Most_common_female_name_by_state.jpg",width=1300,height=700, quality=100)
usa <- map("state",fill=TRUE,col="pink")
map.text(add=T,"state",regions=regions1,labels=mat$V2, cex = 1)
dev.off()
exit;
####################
########################
#############










