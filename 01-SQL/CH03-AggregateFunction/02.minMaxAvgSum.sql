--02- minMaxAvgSum.sql
CREATE DATABASE DBK17F2_ch03_Aggregate
USE DBK17F2_ch03_Aggregate
--Tạo table lưu điểm tb của sv
CREATE TABLE GPA(
	Name nvarchar(10),
	point float,
	major char(3),
)
INSERT INTO GPA VALUES (N'An', 9, 'IS')
insert into GPA values(N'Bình', 7, 'IS')
insert into GPA values(N'Cường', 5, 'IS')

insert into GPA values(N'Dũng', 8, 'JS')
insert into GPA values(N'Em', 7, 'JS')
insert into GPA values(N'Giang', 4, 'JS')
insert into GPA values(N'Hương', 8, 'JS')

insert into GPA values(N'Khanh', 7, 'ES')
insert into GPA values(N'Minh', 6, 'ES')
insert into GPA values(N'Nam', 5, 'ES')
insert into GPA values(N'Oanh', 5, 'ES')
---------------------
--Min(), Max(), Avg(), Sum()
-- 4 thằng trên đều là aggregate function
--4 thằng này đều là những hàm gom nhóm
--gom value trên 1 cột thành 1 cell(1 ô)
--count, max, min , sum
----Lưu ý*: các Aggregate function không thể lồng vào nhau
----------max(count(cột)) --> gãy
------------> phải thông qua Multiple Column
------**************---------
--1. Có tất cả bao nhiêu sinh viên
SELECT count(name) FROM GPA
SELECT count(*) FROM GPA
--2. Chuyên ngành nhúng có bao nhiêu sinh viên(IS)
SELECT count(*) FROM GPA WHERE major = 'IS'
SELECT count(name) FROM GPA WHERE major = 'IS'
--2.1 Chuyên ngành nhúng và cầu nối có tổng cộng bao nhiêu sinh
--viên('JS','IS')
SELECT count(name) FROM GPA WHERE major = 'IS' or major = 'JS'
--2.2 Con điểm bao nhiêu là cao nhất trong danh sách sinh viên
SELECT max(point) FROM GPA  
--2.3 ai là người cao điểm nhất trong đám sinh viên
SELECT Name FROM GPA WHERE point in (SELECT max(point) FROM GPA)
--All
SELECT * FROM GPA WHERE point >= All(SELECT point FROM GPA)
--2.4 tính tổng điểm của tất cả sinh viên
SELECT sum(point) FROM GPA
--2.5 điểm trung bình của tất cả sinh viên là bao nhiêu
SELECT Avg(point) FROM GPA
--3. Mỗi chuyên ngành có bao nhiêu sv
SELECT major, count(Name) FROM GPA GROUP BY major
---> khi trong câu có chữ "Mỗi - Each" thì phải dùng GROUP BY
--Group By: là gom nhóm các object theo 1 tiêu chuẩn nhóm nào đó
--vd: 1 ds sv gồm tên, yob, điểm, thành phố
-- Ta có thể gom nhóm sv theo năm sinh(yob)
--vd1: Đếm số lượng sv dựa vào năm sinh
------> Mỗi năm sinh có bn sv
--yob		số lượng
--1999		20
--2003		30
--2001		18
--Vd2: Mỗi Thành Phố có bao nhiêu sinh viên
--TP		Số lượng
--HCM		32
--HN		35
--Đà Nẵng	18
-->*Muốn xài group by thì phải nhớ thần chú sau*
--> khi đã xài group by, mệnh đề Select chỉ được dùng những gì có trong
--	group by, nếu không thì nó phải là Aggregate

--gom nhóm theo sinh viên theo thành phố
--thì Select chỉ có cột TP và Aggregate Count(Sinh viên)
---------****************------------
--4. Điểm cao nhất mỗi chuyên ngành là bn
SELECT major, max(point) FROM GPA GROUP BY major
--4. Điểm tb mỗi cn là bn
SELECT major, Avg(point) FROM GPA GROUP BY major
--Thêm vào 2 data nữa để tăng độ khó
INSERT INTO GPA VALUES(N'Phượng', 8 , 'JP')
--thêm Phượng 8 điểm, ngôn ngữ nhật
--->trường bổ sung thêm ngành hotel management
INSERT INTO GPA VALUES(Null, Null , 'HT')
--***Sau khi đã thêm data xem lại kết quả câu 3,  
--câu 3 làm lại:
SELECT major, count(*) FROM GPA GROUP BY major   --Ht 1 gãy
SELECT major, count(Name) FROM GPA GROUP BY major--Ht 0
---********************************--------------
--SELECT...FROM...WHERE....GROUP BY...HAVING...ORDER BY
--SELECT...FROM...GROUP BY...WHERE => gãy
--HAVING: dùng để lọc kết quả sau khi gom nhóm (Group by)
--bản thân của Having chính là Where thứ 2
--*khi đã xài group by, mệnh đề Select(Having) chỉ được dùng 
--  những gì có trong
--	group by, nếu không thì nó phải là Aggregate*
--********************************--
--5.Chuyên ngành nào có từ 4 sinh viên trở lên
--b1: sv của mỗi cn là bn
SELECT major, count(Name) FROM GPA 
GROUP BY major
HAVING COUNT(Name) >= 4
--5.1 Ngành IS, JS, ES mỗi ngành có bn sv
SELECT major, count(Name) FROM GPA 
GROUP BY major HAVING major in ('IS', 'JS', 'ES')
--Dùng WHERE
SELECT major, count(Name) FROM GPA 
WHERE major in ('IS', 'JS', 'ES') GROUP BY major 
--6. Cn nào có ít sv nhất
--Dùng All
SELECT major, count(Name) FROM GPA 
GROUP BY major 
HAVING COUNT(Name) <= All(SELECT count(Name) FROM GPA 
GROUP BY major)
--Dùng Min()
SELECT Major, count(Name) as Np FROM GPA 
Group By Major
--
SELECT min(np) FROM (SELECT Major, count(Name) as Np FROM GPA 
				Group By Major) as ld --0
