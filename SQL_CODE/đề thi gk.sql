﻿CREATE DATABASE QUANLYDUAN
GO

USE QUANLYDUAN
GO

CREATE TABLE DUAN
(MADUAN VARCHAR(10) CONSTRAINT DA_PK PRIMARY KEY,
TENDUAN NVARCHAR(100),
LOAIDUAN NVARCHAR(100),
THOIGIANTHUCHIEN_THANG INT,
NGAYBATDAU DATETIME,
NGAYKETTHUC_DUKIEN DATETIME)
GO

CREATE TABLE NHANVIEN
(MANHANVIEN VARCHAR(10) CONSTRAINT NV_PK PRIMARY KEY,
TENNHANVIEN NVARCHAR(100),
GIOITINH INT CONSTRAINT GT_CK CHECK (GIOITINH= 0 OR GIOITINH=1),
CONGVIEC NVARCHAR(100),
DIENTHOAI CHAR(10),
QUEQUAN NVARCHAR(100))
GO

CREATE TABLE TRIENKHAIDUAN
(ID_PHANCONG VARCHAR(10) CONSTRAINT TK_PK PRIMARY KEY,
MANHANVIEN VARCHAR(10) CONSTRAINT NV_TK_FK FOREIGN KEY(MANHANVIEN) REFERENCES NHANVIEN(MANHANVIEN),
MADUAN VARCHAR(10) CONSTRAINT DA_TK_FK FOREIGN KEY(MADUAN) REFERENCES DUAN(MADUAN),
NHIEMVU NVARCHAR(100),
NGAYTHAMGIA DATETIME,
NGAYKETTHUC DATETIME,
SONGAYTHAMGIA INT,
TINHTRANG NVARCHAR(100))
GO

INSERT INTO NHANVIEN VALUES
('E001',N'Nguyễn Văn Chung',1,'Software','0905123456',N'Đà Nẵng'),
('E002',N'Nguyễn Thị Hoa',0,'Software','0905123457',N'Huế'),
('E003',N'Nguyễn Văn Chung',1,'App Mobile','0905123458',N'Quảng Nam')
GO

INSERT INTO DUAN(MADUAN,TENDUAN,LOAIDUAN,THOIGIANTHUCHIEN_THANG,NGAYBATDAU) VALUES
('DA001',N'ERP','Software',12,'2021/01/15'),
('DA002',N'Phân tích dữ liệu','Software',3,'2021/09/15'),
('DA003','Chăm sóc khách hàng','App Mobile',6,'2021/10/01')
GO

INSERT INTO TRIENKHAIDUAN(ID_PHANCONG,MANHANVIEN,MADUAN,NHIEMVU,NGAYTHAMGIA,NGAYKETTHUC,TINHTRANG) VALUES
('T0001','E001','DA001',N'Lập trình','2021/01/15','2021/03/20',N'Đã kết thúc'),
('T0002','E002','DA001',N'Kiểm thử','2021/09/15','2021/03/27',N'Đã kết thúc'),
('T0003','E003','DA003','Triển khai','2021/10/01','2022/02/15',N'Đang triển khai')
GO

ALTER TABLE NHANVIEN ADD LUONG FLOAT
GO

UPDATE DUAN
SET THOIGIANTHUCHIEN_THANG=DAY(NGAYKETTHUC_DUKIEN)-DAY(NGAYBATDAU)
GO

UPDATE TRIENKHAIDUAN
SET SONGAYTHAMGIA=DAY(NGAYKETTHUC)-DAY(NGAYTHAMGIA)
GO

-- 7.

SELECT NV.MANHANVIEN, NV.TENNHANVIEN,CONGVIEC, TENDUAN
FROM NHANVIEN NV, DUAN DA, TRIENKHAIDUAN TK
WHERE NV.MANHANVIEN=TK.MANHANVIEN AND DA.MADUAN=TK.MADUAN
AND DA.MADUAN='DA001' AND NHIEMVU=N'LẬP TRÌNH'
GO

--8.

SELECT *
FROM DUAN
WHERE MONTH(NGAYKETTHUC_DUKIEN)>0 AND MONTH(NGAYKETTHUC_DUKIEN)<=3 AND YEAR(NGAYKETTHUC_DUKIEN)=2022
ORDER BY DAY(NGAYKETTHUC_DUKIEN) DESC

-- 9. 

SELECT NV.MANHANVIEN, TENNHANVIEN, TENDUAN, LOAIDUAN, NGAYTHAMGIA, SONGAYTHAMGIA
FROM NHANVIEN NV, DUAN DA, TRIENKHAIDUAN TK
WHERE TK.MADUAN='DA001' AND NHIEMVU=N'KIỂM THỬ'

-- 6.

SELECT CONGVIEC, COUNT(CONGVIEC) N'SỐ NHÂN VIÊN CỦA TỪNG CÔNG VIÊC'
FROM NHANVIEN
GROUP BY CONGVIEC
ORDER BY COUNT(CONGVIEC) DESC