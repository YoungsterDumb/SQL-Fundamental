--02-JoinAggregate.sql
--1. Ta thiết kế database lưu trữ thông tin sv
--và cn mà sv theo đuổi

--Trường mở nhiều cn gồm thông tin như sau
--mã cn, tên cn, văn phòng của cn, hotline
--vd: jp	ngôn ngữ nhật	R102	098x...
--có tình trạng cn mới mở nên ko có sv

--Thông tin sv: mã sv, tên sv, MajorID(MID)
--có những sv chưa có mã cn

--tạo database
CREATE DATABASE DBK17F2_Ch04_JoinAggregate
Use DBK17F2_Ch04_JoinAggregate
--tạo major trước | student trước
--Tạo Major trước
CREATE TABLE Major(
	ID char(3) primary key, --khóa chính: cấm trùng
	Name nvarchar(30),
	Room char(5) null,
	Hotline char(11),
)

insert into Major values('IS','Information System','R101','091x...')
insert into Major values('JS','Japanese Software Eng','R102','091x...')
insert into Major values('ES','Embedded System','R103',null)
insert into Major values('JP','Japanese Language','R104','091x...')
insert into Major values('EN','English','R105','091x...')
insert into Major values('HT','Hotel Management','R106','091x...')
insert into Major values('IA','Information Asurance','R103',null)
--------------------------
CREATE TABLE Student(
	ID char(9) primary key,
	Name nvarchar(30) not null,
	MID char(3) null,
	Foreign key (MID) references Major(ID)
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

insert into Student values ('SE123472', N'Anh Lê', 'IA')
--IS: 4, JS: 4, ES: 3, JP: 2
--HT: 0, EN: 0
--3 sv đang học dự bị, tức là mã CN là null
insert into Student values ('SE123469', N'Quang Trần', null)
insert into Student values ('SE123470', N'Rừng Lê', null)
insert into Student values ('SE123471', N'Sơn Phạm', null)

--1. Có bao nhiêu chuyên ngành  --6rows
SELECT count(ID) FROM Major
--2. Có bao nhiêu sinh viên
SELECT count(ID) FROM Student
--3. Có bao nhiêu sv học chuyên ngành IS
SELECT count(ID) FROM Student WHERE MID = 'IS'
--4. Đếm xem mỗi CN có bao nhiêu SV
SELECT m.ID, count(s.ID) as Amount 
FROM Student s right join Major m ON s.MID = m.ID 
GROUP BY m.ID
--5. Chuyên ngành nào có nhiều SV nhất
--xử lý 2 cn không có sinh viên bằng iff trước khi tìm max min
SELECT m.ID, count(s.ID) as Amount 
FROM Student s right join Major m ON s.MID = m.ID GROUP BY m.ID
HAVING count(s.ID) >= All(SELECT count(s.ID) as Amount 
FROM Student s right join Major m ON s.MID = m.ID GROUP BY m.ID)

SELECT MID, count(MID) as Amount FROM Student 
GROUP BY MID
HAVING count(MID) >= All(SELECT count(MID) as Amount FROM Student 
GROUP BY MID)
--6. Chuyên ngành nào có ít sv nhất
--<= ALL:
SELECT m.ID, count(s.ID) as Amount 
FROM Student s right join Major m ON s.MID = m.ID GROUP BY m.ID
HAVING count(s.ID) <= All(SELECT count(s.ID) as Amount 
FROM Student s right join Major m ON s.MID = m.ID GROUP BY m.ID)

SELECT MID, count(MID) as Amount FROM Student 
GROUP BY MID
HAVING count(MID) <= All(SELECT count(MID) as Amount FROM Student 
GROUP BY MID)
--dùng min:
SELECT min(Amount) FROM (SELECT m.ID, count(s.ID) as Amount 
						 FROM Student s right join Major m ON s.MID = m.ID 
						 GROUP BY m.ID) as mc 

SELECT m.ID, count(s.ID) as Amount 
FROM Student s right join Major m ON s.MID = m.ID 
GROUP BY m.ID
HAVING count(s.ID) = (SELECT min(Amount) 
					  FROM (SELECT m.ID, count(s.ID) as Amount 
						    FROM Student s right join Major m ON s.MID = m.ID 
							GROUP BY m.ID) as mc)
--7. Đếm số sv của cả 2 chuyên ngành ES và JS 
--dùng Where + aggregate: 
SELECT count(ID) FROM Student WHERE MID in ('ES', 'JS') 
--dùng Group by + MultipleColum + sum : 
SELECT sum(Amount) FROM (SELECT m.ID, count(s.ID) as Amount 
						 FROM Student s right join Major m ON s.MID = m.ID 
						 GROUP BY m.ID HAVING m.ID in ('ES', 'JS')) as mc
--8. Mỗi chuyên ngành ES và JS có bao nhiêu sv
SELECT m.ID, count(s.ID) as Amount 
FROM Student s right join Major m ON s.MID = m.ID 
GROUP BY m.ID HAVING m.ID in ('ES', 'JS')
--9. Chuyên ngành nào có từ 3 sv trở lên
SELECT m.ID, count(s.ID) as Amount 
FROM Student s right join Major m ON s.MID = m.ID GROUP BY m.ID
HAVING count(s.ID) > 3
--10. Chuyên ngành nào có từ 2 sv trở xuống
SELECT m.ID, count(s.ID) as Amount 
FROM Student s right join Major m ON s.MID = m.ID GROUP BY m.ID
HAVING count(s.ID) < 2
--11. Liệt kê danh sách sv của mỗi CN
--output: mã cn, tên cn, mã sv, tên sv
SELECT m.ID, m.Name, s.ID, s.Name 
FROM Student s right join Major m ON s.MID = m.ID
--12. Liệt kê thông tin chuyên ngành của mỗi sv
--output: mã sv, tên sv, mã cn, tên cn, room
SELECT s.ID, s.Name, m.ID, m.Name, m.Room 
FROM Student s left join Major m ON s.MID = m.ID
--thử thách làm lại câu 13 siêu khó của bài MaxMinSumAll
Use convenienceStoreDB
--1. đếm xem mỗi nhà vận chuyển đã vận chuyển bao nhiêu đơn hàng ?
--output: mã nhà vận chuyển, tên nhà vận chuyển, số lượng đơn hàng
SELECT s.ShipID, count(OrdID) as Amount 
FROM Shipper s left join Orders o ON s.ShipID = o.ShipID 
GROUP BY s.ShipID

SELECT s.ShipID, s.CompanyName, mc.Amount 
FROM (SELECT s.ShipID, count(OrdID) as Amount 
FROM Shipper s left join Orders o ON s.ShipID = o.ShipID 
GROUP BY s.ShipID) as mc left join Shipper s ON mc.ShipID = s.ShipID 

--2. đếm xem mỗi nhà vận chuyển đã vận chuyển bao nhiêu đơn hàng đến USA?
--output: mã nhà vận chuyển, tên nhà vận chuyển, số lượng đơn hàng
SELECT s.ShipID, count(OrdID) as Amount 
FROM Shipper s left join Orders o ON s.ShipID = o.ShipID 
WHERE o.ShipCountry = 'USA'
GROUP BY s.ShipID

SELECT s.ShipID, s.CompanyName, mc.Amount 
FROM (SELECT s.ShipID, count(OrdID) as Amount 
FROM Shipper s left join Orders o ON s.ShipID = o.ShipID 
WHERE o.ShipCountry = 'USA'
GROUP BY s.ShipID) as mc left join Shipper s ON mc.ShipID = s.ShipID
--3. Khách hàng CUS001 , CUS005, CUS007 đã mua bao nhiêu đơn hàng
--output: mã khách hàng, tên khách hàng, số lượng khách hàng
SELECT c.CusID, c.FirstName, c.LastName, mc.Amount 
FROM (SELECT c.CusID, count(OrdID) as Amount 
FROM Customer c left join Orders o ON c.CusID = o.CustomerID
WHERE o.CustomerID in ('CUS001', 'CUS005', 'CUS007')
GROUP BY c.CusID) as mc left join Customer c ON mc.CusID = c.CusID
--4. Khách hàng CUS001 , CUS005, CUS007 dã mua bao nhiêu đơn hàng vận chuyển tới đúng quê của họ
--output: mã khách hàng, tên khách hàng, số lượng khách hàng
--Lấy thông tin miền quê của 3 khách hàng
SELECT CusID, Country FROM Customer WHERE CusID in ('CUS001', 'CUS005', 'CUS007')
--Các đơn hàng của 3 khách hàng
SELECT OrdID, CustomerID, ShipCountry FROM Orders 
WHERE CustomerID in ('CUS001', 'CUS005', 'CUS007')
ORDER BY CustomerID asc
--Nối 2 bảng đó lại và so sánh

SELECT c.CusID, count(o.OrdID) as Amount 
FROM (SELECT CusID, Country FROM Customer 
		WHERE CusID in ('CUS001', 'CUS005', 'CUS007')) as c
		left join (SELECT OrdID, CustomerID, ShipCountry FROM Orders 
		WHERE CustomerID in ('CUS001', 'CUS005', 'CUS007')) as o
		ON c.CusID = o.CustomerID and c.Country = o.ShipCountry
GROUP BY c.CusID
----------------------
SELECT c.CusID, count(o.OrdID) as Amount
FROM Customer c left join Orders o 
ON c.CusID = o.CustomerID and c.Country = o.ShipCountry
WHERE c.CusID in ('CUS001', 'CUS005', 'CUS007')
GROUP BY c.CusID