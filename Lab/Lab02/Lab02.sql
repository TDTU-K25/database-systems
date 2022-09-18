CREATE DATABASE TH_CSDL_Session2
GO
USE TH_CSDL_Session2

CREATE TABLE SinhVien (
	masv char(10),
	hoten nvarchar(30) NOT NULL,
	namsinh int,
	qq nvarchar(30)
)
ALTER TABLE SinhVien ADD hocluc float
ALTER TABLE SinhVien ALTER COLUMN masv char(10) NOT NULL
ALTER TABLE SinhVien ADD CONSTRAINT PK_SinhVien PRIMARY KEY(masv)
--ALTER TABLE SinhVien DROP CONSTRAINT PK_SinhVien
--ALTER TABLE SinhVien DROP COLUMN namsinh
--sp_help SinhVien
--DROP TABLE SinhVien

CREATE TABLE DeTai (
	madt char(10),
	tendt nvarchar(30) NOT NULL,
	chunhiem nvarchar(30),
	kinhphi bigint,
	PRIMARY KEY(madt)
)
--sp_help DeTai
--DROP TABLE DeTai

CREATE TABLE SV_DT (
	masv char(10) NOT NULL,
	madt char(10) NOT NULL,
	noiAD nvarchar(30),
	kq float
)
ALTER TABLE SV_DT ADD CONSTRAINT PK_SV_DT PRIMARY KEY(masv, madt)
ALTER TABLE SV_DT ADD CONSTRAINT FK_SV_DT_masv_SinhVien FOREIGN KEY(masv) REFERENCES SinhVien(masv)
ALTER TABLE SV_DT ADD CONSTRAINT FK_SV_DT_madt_DeTai FOREIGN KEY(madt) REFERENCES DeTai(madt)
--sp_help SV_DT
--DROP TABLE SV_DT

INSERT INTO SinhVien VALUES
('SV001', N'Nguyễn Văn A', 2002, N'Hải Phòng', 8),
('SV002', N'Lê Thị B', 1999, N'Quy Nhơn', 7),
('SV003', N'Đào Văn C', 2005, N'Quảng Ninh', 5)

INSERT INTO DeTai VALUES
('DT001', N'Web bán quần áo', N'Đinh Văn D', 3000000),
('DT002', N'Web tin tức', N'Doãn Văn T', 2000000),
('DT003', N'Web đăng ký môn học', N'Võ Thị V', 7000000)

INSERT INTO SV_DT VALUES 
('SV001', 'DT001', 'TP.HCM', 8.3),
('SV002', 'DT002', 'HN', 7.5),
('SV003', 'DT003', 'AG', 9.2)

SELECT * FROM SinhVien
SELECT * FROM DeTai
SELECT * FROM SV_DT

UPDATE SinhVien 
SET hoten = N'Nguyễn Văn C'
WHERE masv = 'SV001'

DELETE FROM SV_DT 
WHERE masv = 'SV002'

-- Exercise 1

-- Câu 1
CREATE DATABASE QLSV 
GO
USE QLSV

CREATE TABLE Khoa (
	MaKhoa char(10) NOT NULL,
	TenKhoa nvarchar(30) NOT NULL,
	primary key(MaKhoa)
)

CREATE TABLE SinhVien (
	Ho nvarchar(30) NOT NULL,
	Ten nvarchar(10) NOT NULL,
	Ma char(10),
	NgaySinh date,
	Phai nchar(4),
	MaKhoa char(10)
)
ALTER TABLE SinhVien ALTER COLUMN Ma char(10) NOT NULL
ALTER TABLE SinhVien ADD CONSTRAINT PK_SinhVien PRIMARY KEY(Ma)
ALTER TABLE SinhVien ADD CONSTRAINT PK_SinhVien_MaKhoa_Khoa FOREIGN KEY(MaKhoa) REFERENCES Khoa(MaKhoa)

CREATE TABLE MonHoc (
	TenMH nvarchar(30) NOT NULL,
	MaMH char(10) not null,
	SoTiet int,
	primary key(MaMH)
)

CREATE TABLE KetQua (
  MaSV char(10) NOT NULL,
  MaMH char(10) NOT NULL,
  LanThi int,
  Diem float,
  PRIMARY KEY(MaSV, MaMH, LanThi)
)
ALTER TABLE KetQua ADD CONSTRAINT FK_KetQua_MaSV_SinhVien FOREIGN KEY (MaSV) REFERENCES SinhVien(Ma)
ALTER TABLE KetQua ADD CONSTRAINT FK_KetQua_MaMH_MonHoc FOREIGN KEY (MaMH) REFERENCES MonHoc(MaMH)

-- Câu 2
ALTER TABLE KetQua DROP CONSTRAINT FK_KetQua_MaSV_SinhVien
ALTER TABLE KetQua DROP CONSTRAINT FK_KetQua_MaMH_MonHoc

-- Câu 3
ALTER TABLE SinhVien DROP CONSTRAINT PK_SinhVien_MaKhoa_Khoa
DROP TABLE Khoa
DROP TABLE Monhoc

