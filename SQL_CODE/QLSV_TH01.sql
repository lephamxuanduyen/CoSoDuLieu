﻿CREATE DATABASE QLSV_TH01
ON
(NAME = 'QLSV_TH01',
FILENAME = 'F:\CSDL\SQL_DATA\QLSV_TH01.mdf',
SIZE = 10MB,
MAXSIZE = UNLIMITED,
FILEGROWTH = 5MB)
LOG ON
(NAME = 'QLSV_TH01_LOG',
FILENAME = 'F:\CSDL\SQL_DATA\QLSV_TH01_LOG.ldf',
SIZE = 5MB,
MAXSIZE = UNLIMITED,
FILEGROWTH = 2MB)
USE QLSV_TH01
GO

CREATE TABLE KHOA
(MAKHOA CHAR(4) CONSTRAINT PK_MK PRIMARY KEY,
TENKHOA NVARCHAR(100),
NAMTL INT)
GO

CREATE TABLE SVIEN
(MASV CHAR(8) CONSTRAINT PK_SV PRIMARY KEY,
TENSV NVARCHAR(100),
NAM INT,
MAKHOA CHAR(4),
CONSTRAINT FK_KHOA_SV FOREIGN KEY(MAKHOA) REFERENCES KHOA(MAKHOA))
GO

CREATE TABLE MHOC
(MAMH CHAR(6) CONSTRAINT PK_MH PRIMARY KEY,
TENMH NVARCHAR(100),
TINCHI INT CONSTRAINT CHK_TC CHECK(TINCHI<=6),
MAKHOA CHAR(4),
CONSTRAINT FK_MH_KHOA FOREIGN KEY(MAKHOA) REFERENCES KHOA(MAKHOA))
GO

CREATE TABLE DKIEN
(MAMH CHAR(6) NOT NULL,
MAMH_TRUOC CHAR(6) NOT NULL,
CONSTRAINT PK_DK PRIMARY KEY(MAMH, MAMH_TRUOC),
CONSTRAINT FK_MH_DK FOREIGN KEY(MAMH) REFERENCES MHOC(MAMH),
CONSTRAINT FK_MHTRUOC_DK FOREIGN KEY(MAMH_TRUOC) REFERENCES MHOC(MAMH))
GO

CREATE TABLE HPHAN
(MAHP INT CONSTRAINT PK_HP PRIMARY KEY,
MAMH CHAR(6),
HOCKY INT CONSTRAINT CHK_HK CHECK(HOCKY IN (1,2)),
NAM INT,
GV CHAR(50),
CONSTRAINT FK_HP_MH FOREIGN KEY(MAMH) REFERENCES MHOC(MAMH))
GO

CREATE TABLE KQUA
(MASV CHAR(8) NOT NULL,
MAHP INT NOT NULL,
CONSTRAINT PK_KQ PRIMARY KEY(MASV,MAHP),
CONSTRAINT FK_KQ_SV FOREIGN KEY(MASV) REFERENCES SVIEN(MASV),
CONSTRAINT FK_KQ_HP FOREIGN KEY(MAHP) REFERENCES HPHAN(MAHP),
DIEM FLOAT)
GO

INSERT INTO KHOA VALUES
('TOAN',N'Toán',1976),
('HOA',N'Hóa',1980),
('SINH',N'Sinh',1981),
('VLY',N'Vật lý',1982)
GO

INSERT INTO SVIEN VALUES
('K27.0017',N'Nguyễn Công Phú',1,'TOAN'),
('K26.0008',N'Phan Anh Khanh',2,'TOAN'),
('K25.0005',N'Lý Thành',3,'HOA'),
('K27.0018',N'Hàn Quốc Việt',2,'VLY')
GO

INSERT INTO MHOC VALUES
('TH0001',N'Tin học đại cương',4,'TOAN'),
('TH0002',N'Cấu trúc dữ liệu',4,'TOAN'),
('TO0001',N'Toán rời rạc',3,'TOAN'),
('HH0001',N'Hóa học đại cương A1',5,'HOA'),
('HH0002',N'Hóa học đại cương A2',5,'HOA'),
('VL0002',N'Vật lý đại cương A2',4,'VLY'),
('TH0003',N'Cơ sở dữ liệu',5,'TOAN'),
('VL0001',N'Vật lý đại cương A1',5,'VLY')
GO

