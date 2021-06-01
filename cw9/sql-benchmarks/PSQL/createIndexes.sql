\connect geopsql

CREATE UNIQUE INDEX IF NOT EXISTS liczba_idx ON geochrono.milion (liczba);
CREATE UNIQUE INDEX IF NOT EXISTS id_pietro_idx ON geochrono.geotabela (id_pietro);
CREATE UNIQUE INDEX IF NOT EXISTS id_eon_idx ON geochrono.geoeon (id_eon);
CREATE UNIQUE INDEX IF NOT EXISTS id_era_idx ON geochrono.geoera (id_era);
CREATE UNIQUE INDEX IF NOT EXISTS id_okres_idx ON geochrono.geookres (id_okres);
CREATE UNIQUE INDEX IF NOT EXISTS id_epoka_idx ON geochrono.geoepoka (id_epoka);
CREATE UNIQUE INDEX IF NOT EXISTS id_pietroG_idx ON geochrono.geopietro (id_pietro);