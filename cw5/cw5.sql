CREATE DATABASE firma;
create SCHEMA ksiegowosc;

CREATE TABLE ksiegowosc.pracownicy (
    id_pracownika serial  PRIMARY KEY NOT NULL,
    imie varchar(60)  NOT NULL,
    nazwisko varchar(60)  NOT NULL,
    adres varchar(80),
    telefon varchar(15)
);

CREATE TABLE ksiegowosc.godziny (
    id_godziny serial  PRIMARY KEY NOT NULL,
    data date  NOT NULL,
    liczba_godzin int  NOT NULL,
    id_pracownika int  NOT NULL
);

CREATE TABLE ksiegowosc.pensja (
    id_pensji serial PRIMARY KEY  NOT NULL,
    stanowisko varchar(60)  NOT NULL,
    kwota float(2)  NOT NULL
);

CREATE TABLE ksiegowosc.premia (
    id_premii serial PRIMARY KEY NOT NULL,
    rodzaj varchar(60),
    kwota float(2)

);

CREATE TABLE ksiegowosc.wynagrodzenia (
    id_wynagrodzenia serial PRIMARY KEY NOT NULL,
    data date  NOT NULL,
    id_pracownika int NOT NULL,
    id_godziny int NOT NULL,
    id_pensji int NOT NULL,
    id_premii int NOT NULL
);


ALTER TABLE ksiegowosc.godziny
	ADD FOREIGN KEY (id_pracownika)
		REFERENCES ksiegowosc.pracownicy(id_pracownika);

ALTER TABLE ksiegowosc.wynagrodzenia
    ADD FOREIGN KEY (id_pracownika)
		REFERENCES ksiegowosc.pracownicy(id_pracownika);
ALTER TABLE ksiegowosc.wynagrodzenia
	ADD FOREIGN KEY (id_godziny)
		REFERENCES ksiegowosc.godziny(id_godziny);
ALTER TABLE ksiegowosc.wynagrodzenia
	ADD FOREIGN KEY (id_pensji)
		REFERENCES ksiegowosc.pensja(id_pensji);
ALTER TABLE ksiegowosc.wynagrodzenia
	ADD FOREIGN KEY (id_premii)
		REFERENCES ksiegowosc.premia(id_premii);

INSERT INTO ksiegowosc.pracownicy VALUES
	(1, 'Konrad', 'Majka', 'Plac Centralny 6', '865326534'),
	(2, 'Roberto', 'Pleks', 'Ciepla 8', '6633245421'),
	(3, 'Anna', 'Tracz', 'Adna 7', '412336445'),
	(4, 'Anatolij', 'Klawy', 'Poprzeczna 67', '765878431'),
	(5, 'Gabriela', 'Mak', 'Turecka 3', NULL),
	(6, 'Misza', 'Kondracki', NULL, NULL),
	(7, 'Magdalena', 'Kruk', NULL, '01148126556789'),
	(8, 'Bartosz', 'Bartoszewski', 'Aleja Misza', '743218764'),
	(9, 'Anna', 'Maria', 'Smutna 2', NULL),
	(10, 'Jakub', 'Kwiatkowski', 'Torunska 2', NULL);

INSERT INTO ksiegowosc.godziny VALUES
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

INSERT INTO ksiegowosc.pensja VALUES
	(1, 'dyrektor', 5545),
	(2, 'kierownik', 4322),
	(3, 'kelner', 3550),
	(4, 'manager', 4440),
	(5, 'stazysta', 2220),
	(6, 'kierowca', 3000),
	(7, 'ochroniarz', 4600),
	(8, 'kucharz', 4200),
	(9, 'barista', 3000),
	(10, 'sushiMaster', 2200);

INSERT INTO ksiegowosc.premia VALUES
	(1, 'motywacyjna', 55),
	(2, 'uznaniowa', 1500),
	(3, NULL, NULL),
	(4, NULL, NULL),
	(5, NULL, 30),
	(6, 'motywacyjna', 500),
	(7, 'regulaminowa', 1800),
	(8, NULL, 1200),
	(9, NULL, 450),
	(10, 'uznaniowa', 100);

