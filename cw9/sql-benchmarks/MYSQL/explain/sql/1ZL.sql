USE geomysql;

-- 1ZL
EXPLAIN SELECT COUNT(*) FROM milion INNER JOIN geotabela ON
(mod(milion.liczba,68)=(geotabela.id_pietro));