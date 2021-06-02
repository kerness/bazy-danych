USE geomysql;

-- 2ZL
EXPLAIN SELECT COUNT(*) FROM milion INNER JOIN geopietro ON
(mod(milion.liczba,68)=geopietro.id_pietro) NATURAL JOIN geoepoka NATURAL JOIN
geookres NATURAL JOIN geoera NATURAL JOIN geoeon;