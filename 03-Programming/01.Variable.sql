--01-Variable.sql
--DB Engine là 1 môi trường/tool/app nhận lệnh sql
--kiểm tra cú pháp có sai hay ko
--dịch lệnh của mình
--> compiler and runtime

--DBE cung cấp cho mình 1 môi trường giống như bối cảnh
--của lập trình bằng "ngôn ngữ lập trình" nào đó
--SQL ko phải ngôn ngữ lập trình
--nhưng mà nó cho mình một vài syntax giống bối cảnh lập trình

--khai báo biến, có lệnh if else
--while.., có hàm (procedure - thủ tục)
--vì nó sẽ lấy data từ table chứ không phải từ bàn phím
--> nó không có hàm nhận giá trị từ bàn phím (scanf|scanner)

--Mục tiêu của lập trình trong database là gì?
--Khai thác và tính toán từ giữ liệu có sẵn trong table
--vì mục đích này nên nó không có đủ câu lệnh như 1 nnlt
--việc khai báo biến có thể gán giá trị luôn hoặc là từ table

Use DBK17F1_PromotionGirl
Select * From PromotionGirl
--Học cách khai báo biến (biến là cái túi đựng giá trị)
--declare @nameVariablke datatype
declare @yob int --tạo biến mà chưa gán giá trị
declare @yob2 int = 2003
set @yob = 1999 --muốn gán giá trị dùng set @name = value

print @yob2 --xem giá trị dưới dạng chuỗi
Select @yob
--------
declare @sms char(40) = 'Xin chao ban'
declare @sms2 as nvarchar(40) = 'xin chao ban'
Select @sms
Select @sms2

--procedure(ham thủ tục) - proc
--Viết 1 hàm có chức năng là: nếu bạn đưa tôi 1 ID. tôi sẽ tìm ra những nhân viên
--được lead bởi người có ID đó
--getMemberList(ID)
Create proc getMemberList1(@LeadID char(8)) as
begin
	Select * From PromotionGirl Where LID = @LeadID
end
--Đã tạo ra 1 proc cho database PromotionGirl

exec getMemberList1 'G51' -- Tìm các tv của leader có mã là G51

--tạo ra 1 proc
--nhận vào ID và tìm các tv của ID đó luôn
--nếu người dùng truyền null thì mình sẽ nói

Create proc getMemberList2(@LeadID char(8)) as
begin
	if @LeadID is null
		begin
			print N'M có biết nhập không?'
		end
	else
		begin
			Select * From PromotionGirl Where LID = @LeadID
		end
end
exec getMemberList2 'G50'

--Viết 1 proc getMemberList3 nhận vào LeadID
--nếu nhận vào null thì nói
--nếu nhận vào mã thì xem ds nhân sự
--nếu như không có nhân sự nào (đếm) thì nói là cô nhân viên đó ko lead ai cả
--nêu như có ds thì in ra ds
--hint SELECT count(*) as @soluong
--> gán giá trị vào biến @soluong
Create proc getMemberList3(@LeadID char(8)) as
begin
	if @LeadID is null
		begin
			print N'Mày có biết nhập ID không?'
		end
	else
		begin
			declare @count int
			Select @Count = count(ID) From PromotionGirl 
			Where LID = @LeadID
			if @Count = 0
				begin
					print @LeadID + N' Không phải là leader'
				end
			else
				begin
					Select * From PromotionGirl 
					Where LID = @LeadID
				end
		end
end
exec getMemberList3 'G51'