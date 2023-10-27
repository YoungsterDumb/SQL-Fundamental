--02-selectTable.sql

--Thức tế có rất nhiều dạng DB trên thế giới
--RDBMS: relationship DB management system
--		(Oracle, MySQL, MS Server, PostgreSQL)

--CSDL dạng khóa - key, value (Hashmap, Redis, Memcached)
--Document Store - (MongoDB, couchbase)


--chúng ta học RDBMS: vì nó đáp ứng ACID
--	Atomicity: tính nguyên tố: Trong 1 chu trình
--			có rất nhiều tác vụ, nếu 1 tác vụ bị false
--			--> cả chu trình false
--	Consistency: Tính nhất quán: sao kê
--			1 tác vụ nào đó sẽ tạo ra trạng thái mới hợp
--			lệ cho data
--			nếu trong quá trình thực hiện tác vụ mà
--				có lỗi thì quay ngược lại trạng thái
--				hợp lệ ban đầu
--  Isolation: tính độc lập: một tác vụ đang thực thi
--		thì phải tách biệt với các tác vụ khác
--  Durability: tính bền vững: Dữ liệu được xác nhận sẽ
--		được hệ thống lưu lại, trong trường hỏng hóc, 
--		dữ liệu sẽ được đảm bảo không bị mất

--Anh Cần chuyển qua cho tài khoản B: 1 chu trình
--	1 chu trình thì có nhiều tác vụ
-------------
-- kiểm tra ngân khố của Anh : true
-- kiểm tra tính khả dụng của Anh : false
-- Chuyển : true
-- Kiểm tra tài khoản Thụ hưởng : true
-- đã chuyển : true

--anh có 10tr chuyển cho A 7tr : chưa xác nhận
--anh phải phải chuyển cho B : 


--Truy xuất thông qua SQL đa dụng, dễ dàng phát triễn, mở rộng
--Cung cấp phân quyền (admin, guest, user,..)
--Nhược điểm: xử lý dữ liệu phi cấu trúc kém
--				tốc độ xử lý chậm
--Nên dùng khi nào: 
	--các trường hợp muốn giữ tính toàn vẹn dữ liệu
	--Không thể bị chỉnh sửa dễ dàng
	--Vidu: Ứng dụng tài chính (Misa), Ứng dụng trong quốc phòng
	--Lĩnh vực thông tin cá nhân sức khỏe
	--Lĩnh vực tự động hóa
	--Thông tin nội bộ(Nhơn Hòa)

--Trong database có nhiều table
--Table là gì? là danh sách của một dạng đối tượng nào đó
--Trong table có gì? có cột
--1 dòng là full thông tin của object
--> 1 dòng là 1 object
--Trong một table thường có nhiều cột
--cột | column | field | property | attribute

--Trong 1 table thường luôn có 1 cột đặc biệt
--là data trong cột không bao giờ trùng
--> Ý nghĩa: giúp nhận dạng object
--			 giúp không dòng nào trùng 100%

--Table student
--  ID	|	Name   | Score | YOB |

--2. Database là gì?
--là 1 tập hợp nhiều table có cùng chủ đề, cùng giải quyết
--1 bài toán lưu trữ
--Muốn tạo db bán hàng
--Nhân viên, Khách hàng, Sản phẩm, Nhà cung cấp, Shipper,...


--3. Để xem, thêm, xóa, sửa thì cần dùng
-- nhóm câu lệnh thuộc SQL (DML)
--data manipulation language
--SQL DML: SELECT, insert, update, delete

--I-Thực hành
--chọn Database
USE convenienceStoreDB
--1. Liệt kê danh sách nhân viên có đầy đủ thông tin
--table nào? danh sách nhân viên --> table employee
--cột nào? tất cả các cột --> *
SELECT * FROM Employee
-- Liệt kê danh sách nhân viên, ta chỉ xem một vài cột
--output: id, name, birthday
SELECT EmpID, FirstName, LastName, Birthday 
FROM Employee
--3. In ra danh sách nhân viên, lấy các cột 
--output: id, fullname, năm sinh
SELECT EmpID, FirstName + ' ' + LastName AS Fullname, year(Birthday) as YOB  
FROM Employee
--4. In ra danh sách tuổi các nhân viên
SELECT EmpID, FirstName + ' ' + LastName AS Fullname, year(getdate()) - year(Birthday) AS Age 
FROM Employee
--alias: giả danh
--5. In ra thông tin nhà cung cấp
SELECT * FROM Supplier
--cột ID: primary key - khóa chính
--6. In ra thông tin các nhà vận chuyển
SELECT * FROM Shipper
--7. In ra thông tin những chủng loại sản phẩm
SELECT * FROM Category
--8. In ra xem công ty bán những loại sản phẩm nào
SELECT * FROM Product
--9. Kiểm tra xem trong kho có những gì
SELECT * FROM Barn
--10. In ra thông tin các đơn hàng đã bán
SELECT * FROM Orders
--11. In ra thông tin của đơn hàng đã bán như sau
--mã đơn hàng, mã khách hàng đã mua, mã nhân viên đã bán, cân nặng
SELECT OrdID, CustomerID, EmpID, Freight 
FROM Orders
--12. In ra thông tin đơn hàng chi tiết
SELECT * FROM OrdersDetail