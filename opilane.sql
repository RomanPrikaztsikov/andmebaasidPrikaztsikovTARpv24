--AB loomine
Create database PrikaztsikovBaas;

use PrikaztsikovBaas;
CREATE TABLE opilane(
opilaneId int primary key identity(1,1),
eesimi varchar(25) not null,
perenimi varchar(25) not null,
synniaeg date,
stip bit,
aadress text,
keskmine_hinne decimal(2,1)
)
select * from opilane;
--andmete lisamine tabelisse
INSERT INTO opilane(eesimi, perenimi, synniaeg, stip, keskmine_hinne)
VALUES(
'Nikita',
'Nikita',
'2000-12-5',
1,
4.5),
(
'Nikita1',
'Nikita1',
'2000-12-5',
1,
4.5)

--tabeli kasutamine
--drop table opilane 
--rida kustutamine, kus on opilaneID=2
DELETE FROM opilane WHERE opilaneID=2;
select * from opilane;

--andmete uuendamine
UPDATE opilane SET aadress='Tallinn'
WHERE opilaneID=3

CREATE TABLE Language
(
ID int NOT NULL PRIMARY KEY,
Code char(3) NOT NULL,
Language varchar(50) NOT NULL,
IsOfficial bit,
Percentage smallint
); 

Select * from Language

INSERT INTO Language(ID, Code, Language)
VALUES 
(1,'EST', 'eesti'), 
(2,'ENG', 'Inglise'),
(3,'DE', 'saksa');


CREATE TABLE keelevalik(
keelevalikID INT PRIMARY KEY IDENTITY(1,1),
valikuNimetus VARCHAR(10) NOT NULL,
opilaneID INT,
FOREIGN KEY (opilaneID) REFERENCES opilane(opilaneId),
LanguageID INT,
FOREIGN KEY (LanguageID) REFERENCES Language(ID)
);

select * from keelevalik;
select * from Language;
select * from opilane;

INSERT INTO keelevalik(valikuNimetus, opilaneID, LanguageID)
VALUES 
('valik A', 1, 1),
('valik B', 1, 2),  
('valik A', 2, 2), 
('valik B', 2, 3);  

SELECT opilane.eesnimi, Language.Language
FROM opilane, Language keelevalik
WHERE opilane.opilaneId=keelevalik.opilaneID
AND Language.ID=keelevalik.Language

SELECT * 
FROM opilane, Language keelevalik
WHERE opilane.opilaneId=keelevalik.opilaneID
AND Language.ID=keelevalik.Language
