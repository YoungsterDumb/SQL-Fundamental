--01-Join.sql
---------------
CREATE DATABASE DBK17F1_CH04_Join
USE DBK17F1_CH04_Join

CREATE TABLE Master(
	MNO int,
	ViDesc nvarchar(10),
)
INSERT INTO Master VALUES (1, N'Một')
INSERT INTO Master VALUES (2, N'Hai')
INSERT INTO Master VALUES (3, N'Ba')
INSERT INTO Master VALUES (4, N'Bốn')
INSERT INTO Master VALUES (5, N'Năm')
SELECT * FROM Master

CREATE TABLE Detailed(
	DNO int,
	EnDesc nvarchar(10),
)
INSERT INTO Detailed VALUES (1, 'One')
INSERT INTO Detailed VALUES (3, 'Three')
INSERT INTO Detailed VALUES (5, 'Five')
INSERT INTO Detailed VALUES (7, 'Seven')
SELECT * FROM Detailed
--------------------------
SELECT * FROM Master, Detailed
--tích đề cát, Cartesian
--Gom nhóm từa lưa
--Master có 5 hàng, Detailed có 4 hàng
--Mỗi 1 hàng của master sẽ nối với 4 hàng của Detailed
--> 5 * 4 = 20 hàng
SELECT * FROM Master, Detailed WHERE MNO = DNO
--Ghép môn đăng hộ đối
--Inner Join (Nối vùng chung)
SELECT * FROM Master Join Detailed ON MNO = DNO
SELECT * FROM Master M Join Detailed D ON m.MNO = d.DNO

--Outer Join
SELECT * FROM Master Left Join Detailed ON MNO = DNO
--Table bên trái làm gốc, kéo qua bên phải
--thằng nào có bên gốc thì lấy thông tin
--thằng nào không có thì Null
SELECT * FROM Master Right Join Detailed ON MNO = DNO
--Full Join
SELECT * FROM Master Full Join Detailed ON MNO = DNO
-------
CREATE TABLE Major(
	ID char(2) Primary Key,
	Name nvarchar(30),
	Room char(4),
	Hotline char(11),
)
insert into Major values ('IS','Information System','R101','091x...')
insert into Major values ('JS','Japanese Software Eng','R101','091x...')
insert into Major values ('ES','Embedded System','R102','091x...')
insert into Major values ('JP','Japanese Language','R103','091x...')
insert into Major values ('EN','English','R102',null)
insert into Major values ('HT','Hotel Management','R103',null)

CREATE TABLE Student(
	ID char(8) Primary Key,
	Name nvarchar(30),
	MID char(2) null,
	Foreign key (MID) references Major(ID),
)
insert into Student values ('SE123456', N'An Nguyễn', 'IS')
insert into Student values ('SE123457', N'Bình Lê', 'IS')
insert into Student values ('SE123458', N'Cường Võ', 'IS')
insert into Student values ('SE123459', N'Dũng Phạm', 'IS')

insert into Student values ('SE123460', N'Em Trần', 'JS')
insert into Student values ('SE123461', N'Giang Lê', 'JS')
insert into Student values ('SE123462', N'Hương Võ', 'JS') 
insert into Student values ('SE123463', N'Khanh Lê', 'JS') 

insert into Student values ('SE123464', N'Lan Trần', 'ES')
insert into Student values ('SE123465', N'Minh Lê', 'ES')
insert into Student values ('SE123466', N'Ninh Phạm', 'ES') 

insert into Student values ('SE123467', N'Oanh Phạm', 'JP')
insert into Student values ('SE123468', N'Phương Nguyễn', 'JP')

--IS: 4, JS: 4, ES: 3, JP: 2
--HT: 0, EN: 0
--3 sv đang học dự bị, tức là mã CN là null
insert into Student values ('SE123469', N'Quang Trần', null)
insert into Student values ('SE123470', N'Rừng Lê', null)
insert into Student values ('SE123471', N'Sơn Phạm', null)

--1. Liệt kê ds cn kèm theo ds sv theo học
--output: mã cn, tên cn, mã cn, tên sv
SELECT * FROM Major m left join Student s ON m.ID = s.MID
--Nếu lấy major làm gốc thì sẽ có 2 cn chưa có sv
--nhưng ta mất 3 sv chưa có cn
SELECT * FROM Major m right join Student s ON m.ID = s.MID
--coi Student làm gốc, Student k mất data
--nhưng ta mất 2 cn chưa có sv
SELECT * FROM Major m inner join Student s ON m.ID = s.MID
--Nếu ghép môn đăng hộ đối
--mất 3 sv ko có cn và mất 2 cn chưa có sv
SELECT * FROM Major m full join Student s ON m.ID = s.MID
--Nếu lấy full thì sẽ có hết, ko mất data nhưng data null nhiều
--phải xử lí null

