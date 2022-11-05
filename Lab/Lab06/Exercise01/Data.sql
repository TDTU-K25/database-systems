INSERT INTO LOAISANPHAM VALUES
('ML001',N'Sách'),
('ML002',N'Túi xách, ba lô')

INSERT INTO SANPHAM (MASP, TENSP, GIABAN, SOLUONGTONKHO, MOTA, MALOAISP) VALUES 
('SP001', N'Doraemon' , 22000 , 47 , NULL, 'ML001'),
('SP002', N'Tuổi trẻ đáng giá bao nhiêu' , 59000 , 86 , NULL, 'ML001'),
('SP003', N'Overlord' , 79000, 0 , NULL, 'ML001'),
('SP004', N'Harry Potter' , 225000 , 114 , NULL, 'ML001'),
('SP005', N'Balo búp bê Barbie', 329000, 70, NULL, 'ML002'),
('SP006', N'Balo siêu anh hùng', 279000, 15, NULL, 'ML002'),
('SP007', N'Túi xách đi chợ', 119000, 7, NULL, 'ML002'),
('SP008', N'Túi xách đi tiệc', 525000, 43, NULL, 'ML002')

INSERT INTO TacGia VALUES 
('TG001', N'Nguyễn Hoàng Nguyên', 1987, N'Rosie Nguyễn'),
('TG002', N'Kugane Maruyama', 1965, N'Kugane Maruyama')

INSERT INTO NhaXuatBan VALUES
('0100110729',N'Hà Nội',N'Hà Nội','0543256891'),
('0100111320',N'Hội Nhà Văn',N'TP.HCM','0354269875')

INSERT INTO SACH VALUES
('SP002', 'TG001', '0100110729', 2017),
('SP003', 'TG002', '0100111320', 2012)

INSERT INTO TuiXachBaLo VALUES
('SP005', '60-30 cm', N'Vải Nylon', N'Hồng'),
('SP006', '80-40 cm', N'Vải Poly', N'Xanh dương'),
('SP007', '60-120 cm', N'Da thuộc', N'Đen'),
('SP008', '30-40 cm', N'Da thú', N'Trắng bạch tạng')

INSERT INTO KHACHHANG VALUES
('KH001', N'Nguyễn Văn', N'Dũng', '10-5-1999', 'Nam', 'TP.HCM', '0930519321'),
('KH002', N'Lê Thị Kim', N'Ngân', '7-22-2002', N'Nữ', 'Long An', '0783023921')

INSERT INTO HOADON  VALUES
('HD001', 'KH001', GETDATE(), 395000, 500000, 105000),
('HD002', 'KH002', GETDATE(), 279000, 280000, 1000),
('HD003', 'KH002', GETDATE(), 238000, 300000, 62000)

INSERT INTO ChiTietHoaDon (MAHD, MASP, SOLUONGMUA, GIABAN) VALUES
('HD001', 'SP002', 5, 79000),
('HD001', 'SP005', 1,279000),
('HD002', 'SP001', 2, 119000)