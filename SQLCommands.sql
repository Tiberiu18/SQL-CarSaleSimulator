 -- CERINTA 3
 -- SA SE CREEZE TABELUL JUDETE
CREATE TABLE JUDETE(
ID_JUDET NUMBER(2) PRIMARY KEY,
DENUMIRE_JUDET VARCHAR2(40) NOT NULL
);

-- SA SE CREEZE TABELUL VANZATORI
CREATE TABLE VANZATORI(
ID_VANZATOR NUMBER(6) PRIMARY KEY,
NUME VARCHAR2(25) NOT NULL,
PRENUME VARCHAR2(25) NOT NULL,
EMAIL VARCHAR2(30),
TELEFON VARCHAR2(20) NOT NULL,
ID_JUDET NUMBER(2) NOT NULL,
CONSTRAINT JUDET_VZT_FK FOREIGN KEY(ID_JUDET) REFERENCES JUDETE(ID_JUDET)
);
DROP TABLE VANZATORI;
-- SA SE CREEZE TABELUL ANUNTURI MASINI
CREATE TABLE ANUNTURI_MASINI(
ID_ANUNT NUMBER(12) PRIMARY KEY,
MARCA VARCHAR2(35) NOT NULL,
MODEL VARCHAR2(40) NOT NULL,
AN_FABRICATIE NUMBER(4) NOT NULL,
COMBUSTIBIL CHAR(4) NOT NULL,
PRET NUMBER(8,2) NOT NULL,
ID_VANZATOR NUMBER(6) not null,
CONSTRAINT ANUNT_ID_VANZ_FK FOREIGN KEY(ID_VANZATOR) REFERENCES VANZATORI(ID_VANZATOR)
);

-- SA SE STEARGA TABELA JUDETE
DROP TABLE JUDETE;

-- SA SE CREEZE TABELUL ISTORIC_VANZARI
CREATE TABLE ISTORIC_VANZARI
(
    ID_ANUNT NUMBER(12) not null,
    DATA_VANZARE DATE not null,
    PRIMARY KEY(ID_ANUNT, DATA_VANZARE),
    CONSTRAINT VANZ_ID_ANUNT_FK FOREIGN KEY(ID_ANUNT) REFERENCES ANUNTURI_MASINI(ID_ANUNT)
);

DROP TABLE ISTORIC_VANZARI;
-- SA SE ADAUGE o restrictie de tip check la tabela ANUNTURI_MASINI
ALTER TABLE ANUNTURI_MASINI ADD CONSTRAINT COMBUSTIBIL_C CHECK(COMBUSTIBIL = 'DSL' OR
COMBUSTIBIL = 'BZN' OR COMBUSTIBIL = 'ELC' OR COMBUSTIBIL = 'HY');

-- SA SE ADAUGE O RESTRICTIE DE TIP UNIQUE KEY LA TABELA VANZATORI
ALTER TABLE VANZATORI ADD CONSTRAINT TELEFON_UK1 UNIQUE(TELEFON);

-- SA SE SCOATA RESTRICTIA DE TIP FK DIN TABELA VANZATORI
ALTER TABLE VANZATORI DROP CONSTRAINT JUDET_VZT_FK;
-- SA SE ADAUGE RESTRICTIA DE TIP FK LA TABELA VANZATORI
ALTER TABLE VANZATORI ADD CONSTRAINT JUDET_VZT_FK FOREIGN KEY(ID_JUDET) REFERENCES JUDETE(ID_JUDET);
-- SA SE ADAUGE O RESTRICTIE DE TIP CHECK TABELEI ANUNTURI_MASINI
ALTER TABLE ANUNTURI_MASINI ADD CONSTRAINT PRET_CHECK_C CHECK(PRET>0);









SELECT * FROM VANZATORI WHERE NUME = 'Ghita';



-- CERINTA 4
-- SA SE ADAUGE IN TABELA JUDETE 5 INREGISTRARI
INSERT INTO JUDETE(ID_JUDET, DENUMIRE_JUDET) VALUES(1, 'TELEORMAN');
INSERT INTO JUDETE(ID_JUDET, DENUMIRE_JUDET) VALUES(2, 'GIURGIU');
INSERT INTO JUDETE(ID_JUDET, DENUMIRE_JUDET) VALUES(3, 'BUCURESTI');
INSERT INTO JUDETE(ID_JUDET, DENUMIRE_JUDET) VALUES(4, 'ILFOV');
INSERT INTO JUDETE(ID_JUDET, DENUMIRE_JUDET) VALUES(5, 'BRAILA');