-- Câu 4
CREATE TABLE Khoa (
	MaKhoa char(10) NOT NULL,
	TenKhoa nvarchar(30) NOT NULL,
	primary key(MaKhoa)
)

CREATE TABLE MonHoc (
	TenMH nvarchar(30) NOT NULL,
	MaMH char(10) not null,
	SoTiet int,
	primary key(MaMH)
)

ALTER TABLE SinhVien ADD CONSTRAINT PK_SinhVien_MaKhoa_Khoa FOREIGN KEY(MaKhoa) REFERENCES Khoa(MaKhoa)
ALTER TABLE KetQua ADD CONSTRAINT FK_KetQua_MaSV_SinhVien FOREIGN KEY (MaSV) REFERENCES SinhVien(Ma)
ALTER TABLE KetQua ADD CONSTRAINT FK_KetQua_MaMH_MonHoc FOREIGN KEY (MaMH) REFERENCES MonHoc(MaMH)

-- Câu 5
INSERT INTO Khoa VALUES('AVAN', 'Khoa Anh Van')
INSERT INTO Khoa VALUES('CNTT', 'Cong Nghe Thong Tin')
INSERT INTO Khoa VALUES('DTVT', 'Dien Tu Vien Thong')
INSERT INTO Khoa VALUES('QTKD', 'Quan Tri Kinh Doanh')


INSERT INTO SinhVien VALUES
('Tran Minh', 'Son', 'S001', '1985-1-5', 'Nam', 'CNTT'),
('Nguyen Quoc', 'Bao', 'S002', '1985-6-15', 'Nam', 'CNTT'),
('Phan Anh', 'Tung', 'S003', '1983-12-20', 'Nam', 'QTKD'),
('Bui Thi Anh', 'Thu', 'S004', '1985-2-1', 'Nu', 'QTKD'),
('Le Thi Lan', 'Anh', 'S005', '1987-7-3', 'Nu', 'DTVT'),
('Nguyen Thi', 'Lam', 'S006', '1984-11-25', 'Nu', 'DTVT'),
('Phan Thi', 'Ha', 'S007', '1988-3-7', 'Nu', 'CNTT'),
('Tran The', 'Dung', 'S008', '1985-10-21', 'Nam', 'CNTT')

INSERT INTO MonHoc VALUES('Anh Van', 'AV', 45)
INSERT INTO MonHoc VALUES('Co So Du Lieu', 'CSDL', 45)
INSERT INTO MonHoc VALUES('Ky Thuat Lap Trinh', 'KTLT', 60)
INSERT INTO MonHoc VALUES('Ke Toan Tai Chinh', 'KTTC', 45)
INSERT INTO MonHoc VALUES('Toan Cao Cap', 'TCC', 60)
INSERT INTO MonHoc VALUES('Tin Hoc Van Phong', 'THVP', 30)
INSERT INTO MonHoc VALUES('Tri Tue Nhan Tao', 'TTNT', 45)

INSERT INTO KetQua VALUES('S001', 'CSDL', 1, 4)
INSERT INTO KetQua VALUES('S001', 'TCC', 1, 6)
INSERT INTO KetQua VALUES('S002', 'CSDL', 1, 3)
INSERT INTO KetQua VALUES('S002', 'CSDL', 2, 6)
INSERT INTO KetQua VALUES('S003', 'KTTC', 1, 5)
INSERT INTO KetQua VALUES('S004', 'AV', 1, 8)
INSERT INTO KetQua VALUES('S004', 'THVP', 1, 4)
INSERT INTO KetQua VALUES('S004', 'THVP', 2, 8)
INSERT INTO KetQua VALUES('S006', 'TCC', 1, 5)
INSERT INTO KetQua VALUES('S007', 'AV', 1, 2)
INSERT INTO KetQua VALUES('S007', 'AV', 2, 9)
INSERT INTO KETQUA VALUES('S007', 'KTLT', 1, 6)
INSERT INTO KetQua VALUES('S008', 'AV', 1, 7)

-- Câu 6
UPDATE MonHoc 
SET SoTiet = 30 
WHERE TenMH ='Tri Tue Nhan Tao'

-- Câu 7
DELETE FROM KetQua where MaSV = 'S001' 

-- Câu 8
INSERT INTO KetQua VALUES ('S001','CSDL', 1, 4)
INSERT INTO KetQua VALUES ('S001','TCC', 1, 6)

-- Câu 9
UPDATE SinhVien 
SET Ho = 'Nguyen Van',
	Phai = 'Nam'
WHERE Ho + ' ' + Ten = 'Nguyen Thi Lam'

-- Câu 10
UPDATE SinhVien 
SET MaKhoa = 'CNTT'
WHERE Ho + ' ' + Ten = 'Le Thi Lan Anh'

-- Exercise 2
CREATE DATABASE QLBH
GO
USE QLBH

-- Câu 1
CREATE TABLE KhachHang (
	MaKhachHang char(10) NOT NULL,
	TenCongTy nvarchar(30) NOT NULL,
	TenGiaoDich nvarchar(30),
	DiaChi nvarchar(50),
	Email varchar(30),
	DienThoai char(11),
	Fax char(11),
	PRIMARY KEY(MaKhachHang)
)

