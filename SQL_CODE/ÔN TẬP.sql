﻿use QLNV
GO

--TRUY VẤN CƠ BẢN
--1. TÌM NỮ NHÂN VIÊN SỐNG TẠI TPHCM
SELECT MANV, HONV+' '+TENLOT+' '+TENNV N'Nhân viên', PHAI, DCHI
FROM NHANVIEN
WHERE PHAI=N'Nữ' AND DCHI LIKE N'%TpHCM'

--2. TÌM TẤT CẢ NHÂN VIÊN CÓ MỨC LƯƠNG >=2TR VÀ <= 3TR
SELECT MANV, HONV+' '+TENLOT+' '+TENNV N'Nhân viên', MLUONG Lương, MLUONG*0.1 Thuế
FROM NHANVIEN
WHERE MLUONG>=2000000 AND MLUONG<=3000000
ORDER BY Thuế --DESC

--3. TÌM TẤT CẢ SINH VIÊN VÀ TUỔI CỦA HỌ, BIẾT TUỔI >=40 VÀ <=60, SẮP XẾP TUỔI GIẢM DẦN
SELECT MANV, HONV+' '+TENLOT+' '+TENNV N'Nhân viên', YEAR(GETDATE())-YEAR(NGAYSINH) Tuổi
FROM NHANVIEN
WHERE YEAR(GETDATE())-YEAR(NGAYSINH)>=40 AND YEAR(GETDATE())-YEAR(NGAYSINH)<=60
ORDER BY Tuổi DESC

-- PHÉP KẾT
-- 1. TÌM NHÂN VIÊN CỦA PHÒNG NGHIÊN CỨU
SELECT MANV, HONV+' '+TENLOT+' '+TENNV N'Nhân viên',PHONG
FROM PHONGBAN P JOIN NHANVIEN NV ON P.MAPHONG=NV.PHONG
WHERE TENPHONG=N'Nghiên cứu'

-- 2. TÌM TRƯỞNG PHÒNG CỦA PHÒNG NGHIÊN CỨU
SELECT MANV N'Mã trưởng phòng', HONV+' '+TENLOT+' '+TENNV N'Trưởng phòng',PHONG
FROM PHONGBAN P JOIN NHANVIEN NV ON P.TRPHONG=NV.MANV
WHERE TENPHONG=N'Nghiên cứu'

-- 3. TÌM NHÂN VIÊN LÀM VIỆC TẠI CÁC PHÒNG BAN TẠI HA NOI
SELECT MANV , HONV+' '+TENLOT+' '+TENNV N'Nhân viên', TENPHONG
FROM (PHONGBAN P JOIN NHANVIEN NV ON P.MAPHONG=PHONG) JOIN DIADIEM_PHG DD ON P.MAPHONG=DD.MAPHG
WHERE DIADIEM LIKE '%HANOI'

-- 4. CHO BIẾT NHÂN VIÊN VÀ HỌ TÊN NGƯỜI QUẢN LÝ TRỰC TIẾP CỦA HỌ
SELECT NV1.MANV , NV1.HONV+' '+NV1.TENLOT+' '+NV1.TENNV N'Nhân viên',NV2.HONV+' '+NV2.TENLOT+' '+NV2.TENNV N'Người quản lý'
FROM NHANVIEN NV1, NHANVIEN NV2
WHERE NV2.MANV=NV1.MA_NQL

-- 5. TÌM TÊN NHÂN VIÊN VÀ TÊN TRƯỞNG PHÒNG CỦA PHÒNG BAN NHÂN VIÊN ĐÓ LÀ VIỆC
SELECT NV1.MANV , NV1.HONV+' '+NV1.TENLOT+' '+NV1.TENNV N'Nhân viên',TENPHONG, NV2.HONV+' '+NV2.TENLOT+' '+NV2.TENNV N'Trưởng phòng'
FROM NHANVIEN NV1, NHANVIEN NV2,PHONGBAN P
WHERE NV1.PHONG=MAPHONG AND TRPHONG=NV2.MANV

-- 6. TÌM NHÂN VIÊN THAM GIA VÀO ĐỀ ÁN 'ĐÀO TẠO 1' HOẶC 'ĐÀO TẠO 2'
SELECT NV.MANV, HONV+' '+TENLOT+' '+TENNV N'Nhân viên',TENDA
FROM NHANVIEN NV, PHANCONG PC, DEAN DA
WHERE NV.MANV=PC.MANV AND PC.MADA=DA.MADA
AND (TENDA=N'ĐÀO TẠO 1' OR TENDA=N'ĐÀO TẠO 2')

