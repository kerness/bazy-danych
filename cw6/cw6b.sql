-- a) dodanie (+48)
-- kolumna 'telefon' na ograniczony rozmiar, więć tworzę nową kolumnę tylko dla polskich numerów
ALTER TABLE pracownicy
ADD COLUMN telefon_pl VARCHAR;
UPDATE  pracownicy
SET telefon_pl = concat('(+48)', telefon)
WHERE telefon IS NOT NULL AND length(telefon) = 9;

-- b) dodanie '-'

UPDATE pracownicy
SET telefon_pl = concat(
        substring(telefon_pl from 1 for 8),
        '-',
        substring(telefon_pl from 9 for 3),
        '-',
        substring(telefon_pl from 12 for 3)
    )
WHERE telefon_pl IS NOT NULL;

-- c) dane pracownika o najdłuższym nazwisku
SELECT id_pracownika,
       upper(imie) AS imie,
       upper(nazwisko) AS nazwisko,
       upper(adres) AS adres,
       telefon,
       telefon_pl
FROM pracownicy
ORDER BY length(nazwisko) DESC
LIMIT 1;

-- d) dane pracowników + pensja md5
SELECT pracownicy.id_pracownika,
       imie,
       nazwisko,
       adres,
       telefon,
       telefon_pl,
       md5(cast(kwota as varchar))
FROM pracownicy
JOIN wynagrodzenia w ON pracownicy.id_pracownika = w.id_pracownika
JOIN pensja p on w.id_pensji = p.id_pensji;

-- e) pracownicy, pencje, premie
SELECT imie, nazwisko, p.kwota AS pensja, p2.kwota AS premia FROM pracownicy
LEFT JOIN wynagrodzenia w on pracownicy.id_pracownika = w.id_pracownika
LEFT JOIN pensja p on w.id_pensji = p.id_pensji
LEFT JOIN premia p2 on w.id_premii = p2.id_premii;

-- g) Raport w postaci zapytania

-- kolumna z nadgodzinami
ALTER TABLE godziny
ADD COLUMN nadgodziny INTEGER;
UPDATE  godziny
SET nadgodziny = liczba_godzin - 160
WHERE liczba_godzin > 160;
-- raport
SELECT pracownicy.id_pracownika,
concat(
        'Pracownik ', imie, ' ', nazwisko, 'w dniu ', w.data,
        ' otrzymał pensję całkowitą na kwotę ', p.kwota + coalesce(p2.kwota, 0),
        ' zł, gdzie wynagrodzenie zasadnicze wynosiło: ', p.kwota, ' zł,',
        ' premia: ', coalesce(p2.kwota, 0), ' zł, ',
        'nadgodziny: ', coalesce(g.nadgodziny, 0) * 40, 'zł.'
    )
FROM pracownicy
LEFT JOIN wynagrodzenia w on pracownicy.id_pracownika = w.id_pracownika
LEFT JOIN pensja p on w.id_pensji = p.id_pensji
LEFT JOIN premia p2 on w.id_premii = p2.id_premii
LEFT JOIN godziny g on pracownicy.id_pracownika = g.id_pracownika
