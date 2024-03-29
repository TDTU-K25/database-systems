﻿-- Exercise 1

CREATE DATABASE QLNV
GO
USE QLNV

CREATE TABLE PHONG (
	MAPHONG char(3),
	TENPHONG nvarchar(40),
	DIACHI nvarchar(50),
	TEL char(10)
	PRIMARY KEY(MAPHONG)
)

CREATE TABLE DMNN (
	MANN char(2),
	TENN nvarchar(20),
	PRIMARY KEY(MANN)
)

CREATE TABLE NHANVIEN (
	MANV char(5),
	HOTEN nvarchar(40),
	GIOITINH nchar(3),
	NGAYSINH datetime,
	LUONG int,
	MAPHONG char(3),
	SDT char(10),
	NGAYBC datetime,
	PRIMARY KEY(MANV),
	FOREIGN KEY(MAPHONG) REFERENCES PHONG(MAPHONG)
)

CREATE TABLE TDNN (
	MANV char(5),
	MANN char(2),
	TDO char(1),
	PRIMARY KEY(MANV, MANN)
)

ALTER TABLE TDNN ADD CONSTRAINT FK_TDNN_MANV_NHANVIEN FOREIGN KEY(MANV) REFERENCES NHANVIEN(MANV)
ALTER TABLE TDNN ADD CONSTRAINT FK_TDNN_MANN_DMNN FOREIGN KEY(MANN) REFERENCES DMNN(MANN)

-- Exercise 2

INSERT INTO PHONG VALUES 
('HCA', N'Hành chính tổ hợp', N'123, Láng Hạ, Đống Đa, Hà Nội', '04 8585793'),
('KDA', N'Kinh Doanh', N'123, Láng Hạ, Đống Đa, Hà Nội', '04 8574943'),
('KTA', N'Kỹ thuật', N'123, Láng Hạ, Đống Đa, Hà Nội', '04 9480485'),
('QTA', N'Quản trị', N'123, Láng Hạ, Đống Đa, Hà Nội', '04 8508585')

INSERT INTO DMNN VALUES 
('01', N'Anh'),
('02', N'Nga'),
('03', N'Pháp'),
('04', N'Nhật'),
('05', N'Trung Quốc'),
('06', N'Hàn Quốc')

INSERT INTO NHANVIEN VALUES 
('HC001', N'Nguyễn Thị Hà', N'Nữ', '8/27/1950', 2500000, 'HCA', NULL, '2/8/1975'),
('HC002', N'Trần Văn Nam', N'Nam', '6/12/1975', 3000000, 'HCA', NULL, '6/8/1997'),
('HC003', N'Nguyễn Thanh Huyền', N'Nữ', '7/3/1978', 1500000, 'HCA',  NULL, '9/24/1999'),
('KD001', N'Lê Tuyết Anh', N'Nữ', '2/3/1997', 2500000, 'KDA', NULL, '10/2/2001'),
('KD002', N'Nguyễn Anh Tú', N'Nam', '7/4/1942', 2600000, 'KDA', NULL, '9/24/1999'),
('KD003', N'Phạm An Thái', N'Nam', '5/9/1977', 1600000, 'KDA', NULL, '9/24/1999'),
('KD004', N'Lê Văn Hải', N'Nam', '1/2/1976', 2700000, 'KDA', NULL, '6/8/1997'),
('KD005', N'Nguyễn Phương Minh', N'Nam', '1/2/1980', 2000000, 'KDA', NULL, '10/2/2001'),
('KT001', N'Trần Đình Khâm', N'Nam', '12/2/1981', 2700000, 'KTA', NULL, '1/1/2005'),
('KT002', N'Nguyễn Mạnh Hùng', N'Nam', '8/16/1980', 2300000, 'KTA', NULL, '1/1/2005'),
('KT003', N'Phạm Thanh Sơn', N'Nam', '8/20/1984', 2000000, 'KTA', NULL, '1/1/2005'),
('KT004', N'Vũ Thị Hoài', N'Nữ', '12/5/1980', 2500000, 'KTA', NULL, '10/2/2001'),
('KT005', N'Nguyễn Thu Lan', N'Nữ', '10/5/1977', 3000000, 'KTA', NULL, '10/2/2001'),
('KT006', N'Trần Hoài Nam', N'Nam', '7/2/1978', 2800000, 'KTA', NULL, '6/8/1997'),
('KT007', N'Hoàng Nam Sơn', N'Nam', '12/3/1940', 3000000, 'KTA', NULL, '7/2/1965'),
('KT008', N'Lê Thu Trang', N'Nữ', '7/6/1950', 2500000, 'KTA', NULL, '8/2/1968'),
('KT009', N'Khúc Nam Hải', N'Nam', '7/22/1980', 2000000, 'KTA', NULL, '1/1/2005'),
('KT010', N'Phùng Trung Dũng', N'Nam', '8/28/1978', 2200000, 'KTA', NULL, '9/24/1999')

INSERT INTO TDNN VALUES
('HC001', '01', 'A'),
('HC001', '02', 'B'),
('HC002', '01', 'C'),
('HC002', '03', 'C'),
('HC003', '01', 'D'),
('KD001', '01', 'C'),
('KD001', '02', 'B'),
('KD002', '01', 'D'),
('KD002', '02', 'A'),
('KD003', '01', 'B'),
('KD003', '02', 'C'),
('KD004', '01', 'C'),
('KD004', '04', 'A'),
('KD004', '05', 'A'),
('KD005', '01', 'B'),
('KD005', '02', 'D'),
('KD005', '03', 'B'),
('KD005', '04', 'B'),
('KT001', '01', 'D'),
('KT001', '04', 'E'),
('KT002', '01', 'C'),
('KT002', '02', 'B'),
('KT003', '01', 'D'),
('KT003', '03', 'C'),
('KT004', '01', 'D'),
('KT005', '01', 'C')