INSERT INTO ksiegowosc.wynagrodzenia VALUES
	(1, '2020-01-10', 1, 1, 1, 1),
	(2, '2020-01-10', 2, 2, 2, 2),
	(3, '2020-01-10', 3, 3, 3, 3),
	(4, '2020-01-10', 4, 4, 4, 4),
	(5, '2020-01-10', 5, 5, 5, 5),
	(6, '2020-01-10', 6, 6, 6, 6),
	(7, '2020-01-10', 7, 7, 7, 7),
	(8, '2020-01-10', 8, 8, 8, 8),
	(9, '2020-01-10', 9, 9, 9, 9),
	(10, '2020-01-10', 10, 10, 10, 10);

-- a) Wyświetl tylko id pracownika oraz jego nazwisko
SELECT id_pracownika, nazwisko
FROM ksiegowosc.pracownicy;

-- b) Wyświetl id pracowników, których płaca jest większa niż 3000
SELECT id_pracownika
FROM ksiegowosc.wynagrodzenia
JOIN ksiegowosc.pensja ON ksiegowosc.pensja.id_pensji = ksiegowosc.wynagrodzenia.id_pensji
WHERE kwota > 3000;

-- c) Wyświetl id pracowników nieposiadających premii,których płaca jest większa niż 2000.
SELECT id_pracownika
FROM ksiegowosc.wynagrodzenia
JOIN ksiegowosc.premia ON ksiegowosc.premia.id_premii = ksiegowosc.wynagrodzenia.id_premii
JOIN ksiegowosc.pensja ON ksiegowosc.pensja.id_pensji = ksiegowosc.wynagrodzenia.id_pensji
WHERE ksiegowosc.pensja.kwota >2000 AND ksiegowosc.premia.kwota IS NULL;

-- d) Wyświetl pracowników, których pierwsza litera imienia zaczyna się na literę ‘J’.
SELECT * FROM ksiegowosc.pracownicy
WHERE imie LIKE 'J%';

-- e) Wyświetl pracowników, których nazwisko zawiera literę ‘n’ oraz imię kończy się na literę ‘a’.
SELECT * FROM ksiegowosc.pracownicy
WHERE nazwisko LIKE '%n%' AND imie LIKE '%a';

-- f) Wyświetl imię i nazwisko pracowników oraz liczbę ich nadgodzin, przyjmując, iż standardowy czas pracy to 160 h miesięcznie.
SELECT imie, nazwisko, ksiegowosc.godziny.liczba_godzin - 160 AS liczba_nadgodzin
FROM ksiegowosc.pracownicy
JOIN ksiegowosc.godziny ON ksiegowosc.godziny.id_pracownika = ksiegowosc.pracownicy.id_pracownika
WHERE ksiegowosc.godziny.liczba_godzin > 160;


-- g) Wyświetl imię i nazwisko pracowników, których pensja zawiera się w przedziale 1500 –3000PLN
SELECT imie, nazwisko FROM ksiegowosc.pracownicy
JOIN ksiegowosc.wynagrodzenia ON pracownicy.id_pracownika = ksiegowosc.wynagrodzenia.id_pracownika
JOIN ksiegowosc.pensja ON pensja.id_pensji = ksiegowosc.wynagrodzenia.id_pensji
WHERE kwota > 1500 AND kwota < 3000;

-- h)Wyświetl imię i nazwisko pracowników, którzy pracowali w nadgodzinachi nie otrzymali premii.
SELECT imie, nazwisko, ksiegowosc.godziny.liczba_godzin - 160 AS liczba_nadgodzin, ksiegowosc.premia.kwota
FROM ksiegowosc.pracownicy
JOIN ksiegowosc.godziny ON ksiegowosc.godziny.id_pracownika = ksiegowosc.pracownicy.id_pracownika
JOIN ksiegowosc.wynagrodzenia ON pracownicy.id_pracownika = ksiegowosc.wynagrodzenia.id_pracownika
JOIN ksiegowosc.premia ON premia.id_premii = ksiegowosc.wynagrodzenia.id_premii
WHERE ksiegowosc.godziny.liczba_godzin > 160 AND ksiegowosc.premia.kwota IS NULL;


