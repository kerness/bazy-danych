USE geomysql;

-- add indexes
CREATE UNIQUE INDEX liczba_idx ON milion (liczba);
CREATE UNIQUE INDEX id_pietro_idx ON geotabela (id_pietro);
CREATE UNIQUE INDEX id_eon_idx ON geoeon (id_eon);
CREATE UNIQUE INDEX id_era_idx ON geoera (id_era);
CREATE UNIQUE INDEX id_okres_idx ON geookres (id_okres);
CREATE UNIQUE INDEX id_epoka_idx ON geoepoka (id_epoka);
CREATE UNIQUE INDEX id_pietroG_idx ON geopietro (id_pietro);