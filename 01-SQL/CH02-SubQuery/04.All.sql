--04-All.sql
--tạo ngôi nhà (database): create database
CREATE DATABASE DBK17F1_SubQuery_All
USE DBK17F1_SubQuery_All

--tạo table lưu các số lẻ: create table
CREATE TABLE Odds(
	Number INT --tạo cột kiểu dữ liệu là integer(số nguyên)
)
SELECT * FROM Odds
--insert --> DML
INSERT INTO Odds VALUES (1)
INSERT INTO Odds VALUES (3)
INSERT INTO Odds VALUES (5)
INSERT INTO Odds VALUES (7)
INSERT INTO Odds VALUES (9)
--table: drop | delete
DELETE Odds
-------------------------
--Tạo bảng chứa số chẵn
CREATE TABLE Evens(
	Number INT
)
INSERT INTO Evens VALUES (0)
INSERT INTO Evens VALUES (2)
INSERT INTO Evens VALUES (4)
INSERT INTO Evens VALUES (6)
INSERT INTO Evens VALUES (8)
-------------------------
--Tạo bảng lưu các số nguyên
CREATE TABLE Integers(
	Number INT
)
INSERT INTO Integers VALUES (0)
INSERT INTO Integers VALUES (2)
INSERT INTO Integers VALUES (4)
INSERT INTO Integers VALUES (6)
INSERT INTO Integers VALUES (8)
INSERT INTO Integers VALUES (1)
INSERT INTO Integers VALUES (3)
INSERT INTO Integers VALUES (5)
INSERT INTO Integers VALUES (7)
INSERT INTO Integers VALUES (9)

SELECT * FROM Odds
SELECT * FROM Evens
SELECT * FROM Integers
--------------------------------

--1-Sql cung cấp thêm toán tử ALL dùng để sử dụng chung vs mệnh đề so sánh
--> < >= <= = !=

--Cú pháp:
--			toán tử ALL so sánh (SubQuery MultipleValue | Single)
--Ví dụ
--			WHERE weight >= ALL (câu sub trả về một dòng/ một cột nhiều dòng)

--2. Ý nghĩa:
-- WHERE cột so sánh với ALL (tập hợp)
--so sánh value của cột này với tất cả value có trong tập hợp
--giá trị nào trong cột này thỏa với tất cả giá trị trong
--tập hợp lấy ra

--Thực hành dùng All
--1. Tìm trong Evens những số nào lớn hơn tất cả các số bên Odds
SELECT * FROM Evens WHERE Number > All(SELECT Number FROM Odds)
--2. Ngược lại
SELECT * FROM Odds WHERE Number > All(SELECT Number FROM Evens)
--3. Tìm trong Evens những số nào lớn hơn tất cả các số bên Evens
SELECT * FROM Evens WHERE Number > All(SELECT Number FROM Evens)
--4. Tìm trong Evens những số nào lớn hơn hoặc bằng tất cả các số bên Evens
SELECT * FROM Evens WHERE Number >= All(SELECT Number FROM Evens)--tìm lớn nhất
--5. Tìm số bé nhất trong integers
SELECT * FROM Integers WHERE Number <= All(SELECT Number FROM Integers)
----------------------
USE convenienceStoreDB
--1. In ra thông tin các nhân viên kèm tuổi của họ
SELECT *, year(getdate()) - year(Birthday) as Age FROM Employee
--1.1 In ra thông tin của nhân viên có tuổi lớn nhất
SELECT *, year(getdate()) - year(Birthday) as Age FROM Employee 
WHERE year(getdate()) - year(Birthday) >= All(SELECT year(getdate()) - year(Birthday) as Age 
											  FROM Employee)
--2. Trong các nhân viên ở USA, ai là người lớn tuổi nhất
INSERT INTO Employee VALUES ('EMP014', N'Tuấn', N'Nguyễn', N'Telesale', 'HCM', N'49 Võ Văn Tần', 'Vietnam', N'1960-01-01')

SELECT *, year(getdate()) - year(Birthday) as Age FROM Employee 
WHERE Country = 'USA' 
and year(getdate()) - year(Birthday) >= All(SELECT year(getdate()) - year(Birthday) as Age 
											  FROM Employee WHERE Country = 'USA')
--4. in ra thông tin của những sản phẩm thuộc chủng loại, quần áo, túi,moto
SELECT * FROM Product 
WHERE CategoryID in (SELECT CategoryID FROM Category 
WHERE CategoryName in ('Clothes', 'Bag', 'Moto'))

--5. Đơn hàng nào có trọng lượng lớn nhất???
--PHÂN TÍCH: lấy ra đc tập hợp các trọng lượng đang có 
--sau đó sàng lại trong đám trọng lượng, ai lớn hơn hay bằng tất cả
SELECT * FROM Orders 
WHERE Freight >= All(SELECT Freight FROM Orders)
--5.1. Trong tất cả các đơn hàng, trọng lượng lớn nhất là bao nhiêu
SELECT * FROM Orders WHERE Freight >= All(SELECT Freight FROM Orders)

--6. Trong các đơn hàng gửi tới Hàng Mã, Tokyo đơn hàng nào trọng lượng
--lớn nhất (vi diệu)
SELECT * FROM Orders 
WHERE ShipCity in (N'Hàng Mã', 'Tokyo') 
and Freight >= All (SELECT Freight FROM Orders 
WHERE ShipCity in (N'Hàng Mã', 'Tokyo'))
--7. Trong các đơn hàng gửi tới Hàng Mã, Tokyo đơn hàng nào trọng lượng
--nhỏ nhất (vi diệu)
SELECT * FROM Orders 
WHERE ShipCity in (N'Hàng Mã', 'Tokyo') 
and Freight <= All (SELECT Freight FROM Orders 
WHERE ShipCity in (N'Hàng Mã', 'Tokyo'))
--8. Sản phẩm nào giá bán cao nhất
SELECT * FROM Product WHERE Price >= All (SELECT Price FROM Product)
--9. Sản phẩm có giá bán cao nhất thuộc chủng loại gì
SELECT * FROM Category 
WHERE CategoryID in (SELECT CategoryID FROM Product 
WHERE Price >= All (SELECT Price FROM Product))