-- i) Uszereguj pracowników według pensji.
SELECT imie, nazwisko, ksiegowosc.pensja.kwota
FROM ksiegowosc.pracownicy
JOIN ksiegowosc.wynagrodzenia ON pracownicy.id_pracownika = wynagrodzenia.id_pracownika
JOIN ksiegowosc.pensja ON pensja.id_pensji = ksiegowosc.wynagrodzenia.id_pensji
ORDER BY ksiegowosc.pensja.kwota DESC;

-- j)  Uszereguj pracowników według pensji i premii malejąco
SELECT imie, nazwisko, ksiegowosc.pensja.kwota AS pensja, ksiegowosc.premia.kwota AS premia
FROM ksiegowosc.pracownicy
JOIN ksiegowosc.wynagrodzenia ON pracownicy.id_pracownika = wynagrodzenia.id_pracownika
JOIN ksiegowosc.pensja ON pensja.id_pensji = ksiegowosc.wynagrodzenia.id_pensji
JOIN ksiegowosc.premia ON premia.id_premii = ksiegowosc.wynagrodzenia.id_premii
ORDER BY ksiegowosc.pensja.kwota DESC, ksiegowosc.premia.kwota DESC;

-- k) Zlicz i pogrupuj pracowników według pola ‘stanowisko’
SELECT stanowisko, COUNT(*)
FROM ksiegowosc.pracownicy
JOIN ksiegowosc.wynagrodzenia ON ksiegowosc.wynagrodzenia.id_pracownika = ksiegowosc.pracownicy.id_pracownika
JOIN ksiegowosc.pensja ON ksiegowosc.pensja.id_pensji = ksiegowosc.wynagrodzenia.id_pensji
GROUP BY pensja.stanowisko;


-- l) Policz średnią, minimalną i maksymalną płacę dla stanowiska ‘kierownik’ (jeżeli takiego nie masz, to przyjmij dowolne inne).
SELECT stanowisko, avg(kwota), min(kwota), max(kwota)
FROM ksiegowosc.pensja
WHERE stanowisko = 'kierownik'
GROUP BY stanowisko;

-- m) Policz sumę wszystkich wynagrodzeń.
SELECT sum((pensja.kwota + premia.kwota)) AS suma_wszystkich_wynagrodzen FROM wynagrodzenia
JOIN ksiegowosc.pensja ON ksiegowosc.pensja.id_pensji = ksiegowosc.wynagrodzenia.id_pensji
JOIN ksiegowosc.premia ON ksiegowosc.premia.id_premii = ksiegowosc.wynagrodzenia.id_premii;

-- n) Policz sumę wynagrodzeń w ramach danego stanowiska.
SELECT (pensja.kwota + coalesce(premia.kwota, 0)) AS suma_wynagrodzen, pensja.stanowisko FROM wynagrodzenia -- coalesce = isnull
JOIN ksiegowosc.pensja ON ksiegowosc.pensja.id_pensji = ksiegowosc.wynagrodzenia.id_pensji
JOIN ksiegowosc.premia ON ksiegowosc.premia.id_premii = ksiegowosc.wynagrodzenia.id_premii;

-- o) Wyznacz liczbę premii przyznanych dla pracowników danego stanowiska.
SELECT count(premia.id_premii), pensja.stanowisko FROM ksiegowosc.premia
JOIN ksiegowosc.wynagrodzenia ON ksiegowosc.wynagrodzenia.id_premii = premia.id_premii
JOIN ksiegowosc.pensja ON pensja.id_pensji = ksiegowosc.wynagrodzenia.id_pensji
WHERE premia.kwota IS NOT NULL
GROUP BY pensja.stanowisko

-- p) Usuń wszystkich pracowników mających pensję mniejszą niż 1200 zł.