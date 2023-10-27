--08-like.sql
--So sánh bằng nhau '=' là so sánh chính xác
--cell phải chuẩn 100%
--nhưng đôi khi trong thực tế ta cần filter gần giống
--kiểu như lấy ra các tỉnh thành mà có tên trong tên có chữ hà
--'Hà Nội', 'Hà Giang'

--Tìm xem tên đứa nào có chữ Minh
--Minh tiến, Quốc Minh, Bảo Minh, Minh Nhật

--DBEngine: cung cấp cho mình toán tử like
--giúp cho mình tìm gần đúng, giống như google

--like đi kèm 2 toán tử đặc biệt % và _
--%: sẽ đại diện cho 1 nhóm ký tự ( 0 hoặc nhiều)
--_:đại diện cho 1 ký tự bất kỳ (có tính space)

--vd1: Tìm ra sinh viên có tên là Điệp
---> WHERE name = N'Điệp'
--vd2: Tìm ra sinh viên có chữ Điệp trong tên
--> Điệp Lê, Điệp đẹp trai, aaĐiệp , zĐiệpz123 
---> WHERE name like N'%Điệp%'

--vd3: Tìm ra người có tên là chữ Điệp ở đầu
---> WHERE name like N'Điệp%'

--vd4: tìm ra người trong tên có 3 ký tự thôi
----> WHERE name like '_'
-----------------------------
--1. Dùng convenienceStoreDB
USE convenienceStoreDB
--2. In ra danh sách nhân viên
SELECT * FROM Employee
--3. In ra nhân viên có tên là Scarlett (tìm chính xác)  
-- 1 row
SELECT * FROM Employee WHERE FirstName like 'Scarlett'
--4. In ra những nhân viên có tên là Hanna (0 row) 
--vì tìm chính xác 
SELECT * FROM Employee WHERE FirstName like 'Hanna'
--5. In ra những nhân viên mà tên có chữ A đứng đầu 
--(2 người, Andrew, Anne)
SELECT * FROM Employee WHERE FirstName like 'A%'
--6. In ra những nhân viên mà họ có chữ A đứng cuối cùng
SELECT * FROM Employee WHERE LastName like '%A'
--7. In ra những nhân viên mà tên có chữ A 
--(ko quan tâm chữ A đứng ở đâu trong tên)
SELECT * FROM Employee WHERE FirstName like '%A%'
--8. Những nhân viên nào có tên gồm đúng 3 kí tự 
SELECT * FROM Employee WHERE FirstName like '___'
--8. Những nhân viên nào có tên gồm đúng 2 kí tự 
----0 ROW, VÌ TOÀN LÀ 3 KÍ TỰ TRỞ LÊN 
SELECT * FROM Employee WHERE FirstName like '__'
--9. Những nhân viên nào mà tên có kí tự cuối cùng là e
SELECT * FROM Employee WHERE FirstName like '%e'
--9. Những nhân viên nào mà tên có 4 kí tự, 
--kí tự cuối cùng là e
SELECT * FROM Employee 
WHERE FirstName like '____' and FirstName like '%e'
--10. Những nhân viên nào mà tên có 6 kí tự,
-- và có chứa chữ A (A ở đâu cũng đc) --3rows
SELECT * FROM Employee 
WHERE FirstName like '______' and FirstName like '%A%'
--11. Tìm các khách hàng mà địa chỉ có I đứng thứ 
--2 kể từ bên trái sang
SELECT * FROM Customer WHERE Address like '_I%'

--12. Tìm các sản phẩm mà tên sản phẩm có 5 kí tự  -2row
SELECT * FROM Product WHERE ProName like '_____'

--13.*** Tìm các sản phẩm mà từ cuối cùng trong 
--tên sản phẩm có 5 kí tự
SELECT * FROM Product WHERE ProName like '% _____' or ProName like '_____'
--VinFast Lux A 2.0 REGEX(JAVA, JS)
--Nâng cao
--1. In ra sản phẩm mà tên của nó có chứa '.'
SELECT * FROM Product WHERE ProName like '%.%'
--2. In ra nhân viên mà địa chỉ của nó có chứa '_'
SELECT * FROM Employee WHERE Address like '%[_]%'
SELECT * FROM Employee WHERE Address like '%#_%' ESCAPE '#'
-- ~ # $ ^

--Tìm kiếm những nhân viên có ' trong tên
SELECT * FROM Employee WHERE FirstName like '%''%'
-----------------