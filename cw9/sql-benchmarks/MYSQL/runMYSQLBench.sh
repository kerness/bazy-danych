echo "Running MYSQL benchmarks..."

# prepare dataBase
mysql < dropDatabase.sql
# create database without indexes
mysql < createDatabase.sql
echo "Database was created"

echo "Start benchmark..."
echo "Without indexes"
for I in {1..25}
do
    echo "Test number: $I"
    #echo "Test number: $I" >> benchMYSQLRes.txt
    mysql -vvv < 1ZL.sql | grep "set (*" >> res/1ZL_MYSQL_normal.txt
    mysql -vvv < 2ZL.sql | grep "set (*" >> res/2ZL_MYSQL_normal.txt
    mysql -vvv < 3ZG.sql | grep "set (*" >> res/3ZG_MYSQL_normal.txt
    mysql -vvv < 4ZG.sql | grep "set (*" >> res/4ZG_MYSQL_normal.txt
done

mysql < createIndexes.sql

echo "With indexes"
for I in {1..25}
do
    echo "Test number: $I"
    #echo "Test number: $I" >> benchMYSQLRes.txt
    mysql -vvv < 1ZL.sql | grep "set (*" >> res/1ZL_MYSQL_idx.txt
    mysql -vvv < 2ZL.sql | grep "set (*" >> res/2ZL_MYSQL_idx.txt
    mysql -vvv < 3ZG.sql | grep "set (*" >> res/3ZG_MYSQL_idx.txt
    mysql -vvv < 4ZG.sql | grep "set (*" >> res/4ZG_MYSQL_idx.txt
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