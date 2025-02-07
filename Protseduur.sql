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

--tabeli uuendamine - rahvaArv kasvab 10 % võrra
update linn set rahvaArv=rahvaArv*1.1
select * from linn;
update linn set rahvaArv=rahvaArv*1.1
where linnID=1;

create procedure rahvaArvuUuendus
@linnID int, 
@koef decimal(2,1)
as
begin
select * from linn;
update linn set rahvaArv=rahvaArv*@koef
where linnID=@linnId;
select * from linn;
end;

--drop procedure rahvaArvuUuendus;

exec rahvaArvuUuendus 1, 1.2;



--------------------------------------------------------------kasutame XAMPP local host


Create table linn( linnId int Primary key AUTO_INCREMENT, linnNimi varchar(30), rahvaarv int); 
INSERT INTO linn(linnNimi, rahvaArv) Values ('Tallinn', 60000), ('Narva', 30000), ('Pärnu', 40000), ('Tartu', 50000); 
Begin

INSERT INTO linn(linnNimi, rahvaArv)
Values
(lnimi, rArv);
Select * from linn;



-------------------------------procedure xampp sql opilane table
CREATE TABLE opilane( opilaneId int primary key AUTO_INCREMENT, eesnimi varchar(25) not null, perenimi varchar(25) not null, synniaeg date, stip bit, aadress text, keskmine_hinne decimal(2,1) ); 




--------------------------------------------------------------
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

--uue veeru lisamine
alter table linn add test int;
--veeru kustutamine
alter table linn drop column test;

create procedure veeruLisaKustuta
@valik varchar(20), 
@veerunimi varchar(20),
@tyyp varchar(20) =null

as
begin
declare @sqltegevus as varchar (max)
set @sqltegevus=case
when @valik='add' then concat('alter table linn add ', @veerunimi, ' ',  @tyyp)
when @valik='drop' then concat('alter table linn drop column ', @veerunimi)
end;
print @sqltegevus;
begin
exec (@sqltegevus);
end;
end;

--kutse
exec veeruLisaKustuta @valik='add', @veerunimi='test3', @tyyp='int';
select * from linn;

exec veeruLisaKustuta @valik='drop', @veerunimi='test3';




create procedure veerukustutaTabelis
@valik varchar(20), 
@tabelinimi varchar(20),
@veerunimi varchar(20),
@tyyp varchar(20) =null

as
begin
declare @sqltegevus as varchar (max)
set @sqltegevus=case
when @valik='add' then concat('alter table ', @tabelinimi, ' add ',  @veerunimi, ' ',  @tyyp)
when @valik='drop' then concat('alter table ',  @tabelinimi, ' drop column ', @veerunimi)
end;
print @sqltegevus;
begin
exec (@sqltegevus);
end;
end;

--kutse
exec veerukustutaTabelis @valik='add', @tabelinimi='linn', @veerunimi='test3', @tyyp='int';
select * from linn;

exec veerukustutaTabelis @valik='drop', @tabelinimi='linn', @veerunimi='test3';

--protseduur tingimusega
create procedure rahvaHinnang
@piir int


as
begin
select linnNimi, rahvaArv, iif(rahvaArv<@piir, 'väike linn', 'surr linn') as Hinnang
from linn;

end;

drop procedure rahvaHinnang;

exec rahvaHinnang 42000;
--Agregaat funktisoonid: sum(), avg(), min(), max(), count()

create procedure kokkurahvaArv

as
begin
select sum(rahvaarv) as 'kokku rahvaArv', avg(rahvaArv) as 'keskmine rahvaArv', count(*) as 'linnade arv'
from linn;
end;

exec kokkurahvaarv;


