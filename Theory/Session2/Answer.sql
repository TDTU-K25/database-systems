CREATE DATABASE IntershipManagement
USE InternshipManagement

CREATE TABLE Student (
	ID char(8),
  	fullName nvarchar(30),
  	country nvarchar(30),
  	yob date,
  	score float
)

ALTER TABLE Student ALTER COLUMN ID CHAR(8) NOT NULL
ALTER TABLE Student ADD CONSTRAINT PK_StudentID PRIMARY KEY (ID)

INSERT INTO Student VALUES
('SV01', N'Trần Thanh Trâm', N'Sài Gòn', '1998/03/23', 8.5),
('SV02', N'Nguyễn Hồng Linh', N'Thanh Hóa', '2000/01/20', 9.0),
('SV03', N'Trần Thanh Phước', N'Tiền Giang', '2001/07/12', 7.5),
('SV04', N'Nguyễn Minh Hải', N'Nghệ An', '1993/02/28', 7.0),
('SV05', N'Trần Thị Hồng Nhung', N'Kiên Giang', '1998/07/15' ,9.0)

CREATE TABLE Project (
 	ID char(8),
  	name nvarchar(30),
  	formTeacher nvarchar(30),
  	cost bigint
)

ALTER TABLE Project ALTER COLUMN ID char(8) NOT NULL
ALTER TABLE Project ADD CONSTRAINT PK_ProjectID PRIMARY KEY(ID)

INSERT INTO Project VALUES
('DT01', N'Quản lý quán ăn', N'Nguyễn Thễ Hữu', 100000000),
('DT02', N'Quản lý khách sạn', N'Trần Trung Hiếu', 200000000),
('DT03', N'Quản lý sân bóng đá mini', N'Nguyễn Công Tâm', 300000000),
('DT04', N'Quản lý shop hoa tươi', N'Đặng Đức Trung', 150000000),
('DT05', N'Quản lý cửa hàng điện thoại', N'Trịnh Thanh Duy', 2000000000)

CREATE TABLE Student_Project (
 	studentID char(8),
  	projectID char(8),
  	internPlace nvarchar(30),
  	distance int,
  	result float
)

ALTER TABLE Student_Project ALTER COLUMN studentID CHAR(8) NOT NULL
ALTER TABLE Student_Project ALTER COLUMN projectid CHAR(8) NOT NULL
ALTER TABLE Student_Project ADD CONSTRAINT PK_Student_Project PRIMARY KEY (studentid, projectid)
ALTER TABLE Student_Project ADD CONSTRAINT FK_StudentID FOREIGN KEY (studentid) REFERENCES Student(ID)
ALTER TABLE Student_Project ADD CONSTRAINT FK_ProjectID FOREIGN KEY (projectid) REFERENCES Project(ID)

INSERT INTO Student_Project VALUES 
('SV01', 'DT01', N'Tiền Giang', 70, 8.0),
('SV02', 'DT01', N'Bình Dương', 50, 7.0),
('SV03', 'DT02', N'Vũng Tàu', 150, 9.5),
('SV03', 'DT03', N'Long An', 50, 8.5),
('SV04', 'DT03', N'Nha Trang', 500, 10)

------------------------------------------------------------------------------------------------------
-- Câu 2 Cập nhật dữ liệu

-- a. Thay đổi ngày sinh thành “15/09/2000” cho sinh viên có mã số là “SV01”
UPDATE Student
SET yob = '2000/09/15'
WHERE ID = 'SV01'

-- b. Thay đổi quê quán của sinh viên “Nguyễn Hồng Linh” là “Bạc Liêu”
UPDATE Student
SET country = N'Bạc Liêu'
WHERE fullname = N'Nguyễn Hồng Linh'

-- c. Cộng 0.5 điểm thực tập cho sinh viên quê ở “Nghệ An”. (ĐIều kiện dùng In)
UPDATE Student_Project
SET result += 0.5
WHERE studentID IN (SELECT ID FROM Student WHERE country = N'Nghệ An')

-- d. Cộng 1.0 điểm thực tập cho sinh viên có mã số “SV03” và có mã số đề tài là
-- “DT02”. Tuy nhiên, nếu cộng điểm vượt quá 10 thì chỉ lấy 10 điểm mà thôi.
UPDATE Student_Project
SET result = CASE WHEN result + 1 > 10 THEN 10 ELSE result + 1 END
WHERE studentid = 'SV03' AND projectid = 'DT02'

----------------------------------------------------------------------------------------------
-- 3. Thay đổi cấu trúc bảng

-- a. Bổ sung cột số điện thoại kiểu varchar vào bảng Sinh viên, cột này phải là
-- unique
ALTER TABLE Student ADD phone varchar(11) 
ALTER TABLE Student ADD CONSTRAINT UQ_StudentPhone UNIQUE (phone) -- Không add được constraint
																  -- vì cột mới thêm vào chứ chưa đưa data vào cột này
                                                                  -- nên toàn NULL (để trống) => duplicate
-- b. Bổ sung cột giới tính cho bảng sinh viên
ALTER TABLE Student ADD gender nvarchar(5) 

-- c. Bổ sung ràng buộc giới tính là “Nam” hoặc “Nữ”, mặc định là Nam
ALTER TABLE Student ADD CONSTRAINT CK_StudentGender CHECK (gender IN('Nam', N'Nữ'))
ALTER TABLE Student ADD CONSTRAINT DF_StudentGender DEFAULT 'Nam' FOR gender 