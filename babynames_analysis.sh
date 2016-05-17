####################################this is the shell scripting of the file#######################
#####these are used for processing various portions of answer 2 of the data science challenge#####
#####In order to run this script, just go to the unix terminal and type ./name_of_the_file.sh#########
###please try chmod 777 name_of_the_file.sh before running the file###############
###############################AUTHOR: RAJESH BAWA###################################################
#!/bin/bash
cat *.TXT > ALLSTATES_BABYNAMES.txt ###concatenate all the state files into single file
sed -i'' -e "s/,/\t/g" ALLSTATES_BABYNAMES.txt ###replace csv with tab separated file, just for ease to read in terminal
cut -f 2,4 -d$'\t' ALLSTATES_BABYNAMES.txt | sed  -e "s/\t/_/g" > new_names_bygender.txt ###create new ids
paste new_names_bygender.txt ALLSTATES_BABYNAMES.txt | cut -f 1,6 -d$'\t' > allnames_4-5.txt
####Adds up all the duplicate names
awk '{sums[$1] += $2} END { for (i in sums) printf("%s %s\n", i, sums[i])}' allnames_4-5.txt | sort -r -n -k2,2 > Summed_names_sorted.txt
#head Summed_names_sorted.txt
#cat Summed_names_sorted.txt| grep "F_" | head -1
#cat Summed_names_sorted.txt | grep "M_" | head -1
####the alternative way or a better way to answer question1 would be 
echo "The most popular name in USA (irrespective of gender) and the total number of times it has been recorded is " | tr '\n' ' ' && cat *.TXT | cut -f 4- -d',' | awk -F, '{sums[$1] += $2} END { for (i in sums) printf("%s %s\n", i, sums[i])}' | sort -n -r -k2,2 | head -n 1 
echo "The most popular female name in USA and the total number of times it has been recorded is " | tr '\n' ' ' && cat *.TXT | awk -F, '$2 == "F"' | cut -f 4- -d',' | awk -F, '{sums[$1] += $2} END { for (i in sums) printf("%s %s\n", i, sums[i])}' | sort -n -r -k2,2 | head -n 1 
echo "The most popular male name in USA and the total number of times it has been recorded is " | tr '\n' ' ' && cat *.TXT | awk -F, '$2 == "M"' | cut -f 4- -d',' | awk -F, '{sums[$1] += $2} END { for (i in sums) printf("%s %s\n", i, sums[i])}' | sort -n -r -k2,2 | head -n 1 
####need to improve the code here
#####################################
#####################################
awk '{print >> $3; close($3)}' ALLSTATES_BABYNAMES.txt ###split the file by each year and name them by year
#####################################
cut -f 2,4 -d$'\t' 1945 | sed -e "s/\t/_/g" > new_id_gender_names_1945 ###create new ids with name and gender
cut -f 2,4 -d$'\t' 2013 | sed -e "s/\t/_/g" > new_id_gender_names_2013
paste new_id_gender_names_1945 1945 > new_names_data_1945.txt
paste new_id_gender_names_2013 2013 > new_names_data_2013.txt
cut -f 1,6 -d$'\t' new_names_data_1945.txt | awk '{sums[$1] += $2} END { for (i in sums) printf("%s %s\n", i, sums[i])}' > summed_names_1945.txt
cut -f 1,6 -d$'\t' new_names_data_2013.txt | awk '{sums[$1] += $2} END { for (i in sums) printf("%s %s\n", i, sums[i])}' > summed_names_2013.txt
#########################################
#########################################
#########################################
cut -f 2,4 -d$'\t' 1980 | sed -e "s/\t/_/g" > new_id_gender_names_1980
cut -f 2,4 -d$'\t' 2014 | sed -e "s/\t/_/g" > new_id_gender_names_2014
paste new_id_gender_names_1980 1980 > new_names_data_1980.txt  
paste new_id_gender_names_2014 2014 > new_names_data_2014.txt 
cut -f 1,6 -d$'\t' new_names_data_1980.txt | awk '{sums[$1] += $2} END { for (i in sums) printf("%s %s\n", i, sums[i])}' > summed_names_1980.txt
cut -f 1,6 -d$'\t' new_names_data_2014.txt | awk '{sums[$1] += $2} END { for (i in sums) printf("%s %s\n", i, sums[i])}' > summed_names_2014.txt
############################################
############################################
############################################
cut -f 4- -d$'\t' 1980 | awk '{sums[$1] += $2} END { for (i in sums) printf("%s %s\n", i, sums[i])}' > summed_names_noNewIDS_1980.txt
cut -f 4- -d$'\t' 2014 | awk '{sums[$1] += $2} END { for (i in sums) printf("%s %s\n", i, sums[i])}' > summed_names_noNewIDS_2014.txt 
#############################################
#############################################
#############################################
#############################################
####this code parses all the state files, and finds out the top male and female name in each state
for f in *.TXT; do echo "$f" | tr '\n' ' ' && cat $f | awk -F, '$2 == "F"' | cut -f 4- -d',' | awk -F, '{sums[$1] += $2} END { for (i in sums) printf("%s %s\n", i, sums[i])}' | sort -n -r -k2,2 | head -n 1; done >top_female_name_in_each_state.txt
for f in *.TXT; do echo "$f" | tr '\n' ' ' && cat $f | awk -F, '$2 == "M"' | cut -f 4- -d',' | awk -F, '{sums[$1] += $2} END { for (i in sums) printf("%s %s\n", i, sums[i])}' | sort -n -r -k2,2 | head -n 1; done >top_male_name_in_each_state.txt
#############################################
#############################################
####################################
####################################
##now that we have all the files we need to use to get the other part of analysis done
### we run the Rscript, make sure the rscript is in the same folder as the all above files and shell script is
Rscript answer2_complete.r
exit;

#####these files are supposed to be run in conjunction with r code, to get the results.

