-- 01-Select
-- Lưu ý: Trong DB không quan tâm hoa thường
-- Chữ nào màu xanh thì viết hoa (full)

-- Selacet có 2 chức năng:
--- 1. Dùng để in ra màn hình giống printf, sout, cls.log
		--SELECT luôn trả kq dưới dạng table
		SELECT 'haha'
--- 2. Dùng để trích xuất dữ liệu từ table (bài sau)
-- Datatype: Kiểu dữ liệu
--> Số: Int, Decimal, Float, Double, Money(vnd, $)
--> Chuỗi: char(?), nchar(?), varchar(?), nvarchar(?)
		--?: kích thước của chuỗi
			--'hello\0' --> char(6)
		--n: dùng unicode (viết dấu)
--char() | nchar(): lưu trong ram, giới hạn bởi kích thước
				-- xin nhiều xài ít bù 32(space)
--char(10) --> 'hello\0    '
--varchar() | nvarchar(): lưu ở ổ cứng, không giới hạn kích thước,
--						 có co giãn
--varchar(30) --> 'hello\0'

-- Biểu diễn chuỗi thì pahir bỏ trong cặp nháy đơn
-- Nếu biểu diễn chuỗi có dấu thì thêm N''
SELECT N'Xin chào bạn'
-- Ngày tháng năm: date, datetime, YYYY-MM-DD
-- Biểu diễn như chuỗi
SELECT '2022-05-13'
----
-- Built in function: hàm có sẵn
-- round(number, regit) làm tròn
SELECT round(5.67, 1) --->5.7

--year(): trích xuất ra năm từ ngày tháng năm
SELECT year('2022-05-13')
--month(), day(),...
--getdate(): lấy datetime hiện hành

--------------------------------
--1.in ra màn hình: 'Anh Điệp dthg, cute phô mai que'
SELECT N'Anh Điệp dthg, cute phô mai que'
--2.cho em 3 chuỗi: 'Tên của em', '<3', 'Anh Điệp'
--nối 3 chữ lại thành 1, hint: +
SELECT N'Minh' + ' <3 ' + N'Anh Điệp'
--3.In ra ngày tháng năm hôm nay
SELECT '2022-05-13' -- Hardcode: code cứng
SELECT getdate()
--4. Năm nay là năm bn
SELECT year(getdate())
--5. Bây giờ là tháng mấy
SELECT month(getdate())
--6. in ra kq của 10 + 12
SELECT 10 + 12 -- 22
SELECT '10' + 12 -- 22 (JS: 1012)
SELECT '10' + '12' -- 1012
SELECT '12' + '10' -- error (JS: 2)