CREATE TABLE NhanVien (
	MaNhanVien char(10) NOT NULL,
	Ho nvarchar(30) NOT NULL,
	Ten nvarchar(10) NOT NULL,
	NgaySinh date,
	NgayLamViec date,
	DiaChi nvarchar(50),
	DienThoai char(11),
	LuongCoBan bigint,
	PhuCap bigint,
	PRIMARY KEY(MaNhanVien)
)

CREATE TABLE NhaCungCap (
	MaCongTy char(10) NOT NULL,
	TenCongTy nvarchar(30) NOT NULL,
	TenGiaoDich nvarchar(30),
	DiaChi nvarchar(50),
	DienThoai char(11),
	Fax char(11),
	Email varchar(30),
	PRIMARY KEY(MaCongTy)
)

CREATE TABLE LoaiHang (
	MaLoaiHang char(10) NOT NULL,
	TenLoaiHang nvarchar(30) NOT NULL,
	PRIMARY KEY(MaLoaiHang)
)

CREATE TABLE MatHang (
	MaHang char(10) NOT NULL,
	TenHang nvarchar(30) NOT NULL,
	MaCongTy char(10) NOT NULL,
	MaLoaiHang char(10) NOT NULL,
	SoLuong int,
	DonViTinh varchar(10),
	GiaHang bigint,
	PRIMARY KEY(MaHang),
	FOREIGN KEY(MaCongTy) REFERENCES NhaCungCap(MaCongTy),
	FOREIGN KEY(MaLoaiHang) REFERENCES LoaiHang(MaLoaiHang)
)

CREATE TABLE DonDatHang (
	SoHoaDon char(10) NOT NULL,
	MaKhachHang char(10) NOT NULL,
	MaNhanVien char(10) NOT NULL,
	NgayDatHang date NOT NULL,
	NgayGiaoHang date NOT NULL,
	NgayChuyenHang date NOT NULL,
	NoiGiaoHang nvarchar(30) NOT NULL,
	PRIMARY KEY(SoHoaDon),
	FOREIGN KEY(MaKhachHang) REFERENCES KhachHang(MaKhachHang),
	FOREIGN KEY(MaNhanVien) REFERENCES NhanVien(MaNhanVien)
)

CREATE TABLE ChiTietDatHang (
	SoHoaDon char(10) NOT NULL,
	MaHang char(10) NOT NULL,
	GiaBan bigint,
	SoLuong int,
	MucGiamGia float,
	PRIMARY KEY(SoHoaDon, MaHang),
	FOREIGN KEY(MaHang) REFERENCES MatHang(MaHang),
	FOREIGN KEY(SoHoaDon) REFERENCES DonDatHang(SoHoaDon)
)

-- Câu 2
ALTER TABLE ChiTietDatHang ADD CONSTRAINT DF_SoLuong DEFAULT 1 FOR SoLuong
ALTER TABLE ChiTietDatHang ADD CONSTRAINT DF_MucGiamGia DEFAULT 0 FOR MucGiamGia

INSERT INTO NhaCungCap VALUES
('CT001', 'FTP', NULL, 'DN', '092x', '038', 'ftp@gmail.com')

INSERT INTO LoaiHang VALUES
('LH001', N'Linh kiện máy tính')

INSERT INTO MatHang VALUES
('MH001', N'CPU', 'CT001', 'LH001', 10, N'cái', 5000000)

INSERT INTO KhachHang VALUES 
('KH001', 'ABC', NULL, 'HN', 'ABC@gmail.com', '077x', '032')

INSERT INTO NhanVien VALUES 
('NV001', N'Nguyễn Văn', N'A', '2001-05-10', GETDATE(), N'TP.HCM', '090x', 7000000, 500000)

INSERT INTO DonDatHang VALUES
('HD001', 'KH001', 'NV001', GETDATE(), '2022-09-25', '2022-09-24', N'Quy Nhơn')

INSERT INTO ChiTietDatHang (SoHoaDon, MaHang, GiaBan) VALUES
('HD001', 'MH001', 5000000)

-- Câu 3
ALTER TABLE DonDatHang ADD CHECK (NgayGiaoHang >= NgayDatHang AND NgayChuyenHang >= NgayDatHang)

--INSERT INTO DonDatHang VALUES
--('HD001', 'KH001', 'NV001', '2022-05-03', '2022-05-01', '2022-05-01', N'Quy Nhơn')
-- Lỗi vì ngày giao hàng và ngày chuyển hàng trước ngày đặt hàng

-- Câu 4
ALTER TABLE NhanVien ADD CHECK (YEAR(GETDATE()) - YEAR(NgaySinh) BETWEEN 18 AND 60)

--INSERT INTO NhanVien VALUES 
--('NV002', N'Lê Thị', N'B', '1930-03-17', GETDATE(), N'HP', '093x', 5000000, 300000)
-- Lỗi vì tuổi là 92 lớn hơn 60 

-- Câu 5
-- Câu lệnh DROP TABLE NhaCungCap không thực hiện được
-- vì bảng MatHang có khóa ngoại tham chiếu đến bảng NhaCungCap