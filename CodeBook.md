##Project code book
# packages used:
dplyr

#functions used:
read.table
cbind
rbind
rm
grepl
merge
gsub
group_by
summarize_all
write.table

#variables :
test_subject --contain data readed from test folder /subject file
test_value  --contain data readed from test folder /Value file
test_activity  --contain data readed from test folder /activity file

train_subject --contain data readed from train folder /subject file
train_value --contain data readed from train folder /Value file
train_activity --contain data readed from train folder /activity file


activity_lables --contain activity_id and names mapping
features_lables --contain features lables

test_data --collected test data
train_data --collected train data

data --collected test and train data after renaming

data_col_names --all remaining column names after felteration

data_mean --mean of each column and final data set