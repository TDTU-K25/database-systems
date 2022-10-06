CREATE DATABASE QLNGK
GO
USE QLNGK

-- Câu 1


-- a)
CREATE TABLE LoaiNGK (
	MaLoai char(5),
	TenLoai nvarchar(30) UNIQUE,
	PRIMARY KEY(MaLoai) 
)

-- b)
-- Nước giải khát
CREATE TABLE NGK (
	MaNGK char(5),
	TenNGK nvarchar(30) UNIQUE,
	DVT nvarchar(20) CHECK (DVT IN ('chai', 'lon', N'thùng', N'kết')),
	SoLuong int CHECK (SoLuong > 0),
	DonGia float CHECK (DonGia > 0),
	MaLoaiNGK char(5),
	PRIMARY KEY(MaNGK), 
	FOREIGN KEY (MaLoaiNGK) REFERENCES LoaiNGK(MaLoai)
)

-- c)
CREATE TABLE KhachHang (
	MsKH char(5),
	HoTen nvarchar(30),
	DiaChi nvarchar(50),
	DienThoai char(11) DEFAULT NULL,
	PRIMARY KEY (MsKH)
)

-- d)
CREATE TABLE HoaDon (
	SoHD char(5),
	MsKH char(5),
	NhanVien nvarchar(30),
	NgayLap date DEFAULT GETDATE(),
	PRIMARY KEY(SoHD),
	FOREIGN KEY(MsKH) REFERENCES KhachHang(MsKH)
)

-- e)
-- Chi tiết hóa đơn
CREATE TABLE CTHD (
	SoHD char(5),
	MaNGK char(5),
	SoLuong int CHECK (SoLuong > 0), 
	DonGia float,
	PRIMARY KEY (SoHD, MaNGK)
)

-- f)
ALTER TABLE CTHD ADD ThanhTien int

ALTER TABLE CTHD ADD CONSTRAINT FK_CTHD_SoHD_HoaDon FOREIGN KEY (SoHD) REFERENCES HoaDon(SoHD)

ALTER TABLE CTHD ADD CONSTRAINT FK_CTHD_MaNGK_NGK FOREIGN KEY (MaNGK) REFERENCES NGK(MaNGK)

ALTER TABLE CTHD ADD CONSTRAINT CK_CTHD_DonGia CHECK (DonGia > 1000)

-- g)
ALTER TABLE CTHD DROP CONSTRAINT FK_CTHD_SoHD_HoaDon
ALTER TABLE CTHD DROP CONSTRAINT FK_CTHD_MaNGK_NGK

-- h)
ALTER TABLE CTHD ADD CONSTRAINT CK_CTHD_ThanhTien CHECK (ThanhTien > 0)

-- Câu 2

-- a)
INSERT INTO LoaiNGK VALUES
('NGK01', N'Nước ngọt'),
('NGK02', 'Bia'),
('NGK03', N'Rượu')

INSERT INTO NGK VALUES 
('N001', 'Pepsi', 'lon', 10, 7000, 'NGK01'),
('N002', '333', N'thùng', 15, 200000, 'NGK02'),
('N003', 'Sting', 'chai', 5, 10000, 'NGK01')

INSERT INTO KhachHang VALUES
('KH001', N'Nguyễn Văn A', 'TPHCM', '0909'),
('KH002', N'Lương Quốc Trung', 'Long An', '0901'),
('KH003', N'Vũ Cát Tường', N'Đà Nẵng', '0902')

INSERT INTO HoaDon VALUES
('HD001', 'KH001', N'Lê Thị B', DEFAULT),
('HD002', 'KH002', N'Đinh Văn C', DEFAULT),
('HD003', 'KH003', N'Cao Văn Sơn', DEFAULT)

INSERT INTO CTHD VALUES 
('HD001', 'N001', 1, 7000, 1 * 7000),
('HD001', 'N002', 2, 200000, 2 * 200000),
('HD002', 'N003', 4, 10000, 4 * 10000)

-- b)
UPDATE NGK
SET DonGia += 10000
WHERE DVT = 'lon'

-- c)
DELETE FROM KhachHang WHERE MsKH NOT IN (SELECT MsKH
                                  FROM HoaDon
                                  WHERE YEAR(ngaylap) >= 2010
                                 )

-- d)
DELETE FROM NGK 
WHERE SoLuong = 0

-- e)
SELECT * FROM NGK
UPDATE NGK
SET DonGia = (CASE WHEN DonGia + 100000 <= 500000 THEN DonGia + 100000 
              ELSE 500000 
              END)
WHERE DVT = N'thùng'

-- Câu 3

-- a)
SELECT * 
FROM NGK
WHERE DVT = 'lon'

-- b)
SELECT *
FROM KhachHang
WHERE DiaChi = 'TPHCM'

-- c)
SELECT NGK.*
FROM NGK, CTHD, HoaDon
WHERE NGK.MaNGK = CTHD.MaNGK AND CTHD.SoHD = HoaDon.SoHD
AND MONTH(HoaDon.NgayLap) IN (7, 8, 9) AND YEAR(HoaDon.NgayLap) = 2018

SELECT *
FROM NGK
WHERE MaNGK IN (SELECT MaNGK 
                FROM CTHD
                WHERE SoHD IN (SELECT SoHD
                               FROM HoaDon
                               WHERE MONTH(NgayLap) IN (7, 8, 9) AND YEAR(NgayLap) = 2018)
                )

-- d)
SELECT TenNGK, SoLuong
FROM NGK

-- hoặc

SELECT NGK.TenNGK, CTHD.SoLuong
FROM NGK, CTHD
WHERE NGK.MaNGK = CTHD.mangk

-- e)
SELECT DISTINCT SoHD
FROM CTHD, NGK, LoaiNGK
WHERE CTHD.MaNGK = NGK.MaNGK AND NGK.MaLoaiNGK = LoaiNGK.MaLoai
AND LoaiNGK.TenLoai IN (N'Nước có ga', N'Nước ngọt')

SELECT DISTINCT SoHD
FROM CTHD
WHERE MaNGK IN (SELECT MaNGK
                FROM NGK 
                WHERE MaLoaiNGK IN (SELECT MaLoai
                                    FROM LoaiNGK
                                    WHERE TenLoai IN (N'Nước có ga', N'Nước ngọt')
                                   )
               )

-- f)
SELECT *
FROM NGK 
WHERE MaNGK NOT IN (SELECT DISTINCT MaNGK 
                    FROM CTHD)
                    
SELECT NGK.*
FROM NGK
	LEFT JOIN CTHD
    ON NGK.MaNGK = CTHD.MaNGK
WHERE CTHD.MaNGK IS NULL