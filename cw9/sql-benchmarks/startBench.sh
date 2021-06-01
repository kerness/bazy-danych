# remove unnecessary res files
rm res/*.txt 2>/dev/null
rm MYSQL/res/*MYSQL*.txt 2>/dev/null
rm PSQL/res/*PSQL*.txt 2>/dev/null


echo "MYSQL TEST"
MYSQL/runMYSQLBench.sh 

echo "PSQL TEST"
PSQL/runPSQLBench.sh 

echo "TEST COMPLETED"
echo "PREPARING DATA"
dataProcessing/getNumbers.sh

echo "CALCULATING AVG"
dataProcessing/calculateAvg.sh

echo "Data are in res directory"