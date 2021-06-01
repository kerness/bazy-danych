echo "MYSQL TEST"
#cd MYSQL
MYSQL/runMYSQLBench.sh

#cd ..

echo "PSQL TEST"
#cd PSQL
PSQL/runPSQLBench.sh

echo "TEST COMPLETED"

# cd ..
# cd dataProcessing

echo "PREPARING DATA"
dataProcessing/getNumbers.sh
echo "CALCULATING AVG"
dataProcessing/calculateAvg.sh

echo "DATA ARE IN res DIRECTORY"