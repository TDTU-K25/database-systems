-- Tạo các bảng

CREATE TABLE Khoa
(
  MaKhoa CHAR(10) NOT NULL,
  Ten NVARCHAR(30) NOT NULL,
  Email VARCHAR(50) NOT NULL,
  SDT CHAR(10) NOT NULL,
  PRIMARY KEY (MaKhoa)
);

CREATE TABLE Nganh
(
  MaNganh CHAR(10) NOT NULL,
  Ten NVARCHAR(30) NOT NULL,
  MaKhoa CHAR(10) NOT NULL,
  PRIMARY KEY (MaNganh),
  FOREIGN KEY (MaKhoa) REFERENCES Khoa(MaKhoa)
);

CREATE TABLE GiangVien
(
  MaGV CHAR(10) NOT NULL,
  HoTen NVARCHAR(50) NOT NULL,
  SDT CHAR(10) NOT NULL,
  HocVi NVARCHAR(10) NOT NULL,
  MaKhoa CHAR(10) NOT NULL,
  PRIMARY KEY (MaGV),
  FOREIGN KEY (MaKhoa) REFERENCES Khoa(MaKhoa)
);

CREATE TABLE GiangVienThinhGiang
(
  MaGV CHAR(10) NOT NULL,
  ThoiGianThinhGiang DATE NOT NULL,
  PRIMARY KEY (MaGV),
  FOREIGN KEY (MaGV) REFERENCES GiangVien(MaGV)
);

CREATE TABLE SinhVien
(
  MaSV CHAR(10) NOT NULL,
  HoTen NVARCHAR(50) NOT NULL,
  NgaySinh DATE NOT NULL,
  SDT CHAR(10) NOT NULL,
  MaNganh CHAR(10) NOT NULL,
  PRIMARY KEY (MaSV),
  FOREIGN KEY (MaNganh) REFERENCES Nganh(MaNganh)
);

CREATE TABLE TaiKhoanThongTinSinhVien
(
  MaSV CHAR(10) NOT NULL,
  MatKhau VARCHAR(50) NOT NULL,
  PRIMARY KEY (MaSV),
  FOREIGN KEY (MaSV) REFERENCES SinhVien(MaSV)
);

CREATE TABLE NguoiThan
(
  HoTen NVARCHAR(50) NOT NULL,
  QuanHe NVARCHAR(10) NOT NULL,
  SDT CHAR(10) NOT NULL,
  MaSV CHAR(10) NOT NULL,
  PRIMARY KEY (HoTen, MaSV),
  FOREIGN KEY (MaSV) REFERENCES SinhVien(MaSV)
);

CREATE TABLE MonHoc
(
  MaMH CHAR(10) NOT NULL,
  Ten NVARCHAR(50) NOT NULL,
  TinChi INT NOT NULL,
  MaNganh CHAR(10) NOT NULL,
  PRIMARY KEY (MaMH),
  FOREIGN KEY (MaNganh) REFERENCES Nganh(MaNganh)
);

CREATE TABLE DangKy
(
  ThoiGianDangKy DATE NOT NULL,
  MaSV CHAR(10) NOT NULL,
  MaMH CHAR(10) NOT NULL,
  PRIMARY KEY (MaSV, MaMH),
  FOREIGN KEY (MaSV) REFERENCES SinhVien(MaSV),
  FOREIGN KEY (MaMH) REFERENCES MonHoc(MaMH)
);


-- Function

-- Function tạo mã sinh viên tự động

CREATE FUNCTION generateMaSV() 
RETURNS CHAR(10)
AS
BEGIN
	IF (SELECT TOP 1 MaSV FROM SinhVien) IS NULL
		RETURN 'SV00001'

	DECLARE @STT INT

	-- Vì kiểu dữ liệu trả về là CHAR(10) nhưng MaSV chỉ có 7 kí tự nên sẽ còn 3 kí tự khoảng trắng ở cuối 
	-- Vì vậy ta sẽ lấy 8 kí tự từ bên phải sang
	SELECT TOP 1 @STT = CONVERT(INT, RIGHT(MaSV, 8)) FROM SinhVien ORDER BY MaSV DESC

	SET @STT += 1

	DECLARE @MaSV VARCHAR(10)
	SET @MaSV = 'SV'

	DECLARE @i INT
	SET @i = LEN(CONVERT(VARCHAR(5), @STT))

	WHILE @i < 5 
		BEGIN
			SET @MaSV += '0'
			SET @i += 1
		END

	SET @MaSV += CONVERT(VARCHAR(5), @STT)

	RETURN RTRIM(@MaSV)
END

CREATE PROC insertSinhVien @HoTen NVARCHAR(50), @NgaySinh DATE, @SDT CHAR(10), @MaNganh CHAR(10)
AS
BEGIN
	INSERT INTO SinhVien VALUES
	(dbo.generateMaSV(), @HoTen, @NgaySinh, @SDT, @MaNganh)
END


