# calculate AVG


# MYSQL
_1ZL_MYSQL_normal=$(awk -v N=1 '{ sum += $N } END { if (NR > 0) print sum / NR }' res/1ZL_MYSQL_normal.txt)
_2ZL_MYSQL_normal=$(awk -v N=1 '{ sum += $N } END { if (NR > 0) print sum / NR }' res/2ZL_MYSQL_normal.txt)
_3ZG_MYSQL_normal=$(awk -v N=1 '{ sum += $N } END { if (NR > 0) print sum / NR }' res/3ZG_MYSQL_normal.txt) 
_4ZG_MYSQL_normal=$(awk -v N=1 '{ sum += $N } END { if (NR > 0) print sum / NR }' res/4ZG_MYSQL_normal.txt)

_1ZL_MYSQL_idx=$(awk -v N=1 '{ sum += $N } END { if (NR > 0) print sum / NR }' res/1ZL_MYSQL_idx.txt) 
_2ZL_MYSQL_idx=$(awk -v N=1 '{ sum += $N } END { if (NR > 0) print sum / NR }' res/2ZL_MYSQL_idx.txt) 
_3ZG_MYSQL_idx=$(awk -v N=1 '{ sum += $N } END { if (NR > 0) print sum / NR }' res/3ZG_MYSQL_idx.txt)
_4ZG_MYSQL_idx=$(awk -v N=1 '{ sum += $N } END { if (NR > 0) print sum / NR }' res/4ZG_MYSQL_idx.txt) 

# PSQL
_1ZL_PSQL_normal=$(awk -v N=1 '{ sum += $N } END { if (NR > 0) print sum / NR }' res/1ZL_PSQL_normal.txt)
_2ZL_PSQL_normal=$(awk -v N=1 '{ sum += $N } END { if (NR > 0) print sum / NR }' res/2ZL_PSQL_normal.txt) 
_3ZG_PSQL_normal=$(awk -v N=1 '{ sum += $N } END { if (NR > 0) print sum / NR }' res/3ZG_PSQL_normal.txt) 
_4ZG_PSQL_normal=$(awk -v N=1 '{ sum += $N } END { if (NR > 0) print sum / NR }' res/4ZG_PSQL_normal.txt) 

_1ZL_PSQL_idx=$(awk -v N=1 '{ sum += $N } END { if (NR > 0) print sum / NR }' res/1ZL_PSQL_idx.txt) 
_2ZL_PSQL_idx=$(awk -v N=1 '{ sum += $N } END { if (NR > 0) print sum / NR }' res/2ZL_PSQL_idx.txt) 
_3ZG_PSQL_idx=$(awk -v N=1 '{ sum += $N } END { if (NR > 0) print sum / NR }' res/3ZG_PSQL_idx.txt) 
_4ZG_PSQL_idx=$(awk -v N=1 '{ sum += $N } END { if (NR > 0) print sum / NR }' res/4ZG_PSQL_idx.txt) 

printf "##########################################\n"
echo "MySQL - without indexes"
printf "\t1 ZL: %.0f\n" "$_1ZL_MYSQL_normal"
printf "\t2 ZL: %.0f\n" "$_2ZL_MYSQL_normal"
printf "\t3 ZG: %.0f\n" "$_3ZG_MYSQL_normal"
printf "\t4 ZG: %.0f\n" "$_4ZG_MYSQL_normal"

printf "MySQL - with indexes\n"
printf "\t1 ZL: %.0f\n" "$_1ZL_MYSQL_idx"
printf "\t2 ZL: %.0f\n" "$_2ZL_MYSQL_idx"
printf "\t3 ZG: %.0f\n" "$_3ZG_MYSQL_idx"
printf "\t4 ZG: %.0f\n" "$_4ZG_MYSQL_idx"

printf "##########################################\n"
printf "PostgreSQL - without indexes\n"
printf "\t1 ZL: %.0f\n" "$_1ZL_PSQL_normal"
printf "\t2 ZL: %.0f\n" "$_2ZL_PSQL_normal"
printf "\t3 ZG: %.0f\n" "$_3ZG_PSQL_normal"
printf "\t4 ZG: %.0f\n" "$_4ZG_PSQL_normal"

printf "PostgreSQL - with indexes\n"
printf "\t1 ZL: %.0f\n" "$_1ZL_PSQL_idx"
printf "\t2 ZL: %.0f\n" "$_2ZL_PSQL_idx"
printf "\t3 ZG: %.0f\n" "$_3ZG_PSQL_idx"
printf "\t4 ZG: %.0f\n" "$_4ZG_PSQL_idx"