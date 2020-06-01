-- Begin of DB CREATE
-- Loeschen der Datenbank falls vorhanden
Drop Database if exists BIC4A20_04_Schifffahrt;

-- Anlegen der Datenbank
CREATE Database BIC4A20_04_Schifffahrt COLLATE utf8_general_ci;


-- Erzeugen der Tabellen
USE BIC4A20_04_Schifffahrt;
CREATE TABLE Person(
                       SVNR BIGINT(12) UNSIGNED,
                       Vorname VARCHAR(30),
                       Nachname VARCHAR(30),
                       Straße VARCHAR(50),
                       Hausnummer VARCHAR(10),
                       PLZ INT(6),
                       Ort VARCHAR(30),
                       PRIMARY KEY(SVNR)
);

CREATE TABLE Telefonnummer_hatPerson(
                                        Telefonnummer VARCHAR(30),
                                        SVNR BIGINT(12) UNSIGNED NOT NULL,
                                        PRIMARY KEY (SVNR),
                                        FOREIGN KEY (SVNR) REFERENCES Person(SVNR)
);


CREATE TABLE Bank(
                     BLZ INT(10) UNSIGNED,
                     Bankname VARCHAR(30),
                     PRIMARY KEY(BLZ)
);

CREATE TABLE Hersteller(
                           Name VARCHAR(255),
                           PRIMARY KEY(Name)
);

CREATE TABLE Passage (
                         Passagennummer INT UNSIGNED AUTO_INCREMENT,
                         Ankunftszeit DATETIME,
                         Abfahrtszeit DATETIME,
                         Zielhafen VARCHAR(30),
                         Abfahrtshafen VARCHAR(30),
                         Voraussgesetzte_Passage INT UNSIGNED,
                         PRIMARY KEY(Passagennummer),
                         FOREIGN KEY (Voraussgesetzte_Passage) REFERENCES Passage(Passagennummer)
);

CREATE TABLE Gehaltskonto(
                             BLZ INT(10)UNSIGNED,
                             Kontonummer VARCHAR(30),
                             Kontostand DECIMAL,
                             PRIMARY KEY(BLZ, Kontonummer),
                             FOREIGN KEY (BLZ) REFERENCES Bank(BLZ)
);

CREATE TABLE Angestellter_istPersonMitGehaltskonto (
                                                       Angestelltennummer INT(10) UNSIGNED UNIQUE NOT NULL AUTO_INCREMENT,
                                                       SVNR BIGINT(12) UNSIGNED,
                                                       BLZ INT(10) UNSIGNED NOT NULL,
                                                       Kontonummer VARCHAR(30) NOT NULL,
                                                       PRIMARY KEY(SVNR),
                                                       FOREIGN KEY (SVNR) REFERENCES Person(SVNR),
                                                       FOREIGN KEY (BLZ,Kontonummer) REFERENCES Gehaltskonto(BLZ,Kontonummer)
);


CREATE TABLE Techniker_istAngestellter (
                                           Lizenznummer VARCHAR(255) UNIQUE NOT NULL,
                                           SVNR BIGINT(12) UNSIGNED,
                                           Ausbildungsgrad VARCHAR(255),
                                           PRIMARY KEY(SVNR),
                                           FOREIGN KEY (SVNR) REFERENCES Angestellter_istPersonMitGehaltskonto(SVNR)
);


CREATE TABLE Kapitän_istAngestellter (
                                         KapitänspatentNummer BIGINT UNSIGNED UNIQUE NOT NULL,
                                         Seemeilen INT UNSIGNED,
                                         SVNR BIGINT(12) UNSIGNED,
                                         PRIMARY KEY(SVNR),
                                         FOREIGN KEY (SVNR) REFERENCES Angestellter_istPersonMitGehaltskonto(SVNR)
);

CREATE TABLE Passagier_istPerson (
                                     SVNR BIGINT(12) UNSIGNED,
                                     Passagiernummer BIGINT UNSIGNED NOT NULL,
                                     PRIMARY KEY(SVNR),
                                     FOREIGN KEY (SVNR) REFERENCES Person(SVNR)
);


