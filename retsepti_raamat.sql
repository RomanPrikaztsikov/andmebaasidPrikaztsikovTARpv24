create database retseptiRaamatPrikaztsikov;
use retseptiRaamatPrikaztsikov;

create table kasutaja(
kasutaja_id int primary key identity(1,1),
eesnimi varchar(50),
perenimi varchar(50),
email varchar(150)
);

insert into kasutaja(eesnimi, perenimi, email) values
('vadim', 'penkin', 'vadim.penkin@gmail.com'),
('andrei', 'svarshik', 'andrei2004@gmail.com'),
('mike', 'tyson', 'diddy@gmail.com'),
('nikita', 'gruzovik', 'vadimdestroyer@gmail.com'),
('anton', 'krutoi', 'antonandon@hotmail.com');

create table kategooria(
kategooria_id int primary key identity(1,1),
kategooria_nimi varchar(50)
);

insert into kategooria(kategooria_nimi) values
('supid'),
('road'),
('magusad'),
('joogid'),
('puuviljad');

create table toiduaine(
toiduaine_id int primary key identity(1,1),
toiduaine_nimi varchar(100)
);

insert into toiduaine(toiduaine_nimi) values
('tomatipasta'),
('pepperoni'),
('jahu'),
('juust'),
('tainas');

create table yhik(
yhik_id int primary key identity(1,1),
yhik_nimi varchar(100)
);

insert into yhik(yhik_nimi) values
('ml'),
('tl'),
('sl'),
('g'),
('kg'),
('tk');

create table retsept(
retsept_id int primary key identity(1,1),
retsepti_nimi varchar(100),
kirjeldus varchar(200),
juhend varchar(500),
sisestatud_kp date,
kasutaja_id int,
foreign key (kasutaja_id) references kasutaja(kasutaja_id),
kategooria_id int,
foreign key (kategooria_id) references kategooria(kategooria_id)
);

insert into retsept(retsepti_nimi, kirjeldus, juhend, sisestatud_kp, kasutaja_id) values
('pasta carbonara', 
'klassikaline itaalia pastaroog, mis on valmistatud munade, juustu, pancetta ja pipraga.',
'keeda pasta vastavalt pakendi juhistele. küpseta pancettat eraldi pannil krõbedaks. vahusta munad riivitud parmesani ja musta pipraga. nõruta pasta ja kombineeri pancettaga. lisa aeglaselt munasegu ja sega kreemja kastme saamiseks. serveeri peale lisa juustu ja pipraga.',
'2025-02-14',
1);

insert into retsept(retsepti_nimi, kirjeldus, juhend, sisestatud_kp, kasutaja_id) values
('šokolaadikook', 
'rikkalik ja niiske šokolaadikook ühtlase šokolaadijäätisega.',
'kuumuta ahi 180°c-ni. sega omavahel jahu, kakaopulber, suhkur, sooda ja sool. sega eraldi kausis munad, piim, taimeõli ja vanill. lisa märjad koostisosad vähehaaval kuivadele koostisosadele ja sega ühtlaseks massiks. vala tainas võiga määritud koogivormidesse ja küpseta 30 minutit. lase jahtuda, seejärel määri šokolaadiglasuuriga.',
'2025-02-14',
1);

insert into retsept(retsepti_nimi, sisestatud_kp, kasutaja_id, kategooria_id) values
('pizza', '2020-01-01', 3, 2),
('borš', '2024-01-01', 1, 1),
('kartulipüree kotletiga', '1821-05-05', 3, 2);

create table tehtud(
tehtud_id int primary key identity(1,1),
tehtud_kp date,
retsept_id int,
foreign key (retsept_id) references retsept(retsept_id)
);

insert into tehtud(tehtud_kp, retsept_id) values
('2023-02-07', 3),
('2021-01-02', 4),
('2024-12-31', 5),
('2019-07-08', 6),
('2023-02-16', 7);

create table koostis(
koostis_id int primary key identity(1,1),
kogus int,
retsept_retsept_id int,
foreign key (retsept_retsept_id) references retsept(retsept_id),
toiduaine_id int,
foreign key (toiduaine_id) references toiduaine(toiduaine_id),
yhik_id int,
foreign key (yhik_id) references yhik(yhik_id)
);

insert into koostis(retsept_retsept_id, toiduaine_id, kogus, yhik_id) values
(3, 1, 4, 8),
(3, 2, 15, 11),
(3, 4, 200, 9),
(3, 5, 300, 9);

