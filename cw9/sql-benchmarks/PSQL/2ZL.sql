\connect geopsql
\timing on

-- 2ZL
SELECT COUNT(*) FROM geochrono.Milion INNER JOIN geochrono.GeoPietro ON
(mod(Milion.liczba,68)=geochrono.GeoPietro.id_pietro) NATURAL JOIN geochrono.GeoEpoka NATURAL JOIN
geochrono.GeoOkres NATURAL JOIN geochrono.GeoEra NATURAL JOIN geochrono.GeoEon;
