-- Câu 1

CREATE DATABASE quanlythuctap
GO
USE quanlythuctap

CREATE TABLE Sinhvien (
	masv char(10),
	ten nvarchar(30),
	quequan nvarchar(30),
	ngaysinh date,
	hocluc float CHECK (hocluc >= 0 AND hocluc <= 10),
	PRIMARY KEY(masv)
)

CREATE TABLE Detai (
	madt char(10),
	tendetai nvarchar(30),
	chunhiemdetai nvarchar(30),
	kinhphi float DEFAULT 0 CHECK (kinhphi < 100000000),
	PRIMARY KEY(madt)
)

CREATE TABLE Sinhvien_Detai (
	masv char(10) REFERENCES Sinhvien(masv),
	madt char(10) REFERENCES Detai(madt),
	noithuctap nvarchar(30),
	quangduong float,
	ketqua float CHECK (ketqua >= 0 AND ketqua <= 10),
	PRIMARY KEY(masv, madt)
)

INSERT INTO Sinhvien VALUES
('SV01', N'Trần Thanh Trâm', N'Sài Gòn', '1998/03/23', 8.5),
('SV02', N'Nguyễn Hồng Linh', N'Thanh Hóa', '2000/01/20', 9.0),
('SV03', N'Trần Thanh Phước', N'Tiền Giang', '2001/07/12', 7.5),
('SV04', N'Nguyễn Minh Hải', N'Nghệ An', '1993/02/28', 7.0),
('SV05', N'Trần Thị Hồng Nhung', N'Kiên Giang', '1998/07/15' ,9.0)

INSERT INTO Detai VALUES
('DT01', N'Quản lý quán ăn', N'Nguyễn Thễ Hữu', 10000000),
('DT02', N'Quản lý khách sạn', N'Trần Trung Hiếu', 2000000),
('DT03', N'Quản lý sân bóng đá mini', N'Nguyễn Công Tâm', 30000000),
('DT04', N'Quản lý shop hoa tươi', N'Đặng Đức Trung', 15000000),
('DT05', N'Quản lý cửa hàng điện thoại', N'Trịnh Thanh Duy', 20000000)

INSERT INTO Sinhvien_Detai VALUES 
('SV01', 'DT01', N'Tiền Giang', 70, 8.0),
('SV02', 'DT01', N'Bình Dương', 50, 7.0),
('SV03', 'DT02', N'Vũng Tàu', 150, 9.5),
('SV03', 'DT03', N'Long An', 50, 8.5),
('SV04', 'DT03', N'Nha Trang', 500, 10)

-- Câu 2

CREATE VIEW cau2_a AS 
SELECT 
  * 
FROM 
  Sinhvien 
WHERE 
  YEAR(
    GETDATE()
  ) - YEAR(ngaysinh) < 20 
  AND hocluc > 8.5

CREATE VIEW cau2_b AS 
SELECT 
  * 
FROM 
  Detai 
WHERE 
  kinhphi > 1000000


CREATE VIEW cau2_c AS 
SELECT 
  sv.* 
FROM 
  Sinhvien sv 
  INNER JOIN Sinhvien_Detai svdt ON sv.masv = svdt.masv 
WHERE 
  YEAR(
    GETDATE()
  ) - YEAR(sv.ngaysinh) < 20 
  AND sv.hocluc > 8.5 
  AND svdt.ketqua > 8.5

CREATE VIEW cau2_d AS
SELECT 
  dt.chunhiemdetai 
FROM 
  Detai dt 
  INNER JOIN Sinhvien_Detai svdt ON dt.madt = svdt.madt 
  INNER JOIN Sinhvien sv ON sv.masv = svdt.masv 
WHERE 
  sv.quequan = 'TPHCM'
  
CREATE VIEW cau2_e AS
SELECT * 
from Sinhvien 
WHERE YEAR(ngaysinh) < 1980 
	  AND quequan = N'Hải Phòng'

CREATE VIEW cau2_f AS
SELECT AVG(hocluc) AS N'Điểm trung bình' 
FROM Sinhvien 
WHERE quequan = N'Hà Nội' 

CREATE VIEW cau2_g AS
SELECT DISTINCT COUNT(noithuctap)
FROM Sinhvien_Detai
WHERE madt = 'DT005'

CREATE VIEW cau2_h AS
SELECT quequan, COUNT(masv) AS N'Số lượng sinh viên'
FROM Sinhvien
GROUP BY quequan

-- Câu 3

SELECT madt, COUNT(madt) 
FROM Sinhvien_Detai
GROUP BY madt 
HAVING COUNT(madt) >= 2

SELECT * 
FROM Sinhvien 
WHERE hocluc > ANY(SELECT hocluc 
                  FROM Sinhvien 
                  WHERE quequan = 'TPHCM')
				  
UPDATE Sinhvien_Detai
SET ketqua = CASE WHEN ketqua + 2 > 10 THEN 10 ELSE ketqua + 2 END
WHERE masv IN (SELECT masv FROM Sinhvien WHERE quequan = N'Lâm Đồng')
				  
SELECT 
  * 
FROM 
  Sinhvien sv 
  INNER JOIN Sinhvien_Detai svdt On sv.masv = svdt.masv 
WHERE 
  sv.quequan = svdt.noithuctap
  
SELECT * 
FROM Detai 
WHERE madt NOT IN (SELECT DISTINCT madt 
                 FROM Sinhvien_Detai)
				 
SELECT * 
FROM Detai 
WHERE madt IN (SELECT madt
             FROM Sinhvien_Detai
             WHERE masv IN (
                    SELECT masv
                    FROM Sinhvien 
                    WHERE hocluc = (SELECT MAX(hocluc) 
                                   FROM Sinhvien)))
								   
SELECT * 
from Detai 
WHERE madt NOT IN (SELECT madt 
                 FROM Sinhvien_Detai 
                 WHERE masv IN (SELECT masv 
                                     FROM Sinhvien 
                                     WHERE hocluc = (SELECT MIN(hocluc) 
                                                    FROM Sinhvien)))
													
SELECT sv.*
FROM Sinhvien sv, Sinhvien_Detai svdt
WHERE sv.masv = svdt.masv
	  AND svdt.madt IN (SELECT madt
                           FROM Detai
                           WHERE kinhphi > (SELECT 0.2 * SUM(kinhphi)
                                      FROM Detai)
                          )
						  
SELECT * 
FROM Sinhvien 
WHERE hocluc > (SELECT AVG(ketqua) 
               FROM Sinhvien_Detai 
               WHERE madt = 'DT001' 
               GROUP BY madt)