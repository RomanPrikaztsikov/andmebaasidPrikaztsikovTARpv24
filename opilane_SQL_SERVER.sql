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

CREATE TABLE Category (
idCategory Int Primary key identity(1,1),
CategoryName varchar(25) UNIQUE
)
SELECT * FROM Category;
INSERT INTO Category (CategoryName)
Values ('jook'), ('söök')

--Tabeli struktuuri mutmine -->uue veergu lisamine

ALTER TABLE Category ADD test int;

ALTER TABLE Category DROP COLUMN test;
SELECT * FROM Category;

CREATE TABLE Product (
idProduct int Primary key identity(1,1),
ProductName varchar(25),
idCategory int,
Foreign key (idCategory) references Category(idCategory),
Price decimal(5,2)
)

SELECT * FROM Category;
SELECT * FROM  Product;

INSERT INTO Product (ProductName, idCategory, Price)
VALUES 
('Fanta', 1, 2.0),
('Mahl', 1, 2.6),
('Cola', 1, 3.0),
('Vett', 1, 1.0),
('Sprite', 1, 2.4)


--------------------------procedure
CREATE TABLE opilane(
opilaneId int primary key identity(1,1),
eesnimi varchar(25) not null,
perenimi varchar(25) not null,
synniaeg date,
stip bit,
aadress text,
keskmine_hinne decimal(2,1)
)
select * from opilane;


Create procedure AddStudent
@eesnimi varchar(25),
@perenimi varchar(25),
@synniaeg date,
@stip bit,
@aadress text,
@keskmine_hinne decimal(2,1)

as
begin
insert into opilane (eesnimi, perenimi, synniaeg, stip, aadress, keskmine_hinne)
VALUES (@eesnimi, @perenimi, @synniaeg, @stip, @aadress, @keskmine_hinne);
select * from opilane;
end;

exec AddStudent @eesnimi='Aaa', @perenimi='Bbb', @synniaeg='2000-10-4', @stip='1', @aadress='asd', @keskmine_hinne='4.5'

Create procedure NimiOtsing
@taht char(1)
as
begin
select * from opilane
where eesnimi like @taht + '%';
--% - kõik teised tähed
end;
--kutse
exec NimiOtsing T;
