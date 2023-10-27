--01-Count.sql
--Aggregate: gom tụ -> biến cột (bảng) thành 1 ô kq
--count(): dùng để đếm số lượng
--count(*): cứ có hàng là đếm | đếm hàng
--count(cột): ô nào trong cột có value thì đếm, null thì bỏ qua
--Câu select mà có Aggregate function thì luôn luôn kết quả là singleValue
USE convenienceStoreDB
--1. Liệt kê ds các nhân viên
SELECT * FROM Employee
--2. Đếm xem có bao nhiêu nhân viên
SELECT count(*) as noOfEmployee FROM Employee
--3. Có bao nhiêu mã nhân viên
SELECT count(EmpID) as noOfEmployee FROM Employee
-----
SELECT count(*) as noOfEmployee FROM Employee
--4*. Đếm xem bao nhiêu đơn hàng có ngày yêu cầu
SELECT count(RequiredDate) as noOfRequiredDate FROM Orders
--5.đếm xem có bao nhiêu khách hàng có số điện thoại (5)
SELECT count(PhoneNumber) as noOfPhoneNumber FROM Customer
--6.đếm xem có bao nhiêu thành phố đã được xuất hiện trong table khách hàng, cứ có là đếm
SELECT count(City) as noOfCity FROM Customer
--6.1 Đếm xem có bao nhiêu thành phố, mỗi thành phố đếm 1 lần (kh)
SELECT count(DISTINCT city) as noOfCity FROM Customer
--7. Đếm xem có bao nhiêu tp trong table NV, mỗi tp đếm (nv)
SELECT count(DISTINCT city) as noOfCity FROM Employee
--8. Có bao nhiêu khách hàng chưa xd đc số điện thoại (5)
SELECT count(CusID) - count(PhoneNumber) as noOfNullPhoneNumber FROM Customer
SELECT count(CusID) as noOfNullPhoneNumber FROM Customer
WHERE PhoneNumber is null