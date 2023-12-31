﻿CREATE DATABASE THUVIEN
ON
(
NAME = 'THUVIEN',
FILENAME = 'F:\CSDL\SQL_DATA\THUVIEN.mdf',
SIZE = 10MB,
MAXSIZE = UNLIMITED,
FILEGROWTH = 5MB
)
LOG ON
(
NAME = 'THUVIEN_log',
FILENAME = 'F:\CSDL\SQL_DATA\THUVIEN_log.ldf',
SIZE = 5MB,
MAXSIZE = UNLIMITED,
FILEGROWTH = 2MB
)
GO

USE THUVIEN
GO

CREATE TABLE TACGIA
(
MATG CHAR(5) CONSTRAINT PK_TG PRIMARY KEY,
TENTG NVARCHAR(50),
DIACHI NVARCHAR(50)
)

CREATE TABLE LOAISACH 
(
MALOAI CHAR(2) CONSTRAINT PK_LOAI PRIMARY KEY,
TENLOAI NVARCHAR(50)
)
GO

CREATE TABLE NHAXUATBAN
(
MANXB CHAR(5) CONSTRAINT PK_NXB PRIMARY KEY,
TENNXB NVARCHAR(50),
DCNXB NVARCHAR(50),
DTNXB VARCHAR(11) CONSTRAINT CHK_DTNXB CHECK (LEN(DTNXB)>=10),
CONSTRAINT UQ_DT UNIQUE(DTNXB)
)
GO

CREATE TABLE SACH
(
MASH CHAR(5) CONSTRAINT PK_SACH PRIMARY KEY,
TENSACH NVARCHAR(50),
MATG CHAR(5),
NAMXB INT CONSTRAINT CHK_NAMXB CHECK (NAMXB<=YEAR(GETDATE())),
MANXB CHAR(5),
MALOAI CHAR(2),
CONSTRAINT FK_SACH_TG FOREIGN KEY(MATG) REFERENCES TACGIA(MATG),
CONSTRAINT FK_SACH_NXB FOREIGN KEY(MANXB) REFERENCES NHAXUATBAN(MANXB),
CONSTRAINT FK_SACH_MALOAI FOREIGN KEY(MALOAI) REFERENCES LOAISACH(MALOAI)
)
GO 

CREATE TABLE DOCGIA
(
MADG CHAR(5) CONSTRAINT PK_DG PRIMARY KEY,
TENDG NVARCHAR(50),
NGSINH DATE CONSTRAINT CHK_NGSINH CHECK(NGSINH<=GETDATE()),
GIOITINH NVARCHAR(5) CONSTRAINT CHK_GT CHECK(GIOITINH IN (N'Nam',N'Nữ',N'Khác')),
LIENHE VARCHAR(11) CONSTRAINT CHK_LH CHECK(LEN(LIENHE)>=10),
CONSTRAINT UQ_LH UNIQUE(LIENHE)
)
GO

CREATE TABLE MUONTRASACH
(
MADG CHAR(5) NOT NULL,
MASH CHAR(5) NOT NULL,
CONSTRAINT PK_MUONTRASACH PRIMARY KEY(MADG, MASH),
NGMUON DATE,
NGTRA DATE, 
CONSTRAINT FK_MUONTRA_DG FOREIGN KEY(MADG) REFERENCES DOCGIA(MADG),
CONSTRAINT FK_MUONTRA_SH FOREIGN KEY(MASH) REFERENCES SACH(MASH)
)
GO


INSERT INTO TACGIA VALUES
('TG001',N'Nguyễn Hữu Anh',N'Q3, TP.HCM'),
('TG002',N'Tô Hoài',N'Bình Thạnh, TP.HCM'),
('TG003',N'Nguyễn Quang Sang',N'Tràng Bàng, Tây Ninh'),
('TG004',N'Hồ Tùng Mậu',N'Tràng Bom, Đồng Nai'),
('TG005',N'Thi Anh Trung',N'Bến Lức, Long An'),
('TG006','Nguyễn Nhật Ánh','Q1, TP.HCM')
GO

INSERT INTO LOAISACH VALUES
('SH',N'SÁCH'),
('TR',N'TRUYỆN'),
('TC',N'TẠP CHÍ')
GO

INSERT INTO NHAXUATBAN VALUES
('NXB01',N'Đại học quốc gia TP.HCM','Quận 1, TP.HCM','08765348758'),
('NXB02',N'Đại học quốc gia Hà Nội','Quận Cầu Giấy, Hà Nội','04765476574'),
('NXB03',N'Thanh Niên',N'Quận 3, TP.HCM','08765475665'),
('NXB04',N'Tổng Hợp',N'Quận Thanh Xuân,Hà Nội','04876847676'),
('NXB05',N'Nhi Đồng',N'Quận 10,TP.HCM','08765746767')
GO

INSERT INTO SACH VALUES
('SH001',N'Toán rời rạc','TG001',1998,'NXB01','SH'),
('TR001',N'Dế mèn phiêu lưu ký','TG002',1997,'NXB05','TR'),
('TR002','Bàn có 5 chỗ ngồi','TG006',2000,'NXB05','TR'),
('TC001','Tạp chí Tin học và Điều khiển số 6/2015','TG003',2015,'NXB04','TC'),
('TC002','Tạp chí Tin học và Điều khiển số 9/2015','TG003',2015,'NXB04','TC'),
('SH002','Kỹ thuật lập trình C#','TG004',1998,'NXB04','SH')
GO

INSERT INTO DOCGIA VALUES
('DG001',N'Nguyễn Thanh Nam','09/13/1990',N'Nam','01681234567'),
('DG002',N'Lê Văn Anh','04/24/1994',N'Nam','0982999011'),
('DG003',N'Trần Thanh Bình','10/30/1989',N'Nữ','01659000123'),
('DG004',N'Nguyễn Thị Thanh','02/02/1997',N'Nữ','01231452370')
GO

INSERT INTO MUONTRASACH VALUES
('DG004','SH002','05/21/2016','05/28/2016'),
('DG001','SH001','06/01/2016','06/02/2016'),
('DG003','TR001','06/01/2016','06/11/2016'),
('DG001','SH002','06/01/2016',NULL)
GO