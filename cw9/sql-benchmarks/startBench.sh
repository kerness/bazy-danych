echo "MYSQL TEST"
cd MYSQL
./runMYSQLBench.sh

cd ..

echo "PSQL TEST"
cd PSQL
./runPSQLBench.sh

echo "TEST COMPLETED"

cd ..
cd dataProcessing

echo "PREPARING DATA"
./getNumbers.sh
echo "DATA ARE IN res DIRECTORY"