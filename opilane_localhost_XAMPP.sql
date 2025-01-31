CREATE TABLE opilane(
opilaneId int primary key AUTO_INCREMENT,
eesimi varchar(25) not null,
perenimi varchar(25) not null,
synniaeg date,
stip bit,
aadress text,
keskmine_hinne decimal(2,1)
);