-- Exercise 3
INSERT INTO NHANVIEN VALUES
('QT001', N'Lê Khắc Thanh Tùng', 'Nam', NULL, 150000, 'QTA', NULL, NULL)

INSERT INTO TDNN VALUES
('QT001', '01', 'C'),
('QT001', '04', 'A')

SELECT 
  nv.HOTEN, 
  p.TENPHONG, 
  nn.TENN, 
  nv.LUONG 
FROM 
  NHANVIEN nv 
  INNER JOIN PHONG p ON nv.MAPHONG = p.MAPHONG 
  INNER JOIN TDNN td ON nv.MANV = td.MANV 
  INNER JOIN DMNN nn ON td.MANN = nn.MANN 
WHERE 
  nv.HOTEN = N'Lê Khắc Thanh Tùng'

  -- Exercise 4

  -- Câu 1
SELECT *
FROM NHANVIEN
WHERE MANV = 'KT001'

-- Câu 2
UPDATE NHANVIEN
SET HOTEN = N'Trần Đình Khâm'
WHERE MANV = 'KT001'

-- Câu 3
SELECT * 
FROM NHANVIEN
WHERE GIOITINH = N'Nữ'

-- Câu 4
SELECT *
FROM NHANVIEN
WHERE HOTEN like N'Nguyễn%'

-- Câu 5
SELECT *
FROM NHANVIEN
WHERE HOTEN like N'%Văn%'

-- Câu 6
SELECT *, YEAR(GETDATE()) - YEAR(NGAYSINH) AS 'TUOI'
FROM NHANVIEN
WHERE YEAR(GETDATE()) - YEAR(NGAYSINH) < 30

-- Câu 7
SELECT *, YEAR(GETDATE()) - YEAR(NGAYSINH) AS 'TUOI'
FROM NHANVIEN
WHERE YEAR(GETDATE()) - YEAR(NGAYSINH) BETWEEN 25 AND 30

-- Câu 8
SELECT MANV 
FROM TDNN
WHERE MANN = '01' AND TDO IN ('A', 'B', 'C')

-- Câu 9
SELECT *
FROM NHANVIEN
WHERE YEAR(NGAYBC) < 2000

-- Câu 10
SELECT * 
FROM NHANVIEN
WHERE YEAR(GETDATE()) - YEAR(NGAYBC) > 10

-- Câu 11
SELECT *
FROM NHANVIEN
WHERE (GIOITINH = 'Nam' AND YEAR(GETDATE()) - YEAR(NGAYSINH) >= 60) OR (GIOITINH = N'Nữ' AND YEAR(GETDATE()) - YEAR(NGAYSINH) >= 55)

-- Câu 12
SELECT MAPHONG, TENPHONG, TEL
FROM PHONG

-- Câu 13
SELECT TOP 2 HOTEN, NGAYSINH, NGAYBC
FROM NHANVIEN

-- Câu 14
SELECT HOTEN, NGAYSINH, LUONG
FROM NHANVIEN
WHERE LUONG BETWEEN 2000000 AND 3000000

-- Câu 15
SELECT * 
FROM NHANVIEN
WHERE SDT IS NULL

-- Câu 16
SELECT *
FROM NHANVIEN
WHERE MONTH(NGAYSINH) = 3

-- Câu 17
SELECT *
FROM NHANVIEN
ORDER BY LUONG

-- Câu 18
SELECT 
  AVG(LUONG) AS 'LUONGTRUNGBINH' 
FROM 
  NHANVIEN 
WHERE 
  MAPHONG = (
    SELECT 
      MAPHONG 
    FROM 
      PHONG 
    WHERE 
      TENPHONG = N'Kinh Doanh'
  )

-- Câu 19
SELECT 
  COUNT(MANV) AS 'SOLUONGNHANVIEN', 
  AVG(LUONG) AS 'LUONGTRUNGBINH' 
FROM 
  NHANVIEN 
WHERE 
  MAPHONG = (
    SELECT 
      MAPHONG 
    FROM 
      PHONG 
    WHERE 
      TENPHONG = N'Kinh Doanh'
  )

-- Câu 20
SELECT 
  p.TENPHONG, 
  SUM(LUONG) AS 'TONGLUONG' 
FROM 
  NHANVIEN nv 
  INNER JOIN PHONG p ON nv.MAPHONG = p.MAPHONG 
GROUP BY 
  p.TENPHONG

-- Câu 21
SELECT 
  p.TENPHONG, 
  SUM(LUONG) AS 'TONGLUONG' 
FROM 
  NHANVIEN nv 
  INNER JOIN PHONG p ON nv.MAPHONG = p.MAPHONG 
GROUP BY 
  p.TENPHONG
HAVING SUM(LUONG) > 5000000

-- Câu 22
SELECT 
  MANV, 
  HOTEN, 
  nv.MAPHONG, 
  p.TENPHONG 
FROM 
  NHANVIEN nv 
  INNER JOIN PHONG p ON nv.MAPHONG = p.MAPHONG

-- Câu 23
SELECT 
  * 
FROM 
  NHANVIEN nv 
  LEFT JOIN PHONG p ON nv.MAPHONG = p.MAPHONG

-- Câu 24
SELECT 
  * 
FROM 
  NHANVIEN nv 
  RIGHT JOIN PHONG p ON nv.MAPHONG = p.MAPHONG