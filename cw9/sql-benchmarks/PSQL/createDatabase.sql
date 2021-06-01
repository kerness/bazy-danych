CREATE DATABASE geopsql;
CREATE SCHEMA geochrono;



-- create table
CREATE TABLE geochrono.GeoEon (
	id_eon INTEGER PRIMARY KEY,
	nazwa_eon VARCHAR(25) NOT NULL
);

CREATE TABLE geochrono.GeoEra (
	id_era INTEGER PRIMARY KEY,
	id_eon INTEGER REFERENCES geochrono.geoeon(id_eon),
	nazwa_era VARCHAR(25) NOT NULL
);

CREATE TABLE geochrono.GeoOkres (
	id_okres INTEGER PRIMARY KEY,
	id_era INTEGER REFERENCES geochrono.geoera(id_era),
	nazwa_okres VARCHAR(25) NOT NULL
);

CREATE TABLE geochrono.GeoEpoka (
	id_epoka INTEGER PRIMARY KEY,
	id_okres INTEGER REFERENCES geochrono.geookres(id_okres),
	nazwa_epoka VARCHAR(25) NOT NULL
);

CREATE TABLE geochrono.GeoPietro (
	id_pietro INTEGER PRIMARY KEY,
	id_epoka INTEGER REFERENCES geochrono.geoepoka(id_epoka),
	nazwa_p VARCHAR(25) NOT NULL
);


-- add foreign key
ALTER TABLE geochrono.geoera 
ADD FOREIGN KEY (id_eon)
REFERENCES geochrono.geoeon (id_eon);


ALTER TABLE geochrono.geookres 
ADD FOREIGN KEY (id_era)
REFERENCES geochrono.geoera (id_era);

ALTER TABLE geochrono.geoepoka 
ADD FOREIGN KEY (id_okres)
REFERENCES geochrono.geookres (id_okres);

ALTER TABLE geochrono.geopietro 
ADD FOREIGN KEY (id_epoka)
REFERENCES geochrono.geoepoka (id_epoka);

-- insert data
INSERT INTO geochrono.geoeon VALUES 
	(1, 'Fanerozoik');

INSERT INTO geochrono.geoera VALUES
	(1, 1, 'Kenozoik'),
	(2, 1, 'Mezozoik'),
	(3, 1, 'Paleozoik');

INSERT INTO geochrono.geookres VALUES
	(1, 1, 'Czwartorzęd'),
	(2, 1, 'Neogen'),
	(3, 1, 'Paleogen'),
	(4, 2, 'Kreda'),
	(5, 2, 'Jura'),
	(6, 2, 'Trias'),
	(7, 3, 'Perm'),
	(8, 3, 'Karbon'),
	(9, 3, 'Dewon');

INSERT INTO geochrono.geoepoka VALUES
	(1, 1, 'Holocen'),
	(2, 1, 'Plejstocen'),
	(3, 2, 'Pliocen'),
	(4, 2, 'Miocen'),
	(5, 3, 'Oligocen'),
	(6, 3, 'Eocen'),
	(7, 3, 'Paleocen'),
	(8, 4, 'Póżna kreda'),
	(9, 4, 'Wczesna kreda'),
	(10, 5, 'Jura późna'),
	(11, 5, 'Jura środkowa'),
	(12, 5, 'Jura wczesna'),
	(13, 6, 'Późny trias'),
	(14, 6, 'Środkowy trias'),
	(15, 6, 'Wczesny trias'),
	(16, 7, 'Póżny perm'),
	(17, 7, 'Wczesny perm'),
	(18, 8, 'Późny karbon'),
	(19, 8, 'Wczesny karbon'),
	(20, 9, 'Późny dewon'),
	(21, 9, 'Środkowy dewon'),
	(22, 9, 'Dolny dewon');

INSERT INTO geochrono.geopietro VALUES
	(1,1,'megalaj'),
	(2,1,'northgrip'),
	(3,1,'grenland'),
	(4,2,'późny[b]'),
	(5,2,'chiban'),
	(6,2,'kalabr'),
	(7,2,'gelas'),
	(8,3,'piacent'),
	(9,3,'zankl'),
	(10,4,'messyn'),
	(11,4,'torton'),
	(12,4,'serrawal'),
	(13,4,'lang'),
	(14,4,'burdygał'),
	(15,4,'akwitan'),
	(16,5,'szat'),
	(17,5,'rupel'),
	(18,6,'priabon'),
	(19,6,'barton'),
	(20,6,'lutet'),
	(21,6,'iprez'),
	(22,7,'tanet'),
	(23,7,'zeland'),
	(24,7,'dan'),
	(25,8,'mastrycht'),
	(26,8,'kampan'),
	(27,8,'santon'),
	(28,8,'koniak'),
	(29,8,'turon'),
	(30,8,'cenoman'),
	(31,9,'alb'),
	(32,9,'apt'),
	(33,9,'barrem'),
	(34,9,'hoteryw'),
	(35,9,'walanżyn'),
	(36,9,'berrias'),
	(37,10,'tyton'),
	(38,10,'kimeryd'),
	(39,10,'oksford'),
	(40,11,'kelowej'),
	(41,11,'baton'),
	(42,11,'bajos'),
	(43,11,'aalen'),
	(44,12,'toark'),
	(45,12,'pliensbach'),
	(46,12,'synemur'),
	(47,12,'hettang'),
	(48,13,'retyk'),
	(49,13,'noryk'),
	(50,13,'karnik'),
	(51,14,'ladyn'),
	(52,14,'anizyk'),
	(53,15,'olenek'),
	(54,15,'ind'),
	(55,16,'czangsing'),
	(56,16,'wucziaping'),
	(57,16,'kapitan'),
	(58,16,'word'),
	(59,16,'road'),
	(60,17,'kungur'),
	(61,17,'artinsk'),
	(62,17,'sakmar'),
	(63,17,'assel'),
	(64,18,'gżel'),
	(65,18,'kasimow'),
	(66,18,'moskow'),
	(67,18,'baszkir'),
	(68,19,'serpuchow'),
	(69,19,'wizen'),
	(70,19,'turnej'),
	(71,20,'famen'),
	(72,20,'fran'),
	(73,21,'żywet'),
	(74,21,'eifel'),
	(75,22,'ems'),
	(76,22,'prag'),
	(77,22,'lochkow');


-- denormalized table
CREATE TABLE geochrono.GeoTabela AS (SELECT * FROM geochrono.GeoPietro NATURAL JOIN geochrono.GeoEpoka NATURAL
JOIN geochrono.GeoOkres NATURAL JOIN geochrono.GeoEra NATURAL JOIN geochrono.GeoEon );

-- numeric table
CREATE TABLE geochrono.Dziesiec(cyfra int, bit int);
INSERT INTO geochrono.Dziesiec VALUES 
	(0, 1), (1, 1), (2, 1), (3, 1), (4, 1), (5, 1), (6, 1), (7, 1), (8, 1), (9, 1);

CREATE TABLE geochrono.Milion(liczba int,cyfra int, bit int);
INSERT INTO geochrono.Milion SELECT a1.cyfra +10* a2.cyfra +100*a3.cyfra + 1000*a4.cyfra
+ 10000*a5.cyfra + 100000*a6.cyfra AS liczba , a1.cyfra AS cyfra, a1.bit AS bit
FROM geochrono.Dziesiec a1, geochrono.Dziesiec a2, geochrono.Dziesiec a3, geochrono.Dziesiec a4, geochrono.Dziesiec a5, geochrono.Dziesiec a6;