--select * from kasutaja;
--select * from kategooria;
--select * from toiduaine;
--select * from yhik;
select * from retsept;
select * from tehtud;
select * from koostis;

--protseduur mis lisab uus retsept
create procedure lisaretsept
@nimi varchar(100),
@kirjeldus varchar(200),
@juhend varchar(500),
@kasutaja int,
@kategooria int
as
begin

insert into retsept(retsepti_nimi, kirjeldus, juhend, sisestatud_kp, kasutaja_id, kategooria_id) values
(@nimi, @kirjeldus, @juhend, getdate(), @kasutaja, @kategooria);
select * from retsept;

end;

--protseduur mis lisab uue väli 'tehtud' tabelisse
create procedure lisatehtud
@retsept int
as
begin

insert into tehtud(tehtud_kp, retsept_id) values
(getdate(), @retsept);
select * from tehtud;

end;

--protseduur mis lisab uue väli 'koostis' tabelisse
create procedure lisakoostis
@retsept int,
@toiduaine int,
@kogus int,
@yhik int
as
begin

insert into koostis(retsept_retsept_id, toiduaine_id, kogus, yhik_id) values
(@retsept, @toiduaine, @kogus, @yhik);
select * from koostis;

end;

--kutsun kõik protseduurid
exec lisaretsept 'testretsept', 'väga magus', 'osta poodist', 2, 3;
exec lisatehtud 6;
exec lisakoostis 6, 4, 100, 9;

--protseduur mis saab muutama tabelid nime järgi, saab lisada veergid, kustuda veergid ja muudama andmetüüp veergis
create procedure muudatabel
@table varchar(30),
@veerg varchar(30),
@tegevus varchar(20),
@tyyp varchar(20) = null
as
begin

declare @sqltegevus as varchar(max);
set @sqltegevus = case
when @tegevus = 'add' then concat('alter table ', @table, ' add ', @veerg, ' ', @tyyp)
when @tegevus = 'drop' then concat('alter table ', @table, ' drop column ', @veerg)
when @tegevus = 'alter' then concat('alter table ', @table, ' alter column ', @veerg, ' ', @tyyp)
end;

print @sqltegevus;

begin
exec(@sqltegevus);
end;
end;

--lisan uus veerg 'test' 'int' andmetüüpiga tabelis 'retsept'
--muudan seda veergu andmetüüp 'varchar(30)'
--kustutan seda veerg
exec muudatabel 'retsept', 'test', 'add', 'int';
exec muudatabel 'retsept', 'test', 'alter', 'varchar(30)';
exec muudatabel 'retsept', 'test', 'drop';

--näidan kõik retseptid ja nende autori nimi
select concat(kasutaja.eesnimi, ' ', kasutaja.perenimi) nimi, retsept.retsepti_nimi retsept from kasutaja, retsept
where kasutaja.kasutaja_id = retsept.kasutaja_id;

-- uus tabel 
create table arvustused(
arvustus_id int primary key identity(1,1),
kasutaja_id int,
retsept_id int,
hinnang int,
kommentaar varchar(300),
kuupaev date,

foreign key (kasutaja_id) references kasutaja(kasutaja_id),
foreign key (retsept_id) references retsept(retsept_id)
);

insert into arvustused(kasutaja_id, retsept_id, hinnang, kommentaar, kuupaev) values
(2, 3, 4, 'love it', getdate()),
(3, 3, 4, 'love it', getdate()),
(4, 4, 1, 'blud that is my recipe', getdate()),
(1, 5, 4, 'woah', getdate()),
(2, 7, 1, 'hate it', getdate());

select * from arvustused;

--protseduurid minu tabelisse
create procedure lisaarvustus
@kasutaja int, 
@retsept int, 
@hinnang int, 
@kommentaar varchar(300)
as
begin

insert into arvustused(kasutaja_id, retsept_id, hinnang, kommentaar, kuupaev) values
(@kasutaja, @retsept, @hinnang, @kommentaar, getdate());
select * from arvustused;

end;

exec lisaarvustus 1, 5, 5, 'hi';

create procedure kustutaarvustus
@arvustusid int
as
begin

select * from arvustused;
delete from arvustused where arvustus_id = @arvustusid;
select * from arvustused;

end;

exec kustutaarvustus 6;