CREATE TABLE Schifftyp (
                           Typennummer INT(10) UNSIGNED AUTO_INCREMENT,
                           Herstellername VARCHAR(255) NOT NULL,
                           Typbezeichnung VARCHAR(30),
                           Bruttoregistertonnen INT UNSIGNED,
                           Besatzungsstärke INT UNSIGNED,
                           PRIMARY KEY(Typennummer),
                           FOREIGN KEY (Herstellername) REFERENCES Hersteller(Name)
);

CREATE TABLE Techniker_wartet_Schiffstyp (
                                             Typennummer INT(10) UNSIGNED,
                                             SVNR BIGINT(12) UNSIGNED,
                                             PRIMARY KEY(Typennummer, SVNR),
                                             FOREIGN KEY (Typennummer) REFERENCES Schifftyp(Typennummer),
                                             FOREIGN KEY (SVNR) REFERENCES Techniker_istAngestellter(SVNR)
);


CREATE TABLE Schiff_istSchiffstyp (
                                      Inventarnummer INT UNSIGNED AUTO_INCREMENT,
                                      Typennummer INT(10) UNSIGNED NOT NULL,
                                      Fertigungsjahr DATE,
                                      Seemeilen BIGINT UNSIGNED,
                                      PRIMARY KEY(Inventarnummer),
                                      FOREIGN KEY (Typennummer) REFERENCES Schifftyp(Typennummer)
);

CREATE TABLE Logbuch (
                         Logbuchcode INT(10) UNSIGNED,
                         Inventarnummer INT UNSIGNED,
                         PRIMARY KEY(Inventarnummer, Logbuchcode),
                         FOREIGN KEY (Inventarnummer) REFERENCES Schiff_istSchiffstyp(Inventarnummer)
);

CREATE TABLE Logbuch_leihe(
                              Logbuchcode INT(10) UNSIGNED,
                              Inventarnummer INT UNSIGNED,
                              SVNR BIGINT(12) UNSIGNED,
                              PRIMARY KEY(Logbuchcode, SVNR),
                              FOREIGN KEY (Inventarnummer,Logbuchcode) REFERENCES Logbuch(Inventarnummer,Logbuchcode),
                              FOREIGN KEY (SVNR) REFERENCES Angestellter_istPersonMitGehaltskonto(SVNR)
);



CREATE TABLE Passagier_buchtPassage (
                                        Buchungsnummer BIGINT UNSIGNED AUTO_INCREMENT,
                                        SVNR BIGINT(12) UNSIGNED,
                                        Passagennummer INT(10) UNSIGNED NOT NULL,
                                        Buchungsdatum DATETIME,
                                        Klasse INT(1) UNSIGNED,
                                        PRIMARY KEY(Buchungsnummer),
                                        FOREIGN KEY (SVNR) REFERENCES Passagier_istPerson(SVNR),
                                        FOREIGN KEY (Passagennummer) REFERENCES Passage(Passagennummer)
);


CREATE TABLE Kaptiän_fährt (
                               SVNR BIGINT(12) UNSIGNED NOT NULL,
                               Passagennummer INT(10) UNSIGNED,
                               Typennummer INT(10) UNSIGNED,
                               PRIMARY KEY(Passagennummer, Typennummer),
                               FOREIGN KEY (SVNR) REFERENCES Kapitän_istAngestellter(SVNR),
                               FOREIGN KEY (Passagennummer) REFERENCES Passage(Passagennummer),
                               FOREIGN KEY (Typennummer) REFERENCES Schifftyp(Typennummer)
);


-- Insert Dummy Data