-- SA SE ADAUGE IN TABELA VANZATORI 2 INREGISTRARI
INSERT INTO VANZATORI(ID_VANZATOR, NUME, PRENUME, TELEFON, ID_JUDET) VALUES
(
100, 'Ghita', 'Tiberiu', 0766341231, 1
);

INSERT INTO VANZATORI(ID_VANZATOR, NUME, PRENUME,EMAIL, TELEFON, ID_JUDET) VALUES
(
101, 'Vijelie', 'Vali', 'vali_vj@yahoo.com',0766317531, 3
);

-- SA SE ADAUGE IN TABELA ANUNTURI_MASINI 9 INREGISTRARI
INSERT INTO ANUNTURI_MASINI(ID_ANUNT, MARCA, MODEl, AN_FABRICATIE, COMBUSTIBIL, PRET, ID_VANZATOR) VALUES
(
1000, 'BMW', '520D', 2007, 'DSL', 5, 100
);
INSERT INTO ANUNTURI_MASINI(ID_ANUNT, MARCA, MODEl, AN_FABRICATIE, COMBUSTIBIL, PRET, ID_VANZATOR) VALUES
(
1001, 'BMW', '316I', 2015, 'BZN', 15900, 100
);
INSERT INTO ANUNTURI_MASINI(ID_ANUNT, MARCA, MODEl, AN_FABRICATIE, COMBUSTIBIL, PRET, ID_VANZATOR) VALUES
(
1002, 'OPEL', 'Astra H', 2008, 'DSL', 2500, 101
);

INSERT INTO ANUNTURI_MASINI(ID_ANUNT, MARCA, MODEl, AN_FABRICATIE, COMBUSTIBIL, PRET, ID_VANZATOR) VALUES
(
1003, 'Mercedes', 'CLS 63', 2012, 'BZN', 25000, 101
);

INSERT INTO ANUNTURI_MASINI(ID_ANUNT, MARCA, MODEl, AN_FABRICATIE, COMBUSTIBIL, PRET, ID_VANZATOR) VALUES
(
1004, 'Porsche', 'Carrera S', 2008, 'BZN', 19860, 100
);

INSERT INTO ANUNTURI_MASINI(ID_ANUNT, MARCA, MODEl, AN_FABRICATIE, COMBUSTIBIL, PRET, ID_VANZATOR) VALUES
(
1005, 'Peugeot', '508', 2013, 'HY', 11250, 100
);
INSERT INTO ANUNTURI_MASINI(ID_ANUNT, MARCA, MODEl, AN_FABRICATIE, COMBUSTIBIL, PRET, ID_VANZATOR) VALUES
(
1006, 'Audi', 'R8 V10', 2013, 'BZN', 44250, 100
);


INSERT INTO ANUNTURI_MASINI(ID_ANUNT, MARCA, MODEl, AN_FABRICATIE, COMBUSTIBIL, PRET, ID_VANZATOR) VALUES
(
1007, 'Audi', 'A4 B8', 2013, 'DSL', 10200, 100
);

INSERT INTO ANUNTURI_MASINI(ID_ANUNT, MARCA, MODEl, AN_FABRICATIE, COMBUSTIBIL, PRET, ID_VANZATOR) VALUES
(
1008, 'OPEL', 'Insignia', 2013, 'DSL', 8200, 101
);

-- Sa se creeze secventa anunturi_id_seq cu scopul de a fi folosita in generarea de PK
CREATE SEQUENCE anunturi_id_seq increment by 1
start with 1009
maxvalue 10000
CACHE 10
NOCYCLE;
-- Sa se afiseze toate sequence-urile existente
SELECT SEQUENCE_name from user_sequences;

-- Putem folosi si sequence pentru a genera automat ID anunt
INSERT INTO ANUNTURI_MASINI(ID_ANUNT, MARCA, MODEl, AN_FABRICATIE, COMBUSTIBIL, PRET, ID_VANZATOR) VALUES
(
anunturi_id_seq.nextval, 'Toyota', 'Supra', 1998, 'BZN', 25670, vanzator_id.currval
);






