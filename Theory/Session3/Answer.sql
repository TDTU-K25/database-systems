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
-- 1. Cho biết sinh viên quê ở Long An
SELECT * 
FROM Student 
WHERE country = N'Long An'

-- 2. Cho biết những đề tài có sinh viên đăng ký
SELECT * 
FROM Project 
WHERE id IN (SELECT DISTINCT projectid 
             FROM Student_Project)

-- 3. Cho biết những sinh viên có họ là “Nguyễn”
SELECT * 
FROM Student 
WHERE fullname LIKE N'Nguyễn%'

-- 4. Cho biết họ tên những sinh viên có họ lót là “Thanh”.
SELECT fullname AS 'Họ tên' 
FROM Student 
WHERE fullname LIKE N'%Thanh%'

-- 5. cho biết sv < 20 tuổi và có HL > 8.5
SELECT * 
FROM Student 
WHERE YEAR(GETDATE()) - YEAR(yob) < 20 
	  AND score > 8.5

-- 6. Danh sách sinh viên < 20 tuổi, học lực và thực tập > 8
SELECT * 
FROM Student_Project 
WHERE studentid IN (SELECT id 
                    FROM Student 
                    WHERE YEAR(GETDATE()) - YEAR(yob) > 20 
                    	  AND score > 8)
	  AND result > 8

-- 7. Danh sách các sinh viên học giỏi hơn sinh viên ở TPHCM
SELECT * 
FROM Student 
WHERE score > ANY(SELECT score 
                  FROM Student 
                  WHERE country = 'TPHCM')

-- 8. Cho thông tin về sinh viên sinh trước năm 1980 và quê ở Hải Phòng
SELECT * 
from Student 
WHERE YEAR(yob) < 1980 
	  AND country = N'Hải Phòng'

-- 9. Cho danh sách các tỉnh có sinh viên đến thực tập
SELECT DISTINCT internplace 
FROM Student_Project

-- 10. Thông tin về việc thực tập tại Long An
SELECT * 
FROM Student_Project 
WHERE internplace = N'Long An'

-- 11. Cho biết danh sách các sinh viên thực tập tại quê nhà
SELECT * 
FROM Student 
WHERE country IN (SELECT DISTINCT internplace 
                  FROM Student_Project)

-- 12. Các đề tài không có sinh viên nào tham gia
SELECT * 
FROM Project 
WHERE id NOT IN (SELECT DISTINCT projectid 
                 FROM Student_Project)

-- 13. Danh sách các đề tài có sinh viên học giỏi nhất lớp tham gia
SELECT * 
FROM Student_Project 
WHERE studentid IN (SELECT id 
                    FROM Student 
                    WHERE score = (SELECT MAX(score) 
                                   FROM Student))


-- 14. Điểm trung bình của sinh viên quê ở Hà Nội
SELECT id, AVG(score) AS N'Điểm trung bình' 
FROM Student 
WHERE country = N'Hà Nội' 
GROUP BY id

-- 15. Các đề tài từ 2 sinh viên trở lên đăng ký tham gia.
SELECT projectid, COUNT(projectid) 
FROM Student_Project 
GROUP BY projectid 
HAVING COUNT(projectid) >= 2

-- 16. Danh sách các đề tài không có sinh viên học kém nhất lớp tham gia
SELECT * 
from Project 
WHERE id NOT IN (SELECT projectid 
                 FROM Student_Project 
                 WHERE studentid IN (SELECT id 
                                     FROM Student 
                                     WHERE score = (SELECT MIN(score) 
                                                    FROM Student))
)

-- 17. Danh sách các sinh viên có điểm học tập cao hơn điểm thực tập trung bình của đề
-- tài có mã số là 1
SELECT * 
FROM Student 
WHERE score > (SELECT AVG(result) 
               FROM Student_Project 
               WHERE projectid = 'DT01' 
               GROUP BY projectid)
