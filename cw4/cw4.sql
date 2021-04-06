
-- 1. Stworzenie nowej bazy danych
CREATE DATABASE firma;
USE firma;

-- 2. Stworzenie schematu
CREATE SCHEMA rozliczenia;

-- 3. Stworzenie tabeli
CREATE TABLE rozliczenia.pracownicy(
	id_pracownika integer PRIMARY KEY NOT NULL,
	imie varchar(50) NOT NULL,
	nazwisko varchar(50) NOT NULL,
	adres varchar(75),
	telefon varchar(15)
);
CREATE TABLE rozliczenia.godziny(
	id_godziny integer PRIMARY KEY NOT NULL,
	ddata date NOT NULL,
	liczba_godzin integer NOT NULL,
	id_pracownika integer NOT NULL
);
CREATE TABLE rozliczenia.pensje(
	id_pensji integer PRIMARY KEY NOT NULL, 
	stanowisko varchar(50), 
	kwota float(2) NOT NULL, 
	id_premii integer
);
CREATE TABLE rozliczenia.premie(
	id_premii integer PRIMARY KEY NOT NULL, 
	rodzaj varchar(50), 
	kwota float(2) NOT NULL
);

-- Dodanie kluczy obcych

ALTER TABLE rozliczenia.godziny
	ADD FOREIGN KEY (id_pracownika) 
		REFERENCES rozliczenia.pracownicy(id_pracownika);

ALTER TABLE rozliczenia.pensje
	ADD FOREIGN KEY (id_premii) 
		REFERENCES rozliczenia.premie(id_premii);

-- 4. Wype³nienie tabel rekordami
INSERT INTO rozliczenia.pracownicy VALUES
	(1, 'Konrad', 'Majka', 'Plac Centralny 6', '865326534'),
	(2, '£ukasz', 'Pleks', 'Ciep³a 8', '6633245421'),
	(3, 'Anna', 'Tracz', '£adna 7', '412336445'),
	(4, 'Miko³aj', 'Klawy', 'Œwi¹teczna 67', '765878431'),
	(5, 'Gabriela', 'Mak', 'Turecka 3', NULL),
	(6, 'Mi³osz', 'Kondracki', NULL, NULL),
	(7, 'Magdalena', 'Kruk', NULL, '01148126556789'),
	(8, 'Bartosz', 'Bartoszewski', 'Aleja Mi³osza', '743218764'),
	(9, 'Anna', 'Maria', 'Smutna 2', NULL),
	(10, 'Jakub', 'Kwiatkowski', 'Toruñska 2', NULL);

INSERT INTO rozliczenia.godziny VALUES
	(1, '2020-01-10', 155, 1),
	(2, '2020-01-10', 165, 2),
	(3, '2020-01-10', 144, 3),
	(4, '2020-01-10', 170, 4),
	(5, '2020-01-10', 160, 5),
	(6, '2020-01-10', 156, 6),
	(7, '2020-01-10', 160, 7),
	(8, '2020-01-10', 155, 8),
	(9, '2020-01-10', 177, 9),
	(10, '2020-01-10', 121, 10);

INSERT INTO rozliczenia.pensje VALUES
	(1, 'dyrektor', 5545, 1 ),
	(2, NULL, 4322, 2),
	(3, NULL, 3550, 3),
	(4, 'manager', 4440, 4),
	(5, NULL, 2220, 5),
	(6, 'kierowca', 3000, 6),
	(7, NULL, 4600, 7),
	(8, 'kucharz', 4200, 8),
	(9, NULL, 3000, 9),
	(10, NULL, 2200, 10);

INSERT INTO rozliczenia.premie VALUES
	(1, 'motywacyjna', 55),
	(2, 'uznaniowa', 1500),
	(3, NULL, 600),
	(4, NULL, 1200),
	(5, NULL, 30),
	(6, 'motywacyjna', 500),
	(7, 'regulaminowa', 1800),
	(8, NULL, 1200),
	(9, NULL, 450),
	(10, 'uznaniowa', 100);


-- 5. Wyœwietl nazwiska i adresy pracowników
SELECT nazwisko, adres FROM rozliczenia.pracownicy;

-- 6. Konwersja daty
SELECT *, DATEPART(WEEKDAY, ddata) AS 'DzienTygodnia', DATEPART(MONTH, ddata) AS 'Miesiac' from rozliczenia.godziny

-- 7. Obliczenie kwoty netto (podatek 19%)
EXEC SP_RENAME 'rozliczenia.pensje.kwota', 'kwota_brutto', 'COLUMN';
ALTER TABLE rozliczenia.pensje
	ADD kwota_netto float(2);

UPDATE rozliczenia.pensje
	SET kwota_netto = 0.81 * kwota_brutto;

SELECT * FROM rozliczenia.pensje;

