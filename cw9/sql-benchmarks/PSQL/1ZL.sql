\connect geopsql
\timing on

SELECT COUNT(*) FROM geochrono.Milion INNER JOIN geochrono.GeoTabela ON
(mod(Milion.liczba,68)=(GeoTabela.id_pietro));