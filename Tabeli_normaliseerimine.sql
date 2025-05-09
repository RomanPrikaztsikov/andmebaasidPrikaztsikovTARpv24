-- ----------------------------
-- Table: ruhm
-- ----------------------------

create database nf

use nf

CREATE TABLE ruhm
(
    ruhmID    INT              NOT NULL,
    ruhmNimi  VARCHAR(50)      NOT NULL,
    CONSTRAINT PK_ruhm PRIMARY KEY (ruhmID)
);

-- ----------------------------
-- Table: paev
-- ----------------------------
CREATE TABLE paev
(
    paevID    INT              NOT NULL,
    Nimetus   VARCHAR(50)      NOT NULL,
    CONSTRAINT PK_paev PRIMARY KEY (paevID)
);

-- ----------------------------
-- Table: tund
-- ----------------------------
CREATE TABLE tund
(
    tundID    INT              NOT NULL,
    number    INT              NOT NULL,
    CONSTRAINT PK_tund PRIMARY KEY (tundID)
);

-- ----------------------------
-- Table: Opetaja
-- ----------------------------
CREATE TABLE Opetaja
(
    OpetajaID INT              NOT NULL,
    Nimi      VARCHAR(50)      NOT NULL,
    CONSTRAINT PK_Opetaja PRIMARY KEY (OpetajaID)
);

-- ----------------------------
-- Table: ruum
-- ----------------------------
CREATE TABLE ruum
(
    ruumID    INT              NOT NULL,
    kood      VARCHAR(50)      NOT NULL,
    CONSTRAINT PK_ruum PRIMARY KEY (ruumID)
);

-- ----------------------------
-- Table: oppeaine
-- ----------------------------
CREATE TABLE oppeaine
(
    oppeaineID INT             NOT NULL,
    nimetus    VARCHAR(50)     NOT NULL,
    CONSTRAINT PK_oppeaine PRIMARY KEY (oppeaineID)
);

-- ----------------------------
-- Table: tunniplaan (fact)
-- ----------------------------
CREATE TABLE tunniplaan
(
    ruhmID      INT            NOT NULL,
    paevID      INT            NOT NULL,
    tundID      INT            NOT NULL,
    opetajaID   INT            NOT NULL,
    ruumID      INT            NOT NULL,
    oppeaineID  INT            NOT NULL,

    CONSTRAINT PK_tunniplaan PRIMARY KEY (ruhmID, paevID, tundID),

    CONSTRAINT FK_tunniplaan_ruhm
        FOREIGN KEY (ruhmID)
        REFERENCES ruhm (ruhmID),

    CONSTRAINT FK_tunniplaan_paev
        FOREIGN KEY (paevID)
        REFERENCES paev (paevID),

    CONSTRAINT FK_tunniplaan_tund
        FOREIGN KEY (tundID)
        REFERENCES tund (tundID),

    CONSTRAINT FK_tunniplaan_opetaja
        FOREIGN KEY (opetajaID)
        REFERENCES Opetaja (OpetajaID),

    CONSTRAINT FK_tunniplaan_ruum
        FOREIGN KEY (ruumID)
        REFERENCES ruum (ruumID),

    CONSTRAINT FK_tunniplaan_oppeaine
        FOREIGN KEY (oppeaineID)
        REFERENCES oppeaine (oppeaineID)
);

select * from tunniplaan



-- Õpetaja
INSERT INTO Opetaja (OpetajaID, Nimi) VALUES
  (1, 'Marina Oleinik'),
  (2, 'Irina Merkulova'),
  (3, 'Julia Kartusinski'),
  (4, 'Andres Tamm'),
  (5, 'Maria Laht');

-- Rühm
INSERT INTO ruhm (ruhmID, ruhmNimi) VALUES
  (1, 'TARpv19'),
  (2, 'LOGITpv18'),
  (3, 'TARpv20'),
  (4, 'INFpv21'),
  (5, 'WEBpv22');

-- Päev
INSERT INTO paev (paevID, Nimetus) VALUES
  (1, 'esmaspäev'),
  (2, 'teisipäev'),
  (3, 'kolmapäev'),
  (4, 'neljapäev'),
  (5, 'reede');

-- Tund
INSERT INTO tund (tundID, number) VALUES
  (1, 1),
  (2, 2),
  (3, 3),
  (4, 4),
  (5, 5);

-- Ruum
INSERT INTO ruum (ruumID, kood) VALUES
  (1, 'E10'),
  (2, 'A-109'),
  (3, 'A-102'),
  (4, 'B-201'),
  (5, 'C-305');

-- Õppeaine
INSERT INTO oppeaine (oppeaineID, nimetus) VALUES
  (1, 'Andmebaaside alused'),
  (2, 'Kontoritöö tarkvara'),
  (3, 'Andmebaaside haldus'),
  (4, 'Operatsioonisüsteemide alused'),
  (5, 'Arvutiõpetus');

-- Tunniplaan (näited viiest tunnist)
INSERT INTO tunniplaan (ruhmID, paevID, tundID, opetajaID, ruumID, oppeaineID) VALUES
  (1, 1, 1, 1, 1, 1),
  (1, 2, 2, 2, 2, 2),
  (2, 3, 3, 3, 3, 3),
  (3, 4, 4, 4, 4, 4),
  (4, 5, 5, 5, 5, 5);


--INNER JOIN SELECT

SELECT 
  t.tundID      AS Tund,
  r.ruhmNimi    AS Rühm
FROM tunniplaan t
INNER JOIN ruhm r 
  ON t.ruhmID = r.ruhmID;


SELECT 
  t.tundID    AS Tund,
  p.Nimetus   AS Päev
FROM tunniplaan t
INNER JOIN paev p 
  ON t.paevID = p.paevID;


SELECT 
  t.tundID       AS Tund,
  op.nimetus     AS Õppeaine
FROM tunniplaan t
INNER JOIN oppeaine op 
  ON t.oppeaineID = op.oppeaineID;


SELECT 
  t.tundID     AS Tund,
  o.Nimi       AS Õpetaja
FROM tunniplaan t
INNER JOIN Opetaja o
  ON t.opetajaID = o.OpetajaID;



SELECT 
  t.tundID     AS Tund,
  ru.kood      AS Ruum
FROM tunniplaan t
INNER JOIN ruum ru
  ON t.ruumID = ru.ruumID;


CREATE PROCEDURE näita_tunniplaani
AS
BEGIN
  SELECT *
  FROM tunniplaan;
END;

EXEC näita_tunniplaani;


CREATE PROCEDURE loenda_tunnid
AS
  SELECT COUNT(*) AS TundideArv
  FROM tunniplaan;

EXEC loenda_tunnid;


GRANT SELECT, INSERT ON tunniplaan TO PrikaztsikovSekretaar;
GRANT SELECT, INSERT ON ruum TO PrikaztsikovSekretaar;