use convenienceStoreDB
--1. Mỗi khách hàng đã mua bao nhiêu đơn hàng
--Output 1: Mã customer, số đơn hàng
SELECT CusID, count(o.OrdID) as noOfOrders 
FROM Customer c left join Orders o ON c.CusID = o.CustomerID
GROUP BY CusID
--Output 2: Mã customer, tên customer, số đơn hàng  
--**************************LƯU Ý***************************************
--nhớ rằng phải xác định table nào là gốc, table nào là table bị kéo
--table góc sẽ hiển thị đầy đủ danh sách và thông tin của đối tượng
--chỉ nên lấy data của bên góc, khi cần hoặc gốc không có mới lấy data của phụ
SELECT c.CusID, c.FirstName + ' ' + c.LastName as CusName, ID.Amount
FROM Customer c left join (SELECT c.cusID, count(o.OrdID) AS Amount 
FROM Customer c LEFT JOIN Orders o ON c.CusID = o.CustomerID 
GROUP BY c.CusID) ID ON c.CusID = ID.CusID 

SELECT mc.CusID, c.FirstName, c.LastName, mc.Amount
FROM (SELECT CusID, count(o.OrdID) as Amount 
	  FROM Customer c left join Orders o ON c.CusID = o.CustomerID
	  GROUP BY CusID) as mc
	  left join Customer c ON mc.CusID = c.CusID
--2. khác hàng nào mua nhiều đơn hàng nhất
--Output: Mã kh, tên kh, số đơn hàng  
SELECT mc.CusID, c.FirstName, c.LastName, mc.Amount
FROM (SELECT CusID, count(o.OrdID) as Amount 
	  FROM Customer c left join Orders o ON c.CusID = o.CustomerID
	  GROUP BY CusID) as mc
	  left join Customer c ON mc.CusID = c.CusID
WHERE mc.Amount >= All(SELECT mc.Amount
FROM (SELECT CusID, count(o.OrdID) as Amount 
	  FROM Customer c left join Orders o ON c.CusID = o.CustomerID
	  GROUP BY CusID) as mc
	  left join Customer c ON mc.CusID = c.CusID)
--nhớ rằng chơi kiểu này không thể lấy ra những thằng không mua hàng được
--phải join trước rồi mới group by thì sẽ lấy được giá trị 0 cho những thằng k mua hàng

--3. Mỗi nhân viên đã chăm sóc bao nhiêu đơn hàng
--Output 1: Mã nhân viên, số đơn hàng
SELECT e.EMPID, count(o.OrdID) AS Amount 
FROM Employee e LEFT JOIN Orders o ON e.EMPID = o.EMPID 
GROUP BY e.EMPID

--Output 2: Mã nhân viên, tên nhân viên, số đơn hàng  
SELECT e.EMPID, e.lastname, e.firstname, ID.Amount 
FROM Employee e LEFT JOIN (SELECT e.EMPID,count(o.OrdID) AS Amount 
FROM Employee e LEFT JOIN Orders o ON e.EMPID = o.EMPID 
GROUP BY e.EMPID) ID ON e.EMPID = ID.EMPID

SELECT e.EmpID, e.FirstName, e.LastName, mc.Amount 
FROM (SELECT e.EMPID, count(o.OrdID) AS Amount 
FROM Employee e LEFT JOIN Orders o ON e.EMPID = o.EMPID 
GROUP BY e.EMPID) as mc left join Employee e ON mc.EmpID = e.EmpID
--5. show ra ai(những ai) là khách hàng mua ít đơn hàng nhất
SELECT mc.CusID, c.FirstName, c.LastName, mc.Amount
FROM (SELECT CusID, count(o.OrdID) as Amount 
	  FROM Customer c left join Orders o ON c.CusID = o.CustomerID
	  GROUP BY CusID) as mc
	  left join Customer c ON mc.CusID = c.CusID
WHERE mc.Amount <= All(SELECT mc.Amount
FROM (SELECT CusID, count(o.OrdID) as Amount 
	  FROM Customer c left join Orders o ON c.CusID = o.CustomerID
	  GROUP BY CusID) as mc
	  left join Customer c ON mc.CusID = c.CusID)