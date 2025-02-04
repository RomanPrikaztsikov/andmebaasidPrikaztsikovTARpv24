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
EXEC lisaLinn 'Tartu222',1256
--kirje kustutamine 
delete from linn where linnID=3;
Select * from linn;

--protseduur, mis kustutab linn id järgi
Create procedure kustutaLinn
@deleteID int
as
begin
Select * from linn;
delete from linn where linnID=@deleteID;
Select * from linn;
end;

--kutse
exec kustutaLinn 4;
--protseduuri kustutamine
drop procedure kustutaLinn;


--protseduur, mis otsib linn esimese tähte järgi
Create procedure linnaOtsing
@taht char(1)
as
begin
select * from linn
where linnNimi like @taht + '%';
--% - kõik teised tähed
end;
--kutse
exec linnaOtsing T;



--------------------------------------------------------------kasutame XAMPP local host


Create table linn( linnId int Primary key AUTO_INCREMENT, linnNimi varchar(30), rahvaarv int); 
INSERT INTO linn(linnNimi, rahvaArv) Values ('Tallinn', 60000), ('Narva', 30000), ('Pärnu', 40000), ('Tartu', 50000); 
Begin

INSERT INTO linn(linnNimi, rahvaArv)
Values
(@lnimi, @rArv);
Select * from linn;

