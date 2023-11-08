﻿CREATE DATABASE BANHANG
GO

USE BANHANG

CREATE TABLE KHACHHANG
(MAKH VARCHAR(10) CONSTRAINT PK_KH PRIMARY KEY,
HOTEN NVARCHAR(50),
DIACHI NVARCHAR(100),
SODT VARCHAR(10)
CONSTRAINT CHK_SDT CHECK(LEN(SODT)=10),
CONSTRAINT UQ_SDT UNIQUE(SODT),
NGSINH DATETIME,
PHAI NVARCHAR(10),
CONSTRAINT CHK_GT CHECK(PHAI IN (N'Nữ',N'Nam')))
GO

CREATE TABLE NHANVIEN
(MANV VARCHAR(10) CONSTRAINT PK_NV PRIMARY KEY,
HOTEN NVARCHAR(50),
NGVL DATETIME,
DCHI NVARCHAR(100),
PHAI NVARCHAR(10),
CONSTRAINT CHK_GTNV CHECK(PHAI IN (N'Nữ',N'Nam')))
GO

CREATE TABLE SANPHAM
(MASP VARCHAR(10) CONSTRAINT PK_SP PRIMARY KEY,
TENSP NVARCHAR(50),
NUOCSX NVARCHAR(15),
GIA INT)
GO

CREATE TABLE HOADON
(SOHD VARCHAR(10) CONSTRAINT PK_HD PRIMARY KEY,
NGHD DATETIME,
MAKH VARCHAR(10),
MANV VARCHAR(10),
MASP VARCHAR(10),
SOLUONG INT,
CONSTRAINT FK_HP_KH FOREIGN KEY(MAKH) REFERENCES KHACHHANG(MAKH),
CONSTRAINT FK_HD_NV FOREIGN KEY(MANV) REFERENCES NHANVIEN(MANV),
CONSTRAINT FK_HD_SP FOREIGN KEY(MASP) REFERENCES SANPHAM(MASP)
)

-- CÂU 2

INSERT INTO KHACHHANG VALUES
('KH001',N'Lê Phạm Xuân Duyên',N'K87 Dũng Sỹ Thanh Khê','0905800106','07/13/2003',N'Nữ'),
('KH002',N'Nguyễn Ngọc Bảo Hân',N'650 Trần Cao Vân','0782530611','05/18/1979',N'Nữ'),
('KH003',N'Trần Văn Bảo',N'68 Lê Độ','0935261081','08/06/1996',N'Nam')
GO
INSERT INTO KHACHHANG VALUES
('KH004',N'Nguyễn Xuân Thuận',N'Quận 7, TPHCM','0912564879','09/13/1974',N'Nam')
INSERT INTO NHANVIEN VALUES
('NV001',N'Phạm Ngọc Thảo','06/19/2019',N'68 Nguyễn Đức Trung',N'Nữ'),
('NV002',N'Huỳnh Thị Như Quỳnh','06/27/2015',N'79 Nguyễn Như Hạnh',N'Nữ')
GO
INSERT INTO KHACHHANG VALUES
('KH005',N'Nguyễn Thanh Tâm',N'Gò Vấp, TPHCM','0906530081','10/19/2002',N'Nữ')
INSERT INTO KHACHHANG VALUES
('KH006',N'Huỳnh Thị Như Quỳnh',N'Quận 1, TPHCM','0906530779','01/19/2002',N'Nam')
INSERT INTO NHANVIEN VALUES
('NV003',N'Nguyễn Văn A','08/19/2019',N'207 Nguyễn Đức Trung',N'Nam')

INSERT INTO SANPHAM VALUES
('SP001',N'Táo',N'Việt Nam',70000),
('SP002',N'Chuối',N'Việt Nam',70000),
('SP003',N'Ấm siêu tốc',N'Việt Nam',550000)

INSERT INTO HOADON VALUES
('HD001','11/11/2022','KH001','NV002','SP001',1),
('HD002','06/06/2022','KH002','NV003','SP003',1)
INSERT INTO HOADON VALUES
('HD003','08/11/2022','KH004','NV002','SP001',1)
--CÂU 3
SELECT MAKH, KH.HOTEN,(YEAR(GETDATE())-YEAR(KH.NGSINH)) TUỔI
FROM dbo.KHACHHANG KH
WHERE KH.PHAI=N'NAM' AND (YEAR(GETDATE())-YEAR(KH.NGSINH))>=40 AND KH.DIACHI LIKE N'%TPHCM'
GO 

--CÂU 4
SELECT SP.MASP, SP.TENSP,NGHD
FROM dbo.HOADON HD JOIN dbo.SANPHAM SP ON HD.MASP=SP.MASP
WHERE MONTH(HD.NGHD)=8 AND YEAR(HD.NGHD)=2022

--CÂU 5
SELECT NV.MANV, NV.HOTEN, SP.TENSP, SP.NUOCSX, SP.GIA
FROM dbo.NHANVIEN NV, dbo.HOADON HD, dbo.SANPHAM SP
WHERE HD.MANV=NV.MANV AND HD.MASP=SP.MASP
AND SP.GIA>=500000 AND (SP.NUOCSX=N'VIỆT NAM' OR SP.NUOCSX=N'TRUNG QUỐC')

--CÂU 6
SELECT MASP, TENSP,GIA
FROM dbo.SANPHAM
WHERE GIA>=ALL
		(SELECT GIA
		FROM dbo.SANPHAM)

--CÂU 7
SELECT MASP, TENSP,GIA
FROM dbo.SANPHAM
WHERE MASP NOT IN
		(SELECT SP.MASP
		FROM dbo.NHANVIEN NV, dbo.HOADON HD, dbo.SANPHAM SP
		WHERE HD.MANV=NV.MANV AND HD.MASP=SP.MASP
		AND NV.HOTEN=N'NGUYỄN VĂN A')

--CÂU 9
SELECT TOP 3 MASP, TENSP,GIA
FROM dbo.SANPHAM
ORDER BY GIA DESC

--CÂU 10
SELECT SP.MASP, TENSP,GIA, 0.05*SP.GIA*SOLUONG THUẾ
FROM dbo.SANPHAM SP JOIN HOADON HD ON SP.MASP=HD.MASP
WHERE GIA*SOLUONG<=5000000
UNION
SELECT SP.MASP, TENSP,GIA, 0.1*SP.GIA*SOLUONG THUẾ
FROM dbo.SANPHAM SP JOIN HOADON HD ON SP.MASP=HD.MASP
WHERE GIA*SOLUONG>5000000

--CÂU 8--TRÙNG HỌ TÊN
SELECT KH.MAKH,KH.HOTEN,NV.MANV, NV.HOTEN
FROM dbo.KHACHHANG KH,dbo.NHANVIEN NV
WHERE NV.HOTEN=KH.HOTEN