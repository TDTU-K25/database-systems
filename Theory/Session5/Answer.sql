CREATE DATABASE IntershipManagement
GO
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
-- 1. Cho biết kết quả thực tập của những sinh viên quê ở TPHCM

-- Cách 1: SubQuery
SELECT result
FROM Student_Project
WHERE studentid IN (SELECT id 
                    FROM Student
                    WHERE country = N'TPHCM')
                    
-- Cách 2: Join
SELECT result
FROM Student_Project
	INNER JOIN Student
    ON Student.id = Student_Project.studentid
WHERE country = N'TPHCM'

-- 2. Thông tin về đề tài có KP > 1 triệu đồng
SELECT *
FROM Project
WHERE cost > 1000000

-- 3. Danh sách các chủ nhiệm đề tài có sinh viên quê ở TPHCM tham gia
SELECT Project.formTeacher
FROM Student, Project, Student_Project
WHERE Student.id = Student_Project.studentid 
	  AND Project.id = Student_Project.projectid
      AND Student.country = N'TPHCM'
      
SELECT p.formteacher
FROM Student_Project sp
	 INNER JOIN Student s
     ON s.id = sp.studentid
     INNER JOIN Project p
     ON p.id = sp.projectid
WHERE s.country = N'TPHCM'
      
-- 4. Cho biết các địa điểm thực tập xa trường (KM > 100) của đề tài số 01
SELECT internplace
FROM Student_Project
WHERE distance > 100 AND projectid = 'DT001'

-- 5. Cho biết thông tin về đề tài có sinh viên thực tập
SELECT DISTINCT p.*
FROM Project p
	 INNER JOIN Student_Project sp
     ON p.id = sp.projectid
     
-- 6. Danh sách các sinh vien thực tập theo đề tài có kinh phí &gt; 1/5 tổng kinh phí cho các đề tài
SELECT s.*
FROM Student s, Student_Project sp
WHERE s.id = sp.studentid
	  AND sp.projectid IN (SELECT id
                           FROM Project
                           WHERE cost > (SELECT 0.2 * SUM(cost)
                                      FROM Project)
                          )

-- 7. Cho biết những sinh viên có học lực và kết quả thực tập đều >= 8
SELECT s.*
FROM Student s
	 INNER JOIN Student_Project sp
     ON s.id = sp.studentid
WHERE s.score >= 8 AND sp.result >= 8

-- 8. Cho biết những sinh viên chưa đi thực tập

-- Cách 1: SubQuery
SELECT * 
FROM Student
WHERE id NOT IN (SELECT DISTINCT studentid
                 FROM Student_Project)
                 
-- Cách 2: Join
SELECT s.*
FROM Student s
	 LEFT JOIN Student_Project sp
     ON s.id = sp.studentid
     WHERE sp.studentid IS NULL
-- 9. Cho biết những đề tài không có sinh viên nào chọn
SELECT P.*
FROM Student_Project sp 
	 RIGHT JOIN Project p
     ON p.id = sp.projectid
WHERE sp.projectid IS NULL
