# get onlu numbers from time data

# MSQL
# MSQL time is in s so multiply by 60

# cut first 1, grep only numbers, multiply by 60 
#cut -c 2- 1ZL_MYSQL_idx.txt | grep -Eo '[0-9\.]+' | awk -F" "  '{$1*=60;print}' > 1ZL_MSQL_normal.txt

cd MYSQL/res

cut -c 2- 1ZL_MYSQL_idx.txt | grep -Eo '[0-9\.]+' | awk -F" "  '{$1*=60;print}'> ../../res/1ZL_MSQL_normal.txt
cut -c 2- 1ZL_MYSQL_idx.txt | grep -Eo '[0-9\.]+' | awk -F" "  '{$1*=60;print}'> ../../res/2ZL_MSQL_normal.txt
cut -c 2- 1ZL_MYSQL_idx.txt | grep -Eo '[0-9\.]+' | awk -F" "  '{$1*=60;print}'> ../../res/3ZG_MSQL_normal.txt
cut -c 2- 1ZL_MYSQL_idx.txt | grep -Eo '[0-9\.]+' | awk -F" "  '{$1*=60;print}' > ../../res/4ZG_MSQL_normal.txt

cut -c 2- 1ZL_MYSQL_idx.txt | grep -Eo '[0-9\.]+' | awk -F" "  '{$1*=60;print}' > ../../res/1ZL_MSQL_idx.txt
cut -c 2- 1ZL_MYSQL_idx.txt | grep -Eo '[0-9\.]+' | awk -F" "  '{$1*=60;print}' > ../../res/2ZL_MSQL_idx.txt
cut -c 2- 1ZL_MYSQL_idx.txt | grep -Eo '[0-9\.]+' | awk -F" "  '{$1*=60;print}' > ../../res/3ZG_MSQL_idx.txt
cut -c 2- 1ZL_MYSQL_idx.txt | grep -Eo '[0-9\.]+' | awk -F" "  '{$1*=60;print}'> ../../res/4ZG_MSQL_idx.txt

cd ../..
cd PSQL/res

# PSQL
# need to remove (SOMETHING)



grep -Eo '[0-9\.]+' 1ZL_PSQL_normal.txt > ../../res/1ZL_PSQL_normal.txt
grep -Eo '[0-9\.]+' 2ZL_PSQL_normal.txt > ../../res/2ZL_PSQL_normal.txt
sed -e 's/([^()]*)//g' 3ZG_PSQL_normal.txt | grep -Eo '[0-9\.]+' > ../../res/3ZG_PSQL_normal.txt
grep -Eo '[0-9\.]+' 4ZG_PSQL_normal.txt > ../../res/4ZG_PSQL_normal.txt

grep -Eo '[0-9\.]+' 1ZL_PSQL_idx.txt > ../../res/1ZL_PSQL_idx.txt
grep -Eo '[0-9\.]+' 2ZL_PSQL_idx.txt > ../../res/2ZL_PSQL_idx.txt
sed -e 's/([^()]*)//g' 3ZG_PSQL_idx.txt | grep -Eo '[0-9\.]+' > ../../res/3ZG_PSQL_idx.txt
grep -Eo '[0-9\.]+' 4ZG_PSQL_idx.txt > ../../res/4ZG_PSQL_idx.txt
