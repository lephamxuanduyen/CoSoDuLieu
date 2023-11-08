﻿USE QLSV

/*
SELECT <*,TT1,TT2,....>
FROM   <QH1,QH2,....>
WHERE  [ĐK(AND, OR, NOT)]
*/
GO

--1. TÌM TẤT CẢ SINH VIÊN CÓ MÃ KHOA LÀ TKTH
SELECT * FROM SINHVIEN
SELECT * FROM SINHVIEN
WHERE MAKHOA='TKTH'
GO

--2. TÌM TẤT CẢ SINH VIEN(TENSV,MAKHOA) CÓ NĂM 2

SELECT TEN,MAKHOA
FROM SINHVIEN
WHERE NAM=2
GO
--ĐẶT BÍ DANH CHO THUỘC TÍNH

SELECT MASV AS N'MÃ SINH VIEN',TEN AS N'TÊN SINH VIÊN',MAKHOA AS 'MÃ KHOA',NAM NĂM
FROM SINHVIEN
WHERE NAM=2
GO

--3. TÌM TẤT CẢ KHOA(MAKHOA,TENKHOA,SONAM) CÓ SỐ NĂM TRÊN 20
SELECT * FROM KHOA
SELECT MAKHOA, TENKHOA, (YEAR(GETDATE())-NAMTL) AS N'SỐ NĂM'
FROM KHOA
WHERE (YEAR(GETDATE())-NAMTL)>=20

--LOẠI BỎ TRÙNG
--4. CHO BIẾT CÁC KHOA ĐANG CÓ SINH VIÊN HỌC

SELECT DISTINCT MAKHOA
FROM SINHVIEN

--II - THAO TÁC TRÊN MỆNH ĐỀ FROM

--5. TÌM TẤT CẢ SINH VIÊN THUỘC KHOA THỐNG KÊ TIN HỌC

--C1:
SELECT MASV,TEN,TENKHOA
FROM SINHVIEN INNER JOIN KHOA ON SINHVIEN.MAKHOA=KHOA.MAKHOA
WHERE TENKHOA=N'Thống kê tin học'

--C2
SELECT MASV,TEN,TENKHOA
FROM SINHVIEN,KHOA 
WHERE TENKHOA=N'Thống kê tin học' AND SINHVIEN.MAKHOA=KHOA.MAKHOA

--ĐẶT BÍ DANH CHO QUAN HỆ (THÌ BẮT BUỘC CÁC MỆNH ĐỀ KHÁC CX PHẢI SỬ DỤNG BÍ DANH)

--6. TÌM SINH VIÊN(MASV, TENSV,MAKHOA,NAM) HỌC NĂM 3 KHOA THỐNG KÊ TIN HỌC
SELECT MASV,TEN,SINHVIEN.MAKHOA,NAM
FROM SINHVIEN INNER JOIN KHOA ON SINHVIEN.MAKHOA=KHOA.MAKHOA
WHERE TENKHOA=N'Thống kê tin học' AND NAM=3

--7. TÌM SINH VIÊN(MASV, TENSV,MAKHOA,NAM) HỌC NĂM 2 HOẶC KHOA THỐNG KÊ TIN HỌC
SELECT MASV,TEN,SINHVIEN.MAKHOA,NAM NĂM
FROM SINHVIEN INNER JOIN KHOA ON SINHVIEN.MAKHOA=KHOA.MAKHOA
WHERE (TENKHOA=N'Thống kê tin học') OR (NAM=2)

USE QLNV
--8. TÌM NHÂN VIÊN THUỘC PHÒNG NGHIÊN CỨU(MANV, HOTEN,MAPHONG)
SELECT MANV, HONV+' '+TENLOT+' '+TENNV,MAPHONG
FROM NHANVIEN JOIN PHONGBAN ON PHONG=MAPHONG
WHERE TENPHONG=N'Nghiên cứu'
