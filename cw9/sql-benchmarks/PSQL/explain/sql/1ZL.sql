\connect geopsql
\timing on

EXPLAIN SELECT COUNT(*) FROM geochrono.Milion INNER JOIN geochrono.GeoTabela ON
(mod(Milion.liczba,68)=(GeoTabela.id_pietro));