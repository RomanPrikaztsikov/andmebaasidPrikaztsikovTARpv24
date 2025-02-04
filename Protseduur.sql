--SQL salvestatud protseduur - FUNKTSIOON, MIS KÄIVITAB SERVERIS mitu SQL tegevust järjest.
Create database protseduurPrikaztsikov;
use protseduurPrikaztsikov;
Create table linn(
linnId int Primary key identity(1,1),
linnNimi varchar(30),
rahvaarv int);
Select * from linn;
INSERT INTO linn(linnNimi, rahvaArv)
Values
('Tallinn', 60000),
('Narva', 30000),
('Pärnu', 40000),
('Tartu', 50000);
--Protseduuri loomine
--Protseduur, mis lisab uus linn ja kohe näitab tabelis

Create procedure lisaLinn
@lnimi varchar(30),
@rArv int
AS
Begin

INSERT INTO linn(linnNimi, rahvaArv)
Values
(@lnimi, @rArv);
Select * from linn;

End;

--protseduuri kutse
EXEC lisaLinn @lnimi='Tartu',@rArv=1256
--lihtsam
EXEC lisaLinn 'Tartu2',1256