--
SELECT Major, count(Name) as Np FROM GPA 
Group By Major
HAVING count(Name) = (SELECT min(np) FROM (SELECT Major, count(Name) as Np FROM GPA 
				Group By Major) as ld)

--7.Điểm lớn nhất của ngành IS là mấy điểm
--Dùng Max()
SELECT max(point) FROM GPA WHERE major = 'IS'
--Dùng All()
SELECT point FROM GPA WHERE major = 'IS' and point >= All(SELECT point FROM GPA WHERE major = 'IS')
--7.1 lấy Full thông tin của sinh viên thuộc ngành is có điểm
--lớn nhất --Dùng Max()
SELECT * FROM GPA WHERE point = (SELECT max(point) FROM GPA WHERE major = 'IS')
--11.Điểm lớn nhất của mỗi chuyên ngành(cẩn thận HT) --Dùng Max()
--gợi ý dùng iif
SELECT major, iif(max(point) is null, 0, max(point)) AS lp FROM GPA GROUP BY major
--12.Chuyên ngành nào có thủ khoa có điểm trên 8 --Dùng Max()
SELECT major, iif(max(point) is null, 0, max(point)) AS lp FROM GPA 
GROUP BY major HAVING MAX(point) > 8
--13***.Liệt kê những sinh viên đạt thủ khoa của mỗi chuyên ngành
--(chưa làm được)(đệ quy- join)
SELECT * FROM GPA
--Tìm xem điểm cao nhất của mỗi cn là bn
SELECT major, iif(max(point) is null, 0, max(point)) as HighestPnt FROM GPA GROUP BY major
---
SELECT * FROM (SELECT major, iif(max(point) is null, 0, max(point)) as HighestPnt 
	  FROM GPA GROUP BY major) as mc
	  left join GPA g
	  ON mc.major = g.major and mc.HighestPnt = g.point
-------------------
USE convenienceStoreDB
--************Đề******************
--14.1. Trọng lượng nào là con số lớn nhất, tức là trong các đơn "hàng đã vận chuyển",
-- trọng lượng nào là lớn nhất, trọng lượng lớn nhất 
--là bao nhiêu???
--> lấy giá trị lớn nhất trong 1 tập hợp
---Dùng All:
SELECT * FROM Orders 
WHERE Freight >= All(SELECT Freight FROM Orders)
---Dùng MAX Thử:
SELECT * FROM Orders 
WHERE Freight = (SELECT max(Freight) FROM Orders)
--14. Đơn hàng nào có trọng lượng lớn nhất
--Output: mã đơn, mã kh, trọng lượng
--dùng All thử:
SELECT OrdID, CustomerID, Freight FROM Orders 
WHERE Freight >= All(SELECT Freight FROM Orders)
--dùng MAX thử: 
SELECT OrdID, CustomerID, Freight FROM Orders 
WHERE Freight = (SELECT max(Freight) FROM Orders)
--15.Đếm số đơn hàng của mỗi quốc gia 
--Output: quốc gia, số đơn hàng
--nghe chữ mỗi: chia nhóm theo .... => dùng Group By ngay 
SELECT ShipCountry, count(OrdID) AS noOfOrd FROM Orders GROUP BY ShipCountry
--15.1-Hỏi rằng quốc gia nào có từ 8 đơn hàng trở lên
--việc đầu tiên là phải đếm số đơn hàng của mỗi quốc gia
--đếm xong, lọc lại coi thằng nào >= 8 đơn thì in 
--lọc lại sau khi group by, chính là HAVING
SELECT ShipCountry, COUNT(OrdID) FROM Orders 
GROUP BY ShipCountry HAVING COUNT(OrdID) >= 8
--16.Quốc gia nào có nhiều đơn hàng nhất??
--Output: quốc gia, số đơn hàng
--đếm xem mỗi quốc gia có bao nhiêu đơn hàng
--sau đó lọc lại
--Dùng ALL Thử: 
SELECT ShipCountry, COUNT(OrdID) as noOfOrd FROM Orders 
GROUP BY ShipCountry 
HAVING COUNT(OrdID) >= All(SELECT COUNT(OrdID) as noOfOrd FROM Orders 
GROUP BY ShipCountry)
--Dùng Max thử: 
SELECT ShipCountry, COUNT(OrdID) as noOfOrd FROM Orders 
GROUP BY ShipCountry 
HAVING COUNT(OrdID) = (SELECT max(noOfOrd) FROM 
(SELECT ShipCountry, COUNT(OrdID) as noOfOrd FROM Orders 
GROUP BY ShipCountry) as bf)
--Nếu ko đc dùng >= ALL
--tim max sau khi đếm, mà ko đc dùng max(count) do SQL ko cho phép
--ta sẽ count, coi kết quả count là 1 table, tìm max của table này để
--ra đc 12
--Thử dùng Max() xem sao