-- PHÉP TOÁN TẬP HỢP UNION/ EXCEPT/ INTERSECT
SELECT NV.MANV, HONV+' '+TENLOT+' '+TENNV N'Nhân viên',TENDA
FROM NHANVIEN NV, PHANCONG PC, DEAN DA
WHERE NV.MANV=PC.MANV AND PC.MADA=DA.MADA
AND TENDA=N'ĐÀO TẠO 1'
UNION
SELECT NV.MANV, HONV+' '+TENLOT+' '+TENNV N'Nhân viên',TENDA
FROM NHANVIEN NV, PHANCONG PC, DEAN DA
WHERE NV.MANV=PC.MANV AND PC.MADA=DA.MADA
AND TENDA=N'ĐÀO TẠO 2'

--1. TÌM NHÂN VIÊN THAM GIA CẢ 2 ĐỀ ÁN
SELECT NV.MANV, HONV+' '+TENLOT+' '+TENNV N'Nhân viên'
FROM NHANVIEN NV, PHANCONG PC, DEAN DA
WHERE NV.MANV=PC.MANV AND PC.MADA=DA.MADA
AND TENDA=N'ĐÀO TẠO 1'
INTERSECT
SELECT NV.MANV, HONV+' '+TENLOT+' '+TENNV N'Nhân viên'
FROM NHANVIEN NV, PHANCONG PC, DEAN DA
WHERE NV.MANV=PC.MANV AND PC.MADA=DA.MADA
AND TENDA=N'ĐÀO TẠO 2'

-- 2. TÌM NHÂN VIÊN KHÔNG THAM GIA ĐỀ ÁN 'ĐÀO TẠO 1'
SELECT NV.MANV, HONV+' '+TENLOT+' '+TENNV N'Nhân viên'
FROM NHANVIEN NV
EXCEPT
SELECT NV.MANV, HONV+' '+TENLOT+' '+TENNV N'Nhân viên'
FROM NHANVIEN NV, PHANCONG PC, DEAN DA
WHERE NV.MANV=PC.MANV AND PC.MADA=DA.MADA
AND TENDA=N'ĐÀO TẠO 1'

--TRUY VẤN LỒNG

SELECT MANV, HONV+' '+TENLOT+' '+TENNV N'Nhân viên' -- LỒNG PHÂN CẤP
FROM NHANVIEN 
WHERE MANV NOT IN
			(SELECT NV.MANV
			FROM NHANVIEN NV, PHANCONG PC, DEAN DA
			WHERE NV.MANV=PC.MANV AND PC.MADA=DA.MADA
			AND TENDA=N'ĐÀO TẠO 1')

SELECT NV1.MANV, HONV+' '+TENLOT+' '+TENNV N'Nhân viên' -- LỒNG TƯƠNG QUAN
FROM NHANVIEN NV1
WHERE NOT EXISTS
			(SELECT *
			FROM NHANVIEN NV, PHANCONG PC, DEAN DA
			WHERE NV.MANV=PC.MANV AND PC.MADA=DA.MADA
			AND TENDA=N'ĐÀO TẠO 1'
			AND NV1.MANV=NV.MANV)

-- 2. TÌM NHÂN VIÊN CÓ MỨC LƯƠNG LỚN HƠN BẤT KỲ NHÂN VIÊN NÀO CỦA PHÒNG NGHIÊN CỨU
SELECT MANV, HONV+' '+TENLOT+' '+TENNV N'Nhân viên',MLUONG
FROM NHANVIEN 
WHERE MLUONG>ANY
			(SELECT MLUONG
			FROM NHANVIEN NV,PHONGBAN P
			WHERE PHONG=MAPHONG
			AND TENPHONG=N'NGHIÊN CỨU')

-- 3. TÌM NHÂN VIÊN CÓ MỨC LƯƠNG CAO NHẤT CỦA PHÒNG NGHIÊN CỨU
SELECT MANV, HONV+' '+TENLOT+' '+TENNV N'Nhân viên',MLUONG
FROM NHANVIEN NV,PHONGBAN P
WHERE PHONG=MAPHONG
AND TENPHONG=N'NGHIÊN CỨU'
AND MLUONG>=ALL
			(SELECT MLUONG
			FROM NHANVIEN NV,PHONGBAN P
			WHERE PHONG=MAPHONG
			AND TENPHONG=N'NGHIÊN CỨU')