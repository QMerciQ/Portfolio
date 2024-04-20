--A1 Vypiš seznam kurátorů a datum vystavení sbírek, za které je zodpovedný HK:D1, VK:D6
SELECT k.jmeno AS kurator_jmeno, k.prijmeni AS kurator_prijmeni, v.datumvystaveni
FROM kuratori k
JOIN vystavy v ON k.id_kurator = v.kuratori_id_kurator;

--A2 Vypiš seznam kurátorů, kteří nepatří k žádné výstavě HK:D1, VK:D12
SELECT k.jmeno AS kurator_jmeno, k.prijmeni AS kurator_prijmeni
FROM kuratori k
WHERE NOT EXISTS (
    SELECT 1
    FROM vystavy v
    WHERE v.kuratori_id_kurator = k.id_kurator
);

--A3 Vyber pouze předměty, které jsou sochy HK:D3, VK:D12
SELECT *
FROM predmety
WHERE typy_predmetu_id_typpredmetu = (
    SELECT id_typpredmetu
    FROM typy_predmetu
    WHERE typ = 'statue'
);

--A4 Vyber předměty, které jsou ve výpůjčce HK:D4, VK:D12,D15
SELECT *
FROM predmety p
WHERE EXISTS (
    SELECT 1
    FROM pujcky_muzeim pm
    WHERE p.vypujcky_id_vypujcka = pm.id_vypujcka
);

--A5 Vrať záznamy z tabulek pujcky_muzeim a vypujcky, který mají shodné hodnoty v id_vypujcka
SELECT * 
FROM pujcky_muzeim
JOIN vypujcky USING (id_vypujcka);

--A6 Spoj jednotlivá muzea s výpůjčkami/výpůjčkou, kterých se týká HK:D6
SELECT *
FROM vypujcky v
JOIN muzea m ON v.muzea_id_muzeum = m.id_muzeum;

--A7 Spoj tabulky muzea a vypujcky HK:D7
SELECT *
FROM muzea
NATURAL JOIN vypujcky;

--A8 Vytvoř všechny možné kombinace sbírek a předmětů HK:D8
SELECT *
FROM predmety
CROSS JOIN sbirky;

--A9 Vypiš id vystav a k nim částky, které se vybrali za vstupné HK:D9
SELECT id_vystava, castka
FROM vystavy
LEFT OUTER JOIN vstupne ON vystavy.vstupne_id_vstupne = vstupne.id_vstupne;

--A10 Vypiš částky a typ vstpného na výstavy HK:D10
SELECT castka, typ
FROM vystavy
RIGHT OUTER JOIN vstupne ON vystavy.vstupne_id_vstupne = vstupne.id_vstupne;

--A11 Získej kompletní přehled z tabulek vystavy, vstupne a kuratori HK:D11
SELECT *
FROM vystavy
FULL OUTER JOIN vstupne ON vystavy.vstupne_id_vstupne = vstupne.id_vstupne
FULL OUTER JOIN kuratori ON vystavy.kuratori_id_kurator = kuratori.id_kurator;

--A12 Vypiš id předmětů, které mají větší skladovací teplotu než 20 stupňů HK:
SELECT predmety.id_predmet, skladovaci_podminky.teplota
FROM predmety
JOIN skladovaci_podminky ON predmety.id_predmet = skladovaci_podminky.predmety_id_predmet
WHERE skladovaci_podminky.teplota > 20;

--A13 Vypiš název muzea a kolikrát nám něco půjčili nebo my jim HK:D13 VK:D23,D6
SELECT nazev, pocet_vypujcek
FROM muzea
JOIN (
    SELECT muzea_id_muzeum, COUNT(*) AS pocet_vypujcek
    FROM vypujcky
    GROUP BY muzea_id_muzeum
) vypujcky_count ON muzea.id_muzeum = vypujcky_count.muzea_id_muzeum;

--A14 Vypiš id_vystav a ke každé průměrnou částku vybranou jako vstupné HK:D14, VK:D22
SELECT vystavy.id_vystava,
       (SELECT AVG(castka) FROM vstupne WHERE vstupne.id_vstupne = vystavy.vstupne_id_vstupne) AS prumerne_vstupne
FROM vystavy;


--A15 Vyber předměty, které patří do sbírek a do jakých HK:D15, VK:D12
SELECT *
FROM sbirky
WHERE NOT EXISTS (
    SELECT 1
    FROM predmety
    WHERE predmety.sbirky_id_sbirka = sbirky.id_sbirka
);

--A16 Odstraň duplicity z tabulek kurátoři a muzea a vypiš výsledek HK:D16
SELECT jmeno AS unikatni_hodnota FROM kuratori
UNION
SELECT nazev AS unikatni_hodnota FROM muzea;

