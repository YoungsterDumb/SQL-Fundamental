--01-OneTable

CREATE DATABASE DBK17F1_OneTable
USE DBK17F1_OneTable
CREATE TABLE StudentV1(
	ID char(9), 
	Name nvarchar(30),
	DOB date, --yyyy/mm/dd
	Sex char(2), --M, F, L, G, B, T, U
	Email varchar(50)
)
INSERT INTO StudentV1 
	VALUES('SE123456', N'An Nguyễn', '1999-1-1', 'F', 'an@...') 
INSERT INTO StudentV1 
	VALUES('SE123457', 'An Nguyễn', '1999-1-1', 'F', 'an@...')
SELECT * FROM StudentV1
----------------
update StudentV1 set Name = N'An Nguyễn' WHERE ID = 'SE123457'
-------
--Đề xuất: mỗi một table nên có 1 cột chống trùng(Pkey, khóa chính)
--Student(ID, Name, DOB, Email, Phone, Sổ hộ khẩu, Bằng lái xe, CMND)
--Trong table có rất nhiều key: ID, Email, Bằng lái xe, CMND
--Những thg có khả năng làm key đó gọi là: candidate key (key ứng viên)
--Khóa chính được lựa chọn dựa trên tiêu chí: phù hợp với bài toán lưu trữ
--Chọn key làm khóa chính(Primary key, Default key)
--Khóa chính giúp mình ràng buộc data không bị trùng, cấm null
--PK là một constraint(ràng buộc)

--StudentV2 thêm key
CREATE TABLE StudentV2(
	ID char(9) primary key, 
	Name nvarchar(30),
	DOB date, --yyyy/mm/dd
	Sex char(2), --M, F, L, G, B, T, U
	Email varchar(50)
)
INSERT INTO StudentV2 
	VALUES('SE123456', N'An Nguyễn', '1999-1-1', 'F', 'an@...')
INSERT INTO StudentV2 
	VALUES('SE123456', N'Bình Lê', '1999-1-1', 'F', 'an@...')
INSERT INTO StudentV2 
	VALUES('SE123457', null, null, null, null)
--Có những cột không đc null -> constraint not null
--StudentV3: gài not null
CREATE TABLE StudentV3(
	ID char(9) primary key, 
	Name nvarchar(30) not null,
	DOB date null, --yyyy/mm/dd
	Sex char(2) null, --M, F, L, G, B, T, U
	Email varchar(50) null
)
INSERT INTO StudentV3 
	VALUES('SE123456', N'An Nguyễn', null, null, null)
--Kĩ thuật chèn data thiếu cột(kĩ thuật chèn cột 3)
INSERT INTO StudentV3(ID, Name) 
	VALUES('SE123457', N'Bình Lê')

--StudentV4: Xử lí Name để đạt yêu cầu sắp xếp
CREATE TABLE StudentV4(
	ID char(9) primary key, 
	FirstName nvarchar(15) not null,
	LastName nvarchar(15) not null,
	DOB date null, --yyyy/mm/dd
	Sex char(2) null, --M, F, L, G, B, T, U
	Email varchar(50) null
)
INSERT INTO StudentV4(ID, FirstName, LastName)
	VALUES ('SE123456', N'Bình', N'Nguyễn')
INSERT INTO StudentV4(ID, FirstName, LastName)
	VALUES ('SE123457', N'An', N'Nguyễn')
INSERT INTO StudentV4(ID, FirstName, LastName)
	VALUES ('SE123458', N'Johnny', N'Dang')
SELECT * FROM StudentV4 ORDER BY FirstName
---------------#-------------
--Ràng buộc là cách ta ép người dùng nhập data phải tuân theo
--1 quy luật nào đó đã đề ra
--Vd: Sex thì phải M F L G B T U
--Vd: Tên thì không đc bỏ trống
--Vd: ID cấm trùng trong mọi thời điểm
--Vd: ID bên table này phải xuất hiện trong table kia
--Vd: Sinh viên không đc đk quá 5 môn trong 1 kì(trigger)
--Trong table có các loại ràng buộc nào
	--Primary key -> (khóa chính| not null| cấm trùng(unique))
	--Unique	  -> (cấm trùng)
	--not null	  -> (cấm bỏ trống các value)
	--Foreign key -> (khóa ngoại ràng buộc tham chiếu)
	--Default     -> (giá trị mặc định)
	--Check		  -> (coi value có nằm tỏng khoảng không nào ko)
--Trong quá trình thiết kế một table, 1 table có thể có
--rất nhiều ràng buộc, ta nên đặt tên cho các ràng buộc
--để dễ quản lí, để xoá khi cần
--tên rb:
	--rule#1	đi chơi về sớm
	--rule#2	học hành phải trên 8
----------------------
--composite key(key kết hợp)
--2 cột kết hợp lại mới đủ lực để định vị object
--Block nhà và số phòng
-- Primary key (room, block)

--Super key(siêu key| key vô dụng)
--composite key(PK, cột)

--StudentV5: gài ràng buộc đặt tên cho ràng buộc
CREATE TABLE StudentV5(
	ID char(9) not null, 
	FirstName nvarchar(15) not null,
	LastName nvarchar(15) not null,
	DOB date null, --yyyy/mm/dd
	Sex char(2) null, --M, F, L, G, B, T, U
	Email varchar(50) null
	--primary key(ID) --viết dưới này thì composite key được
	--không đặt được tên
)
Alter table StudentV5
	add Constraint PK_StudentV5_ID primary key (ID)

INSERT INTO StudentV5(ID, FirstName, LastName)
	VALUES ('SE123456', N'Bình', N'Nguyễn')

Alter table StudentV5
	add Constraint UQ_StudentV5_Email Unique (Email)
