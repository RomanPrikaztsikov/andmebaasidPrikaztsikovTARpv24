CREATE TABLE opilane(
opilaneId int primary key AUTO_INCREMENT,
eesimi varchar(25) not null,
perenimi varchar(25) not null,
synniaeg date,
stip bit,
aadress text,
keskmine_hinne decimal(2,1)
);

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

DELETE FROM opilane WHERE opilaneID=2;
UPDATE opilane SET aadress='Tallinn'

CREATE TABLE keelevalik(
keelevalikID INT PRIMARY KEY AUTO_INCREMENT,
valikuNimetus VARCHAR(10) NOT NULL,
opilaneID INT,
FOREIGN KEY (opilaneID) REFERENCES opilane(opilaneId),
LanguageID INT,
FOREIGN KEY (LanguageID) REFERENCES Language(ID)
);