--17.Mỗi cty đã vận chuyển bao nhiêu đơn hàng
--Output1: Mã cty, số lượng đơn hàng - hint: group by ShipId(ShipVia)
SELECT ShipID, count(OrdID) as noOfOrd FROM Orders GROUP BY ShipId
--*khó*Output2: mã cty, tên cty, sl (để in ra được câu này thì phải học nhiều hơn)

--18.Cty nào vận chuyển ít đơn hàng nhất
--Output1: Mã cty, số lượng đơn
---Dùng All Thử: 
SELECT ShipID, count(OrdID) as noOfOrd FROM Orders 
GROUP BY ShipId 
HAVING COUNT(OrdID) <= All(SELECT count(OrdID) as noOfOrd FROM Orders 
GROUP BY ShipId)
---dùng Min() thử xem: 
SELECT ShipID, COUNT(OrdID) as noOfOrd FROM Orders 
GROUP BY ShipID 
HAVING COUNT(OrdID) = (SELECT min(noOfOrd) FROM 
(SELECT ShipID, COUNT(OrdID) as noOfOrd FROM Orders 
GROUP BY ShipID) as bf)
--*Khó*Output2: mã cty, tên cty, sl (để in ra được câu này thì phải học nhiều hơn)

--19.in ra danh sách id các khánh hàng kèm tổng
-- cân nặng của tất cả đơn hàng họ đã mua
---->câu này hỏi khác đi: số lượng cân nặng mà khách hàng đã mua
--hint: Sum + Group by:
SELECT CustomerID, sum(Freight) AS np FROM Orders
GROUP BY CustomerID

--20.khách hàng nào có tổng cân nặng của 
--tất cả đơn hàng họ đã mua là lớn nhất
--dùng ALL():
SELECT CustomerID, sum(FREIGHT) FROM Orders 
GROUP BY customerID 
HAVING sum(FREIGHT) >= All(SELECT sum(FREIGHT) FROM Orders 
GROUP BY customerID)
--Dùng Max thử: 
SELECT CustomerID, sum(Freight) as np FROM Orders
Group By CustomerID
--MultipleColumn
SELECT max(np) FROM (SELECT CustomerID, sum(Freight) as np FROM Orders
				Group By CustomerID) as ld
--
SELECT CustomerID, sum(Freight) as np FROM Orders
Group By CustomerID
Having sum(Freight) = (SELECT max(np) FROM (SELECT CustomerID, sum(Freight) as np FROM Orders
				Group By CustomerID) as ld)
--21.NY, London có tổng bao nhiêu đơn hàng
-- dùng count bth xem sao
SELECT ShipCity, count(OrdID) FROM Orders 
GROUP BY ShipCity 
HAVING ShipCity in ('NY', 'London')

--group by having, sum cho nghệ thuật: 
SELECT ShipCity, count(OrdId) as np FROM Orders
Group By ShipCity having ShipCity in ('LonDon', 'Ny')
---
SELECT sum(np) FROM (SELECT ShipCity, count(OrdId) as np FROM Orders
				Group By ShipCity having ShipCity in ('LonDon', 'Ny')) as ld
--22.công ty vận chuyển nào vận chuyển nhiều đơn hàng nhất
--dùng thử All(): 
SELECT ShipID, count(OrdID) FROM Orders 
GROUP BY ShipID 
HAVING count(OrdID) >= All(SELECT count(OrdID) FROM Orders GROUP BY ShipID)
--Dùng MAX() thử xem:
SELECT ShipId, count(OrdID) as Np FROM Orders
Group By ShipId
--MultipleColumn
SELECT max(np) FROM (SELECT ShipId, count(OrdID) as Np FROM Orders
				Group By ShipId) as ld
--
SELECT ShipId, count(OrdID) as Np FROM Orders
Group By ShipId
Having count(OrdID) = (SELECT max(np) FROM (SELECT ShipId, count(OrdID) as Np FROM Orders
				Group By ShipId) as ld)