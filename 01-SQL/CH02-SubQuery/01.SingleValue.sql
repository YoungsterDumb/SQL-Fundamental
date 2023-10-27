--01-SingleValue.sql
--SELECT...FROM...WHERE...

--SELECT * | cột, cột
--FROM	table, table, table(Join - Tích đề cát)
--WHERE điều kiện lọc data
--ORDER BY cột ASC | DESC

USE convenienceStoreDB	
SELECT firstName FROM Employee WHERE EmpID = 'emp001'

--Lấy những nhân viên cùng quê với nhân viên mã số 
--emp003
SELECT City FROM Employee WHERE EmpID = 'emp003'
--đáp án này là 1 single value
--single value: là câu select chỉ trả ra 1 hàng 1 cột (1 ô)
--   1 cell, 1 data

SELECT * FROM Employee 
WHERE City = (SELECT City 
				FROM Employee 
				WHERE EmpID = 'emp003')
			-- Nested Query(câu select lồng trong câu select)

-----------------------------------------------------------------------------
--1. In ra những nhân viên ở London 
SELECT * FROM Employee WHERE City = 'London'
--2. In ra những nhân viên cùng quê với Angelina
SELECT * FROM Employee 
WHERE Country = (SELECT Country FROM Employee WHERE FirstName = 'Angelina')
and not FirstName = 'Angelina'
--3. Liệt kê các đơn hàng có ngày yêu cầu giao
SELECT * FROM Orders WHERE RequiredDate is not null
--4. Liệt kê các đơn hàng có trọng lượng lớn hơn trọng lượng của
--đơn hàng có mã số ORD021
SELECT * FROM Orders WHERE Freight > (SELECT Freight FROM Orders WHERE OrdID = 'ORD021')
--5. Liệt kê các đơn hàng trọng lượng lớn hơn đơn hàng ORD021
--và vận chuyển đến cùng tp với đơn hàng mã ORD012, tính cả đơn ORD012
SELECT * FROM Orders 
WHERE Freight > (SELECT Freight FROM Orders WHERE OrdID = 'ORD021')
and ShipCity = (SELECT ShipCity FROM Orders WHERE OrdID = 'ORD012')
--6. Liệt kê các đơn hàng đc ship cùng tp với đơn hàng ORD014
--và có trọng lượng > 50 pound
SELECT * FROM Orders 
WHERE ShipCity = (SELECT ShipCity FROM Orders WHERE OrdID = 'ORD014')
and Freight > 50
--7. Những đơn hàng nào đc vận chuyển bởi cty vận chuyển mã số 
--là SHIP003  và được ship đến cùng thành phố với đơn hàng ORD012(ShipVia)
SELECT * FROM Orders WHERE ShipID = 'SHIP003'
and ShipCity = (SELECT ShipCity FROM Orders WHERE OrdID = 'ORD012')
--8. Hãng Giaohangtietkiem vận chuyển những đơn hàng nào
SELECT * FROM Orders 
WHERE ShipID = (SELECT ShipID FROM Shipper WHERE CompanyName = 'Giaohangtietkiem')
--tới đây rồi
--9. Liệt kê danh sách các mặt hàng/món hàng/products gồm mã sp
--tên sp, chủng loại (category)
SELECT ProID, ProName, CategoryID FROM Product
--10. pork shank thuộc nhóm hàng nào 
--output: mã nhóm, tên nhóm (xuất hiện ở table Category)
SELECT CategoryID, CategoryName FROM Category 
WHERE CategoryID = (SELECT CategoryID FROM Product WHERE ProName = 'pork shank')
--11. Liệt kê danh sách các món hàng có cùng chủng loại với mặt hàng pork shank
--có tính pork shank
SELECT * FROM Product
WHERE CategoryID = (SELECT CategoryID FROM Product WHERE ProName = 'pork shank')

--12.liệt kê các sản phầm có chủng loại là xe thịt
SELECT * FROM Product 
WHERE CategoryID in (SELECT CategoryID FROM Category 
WHERE CategoryName in ('car','moto', 'meat'))
--13-liệt kê các nhà cung cấp , cung cấp sản phẩm có tên là pork shank
SELECT SupName FROM Supplier WHERE SupID in (SELECT SupID FROM InputBill 
WHERE ProID = (SELECT ProID FROM Product 
WHERE ProName = 'pork shank'))