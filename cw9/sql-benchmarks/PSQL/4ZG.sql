\connect geopsql
\timing on

-- 4ZG
SELECT COUNT(*) FROM geochrono.Milion WHERE mod(Milion.liczba,68) IN (SELECT GeoPietro.id_pietro FROM geochrono.GeoPietro NATURAL JOIN geochrono.GeoEpoka NATURAL JOIN
geochrono.GeoOkres NATURAL JOIN geochrono.GeoEra NATURAL JOIN geochrono.GeoEon);
