echo "Running PSSQL benchmarks..."

# prepare dataBase
#psql < dropDatabase.sql
# create database without indexes
#psql < createDatabase.sql
#echo "Database was created"

echo "Start benchmark..."
echo "Without indexes"
psql -o /dev/null < PSQL/dropIndexes.sql
for I in {1..25}
do
    echo "Test number: $I"
    psql < PSQL/1ZL.sql | grep 'Time' >> PSQL/res/1ZL_PSQL_normal.txt
    psql < PSQL/2ZL.sql | grep 'Time' >> PSQL/res/2ZL_PSQL_normal.txt
    psql < PSQL/3ZG.sql | grep 'Time' >> PSQL/res/3ZG_PSQL_normal.txt
    psql < PSQL/4ZG.sql | grep 'Time' >> PSQL/res/4ZG_PSQL_normal.txt
done

psql -o /dev/null < PSQL/createIndexes.sql

echo "With indexes"
for I in {1..25}
do
    echo "Test number: $I"
    psql < PSQL/1ZL.sql | grep 'Time' >> PSQL/res/1ZL_PSQL_idx.txt
    psql < PSQL/2ZL.sql | grep 'Time' >> PSQL/res/2ZL_PSQL_idx.txt
    psql < PSQL/3ZG.sql | grep 'Time' >> PSQL/res/3ZG_PSQL_idx.txt
    psql < PSQL/4ZG.sql | grep 'Time' >> PSQL/res/4ZG_PSQL_idx.txt
done