INSERT INTO HPHAN VALUES
(1,'TH0001',1,1996,N'N.D.Lâm'),
(2,'VL0001',1,1996,N'T.N.Dung'),
(3,'TH0002',1,1997,N'H.Tuân'),
(4,'TH0001',1,1997,N'N.D.Lâm'),
(5,'TH0003',2,1997,N'N.C.Phú'),
(6,'HH0001',1,1996,N'L.T.Phúc'),
(7,'TH0002',1,1998,N'P.T.Như'),
(8,'TO0001',1,1996,N'N.C.Phú')
GO

INSERT INTO KQUA VALUES
('K27.0017',4,9.5),
('K26.0008',1,10),
('K25.0005',6,6),
('K27.0018',2,8),
('K26.0008',3,9)
GO

INSERT INTO DKIEN VALUES
('TO0001','TH0003'),
('TH0003','TH0002'),
('TH0002','TH0001'),
('HH0002','HH0001'),
('VL0002','VL0001')
GO

--10.Thêm vào SVIEN bộ <"K26.0009", “Nguyễn Thùy Linh”, 2, "SINH"
INSERT INTO SVIEN VALUES('K26.0009',N'Nguyễn Thùy Linh',2,N'SINH')
GO

--11.Thêm vào SVIEN bộ <"K26.0010", “Nguyễn Anh Thư”, 2, "AVAN">, nhận xét ? giải thích ?
INSERT INTO SVIEN VALUES('K26.0010',N'Nguyễn Anh Thư',2,'AVAN')
-->KHÔNG thêm được bộ này vì MAKHOA='AVAN' chưa có trong MAKHOA của bảng KHOA mà khóa ngoại tham chiếu
GO

--12.Thêm vào KQUA 2 bộ <K27.0017,6,7>, <K27.0017,8,9>, nhận xét ? giải thích ?
INSERT INTO KQUA VALUES
('K27.0017',6,7),
('K27.0017',8,9)
-->Tuy 2 bộ có MASV giống nhau nhưng KQUA lấy MASV và MAHP làm cặp khóa chính, 2 bộ chỉ giống nhau MASV nhưng khác nhau MAHP, vì vậy cặp khóa chính của mỗi bộ vẫn đảm bảo được tính duy nhất.
GO

--13.Thêm vào KQUA bộ <K27.0017,5,7>,nhận xét ?giải thích ?
INSERT INTO KQUA VALUES('K27.0017',5,7)
-->Thêm bình thường
GO

--14.Sửa bộ <K27.0017,4,9.5>trong quan hệ KQUAthành <K27.0017,8,7>,nhận xét ? giải thích ?
UPDATE KQUA
SET MAHP=8,DIEM=7
WHERE (MAHP=4 AND DIEM=9.5)
--> KHÔNG sửa được. Vì nếu sửa sẽ bị trùng cặp khóa chinh vừa chèn ở câu 12.
GO

--15.Sửa bộ <K26.0008,3,9> trong quan hệ KQUA thành<K26.0008,10,9>,nhận xét ? giải thích ?
INSERT INTO KQUA VALUES ('K26.0008',3,9)
--> KHÔNG sửa được. Vì nếu sửa sẽ bị trùng cặp khóa chinh vừa chèn ở câu 12.
GO

--16.Thêm vào KQUA bộ <K26.0008,5,10>,nhận xét ? giải thích ?
INSERT INTO KQUA VALUES('K26.0008',5,10)
--> Vì KQUA lấy MASV và MAHP làm cặp khóa chính, bộ này chỉ giống nhau MASV nhưng khác nhau MAHP, vì vậy cặp khóa chính của mỗi bộ vẫn đảm bảo được tính duy nhất.
GO

--17.Xoá bộ <K26.0008,3,9> trong quan hệ KQUA, nhận xétvà giải thích ?
DELETE FROM KQUA
WHERE MASV='K26.0008' AND MAHP=3 AND DIEM=9
-->Xóa bình thường