-- SA SE INSEREZE 3 ANUNTURI IN TABELA ISTORIC_VANZARI
INSERT INTO ISTORIC_VANZARI(ID_ANUNT, DATA_VANZARE) VALUES 
(
1002, '05-JAN-2013'
);
INSERT INTO ISTORIC_VANZARI(ID_ANUNT, DATA_VANZARE) VALUES 
(
1005, '25-MAR-2020'
);
INSERT INTO ISTORIC_VANZARI(ID_ANUNT, DATA_VANZARE) VALUES 
(
1006, '12-DEC-2017'
);



SELECT ID_VANZATOR, NUME, PRENUME FROM VANZATORI WHERE upper(NUME) = 'GHITA' and upper(PRENUME) = 'TIBERIU';

-- SA SE MODIFICE NUMARUL DE TELEFON AL VANZATORULUI/VANZATORILOR CU NUMELE GHITA
UPDATE VANZATORI SET TELEFON = 0766132197 WHERE upper(NUME) = 'GHITA';


-- SA SE MAREASCA PRETUL cu 5% al ANUNTURILOR OPEL  care il au ca  VANZATORUL pe ID 101
UPDATE ANUNTURI_MASINI SET PRET = PRET*1.05 WHERE ID_VANZATOR = 101 AND upper(MARCA) = 'OPEL';












-- SA SE STEARGA ANUNTUL 1001
DELETE FROM ANUNTURI_MASINI WHERE ID_ANUNT = 1001;


--CERINTA 5

-- SA SE AFISEZE ANUNTURILE DE MASINI CU PRETUL MAI MARE DECAT 10000
SELECT * FROM ANUNTURI_MASINI WHERE PRET > 10000;

-- SA SE AFISEZE VANZATORII CARE AU NUMELE DE LUNGIME MAI MICA DECAT 6 caractere
SELECT * FROM VANZATORI WHERE LENGTH(NUME) < 6;

-- SA SE AFISEZE MASINILE VANDUTE INCEPAND CU DATA DE 12 DECEMBRIE 2017 inclusiv
SELECT * FROM ISTORIC_VANZARI WHERE DATA_VANZARE >= '12-DEC-2017';

-- SA SE AFISEZE ANUNTURILE CU MASINI MAI VECHI DECAT ANUL 2010 inclusiv
SELECT * FROM ANUNTURI_MASINI WHERE AN_FABRICATIE <= 2010;

-- SA SE AFISEZE VANZATORII CARE NU AU ADRESA DE EMAIL
SELECT * FROM VANZATORI WHERE EMAIL is null;

-- SA SE AFISEZE VANZATORII AL CAROR NUME INCEPE CU VI
SELECT * FROM VANZATORI WHERE upper(NUME) LIKE 'VI%';


-- SA SE AFISEZE PRETUL, MARCA SI MODELUL MASINILOR VANDUTE
SELECT I.ID_ANUNT, I.DATA_VANZARE, A.PRET, A.MARCA, A.MODEL FROM ISTORIC_VANZARI I JOIN ANUNTURI_MASINI A ON
I.ID_ANUNT = A.ID_ANUNT;




-- SA SE AFISEZE PRETUL, MARCA SI MODELUL MASINILOR VANDUTE care nu au fost vandute 
SELECT  A.MARCA, A.MODEL, A.PRET FROM ISTORIC_VANZARI I RIGHT JOIN ANUNTURI_MASINI A ON
I.ID_ANUNT = A.ID_ANUNT WHERE I.ID_ANUNT is null;










-- SA SE AFISEZE CATE ANUNTURI SUNT PENTRU FIECARE MARCA DE MASINA
SELECT A.MARCA, COUNT(A.MARCA) FROM ANUNTURI_MASINI A 
GROUP BY A.MARCA;


-- SA SE AFISEZE CATE ANUNTURI SUNT PENTRU FIECARE MARCA DE MASINA. Se vor afisa numai
-- cele care au cel putin 2 anunturi

SELECT A.MARCA, COUNT(A.MARCA) FROM ANUNTURI_MASINI A 
HAVING COUNT(A.MARCA) >= 2
GROUP BY A.MARCA;

-- SA SE AFISEZE PRETUL TUTUROR MASINILOR IN FORMATUL $99999.00
SELECT A.MARCA, A.MODEL, TO_CHAR(A.PRET,'$999999.00') AS "PRET" FROM ANUNTURI_MASINI A;

