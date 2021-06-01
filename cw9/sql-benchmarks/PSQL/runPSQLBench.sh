echo "Running PSSQL benchmarks..."

# prepare dataBase
#psql < dropDatabase.sql
# create database without indexes
#psql < createDatabase.sql
echo "Database was created"

echo "Start benchmark..."
echo "Without indexes"
psql -o /dev/null < dropIndexes.sql
for I in {1..25}
do
    echo "Test number: $I"
    psql < 1ZL.sql | grep 'Time' >> res/1ZL_PSQL_normal.txt
    psql < 2ZL.sql | grep 'Time' >> res/2ZL_PSQL_normal.txt
    psql < 3ZG.sql | grep 'Time' >> res/3ZG_PSQL_normal.txt
    psql < 4ZG.sql | grep 'Time' >> res/4ZG_PSQL_normal.txt
done

psql -o /dev/null < createIndexes.sql

echo "With indexes"
for I in {1..25}
do
    echo "Test number: $I"
    psql < 1ZL.sql | grep 'Time' >> res/1ZL_PSQL_idx.txt
    psql < 2ZL.sql | grep 'Time' >> res/2ZL_PSQL_idx.txt
    psql < 3ZG.sql | grep 'Time' >> res/3ZG_PSQL_idx.txt
    psql < 4ZG.sql | grep 'Time' >> res/4ZG_PSQL_idx.txt
done






# echo "Running PSQL benchmarks..."
# echo "Without indexes"
# for I in {1..3}
# do
#     echo "Test number: $I"
#     echo "Test number: $I" $>> benchPSQLRes.txt
#     psql < psqlBenchNormal.sql | grep 'Test*\|Time' &>> benchPSQLRes.txt
#     #psql < psqlBenchNormal.sql | grep 'Time' &>> benchRes4.txt


# done
# echo "With indexes"
# for I in {1..3}
# do
#     echo "Test number: $I"
#     echo "Test number: $I" $>> benchPSQLRes.txt
#     psql < psqlBenchIndex.sql | grep 'Test*\|Time' &>> benchPSQLRes.txt
#     #psql < psqlBenchIndex.sql | grep 'Time' &>> benchRes4.txt
# done

# echo "Benchmark completed successfully"