--A17 Vrať předměty, které nejsou v žádné výstavě HK:D17, VK:D6
SELECT id_predmet, autor, material FROM predmety
MINUS
SELECT p.id_predmet, p.autor, p.material FROM predmety p
JOIN vystavy v ON p.vystavy_id_vystava = v.id_vystava;

--A18 Zobraz sbírky, které obsahují alespoň jeden předmět HK:D18, VKD6
SELECT id_sbirka, nazev FROM sbirky
INTERSECT
SELECT s.id_sbirka, s.nazev FROM sbirky s
JOIN predmety p ON s.id_sbirka = p.sbirky_id_sbirka;

--A19 Spoj jména a příjmení do jednoho řetězce HK:D19
SELECT 
    jmeno || ' ' || prijmeni AS cele_jmeno
FROM kuratori;

--A20 Vypočti vstupné zvýšené o 10% HK:D20
SELECT castka, castka * 1.1 AS zvetsena_castka FROM vstupne;

--A21 Zjisti, jak dlouho (v měsících a dnech) trvaly jednotlivé výpůjčky
SELECT 
    id_vypujcka,
    datumpujceni,
    datumvraceni,
    typvypujcky,
    TRUNC(MONTHS_BETWEEN(datumvraceni, datumpujceni)) AS trvani_vypujcky_mesice,
    ROUND((datumvraceni - datumpujceni), 2) AS trvani_vypujcky_dny
FROM vypujcky;


--A22 Vypočítej průměrnou teplotu nutnou pro správné skladování předmětů HK:D22
SELECT 
    AVG(teplota) AS prumerna_teplota
FROM skladovaci_podminky;

--A23 Zjisti počet vstupů pro jednotlivé typy vstupenek, kterých se prodalo více než 5 HK:D23 
SELECT typ, COUNT(*) AS pocet_vstupu
FROM vstupne
GROUP BY typ
HAVING COUNT(*) > 5;


--A24 Přiřaď ke sbírkám kurátory
SELECT sbirky.nazev, kuratori.jmeno, kuratori.prijmeni
FROM sbirky
JOIN kuratori ON sbirky.kuratori_id_kurator = kuratori.id_kurator;

SELECT sbirky.nazev, kuratori.jmeno, kuratori.prijmeni
FROM sbirky, kuratori
WHERE sbirky.kuratori_id_kurator = kuratori.id_kurator;

SELECT sbirky.nazev, kuratori.jmeno, kuratori.prijmeni
FROM sbirky
CROSS JOIN kuratori
WHERE sbirky.kuratori_id_kurator = kuratori.id_kurator;

--A25 Vypiš období a ke každému kolik děl z něj máme
SELECT 
    období, 
    COUNT(*) AS pocet_del
FROM 
    predmety
WHERE 
    období IS NOT NULL
GROUP BY 
    období
HAVING 
    COUNT(*) > 0
ORDER BY 
    období;

--A26 Pohled nad tabulkami vstupne a vystavy HK:D26
CREATE VIEW vstupne_vystavy_view AS
SELECT
    vstupne.id_vstupne,
    vstupne.datum,
    vstupne.castka,
    vstupne.typ,
    vstupne.poznamka,
    vystavy.datumvystaveni,
    vystavy.datumstazeni
FROM
    vstupne
JOIN vystavy ON vstupne.id_vstupne = vystavy.vstupne_id_vstupne;

--A27 Vyber vstupné od 1.1.2023 HK:D27, VK:21
SELECT *
FROM vstupne_vystavy_view
WHERE datum > TO_DATE('2023-01-01', 'YYYY-MM-DD');

--A28 Muzeum přijalo 2 nové kurátory, které je třeba zapsat do tabulky HK:D28
INSERT INTO kuratori (id_kurator, jmeno, prijmeni, telefon)
SELECT 1, 'Jan', 'Novak', '123456789'
FROM dual
UNION ALL
SELECT 2, 'Eva', 'Svobodova', '987654321'
FROM dual;

--A29 U předmětu s ID 4786566677 bylo zjištěno, že potřebuje vlhkost 30% a ne 50%
UPDATE skladovaci_podminky
SET vlhkost = 30
WHERE predmety_id_predmet = 4786566677;

--A30 Vymaž všechny sbírky, které nemají žádné předměty HK:D30
DELETE FROM sbirky
WHERE id_sbirka NOT IN (
    SELECT s.id_sbirka
    FROM sbirky s
    JOIN predmety p ON s.id_sbirka = p.sbirky_id_sbirka
);
