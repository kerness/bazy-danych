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
    mysql -vvv < MYSQL/1ZL.sql | grep "set (*" >> MYSQL/res/1ZL_MYSQL_idx.txt
    mysql -vvv < MYSQL/2ZL.sql | grep "set (*" >> MYSQL/res/2ZL_MYSQL_idx.txt
    mysql -vvv < MYSQL/3ZG.sql | grep "set (*" >> MYSQL/res/3ZG_MYSQL_idx.txt
    mysql -vvv < MYSQL/4ZG.sql | grep "set (*" >> MYSQL/res/4ZG_MYSQL_idx.txt
done
