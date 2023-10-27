--05-Where.sql
-------
--SELECT * FROM table 
--SELECT cột, cột FROM table
 
 --Where: giúp mình filter (lọc) data (các dòng)

--1 câu select chuẩn luôn trả về kết quả dưới dạng table

--SELECT cột,... FROM table...Where... ORDER BY

--SELECT: dùng để lọc các cột
--FROM: dùng chỉ ra table cần dùng
--WHERE: lấy các data hợp yêu cầu

--SELECT * FROM table WHERE <condition clause>
--lấy hết các cột từ table và các hàng thỏa điều kiện
--Toán tử: <, >, >=, <=, =, |=, <>
--Logic: and | or | not
-- dùng kèm dấu () để đóng gói

use convenienceStoreDB
--1. Liệt kê danh sách nhân viên 
SELECT * FROM Employee
--2. Liệt kê danh sách nhân viên đang ở thành phố California
SELECT * FROM Employee WHERE City = 'California'
--3. Liệt kê danh sách nhân viên đang ở thành phố London
--output: ID, Name (ghép Fullname), title, address
SELECT EmpID, FirstName + ' ' + LastName AS FullName, Title, Address FROM Employee WHERE City = 'London'
--4. Liệt kê tất cả các nhân viên ở thành phố London và California 
SELECT * FROM Employee WHERE City = 'London' or City = 'California' 
--5. Liệt kê tất cả các nhân viên ở thành phố London hoặc NY 
SELECT * FROM Employee WHERE City = 'London' or City = 'NY'
--6. liệt kê các đơn hàng
SELECT * FROM Orders
--7. liệt kê các đơn hàng không giao tới 'Hàng Mã'
SELECT * FROM Orders WHERE not ShipCity = N'Hàng Mã'
--8. liệt kê các đơn hàng giao tới 'Hàng Mã' và London
SELECT * FROM Orders WHERE ShipCity = N'Hàng Mã' or ShipCity = 'London'
--9. liệt kê các đơn hàng không giao tới 'Hàng Mã' hoặc London
SELECT * FROM Orders WHERE not ShipCity = N'Hàng Mã' and not ShipCity = 'London'
--10. Liệt kê các nhân viên có chức danh là Promotion
SELECT * FROM Employee WHERE Title = 'Promotion'
--11. Liệt kê các nhân viên có chức danh không là Promotion
--làm bằng 3 cách	!= 
SELECT * FROM Employee WHERE Title != 'Promotion'
--					<>
SELECT * FROM Employee WHERE Title <> 'Promotion'
--					not
SELECT * FROM Employee WHERE not Title = 'Promotion'
--12. Liệt kê các nhân viên có chức danh là Promotion hoặc TeleSale
SELECT * FROM Employee WHERE Title = 'Promotion' or Title = 'TeleSale'
--13. Liệt kê các nhân viên có chức danh là Promotion và Mentor
SELECT * FROM Employee WHERE Title = 'Promotion' or Title = 'Mentor'
--14. Liệt kê các nhân viên có chức danh không là Promotion và Telesale
SELECT * FROM Employee WHERE not Title = 'Promotion' and not Title = 'TeleSale'
--16. Những nhân viên nào có năm sinh trước 1972
SELECT * FROM Employee WHERE year(Birthday) < 1972
--17. Những nhân viên nào tuổi lớn hơn 40, in ra thêm cột tuổi, và sắp xếp 
SELECT *, year(getdate()) - year(Birthday) AS Age FROM Employee WHERE  year(getdate()) - year(Birthday) > 40 ORDER BY Age ASC
--18. Đơn hàng nào nặng hơn 100 và được gữi đến thành phố london
SELECT * FROM Orders WHERE Freight > 100 and ShipCity = 'London'
--19.khác hàng nào có tuổi trong khoản 19 - 21 và đang ở london không ? hãy in ra
SELECT * FROM Customer 
WHERE (21 >= year(getdate()) - year(Birthday) and year(getdate()) - year(Birthday) >= 19) and City = 'London'
--20. Liệt kê các khách hàng đến từ Anh Quốc hoặc Vietnam
	--custom
SELECT * FROM Customer WHERE Country = 'UK' or Country = 'Vietnam'
--21. Liệt kê các các đơn hàng đc gửi tới Vietnam hoặc Nhật bản
SELECT * FROM Orders WHERE ShipCountry = 'Vietnam' or ShipCountry = 'Japan'
--22. Liệt kê các đơn hàng nặng từ 50.0 đến 100.0 pound (nằm trong đoạn, khoảng)
SELECT * FROM Orders WHERE Freight >= 50 and Freight <= 100
--23. ktra lại cho chắc, sắp giảm dần kết quả theo cân nặng đơn hàng 
SELECT * FROM Orders ORDER BY Freight DESC
--24. Liệt các đơn hàng gửi tới Anh, 
--Mĩ, Việt sắp xếp tăng dần theo trọng lượng
SELECT * FROM Orders 
WHERE ShipCountry = 'UK' or ShipCountry = 'USA' or ShipCountry = 'Vietnam' ORDER BY Freight ASC
--25. Liệt các đơn hàng KHÔNG gửi tới Anh, Pháp Mĩ, và có cân nặng trong khoản 50-100
-- sắp xếp tăng dần theo trọng lượng 
SELECT * FROM Orders 
WHERE (Freight > 50 and Freight < 100) and not (ShipCountry = 'UK' or ShipCountry = 'USA' or ShipCountry = 'France') ORDER BY Freight ASC
--26. Liệt kê các nhân viên sinh ra trong khoảng năm 1970-1999
SELECT * FROM Employee WHERE year(Birthday) > 1970 and year(Birthday) < 1999