-- SA SE AFISEZE MASINILE VANDUTE IN DATA DE 25 martie 2020
SELECT A.MARCA, A.MODEL, I.DATA_VANZARE FROM ISTORIC_VANZARI I JOIN ANUNTURI_MASINI A USING ( ID_ANUNT)
WHERE DATA_VANZARE = TO_DATE('25-MAR-2020','DD-MON-YYYY');

-- SA SE AFISEZE MASINILE VANDUTE INTRE ANII 2010- 2018 
SELECT A.MARCA, A.MODEL, I.DATA_VANZARE FROM ISTORIC_VANZARI I JOIN ANUNTURI_MASINI A USING ( ID_ANUNT)
WHERE EXTRACT(YEAR FROM DATA_VANZARE) BETWEEN 2010 and 2018;

-- SA SE AFISEZE MASINILE VANDUTE IN URMA CU 5 ani
SELECT A.MARCA, A.MODEL, I.DATA_VANZARE FROM ISTORIC_VANZARI I JOIN ANUNTURI_MASINI A USING ( ID_ANUNT)
WHERE EXTRACT(YEAR FROM DATA_VANZARE) = EXTRACT(YEAR FROM SYSDATE) - 5;

-- SA SE extraga 5 caractere incepand cu pozitia 2 din numele vanzatorilor
SELECT NUME, SUBSTR(NUME, 2, 5) RESULT FROM VANZATORI;




-- SA SE FORMATEZE COMBUSTIBILUL MASINILOR DIN ANUNTURI ASTFEL: DSL = DIESEL, BZN = BENZINA
-- HY = HYBRID
SELECT A.ID_ANUNT, A.MARCA, A.MODEL,A.COMBUSTIBIL, DECODE(TRIM(A.COMBUSTIBIL), 'DSL', 'DIESEL', 'BZN', 
'BENZINA', 'HY', 'HYBRID', 'altceva') decode
FROM ANUNTURI_MASINI A;











-- SA SE AFISEZE EMAIL URILE VANZATORILOR. UNDE NU EXISTA EMAIL SE VA PUNE default_email@yahoo.com
SELECT NVL(EMAIL,'default_email@yahoo.com') FROM VANZATORI;

-- SA SE AFISEZE ANUNTURILE CU MASINI. SE VA ADAUGA O COLOANA EXTRA ASTFEL:
-- DACA PRETUL ESTE intre 0 si 2500 => pret mic
-- 2500 si 7500 => pret mediu
-- peste 7500 => pret mare
SELECT ID_ANUNT, MARCA, MODEL, TO_CHAR(PRET,'$99999.99') , CASE WHEN  PRET BETWEEN 0 and 2500 THEN 'PRET MIC'
WHEN PRET BETWEEN 2501 and 7500 THEN 'PRET MEDIU'
ELSE 'PRET MARE' END
AS "CASE_PRET" FROM ANUNTURI_MASINI;

-- SA SE afiseze reuniunea id_anunturilor dintre istoric vanzari si anunturi masini
SELECT ID_ANUNT FROM ISTORIC_VANZARI
UNION
SELECT ID_ANUNT FROM ANUNTURI_MASINI;

-- sa se afiseze toate masinile care sunt inca la vanzare
SELECT AM.ID_ANUNT, AM.MARCA, AM.MODEL FROM ANUNTURI_MASINI AM
WHERE AM.ID_ANUNT IN (SELECT A.ID_ANUNT
FROM ANUNTURI_MASINI A
MINUS
SELECT I.ID_ANUNT
from ISTORIC_VANZARI I);


-- SA SE AFISEZE ID_ANUNT, MODELUL SI MARCA MASINILOR VANDUTE
SELECT ID_ANUNT, MARCA, MODEL FROM ANUNTURI_MASINI
WHERE ID_ANUNT in(SELECT I.ID_ANUNT
FROM ISTORIC_VANZARI I
INTERSECT
SELECT A.ID_ANUNT
FROM ANUNTURI_MASINI A);

SELECT * FROM ISTORIC_VANZARI;
SELECT * FROM ANUNTURI_MASINI;

-- SA SE AFISEZE MASINILE VANDUTE care au pretul mai mic decat pretul mediei tuturor anunturilor
SELECT I.ID_ANUNT, I.DATA_VANZARE, A.MARCA FROM
ISTORIC_VANZARI I, ANUNTURI_MASINI A WHERE I.ID_ANUNT = A.ID_ANUNT
and A.PRET < (SELECT AVG(PRET) FROM ANUNTURI_MASINI);


