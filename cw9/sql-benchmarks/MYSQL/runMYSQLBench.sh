echo "Running MYSQL benchmarks..."

# prepare dataBase
mysql < MYSQL/dropDatabase.sql
# create database without indexes
mysql < MYSQL/createDatabase.sql
echo "Database was created"

echo "Start benchmark..."
echo "Without indexes"
for I in {1..25}
do
    echo "Test number: $I"
    #echo "Test number: $I" >> benchMYSQLRes.txt
    mysql -vvv < MYSQL/1ZL.sql | grep "set (*" >> MYSQL/res/1ZL_MYSQL_normal.txt
    mysql -vvv < MYSQL/2ZL.sql | grep "set (*" >> MYSQL/res/2ZL_MYSQL_normal.txt
    mysql -vvv < MYSQL/3ZG.sql | grep "set (*" >> MYSQL/res/3ZG_MYSQL_normal.txt
    mysql -vvv < MYSQL/4ZG.sql | grep "set (*" >> MYSQL/res/4ZG_MYSQL_normal.txt
done

mysql < MYSQL/createIndexes.sql

echo "With indexes"
for I in {1..25}
do
    echo "Test number: $I"
    #echo "Test number: $I" >> benchMYSQLRes.txt
    mysql -vvv < MYSQL/1ZL.sql | grep "set (*" >> MYSQL/res/1ZL_MYSQL_idx.txt
    mysql -vvv < MYSQL/2ZL.sql | grep "set (*" >> MYSQL/res/2ZL_MYSQL_idx.txt
    mysql -vvv < MYSQL/3ZG.sql | grep "set (*" >> MYSQL/res/3ZG_MYSQL_idx.txt
    mysql -vvv < MYSQL/4ZG.sql | grep "set (*" >> MYSQL/res/4ZG_MYSQL_idx.txt
done


# # remember to delete indexes firstly

# echo "Running MYSQL benchmarks..."
# echo "Without indexes"
# for I in {1..1}
# do
#     echo "Test number: $I"
#     echo "Test number: $I" >> benchMYSQLRes.txt
#     mysql -vvv < mysqlBenchNormal.sql | grep "set (*" >> benchMYSQLRes.txt
#     #psql < psqlBenchNormal.sql | grep 'Time' &>> benchRes4.txt


# done
# echo "With indexes"
# for I in {1..1}
# do
#     echo "Test number: $I"
#     echo "Test number: $I" >> benchMYSQLRes.txt
#     mysql -vvv < mysqlBenchIndex.sql | grep "set (*" >> benchMYSQLRes.txt
#     #psql < psqlBenchIndex.sql | grep 'Time' &>> benchRes4.txt
# done

# echo "Benchmark completed successfully"