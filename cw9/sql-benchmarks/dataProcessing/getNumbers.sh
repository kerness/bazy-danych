# get onlu numbers from time data

# MSQL
# MSQL time is in s so multiply by 60 (and here was the bug! 1 s = 1000 ms not 60 ;) )

# cut first 1, grep only numbers, multiply by 60 


cut -c 2- MYSQL/res/1ZL_MYSQL_normal.txt | grep -Eo '[0-9\.]+' | awk -F" "  '{$1*=1000;print}'> res/1ZL_MYSQL_normal.txt
cut -c 2- MYSQL/res/2ZL_MYSQL_normal.txt | grep -Eo '[0-9\.]+' | awk -F" "  '{$1*=1000;print}'> res/2ZL_MYSQL_normal.txt
cut -c 2- MYSQL/res/3ZG_MYSQL_normal.txt | grep -Eo '[0-9\.]+' | awk -F" "  '{$1*=1000;print}'> res/3ZG_MYSQL_normal.txt
cut -c 2- MYSQL/res/4ZG_MYSQL_normal.txt | grep -Eo '[0-9\.]+' | awk -F" "  '{$1*=1000;print}' > res/4ZG_MYSQL_normal.txt

cut -c 2- MYSQL/res/1ZL_MYSQL_idx.txt | grep -Eo '[0-9\.]+' | awk -F" "  '{$1*=1000;print}' > res/1ZL_MYSQL_idx.txt
cut -c 2- MYSQL/res/2ZL_MYSQL_idx.txt | grep -Eo '[0-9\.]+' | awk -F" "  '{$1*=1000;print}' > res/2ZL_MYSQL_idx.txt
cut -c 2- MYSQL/res/3ZG_MYSQL_idx.txt | grep -Eo '[0-9\.]+' | awk -F" "  '{$1*=1000;print}' > res/3ZG_MYSQL_idx.txt
cut -c 2- MYSQL/res/4ZG_MYSQL_idx.txt | grep -Eo '[0-9\.]+' | awk -F" "  '{$1*=1000;print}' > res/4ZG_MYSQL_idx.txt



# PSQL
# need to remove (SOMETHING INSIDE)

grep -Eo '[0-9\.]+' PSQL/res/1ZL_PSQL_normal.txt > res/1ZL_PSQL_normal.txt
grep -Eo '[0-9\.]+' PSQL/res/2ZL_PSQL_normal.txt > res/2ZL_PSQL_normal.txt
sed -e 's/([^()]*)//g' PSQL/res/3ZG_PSQL_normal.txt | grep -Eo '[0-9\.]+' > res/3ZG_PSQL_normal.txt
grep -Eo '[0-9\.]+' PSQL/res/4ZG_PSQL_normal.txt > res/4ZG_PSQL_normal.txt

grep -Eo '[0-9\.]+' PSQL/res/1ZL_PSQL_idx.txt > res/1ZL_PSQL_idx.txt
grep -Eo '[0-9\.]+' PSQL/res/2ZL_PSQL_idx.txt > res/2ZL_PSQL_idx.txt
sed -e 's/([^()]*)//g' PSQL/res/3ZG_PSQL_idx.txt | grep -Eo '[0-9\.]+' > res/3ZG_PSQL_idx.txt
grep -Eo '[0-9\.]+' PSQL/res/4ZG_PSQL_idx.txt > res/4ZG_PSQL_idx.txt

