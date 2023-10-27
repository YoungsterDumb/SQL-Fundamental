--03- MultipleColumn.sql
--kết quả của câu select luôn trả ra dưới dạng table
--Một câu select chuẩn đầy đủ gồm
--SELECT...FROM...WHERE....Group by ... Having ... Order By...
--SELECT * | Cột, cột, cột
--FROM Table , table, subQuery
----
--Câu select mà muốn dùng trong FROM phải đáp ứng nhu cầu sau
--	câu select đó không có 'No column name'
--	câu select đó trả ra Table, table phải có tên
--				> đặt tên bằng ALIAS (as)
use convenienceStoreDB
--1. Liệt kê các khách hàng đến từ USA
SELECT * FROM Customer WHERE Country = 'USA'
--2. Liệt kê các khách hàng đến từ USA và đã đc xác định sđt
SELECT * FROM Customer WHERE Country = 'USA'
and PhoneNumber is not null
--Biểu diễn
-- khó đọc hơn, ngầu hơn, nhìn đẳng cấp
SELECT * FROM (SELECT * FROM Customer WHERE Country = 'USA') as bl
WHERE PhoneNumber is not null
--
SELECT * FROM (SELECT * FROM Customer WHERE PhoneNumber is not null) as bl
WHERE Country = 'USA'
--3.Liệt kê các đơn hàng gữi đến London, California, Hàng Mã và 
--được nhân viên EMP001 chịu trách nhiệm --8 -- 3 cách
SELECT * FROM Orders WHERE ShipCity in ('London', 'California', N'Hàng Mã')
and EmpID = 'EMP001'
--c2:
SELECT * FROM (SELECT * FROM Orders 
WHERE ShipCity in ('London', 'California', N'Hàng Mã')) AS ct WHERE EmpID = 'EMP001'
--c3:
SELECT * FROM (SELECT * FROM Orders WHERE EmpID = 'EMP001') AS ct 
WHERE ShipCity in ('London', 'California', N'Hàng Mã')
--4.Liệt kê các đơn hàng gữi đến London, California, Hàng Mã và 
--được mua bởi các khách hàng có tên Roney , Hồng--6-- 3 cách
SELECT * FROM Orders 
WHERE ShipCity in ('London', 'California', N'Hàng Mã')
and CustomerID in (SELECT CusID FROM Customer 
WHERE FirstName in ('Roney', N'Hồng'))
--c2:
SELECT * FROM (SELECT * FROM Orders 
WHERE ShipCity in ('London', 'California', N'Hàng Mã')) AS bl
WHERE CustomerID in (SELECT CusID FROM Customer 
WHERE FirstName in ('Roney', N'Hồng'))
--c3:
SELECT * FROM (SELECT * FROM Orders 
WHERE CustomerID in (SELECT CusID FROM Customer 
WHERE FirstName in ('Roney', N'Hồng'))) AS bl
WHERE ShipCity in ('London', 'California', N'Hàng Mã')
----5. liệt kê các đơn nhập của nhà cung cấp bởi SUP006 và
-- có số lượng dưới 1000 -- 3 cách
SELECT * FROM InputBill WHERE SupID = 'SUP006' and Amount < 1000
--c2: 
SELECT * FROM (SELECT * FROM InputBill WHERE SupID = 'SUP006') AS bl
WHERE Amount < 1000
--c3:
SELECT * FROM (SELECT * FROM InputBill WHERE Amount < 1000) AS bl
WHERE SupID = 'SUP006'

--5.(hỏi trực tiếp) liệt kê các đơn nhập của nhà cung cấp bởi Vingroup và
-- có số lượng dưới 1000 -- 3 cách
SELECT * FROM InputBill 
WHERE Amount < 1000 and SupID in (SELECT SupID FROM Supplier
WHERE SupName = 'Vingroup')
--c2: 
SELECT * FROM (SELECT * FROM InputBill WHERE Amount < 1000) AS bl
WHERE SupID in (SELECT SupID FROM Supplier
WHERE SupName = 'Vingroup')
--c3:
SELECT * FROM (SELECT * FROM InputBill WHERE SupID in (SELECT SupID FROM Supplier
WHERE SupName = 'Vingroup')) AS bl
WHERE Amount < 1000