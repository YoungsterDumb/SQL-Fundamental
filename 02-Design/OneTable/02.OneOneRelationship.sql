--02-OneOneRelationship.sql
-- 1-1
CREATE DATABASE DBK17F1_oneOneRelationship
USE DBK17F1_oneOneRelationship
--viết database quản lí công dân của 1 quốc gia
CREATE TABLE Citizen(
	ID char(10) not null,
	LastName nvarchar(15) not null,
	FirstName nvarchar(30) not null
)
Alter table Citizen
	add Constraint PK_Citizen_ID primary key (ID)

INSERT INTO Citizen VALUES ('C1', N'Nguyễn', N'An')
INSERT INTO Citizen VALUES ('C1', N'Lê', N'Bình')
INSERT INTO Citizen VALUES ('C1', N'Võ', N'Cường')
INSERT INTO Citizen VALUES ('C1', N'Phạm', N'Dũng')

--table passport lưu các hộ chiếu của công dân
--mỗi 1 cái cmnd thì chỉ được 1 cái pp
--mỗi cái pp chỉ được tạo ra từ 1 cái cmnd	
drop table passport
CREATE TABLE Passport(
	PNO char(8) not null,
	IssuedDate date, -- Ngày thực thi
	ExpiredDate date, --Ngày hết hạn
	CMND char(10) not null
)
Alter table Passport
	add Constraint PK_Passport primary key(PNO)
Alter table Passport
	add Constraint FK_Passport_CMND_CitizenID 
	foreign key (CMND) references Citizen(ID)
Alter table Passport
	add Constraint UQ_Passport_CMND Unique (CMND) 

Insert into Passport values ('B1', '2022-6-20', '2032-6-20', 'C1')
Insert into Passport values ('B2', '2022-6-20', '2032-6-20', 'C1')

--Mối quan hệ 1-1 được tạo ra từ khóa ngoại(FK) và Cấm trùng(Unique)