SELECT * FROM VANZATORI;
-- sa se schimbe TELEFONUL proprietarului care a vandut Opel Astra H cu pretul de 2625
UPDATE VANZATORI SET TELEFON = 0765312351 WHERE ID_VANZATOR IN
(
SELECT A.ID_VANZATOR FROM ISTORIC_VANZARI I JOIN ANUNTURI_MASINI A 
ON A.ID_ANUNT = I.ID_ANUNT WHERE lower(A.MARCA) = 'opel' and lower(A.MODEL) = 'astra h' and 
a.pret = 2625
);

-- SA SE CREEZE O TABELA VIRTUALA pe baza tabelului VANZATORI
CREATE VIEW view_Ghita as SELECT * FROM VANZATORI;
SELECT * FROM view_Ghita where upper(nume) = 'GHITA';

-- SA SE CREEZE INDEX PE COLOANA NUME A TABELULUI VANZATORI
CREATE INDEX idx_Nume on VANZATORI(Nume);

-- SA SE CREEZE un sinonim pentru tabela VANZATORI
CREATE SYNONYM vzt FOR VANZATORI;

-- SA SE CREEZE O SECVENTA cu increment 5, incepand de la numarul 5, cu valoare maxima 20
-- si cache size de 2
CREATE SEQUENCE id_seq increment by 5 start with 5 minvalue 5 maxvalue 20 cycle
cache 2;
-- sa se afiseze urmatoarea valoare a secventei
select id_seq.nextval from dual;
-- sa se afiseze valoarea curenta a secventei
select id_seq.currval from dual;

-- sa se adauge o coloana in tabela vanzatori
ALTER TABLE VANZATORI ADD ID_MANAGER NUMBER(12);

SELECT * FROM VANZATORI;
-- sa se modifice managerul lui 101
UPDATE VANZATORI SET ID_MANAGER = 100 WHERE ID_VANZATOR = 101;

-- sa se adauge inca 5 vanzatori
INSERT INTO VANZATORI(ID_VANZATOR, NUME, PRENUME, EMAIL, TELEFON, ID_JUDET, ID_MANAGER)
VALUES
(
102, 'Gigi', 'Gigel', 'gigi@gigel.com', 0715345678, 4, 100
);
INSERT INTO VANZATORI(ID_VANZATOR, NUME, PRENUME, EMAIL, TELEFON, ID_JUDET, ID_MANAGER)
VALUES
(
103, 'Costica', 'Florin', 'costica@flr.com', 0745341378, 4, 101
);

INSERT INTO VANZATORI(ID_VANZATOR, NUME, PRENUME, EMAIL, TELEFON, ID_JUDET, ID_MANAGER)
VALUES
(
104, 'Khan', 'Lex', 'Khn@yahoo.com', 0786445678, 5, 103
);

INSERT INTO VANZATORI(ID_VANZATOR, NUME, PRENUME, EMAIL, TELEFON, ID_JUDET, ID_MANAGER)
VALUES
(
105, 'Pamela', 'Anderson', 'Pammy@gmail.com', 0763435678, 5, 102
);
INSERT INTO VANZATORI(ID_VANZATOR, NUME, PRENUME, EMAIL, TELEFON, ID_JUDET, ID_MANAGER)
VALUES
(
106, 'Mark', 'Zucc', 'marky@yahoo.com', 0716375978, 4, 104
);


--  SA SE AFISEZE SUBORDONATII DIRECTI SI INDIRECTI AI ANGAJATULUI CU ID 100
SELECT ID_VANZATOR, LPAD(' ', LEVEL*2-2) || NUME ||' ' || PRENUME, LEVEL
FROM VANZATORI CONNECT BY PRIOR  ID_VANZATOR =  ID_MANAGER
START WITH ID_VANZATOR = 100;



--SA SE AFISEZE SUBORDONATII DIRECTI SI INDIRECTI AI ANGAJATULUI CU ID 100.SA SE FOLOSEASCA si SYS_CONNECT_BY_PATH
SELECT ID_VANZATOR, LPAD(' ', LEVEL*2-2) || SYS_CONNECT_BY_PATH(prenume, '/') PATH, LEVEL
FROM VANZATORI CONNECT BY PRIOR  ID_VANZATOR =  ID_MANAGER
START WITH ID_VANZATOR = 100;