-- Function tạo mã giảng viên tự động

CREATE FUNCTION generateMaGV() 
RETURNS CHAR(10)
AS
BEGIN
	IF (SELECT TOP 1 MaGV FROM GiangVien) IS NULL
		RETURN 'GV0001'

	DECLARE @STT INT

	-- Vì kiểu dữ liệu trả về là CHAR(10) nhưng MaGV chỉ có 6 kí tự nên sẽ còn 4 kí tự khoảng trắng ở cuối 
	-- Vì vậy ta sẽ lấy 8 kí tự từ bên phải sang
	SELECT TOP 1 @STT = CONVERT(INT, RIGHT(MaGV, 8)) FROM GiangVien ORDER BY MaGV DESC

	SET @STT += 1

	DECLARE @MaGV VARCHAR(10)
	SET @MaGV = 'GV'

	DECLARE @i INT
	SET @i = LEN(CONVERT(VARCHAR(5), @STT))

	WHILE @i < 4
		BEGIN
			SET @MaGV += '0'
			SET @i += 1
		END
	
	SET @MaGV += CONVERT(VARCHAR(5), @STT)

	RETURN RTRIM(@MaGV)
END

CREATE PROC insertGiangVien @HoTen NVARCHAR(50), @SDT CHAR(10), @HocVi NVARCHAR(10), @MaKhoa CHAR(10)
AS
BEGIN
	INSERT INTO GiangVien VALUES
	(dbo.generateMaGV(), @HoTen, @SDT, @HocVi, @MaKhoa)
END


-- Trigger

CREATE TRIGGER trigger_ThemTaiKhoanThongTinSinhVien ON TaiKhoanThongTinSinhVien
AFTER INSERT
AS
BEGIN
	DECLARE @MaSV CHAR(10)
	DECLARE @MatKhau VARCHAR(50)
	SELECT @MaSV = MaSV, @MatKhau = MatKhau FROM inserted
	
	IF (@MaSV is NULL OR EXISTS (select @MaSV from SINHVIEN where MaSV = @MaSV)) -- kiểm tra ràng buộc khoá ngoại
		BEGIN
			IF ((SELECT COUNT(MaSV) FROM TaiKhoanThongTinSinhVien WHERE MaSV = @MaSV) = 2) -- kiểm tra tài khoản đã tồn tại hay chưa
				BEGIN
					PRINT(N'Sinh viên đã có tài khoản')
					ROLLBACK TRAN
				END
			-- Kiểm tra mật khẩu
			IF (@MatKhau IS NULL) 
				BEGIN
					PRINT(N'Mật khẩu không được để trống')
					ROLLBACK TRAN
				END
			IF (LEN(@MatKhau) < 8)
				BEGIN
					PRINT(N'Mật khẩu phải có nhiều hơn 8 ký tự')
					ROLLBACK TRAN
				END
		END
	ELSE
		BEGIN
			PRINT(N'Mã sinh viên không tồn tại')
			ROLLBACK TRAN
		END
END


-- Thêm dữ liệu vào các bảng

INSERT INTO KHOA VALUES
('DDT', N'Điện – Điện tử', 'khoadien@tdtu.edu.vn', '2837755028'),
('CNTT', N'Công nghệ thông tin', 'khoait@tdtu.edu.vn', '2837755046')

INSERT INTO NGANH VALUES
('KHMT', N'Khoa học máy tính', 'CNTT'),
('KTPM', N'Kĩ thuật phần mềm', 'CNTT'),
('DTVT', N'Kỹ thuật điện tử-viễn thông', 'DDT')

EXEC insertSinhVien N'Nguyễn Tú Anh', '2003-02-14', '0932105220', 'KHMT'
EXEC insertSinhVien N'Lê Thị Anh Thư', '2003-12-25', '0932101920', 'KHMT'
EXEC insertSinhVien N'Cao Đăng Huy', '2003-03-20', '0932112320', 'KTPM'

EXEC insertGiangVien N'Lê Văn Đại', '0903921220', N'Thạc sĩ', 'CNTT'
EXEC insertGiangVien N'Trương Văn Nhân', '0903923214', N'Giáo sư', 'DDT'
EXEC insertGiangVien N'Võ Thành Đạt', '0901395921', N'Tiến sĩ', 'DDT'

INSERT INTO GiangVienThinhGiang VALUES
('GV0001', '2023-12-31')

INSERT INTO TaiKhoanThongTinSinhVien VALUES
('SV00001', 'IYuNEBmNfgY3aHh3')

INSERT INTO NguoiThan VALUES
(N'Cao Văn Sơn', 'Cha', '0903125921', 'SV00001')

INSERT INTO MonHoc VALUES
('503077', N'Học sâu', 3, 'KHMT'),
('504077', N'Mẫu thiết kế', 3, 'KTPM')

INSERT INTO DangKy VALUES
(GETDATE(), 'SV00001', '503077'),
(GETDATE(), 'SV00001', '504077')