-- Personen
-- Angestellte
INSERT INTO Person
VALUES (081510051987, 'Karl', 'Mitterer', 'Schellhammergasse', '5/1', 1160, 'Wien');
INSERT INTO Person
VALUES (084410121984, 'Michaela', 'Schaff', 'Jenullgasse', '21-7', 1140, 'Wien');
INSERT INTO Person
VALUES (111510051980, 'Franz', 'Holzer', 'Barichgasse', '18', 1030, 'Wien');
-- Techniker
INSERT INTO Person
VALUES (250610081981, 'Karl', 'Mueller', 'Halblehenweg', '67', 1220, 'Wien');
INSERT INTO Person
VALUES (051510111983, 'Arnold', 'Krieger', 'Schellhammergasse', '5/1', 1160, 'Wien');
INSERT INTO Person
VALUES (991510041986, 'Franziska', 'Mueller', 'Halblehenweg', '67', 1220, 'Wien');
-- Kapitäne
INSERT INTO Person
VALUES (141510071983, 'Ferdinand', 'Mitterer', 'Lofer', '38', 5090, 'Lofer');
INSERT INTO Person
VALUES (081510011983, 'Michaela', 'Frischauf', 'Löbing Weg', '4', 8230, 'Hartberg');
INSERT INTO Person
VALUES (771510021975, 'Guenther', 'Leibzig', 'Laxenburger Str.', '166', 2331, 'Vösendorf');
-- Passagiere
INSERT INTO Person
VALUES (361510051979, 'Manfred', 'Leisser', 'Burgweg', '1', 3363, 'Ulmerfeld');
INSERT INTO Person
VALUES (247424041972, 'Nathalie', 'Wilke', 'Magdalenaweg', '95', 8221, 'Hofing');
INSERT INTO Person
VALUES (215121031988,	'Sylvia', 'Krebs', 'Schützengartenstrasse', '40', 6890, 'Lustenau');
INSERT INTO Person
VALUES (393705081988, 'Karl', 'Schuster', 'Sonnberg', '43', 7132, 'Apelton');
INSERT INTO Person
VALUES (133012011991,	'Karola', 'Stadler', 'Wiehtestrasse', '56', 4851, 'Siedling');
INSERT INTO Person
VALUES (192910061991,	'Gunnar', 'Schultz', 'Kelsenstrasse', '57',	3240, 'Kleinaigen');
INSERT INTO Person
VALUES (049314051992,	'Irmgard', 'Rudolph', 'Kalhamer Strasse', '13',	5400, 'Gamp');
INSERT INTO Person
VALUES (151929051998,	'Leonhard', 'Merkel', 'Rosenstrasse', '6', 9400, 'Wolfsberg');



-- Telefonnummern
INSERT INTO Telefonnummer_hatPerson
VALUES ('+43(0)6600815923', 141510071983);
INSERT INTO Telefonnummer_hatPerson
VALUES ('+43(0)6642044134', 084410121984);
INSERT INTO Telefonnummer_hatPerson
VALUES ('+44(0)6848616884',081510011983);
INSERT INTO Telefonnummer_hatPerson
VALUES ('+43(0)669613135',771510021975);
INSERT INTO Telefonnummer_hatPerson
VALUES ('+44(0)6848616884',250610081981);



-- Banken
INSERT INTO Bank
VALUES (19970, 'Banco do Brasil');
INSERT INTO Bank
VALUES (19650, 'DenizBank Wien');
INSERT INTO Bank
VALUES (19360, 'INGBANK');
INSERT INTO Bank
VALUES (19620, 'Commerzialbank Mattersburg');
INSERT INTO Bank
VALUES (20111, 'Sparkas');
INSERT INTO Bank
VALUES (20241, 'Sparkasse Neunkirchen');
INSERT INTO Bank
VALUES (19470, 'Credit Salzburg');
INSERT INTO Bank
VALUES (31200, 'Vermögensverwaltung Bank');
INSERT INTO Bank
VALUES (14000, 'BAWAG PSK Bank');
INSERT INTO Bank
VALUES (19250, 'direktanlage');
INSERT INTO Bank
VALUES (12000, 'UniCredit Bank Austria');

