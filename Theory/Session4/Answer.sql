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
-- 1. Cho biết danh sách các sinh viên thực tập tại quê nhà
SELECT 
  * 
FROM 
  Student s 
  INNER JOIN Student_Project sp On s.ID = sp.studentID 
WHERE 
  s.country = sp.internPlace

-- 2. Các đề tài không có sinh viên nào tham gia
-- Cách 1
SELECT * 
FROM Project 
WHERE id NOT IN (SELECT DISTINCT projectid 
                 FROM Student_Project)

-- Cách 2                 
SELECT 
  p.* 
FROM 
  Project p 
  LEFT JOIN Student_Project sp on p.id = sp.projectID 
WHERE 
  sp.projectid IS NULL

-- 3. Danh sách các đề tài có sinh viên học giỏi nhất lớp tham gia
SELECT * 
FROM Project 
WHERE id IN (SELECT projectid
             FROM Student_Project
             WHERE studentID IN (
                    SELECT id
                    FROM Student 
                    WHERE score = (SELECT MAX(score) 
                                   FROM Student)))

-- 4. Điểm trung bình của sinh viên quê ở Hà Nội
SELECT AVG(score) AS N'Điểm trung bình' 
FROM Student 
WHERE country = N'Hà Nội' 

-- 5. Danh sách các đề tài không có sinh viên học kém nhất lớp tham gia
SELECT * 
from Project 
WHERE id NOT IN (SELECT projectid 
                 FROM Student_Project 
                 WHERE studentid IN (SELECT id 
                                     FROM Student 
                                     WHERE score = (SELECT MIN(score) 
                                                    FROM Student)))

-- 6. Danh sách các sinh viên có điểm học tập cao hơn điểm thực tập trung bình của đề
-- tài có mã số là 1
SELECT * 
FROM Student 
WHERE score > (SELECT AVG(result) 
               FROM Student_Project
               WHERE projectid = 'DT01')

------------------------------------------------------------------------------------------------------
-- 1. Danh sách các sinh vien thực tập theo đề tài có kinh phí > 1/5 tổng kinh phí cho
-- các đề tài
CREATE VIEW VCau1_1 AS 
SELECT 
  * 
FROM 
  Student 
WHERE 
  id IN (
    SELECT 
      studentid 
    FROM 
      Student_Project 
    WHERE 
      projectid IN (
        SELECT 
          id 
        FROM 
          Project 
        WHERE 
          cost > (
            SELECT 
              (
                0.2 * SUM(cost)
              ) 
            FROM 
              Project
          )
      )
  )

-- 2. Cho biết những sinh viên có học lực và kết quả thực tập giỏi nhất.
CREATE VIEW VCau1_2 AS 
SELECT 
  DISTINCT s.* 
FROM 
  Student s 
  INNER JOIN Student_Project sp ON s.id = sp.studentid 
WHERE 
  s.score = (
    SELECT 
      MAX(score) 
    FROM 
      Student
  ) 
  AND sp.result = (
    SELECT 
      MAX(result) 
    FROM 
      Student_Project
  )

-- 3(*). Cho biết những sinh viên có học lực và thực tập trong top 3. Nghiên cứu top,
-- union, intersect
CREATE VIEW VCau1_3 AS
SELECT 
  * 
FROM 
  Student 
WHERE 
  ID IN (
    SELECT 
      TOP 3 id 
    FROM 
      Student 
    ORDER BY 
      score DESC
  ) 
  AND ID IN (
    SELECT 
      TOP 3 studentid 
    FROM 
      Student_Project 
    ORDER BY 
      result DESC
  )

-- 4. Cho biết những đề tài có kết quả thực tập giỏi nhất. (giống câu 3 và 5 phần 1)
CREATE VIEW VCau1_4 AS 
SELECT 
  * 
FROM 
  Project 
WHERE 
  id IN (
    SELECT 
      projectid 
    FROM 
      Student_Project 
    WHERE 
      result = (
        SELECT 
          MAX(result) 
        FROM 
          Student_Project
      )
  )

-- Tìm đề tài có điểm trung bình kết quả thực tập cao nhất
SELECT 
  TOP 1 projectID, 
  AVG(result) 
FROM 
  Student_Project 
GROUP BY 
  projectID 
ORDER BY 
  AVG(result) DESC


SELECT 
  * 
FROM 
  Project 
WHERE 
  id IN (SELECT TOP 1 projectID
         FROM Student_Project
         GROUP BY projectID
         ORDER BY AVG(result) DESC)

SELECT 
  * 
FROM 
  Project 
WHERE 
  id IN (
    SELECT 
      TOP 1 projectID 
    FROM 
      Student_Project 
    GROUP BY 
      projectID 
    ORDER BY 
      AVG(result) DESC
  )

-- 5. Liệt kê những đề tài có kinh phí cao nhất nhưng không được những sinh viên giỏi
-- nhất chọn. Nghiên cứu Not in (giống câu 3 và câu 5)

-- Những đề tài những sinh viên giỏi nhất chọn
SELECT 
  projectid 
FROM 
  Student_Project 
WHERE 
  studentid IN (
    SELECT 
      id 
    FROM 
      Student 
    WHERE 
      score = (
        SELECT 
          MAX(score) 
        FROM 
          Student
      )
  )
 
-- Những đề tài những sinh viên giỏi nhất KHÔNG chọn
SELECT 
  id 
FROM 
  Project 
WHERE 
  ID NOT IN (
    SELECT 
      projectid 
    FROM 
      Student_Project 
    WHERE 
      studentid IN (
        SELECT 
          id 
        FROM 
          Student 
        WHERE 
          score = (
            SELECT 
              MAX(score) 
            FROM 
              Student
          )
      )
  )

CREATE VIEW VCau1_5 AS 
SELECT 
  * 
FROM 
  Project 
WHERE 
  cost = (
    SELECT 
      MAX(cost) 
    FROM 
      Project
  ) 
  AND id IN (
    SELECT 
      id 
    FROM 
      Project 
    WHERE 
      ID NOT IN (
        SELECT 
          projectid 
        FROM 
          Student_Project 
        WHERE 
          studentid IN (
            SELECT 
              id 
            FROM 
              Student 
            WHERE 
              score = (
                SELECT 
                  MAX(score) 
                FROM 
                  Student
              )
          )
      )
  )