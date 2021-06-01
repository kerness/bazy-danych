\connect geopsql
\timing on

-- 3ZG
SELECT COUNT(*) FROM geochrono.Milion WHERE mod(Milion.liczba,68)=
(SELECT id_pietro FROM geochrono.GeoTabela
WHERE mod(Milion.liczba,68)=(id_pietro));