-- Hersteller von Schiffstypen
INSERT INTO Hersteller
VALUES ('A. C. BOOTWERFT GesmbH');
INSERT INTO Hersteller
VALUES ('GEB GLASTIC BOOTSBAU und HANDEL');
INSERT INTO Hersteller
VALUES ('HOLIDAY-Yachting GesmbH');
INSERT INTO Hersteller
VALUES ('RATZ Johann Boot-Liegeplatz- und VermietungsgesmbH');
INSERT INTO Hersteller
VALUES ('SKANDINAVIE BOOT’S IMPORT GMBH');
INSERT INTO Hersteller
VALUES ('TECHNAUTIC Bootsservice GesmbH');


-- Passagen einrichten
INSERT INTO Passage
VALUES (DEFAULT, 081500,101500,'Hamburg','Antwerpen',NULL);
INSERT INTO Passage
VALUES (DEFAULT, 105000,142500,'Antwerpen','Rotterdam',1);
INSERT INTO Passage
VALUES (DEFAULT, 090000,200000,'Los-Angeles','Shanghai',NULL);
INSERT INTO Passage
VALUES (DEFAULT, 152000,180000,'Le Havre','Zeebrügge',NULL);
INSERT INTO Passage
VALUES (DEFAULT, 190000,200000,'Zeebrügge', 'Wilhelmshaven',4);
INSERT INTO Passage
VALUES (DEFAULT, 203000,060000,'Wilhelmshaven','Koppenhagen',5);
INSERT INTO Passage
VALUES (DEFAULT, 090000,200000,'Helsinki','Malmö',NULL);
INSERT INTO Passage
VALUES (DEFAULT, 153000,183000,'Antwerpen','Malmö',1);
INSERT INTO Passage
VALUES (DEFAULT, 190000,220000,'Malmö','Antwerpen',8);



-- Gehaltskonto einrichten
INSERT INTO Gehaltskonto
VALUES(19470,'AT022050302101023600',22355);
INSERT INTO Gehaltskonto
VALUES(19360,'AT401400015379681766',38465);
INSERT INTO Gehaltskonto
VALUES(14000,'AT725400015414338334',4523);
INSERT INTO Gehaltskonto
VALUES(14000,'AT165400089737493781',259599);
INSERT INTO Gehaltskonto
VALUES(12000,'AT503621878638875447',8702);
INSERT INTO Gehaltskonto
VALUES(12000,'AT215400038718322987',1801);
INSERT INTO Gehaltskonto
VALUES(20241,'AT911100017838219533',4232);
INSERT INTO Gehaltskonto
VALUES(19970,'AT363621899451872759',9166);
INSERT INTO Gehaltskonto
VALUES(19250,'AT201947039894359143',7728);


-- Angestellte einrichten
INSERT INTO Angestellter_istPersonMitGehaltskonto
VALUES(DEFAULT, 081510051987, 19470,'AT022050302101023600');
INSERT INTO Angestellter_istPersonMitGehaltskonto
VALUES(DEFAULT, 084410121984, 19360,'AT401400015379681766');
INSERT INTO Angestellter_istPersonMitGehaltskonto
VALUES(DEFAULT, 111510051980, 14000,'AT725400015414338334');
INSERT INTO Angestellter_istPersonMitGehaltskonto
VALUES(DEFAULT, 250610081981, 14000,'AT165400089737493781');
INSERT INTO Angestellter_istPersonMitGehaltskonto
VALUES(DEFAULT, 051510111983, 12000,'AT503621878638875447');
INSERT INTO Angestellter_istPersonMitGehaltskonto
VALUES(DEFAULT, 991510041986, 12000,'AT215400038718322987');
INSERT INTO Angestellter_istPersonMitGehaltskonto
VALUES(DEFAULT, 141510071983, 20241,'AT911100017838219533');
INSERT INTO Angestellter_istPersonMitGehaltskonto
VALUES(DEFAULT, 081510011983, 19970,'AT363621899451872759');
INSERT INTO Angestellter_istPersonMitGehaltskonto
VALUES(DEFAULT, 771510021975, 19250,'AT201947039894359143');



-- Techniker
INSERT INTO Techniker_istAngestellter
VALUES('T01',250610081981,'HTL-Maschinenschlosser');
INSERT INTO Techniker_istAngestellter
VALUES('T02',051510111983,'HTL-Maschinenbauer');
INSERT INTO Techniker_istAngestellter
VALUES('T03',991510041986,'Lehre Elektriker');

