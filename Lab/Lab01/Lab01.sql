CREATE DATABASE QLSV
GO
USE QLSV

CREATE TABLE Khoa (
	MaSo char(10) NOT NULL,
	Ten nvarchar(30) NOT NULL,
	NamThanhLap int,
	PRIMARY KEY(MaSo)
)

CREATE TABLE SinhVien (
	Tensv nvarchar(30) NOT NULL,
	Masv char(10) NOT NULL,
	NamHoc tinyint CHECK (NamHoc >= 1 AND NamHoc <= 4),
	MaKhoa char(10),
	PRIMARY KEY(Masv),
	FOREIGN KEY(MaKhoa) REFERENCES Khoa(MaSo)
)

CREATE TABLE MonHoc (
	Tenmh nvarchar(30) NOT NULL,
	Mamh char(10) NOT NULL,
	TinChi tinyint NOT NULL,
	MaKhoa char(10),
	PRIMARY KEY(Mamh),
	FOREIGN KEY(Makhoa) REFERENCES Khoa(MaSo)
)

CREATE TABLE DieuKien (
	Mamh char(10) NOT NULL,
	Mamh_Truoc char(10) NOT NULL,
	PRIMARY KEY(Mamh, Mamh_Truoc),
	FOREIGN KEY(Mamh) REFERENCES MonHoc(Mamh),
	FOREIGN KEY(Mamh_Truoc) REFERENCES MonHoc(Mamh)
)

CREATE TABLE HocPhan (
	Mahp char(10) NOT NULL,
	Mamh char(10) NOT NULL,
	HocKy varchar(10),
	Nam int,
	GiaoVien nvarchar(30),
	PRIMARY KEY(Mahp),
	FOREIGN KEY(Mamh) REFERENCES MonHoc(Mamh)
)

CREATE TABLE KetQua (
	Masv char(10) NOT NULL,
	Mahp char(10) NOT NULL,
	Diem float CHECK (Diem >= 0 AND Diem <= 10),
	PRIMARY KEY(Masv, Mahp),
	FOREIGN KEY(Masv) REFERENCES SinhVien(Masv),
	FOREIGN KEY(Mahp) REFERENCES HocPhan(Mahp)
)