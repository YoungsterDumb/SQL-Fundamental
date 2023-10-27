--07-Null.sql
--Dữ liệu trong thực tế đôi khi ở thời điểm nhập liệu
--ta biết nó là kiểu gì nhưng lại biết cụ thể giá trị của nó
--Ở trạng thái đó, người ta gọi nó là undefine (bất định, vô định)
--Nêu các hs chưa có điểm
--WHERE point is null | not point is null | point is not null
--cấm: point = null 

--1. Xài db convenienceStoreDB
USE convenienceStoreDB
--2. Liệt kê danh sách khách hàng
SELECT * FROM Customer
--3. liệt kê danh sách các khách hàng chưa có số điện thoại
SELECT * FROM Customer WHERE PhoneNumber is null
--4. liệt kê danh sách các khách hàng đã cập nhật số điện thoại
SELECT * FROM Customer WHERE PhoneNumber is not null
--5. Liệt kê danh sách các đơn hàng chưa có ngày yêu cầu (requiredDate) và đến từ London và California
SELECT * FROM Orders
WHERE RequiredDate is null and (ShipCity = 'London' or ShipCity = 'California')
--6. Liệt kê danh sách các đơn hàng đã có có ngày yêu cầu (requiredDate)
SELECT * FROM Orders WHERE RequiredDate is not null
--7. liệt kê danh sách các đơn hàng đã có ngày yêu câu , được ship bởi 2 công ty vận chuyển SHIP001
--và SHIP004
SELECT * FROM Orders 
WHERE RequiredDate is not null and (ShipID = 'SHIP001' or ShipID = 'SHIP004')
--10. Đơn hàng nào ở London có ngày yêu cầu khác null
SELECT * FROM Orders
WHERE RequiredDate is not null and ShipCity = 'London'