-- Kapitaene
INSERT INTO Kapitän_istAngestellter
VALUES(06548648464846868,65456,141510071983);
INSERT INTO Kapitän_istAngestellter
VALUES(79879879879898446,25,081510011983);
INSERT INTO Kapitän_istAngestellter
VALUES(874843184964156846846874978473213218,3215,771510021975);

-- Passagiere
INSERT INTO Passagier_istPerson
VALUES (361510051979,1);
INSERT INTO Passagier_istPerson
VALUES (247424041972,2);
INSERT INTO Passagier_istPerson
VALUES (215121031988,3);
INSERT INTO Passagier_istPerson
VALUES (393705081988,4);
INSERT INTO Passagier_istPerson
VALUES (133012011991,5);
INSERT INTO Passagier_istPerson
VALUES (192910061991,6);
INSERT INTO Passagier_istPerson
VALUES (049314051992,7);
INSERT INTO Passagier_istPerson
VALUES (151929051998,8);


-- Schifftypen
INSERT INTO Schifftyp
VALUES (DEFAULT, 'A. C. BOOTWERFT GesmbH', 'Kreuzfahrtschiff',228081,700);
INSERT INTO Schifftyp
VALUES (DEFAULT, 'GEB GLASTIC BOOTSBAU und HANDEL', 'Passagierschiff', 90700,450);
INSERT INTO Schifftyp
VALUES (DEFAULT, 'HOLIDAY-Yachting GesmbH', 'Kombischiff', 54282,150);


-- Wartungsliste
INSERT INTO Techniker_wartet_Schiffstyp
VALUES (1,250610081981);
INSERT INTO Techniker_wartet_Schiffstyp
VALUES (2,051510111983);
INSERT INTO Techniker_wartet_Schiffstyp
VALUES (3,991510041986);

-- Schiff aus Schiffstypen
INSERT INTO Schiff_istSchiffstyp
VALUES (DEFAULT, 1, 2007, 234232);
INSERT INTO Schiff_istSchiffstyp
VALUES (DEFAULT, 1, 1997, 534212);
INSERT INTO Schiff_istSchiffstyp
VALUES (DEFAULT, 2, 2017, 2232);
INSERT INTO Schiff_istSchiffstyp
VALUES (DEFAULT, 3, 1999, 434222);
INSERT INTO Schiff_istSchiffstyp
VALUES (DEFAULT, 1, 2012, 23220);
INSERT INTO Schiff_istSchiffstyp
VALUES (DEFAULT, 3, 2010, 22312);


-- Schiffslogbuch
INSERT INTO Logbuch
VALUES (1,1);
INSERT INTO Logbuch
VALUES (2,2);
INSERT INTO Logbuch
VALUES (3,3);


-- Leihliste
-- Kapitän
INSERT INTO Logbuch_leihe
VALUES (1,1,141510071983);
-- Techniker
INSERT INTO Logbuch_leihe
VALUES (3,3,250610081981);



-- Buchungsliste
INSERT INTO Passagier_buchtPassage
VALUES (DEFAULT,215121031988,1,12012020,1);
INSERT INTO Passagier_buchtPassage
VALUES (DEFAULT,393705081988,4,25032020,2);
INSERT INTO Passagier_buchtPassage
VALUES (DEFAULT,133012011991,3,12122019,3);
INSERT INTO Passagier_buchtPassage
VALUES (DEFAULT,192910061991,2,25062020,1);
INSERT INTO Passagier_buchtPassage
VALUES (DEFAULT,049314051992,5,20082020,2);
INSERT INTO Passagier_buchtPassage
VALUES (DEFAULT,151929051998,5,12072020,1);


-- Kapitaen faehrt Route
INSERT INTO Kaptiän_fährt
VALUES (141510071983,2,1);
INSERT INTO Kaptiän_fährt
VALUES (081510011983,3,3);
INSERT INTO Kaptiän_fährt
VALUES (771510021975,5,2);