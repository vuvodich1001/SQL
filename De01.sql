CREATE DATABASE QLTV

CREATE TABLE TACGIA(
	MATG CHAR(5) NOT NULL,
	HOTEN VARCHAR(20),
	DIACHI VARCHAR(50), 
	NGSINH SMALLDATETIME,
	SODT VARCHAR(15),
	CONSTRAINT PK_TACGIA PRIMARY KEY(MATG)
)

CREATE TABLE SACH(
	MASACH CHAR(5) NOT NULL,
	TENSACH VARCHAR(25),
	THELOAI VARCHAR(25),
	CONSTRAINT PK_SACH PRIMARY KEY(MASACH)
)

CREATE TABLE TACGIA_SACH(
	MATG CHAR(5) NOT NULL,
	MASACH CHAR(5),
	CONSTRAINT PK_TACGIA_SACH PRIMARY KEY(MATG, MASACH)
)

CREATE TABLE PHATHANH(
	MAPH CHAR(5) NOT NULL,
	MASACH CHAR(5),
	NGAYPH SMALLDATETIME,
	SOLUONG INT,
	NHAXUATBAN VARCHAR(20),
	CONSTRAINT PK_PHATHANH PRIMARY KEY(MAPH)
)

ALTER TABLE TACGIA_SACH
ADD CONSTRAINT FK_TACGIA_MASACH
FOREIGN KEY (MASACH) REFERENCES SACH(MASACH), 
CONSTRAINT FK_TACGIA_MATG 
FOREIGN KEY (MATG) REFERENCES TACGIA(MATG)

ALTER TABLE PHATHANH
ADD CONSTRAINT FK_PHATHANH
FOREIGN KEY (MASACH) REFERENCES SACH(MASACH)

--2
--2.1
GO
CREATE TRIGGER TRG_NGPH_NGSINH ON PHATHANH
FOR INSERT, UPDATE
AS
BEGIN
	DECLARE @MASACH CHAR(5), @NGAYPH SMALLDATETIME, @NGSINH SMALLDATETIME
	SELECT @MASACH = MASACH, @NGAYPH = NGAYPH FROM INSERTED
	SELECT @NGSINH = NGSINH FROM TACGIA_SACH TS INNER JOIN TACGIA TG ON TS.MATG = TG.MATG 
	WHERE MASACH = @MASACH
	IF @NGAYPH > @NGSINH
	BEGIN
		PRINT'THANH CONG'
	END
	ELSE
	BEGIN
		ROLLBACK TRAN
		PRINT 'LOI! KHONG HOP LE'
	END
END
--2.2
CREATE TRIGGER TRG_THELOAISACH ON PHATHANH
FOR INSERT
AS
BEGIN
	DECLARE @MASACH CHAR(5), @NHAXUATBAN VARCHAR(20), @THELOAI VARCHAR(25)
	SELECT @MASACH = MASACH, @NHAXUATBAN = NHAXUATBAN FROM INSERTED
	SELECT @THELOAI = THELOAI FROM SACH WHERE MASACH = @MASACH
	IF(@THELOAI = 'GIAO KHOA' AND @NHAXUATBAN != 'GIAO DUC')
	BEGIN
		PRINT'THANH CONG'
	END
	ELSE
	BEGIN
		PRINT'LOI! KHONG HOP LE'
	END
END

--3
--3.1
-- C1
SELECT TG.MATG, TG.HOTEN, TG.SODT FROM TACGIA_SACH TS INNER JOIN TACGIA TG ON TS.MATG = TG.MATG
													  INNER JOIN SACH S ON TS.MASACH = S.MASACH
													  INNER JOIN PHATHANH PH ON TS.MASACH = PH.MASACH
WHERE THELOAI = 'VAN HOC' AND NHAXUATBAN = 'NXB TRE'

-- C2
SELECT TG.MATG, TG.HOTEN, TG.SODT FROM TACGIA_SACH TS INNER JOIN TACGIA TG ON TS.MATG = TG.MATG
WHERE MASACH IN (
SELECT MASACH FROM SACH WHERE THELOAI = 'VAN HOC'
INTERSECT
SELECT MASACH FROM PHATHANH WHERE NHAXUATBAN = 'NXB')

-- 3.2
SELECT NHAXUATBAN FROM PHATHANH
GROUP BY NHAXUATBAN
HAVING COUNT(*) >=ALL (SELECT COUNT(*) FROM PHATHANH GROUP BY NHAXUATBAN)

-- 3.3
SELECT PH.NHAXUATBAN, TG.MATG, TG.HOTEN FROM PHATHANH PH, TACGIA_SACH TS, TACGIA TG
WHERE PH.MASACH = TS.MASACH AND TS.MATG = TG.MATG
GROUP BY PH.NHAXUATBAN, TG.MATG, TG.HOTEN
HAVING COUNT(*) >= ALL (SELECT COUNT(*) FROM PHATHANH PH1, TACGIA_SACH TS1
WHERE PH1.MASACH = TS1.MASACH
GROUP BY PH1.NHAXUATBAN, TS1.MATG
HAVING PH.NHAXUATBAN = PH1.NHAXUATBAN)

