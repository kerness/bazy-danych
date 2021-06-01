# prepare data for insert to database
# tabela.csv is data from wiki table of geologic time (Piętro)

import csv

results = []
with open("/home/mb/Documents/tabela.csv") as csvfile:
    reader = csv.reader(csvfile, quoting=csv.QUOTE_ALL) 
    for row in reader:
        results.append(row)
       # print(row)

# remove trash
v = 0
for i in results:
    i = str(i)[2:]
    i = i.split(' ',1)[0]
    results[v] = i
    v = v+1



k = 1
for i in results:
    print("(" + str(k) + ",," + "'" + str(i) + "'" + "),")
    k += 1

    