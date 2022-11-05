INSERT INTO TACGIA VALUES
('nguyenvandung@tdtu.edu.vn', N'Nguyễn Văn', N'Dũng', N'Công nghệ phần mềm', N'Công nghệ thông tin', N'Đại học Tôn Đức Thắng', N'Tiến sĩ', N'Trưởng khoa'),
('lethidiemquynh@hcmus.edu.vn', N'Lê Thị Diễm', N'Quỳnh', N'Kĩ thuật hóa học', N'Khoa học ứng dụng', N'Đại học KHTN', N'Thạc sĩ', N'Giảng viên'),
('trannguyendangkhoa@tdtu.edu.vn', N'Trần Nguyễn Đăng', N'Khoa', N'Khoa học máy tính', N'Công nghệ thông tin', N'Đại học Tôn Đức Thắng', N'Thạc sĩ', N'Giảng viên'),
('nhanhuyen@gmail.com', N'Huỳnh', N'Dũng Nhân', N'Phóng sự', N'Báo chí tuyên truyền', N'Trường Tuyên Hướng Trung Ương Hà Nội', N'Cử nhân đại học', N'Nhà báo VN'),
('phungvu@gmail.com', N'Vũ Trọng', N'Phụng', N'Văn trào phúng – Báo cách mạng', NULL, NULL, N'Tiểu học', N'Nhà văn VN')

INSERT INTO BAIBAO VALUES
('BB001', 'nguyenvandung@tdtu.edu.vn', N'Trí tuệ nhân tạo', NULL, 'TriTueNhanTao.docx'),
('BB002', 'nhanhuyen@gmail.com', N'Giọt lệ trên trời', NULL, 'GiotLeTrenTroi.docx'),
('BB003', 'phungvu@gmail.com', N'Cạm bẫy người', NULL, 'CamBayNguoi.docx')

INSERT INTO THAMGIAVIETBAO VALUES
('BB001', 'nguyenvandung@tdtu.edu.vn'),
('BB001', 'trannguyendangkhoa@tdtu.edu.vn'),
('BB002', 'nhanhuyen@gmail.com'),
('BB003','phungvu@gmail.com')


INSERT INTO NHAKHOAHOC VALUES
('nguyenthithuhong@gmail.com', N'Nguyễn Thị Thu', N'Hồng', '0312421123', N'Tiến sĩ', N'Nghiên cứu sinh', 'AI, ML'),
('quangbuu@gmail.com', N'Tạ', N'Quang Bửu', '0653228417', N'Giáo sư', N'Bộ Trưởng Bộ QP', N'Khoa học - kỹ thuật'),
('nghiatran@gmail.com', N'Trần', N'Đại Nghĩa', '0335621879', N'Giáo sư - Tiến sĩ', N'Cục trưởng ... Bộ QP', N'KHKT và Quân sự')

INSERT INTO CHITIETDANHGIA VALUES
('nguyenthithuhong@gmail.com', 'BB001', N'Bài báo đầy đủ, chi tiết', 9, 9, 10, 10, '100%')

INSERT INTO CAUHOI VALUES
('BB001', 'nguyenthithuhong@gmail.com', 1, N'AI là gì'),
('BB001', 'nguyenthithuhong@gmail.com', 2, N'ML là gì'),
('BB002', 'quangbuu@gmail.com', 1, N'Có đến 89 câu chuyện lãng mạn được đề cập đến. Vậy nguồn thông tin được thu thập như thế nào ạ?'),
('BB003', 'nghiatran@gmail.com', 2, N'Nguồn cảm hứng cũng như động lực nào đã thúc đẩy ông viết nên bài báo này?')