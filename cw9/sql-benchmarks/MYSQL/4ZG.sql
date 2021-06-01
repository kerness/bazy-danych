USE geomysql;

-- 4ZG
SELECT COUNT(*) FROM milion WHERE mod(milion.liczba,68) IN (SELECT geopietro.id_pietro FROM geopietro NATURAL JOIN geoepoka NATURAL JOIN
geookres NATURAL JOIN geoera NATURAL JOIN geoeon);