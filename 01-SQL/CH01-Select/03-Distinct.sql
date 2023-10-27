--03-Distinct.sql
USE convenienceStoreDB

--1 table thường luôn có 1 cột đặc biệt là Primary Key (PK)
--1 câu lệnh select luôn trả ra kết quả dưới dạng table
-- khi mà ta select * thì ra kết quả trả về luôn không có dòng nào trùng 100%
--nhưng nếu ta SELECT cột, cột giả sử không liệt kê cột PK
--thì kết quả có thể trùng 100%
--những cặp trùng thì có tên là tuple
--để loại bỏ dòng trùng ta thêm Distinct ngay sau SELECT
--SELECT Distinct cột, cột  ...
--1. In ra thông tin khách hàng
SELECT * FROM Customer
--2. Khách hàng của bạn đã đến từ những thành phố nào 
--liệt kê danh sách các thành phố có khách hàng của bạn
SELECT Distinct City FROM Customer
--3. In ra thông tin các gói hàng đã nhập vào kho
SELECT * FROM InputBill
--4. In ra các sản phẩm đã nhập vào kho
SELECT Distinct ProID FROM InputBill