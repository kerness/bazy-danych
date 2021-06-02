USE geomysql;

-- 3ZG
EXPLAIN SELECT COUNT(*) FROM milion WHERE mod(milion.liczba,68)=
(SELECT id_pietro FROM geotabela
WHERE mod(milion.liczba,68)=(id_pietro));