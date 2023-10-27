--04-OrderBy
-- SELECT luôn trả về kết quả dưới dạng table
-- Ta có thể sắp xếp kết quả theo một cột nào
-- việc sắp xếp chỉ ảnh hưởng đến kết quả, không ảnh hưởng data gốc
-- Quy tắc so sánh
--		Số: so sánh bthg
--		ngày tháng: so sánh theo
--			12/7/1999 < 10/5/2022
--		Chuỗi: chuỗi dài hơn không có nghĩa là lớn hơn
--		Chuỗi so sánh theo ASCII, nó không quan tâm hoa thường
--		So sánh theo nhiều cột cùng lúc
--		 không quan tâm vị trí luôn từ trái qua phải
-- Sắp xếp theo cột đầu tiên xong,
--  nội bộ những thằng trùng thì sẽ sắp xếp qua cột tiếp theo
-- Score theo chiều tăng dần
-- Sắp xếp name theo chiều giảm dần

--ASC: ascending - tăng dần | DESC: descending - giảm dần

--ORDER BY luôn nằm cuối câu select
--SELECT DISTINCT *
USE convenienceStoreDB
--1. In ra thông tin các đơn hàng
SELECT * FROM Orders
--2. Liệt kê danh sách các đơn hàng đã được sắp xếp theo trọng lượng
SELECT * FROM Orders ORDER BY Freight ASC
--3. Sắp xếp tên của nhân viên
--tăng dần 
SELECT * FROM Employee ORDER BY FirstName
--giảm dần
SELECT * FROM Employee ORDER BY FirstName DESC
--4. Sắp xếp các đơn hàng tăng dần theo mã nhân viên chịu trách nhiệm
--   và giảm dần theo trọng lượng
SELECT * FROM Orders ORDER BY EmpID ASC, Freight DESC