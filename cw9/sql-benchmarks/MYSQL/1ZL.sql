USE geomysql;

-- 1ZL
SELECT COUNT(*) FROM milion INNER JOIN geotabela ON
(mod(milion.liczba,68)=(geotabela.id_pietro));