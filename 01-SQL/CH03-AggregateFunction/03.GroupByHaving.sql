--03-GroupByHaving.sql

--Group by dùng để gom data theo 1 tiêu chí nào đó
--Group by chỉ chơi với aggregate function
--*Lưu ý: 
--nếu đã xài group by thì SELECT(Having) chỉ được chơi với
--	cột có trong group by hoặc là aggregate
----KT1: gom nhóm về 1 con số
--		count
--		Max
--		Min
--		Sum
--		Avg
----KT2: gom nhóm theo 1 tiêu chí nào đó
--		rồi mới aggregate theo từng nhóm
use convenienceStoreDB
--1. in ra danh sách các khách hàng
SELECT * FROM Customer
--2. Đếm xem mỗi thành phố có bao nhiêu khách hàng
--mỗi khu vực: chia nhóm theo khu vực 
--TỪ MỖI -> GOM NHÓM 
SELECT City, count(CusID) as noOfCus FROM Customer GROUP BY City
--nếu bạn đếm count(city) bạn sẽ mất các khách hàng chưa xác định thành phố
--vì null nên sẽ không đếm được số lượng của null bằng cách này, vì null nó sẽ
--không đếm, dùng iif để chỉnh city Null thành 'Chưa xác định'
SELECT iif(city is null, N'Chưa xác định', City) as City, COUNT(CusID) as noOfCus FROM Customer 
GROUP BY City
--5. Liệt kê danh sách các thành phố của các đơn hàng, mỗi thành phố xh 1 lần thoy 
SELECT DISTINCT ShipCity FROM Orders
--thử dùng group by cho câu này xem sao ?
SELECT ShipCity FROM Orders GROUP BY ShipCity
--3. Đếm xem có bao nhiêu quốc gia đã giao dịch trong đơn hàng(cứ có là đếm)
SELECT COUNT(ShipCountry) FROM Orders
--4. Đếm xem có bao nhiêu quốc gia đã giao dịch trong đơn hàng, mỗi
--quốc gia đếm 1 lần thoy(distinct)
SELECT COUNT(DISTINCT ShipCountry) FROM Orders
--4.1 làm nghệ thuật, group by + count + multipleColumn
SELECT ShipCountry, count(ShipCountry) FROM Orders GROUP BY ShipCountry
--MultipleColumn
SELECT count(ShipCountry) FROM (SELECT ShipCountry FROM Orders GROUP BY ShipCountry) as lp

--thử count(ShipCountry) trong group by sẽ thấy nó đếm kiểu khác
SELECT ShipCountry FROM Orders GROUP BY count(ShipCountry)
--5. Mỗi quốc gia có bao nhiêu đơn hàng
SELECT ShipCountry, COUNT(OrdID) FROM Orders GROUP BY ShipCountry
--6. mỗi khác hàng đã mua bao nhiêu đơn hàng
SELECT CustomerID, COUNT(OrdID) FROM Orders GROUP BY CustomerID
--7.khách hàng CUS004 đã mua bao nhiêu đơn hàng(làm 2 cách)
	--c1-hãy dùng group by xem sao ?
	SELECT CustomerID, COUNT(OrdID) FROM Orders WHERE CustomerID = 'CUS004' GROUP BY CustomerID
	--c2-thử làm cách không dùng group by, chỉ dùng aggregate và where hoi xem sao ?
	SELECT COUNT(OrdID) FROM Orders WHERE CustomerID = 'CUS004'
--8. CUS004 CUS001 CUS005 có tổng cộng bao nhiêu đơn hàng
--dùng aggregate + Where hoi xem sao ?
SELECT COUNT(OrdID) FROM Orders 
WHERE CustomerID in ('CUS004', 'CUS001', 'CUS005')
--dùng count + where + group by + multipleColume + Sum xem sao ?
SELECT CustomerID, COUNT(OrdID) as bf FROM Orders 
WHERE CustomerID in ('CUS004', 'CUS001', 'CUS005') GROUP BY CustomerID
--MultipleColumn
SELECT sum(bf) FROM (SELECT CustomerID, COUNT(OrdID) as bf FROM Orders 
WHERE CustomerID in ('CUS004', 'CUS001', 'CUS005') GROUP BY CustomerID) as ld
--9. Đếm số đơn hàng của mỗi quốc gia --21 rows
SELECT ShipCountry, count(OrdID) FROM Orders GROUP BY ShipCountry
--10. Đếm số đơn hàng của nước Mĩ
--c1.Dùng Count + Where
SELECT count(OrdID) FROM Orders WHERE ShipCountry = 'USA'
--c2.dùng Where + Group By
SELECT ShipCountry, count(OrdID) FROM Orders WHERE ShipCountry = 'USA' GROUP BY ShipCountry
--c3.dùng having, lọc sau group
SELECT ShipCountry, count(OrdID) FROM Orders GROUP BY ShipCountry HAVING ShipCountry = 'USA'
--11.liệt kê id của các khách hàng, và số lượng sản phẩm đã mua của 
--khác hàng nào đã mua trên 2 đơn hàng
SELECT CustomerID, count(OrdID) FROM Orders GROUP BY CustomerID HAVING COUNT(OrdID) > 2
--12. Quốc gia nào có số lượng đơn hàng nhiều nhất?????
--phân tích:
-- - đếm số đơn hàng của mỗi quốc gia, count(*), mỗi - group by
-- - đếm xong có quá trời quốc gia, kèm số lượng đơn hàng
-- - ta cần số lớn nhất
-- - ta having cột số lượng vừa đếm >= ALL (??????)
--dùng All()
SELECT ShipCountry, COUNT(OrdID) FROM Orders 
GROUP BY ShipCountry 
HAVING COUNT(OrdID) >= All(SELECT COUNT(OrdID) FROM Orders 
GROUP BY ShipCountry)

--thử thách dùng max() đi đại ca :
SELECT ShipCountry, COUNT(OrdID) FROM Orders 
GROUP BY ShipCountry 
HAVING COUNT(OrdID) = (SELECT max(np) FROM (SELECT ShipCountry, COUNT(OrdID) as np FROM Orders 
GROUP BY ShipCountry) as lp)
--13. Mỗi công ty đã vận chuyển bao nhiêu đơn hàng
SELECT ShipID, COUNT(OrdID) FROM Orders GROUP BY ShipID
--14. Mỗi nhân viên phụ trách bao nhiêu đơn hàng
--output 1: mã nv, số đơn hàng
SELECT EmpID, COUNT(OrdID) FROM Orders GROUP BY EmpID
--output2:(khó) mã nv, tên nv, số đơn hàng(phải học nhiều hơn mới làm được, để từ từ làm)
