--04-SurrogateKey.sql
--Key nhân tạo, Key tự tăng, Key thay thế
--SQL cho mình 2 cơ chế phát sinh số tự tăng
--	+ phát sinh ra số ko trùng lại số cũ trên table
--	+ phát sinh hcuooix mã hóa không trùng chuỗi cũ trên toàn bộ database
Use DBK17F2_OneManyRelationship
Create Table KeyWords(
	SEQ int identity(5,5),
		--Sequence: tuần tự
		--mỗi lần chèn 1 object nào
		--thì cột SEQ tự có số 
		--ban đàu sẽ là 5
		--lần tiếp theo số đó sẽ tăng 5
	InputText nvarchar(40),
	InputDate datetime, --Lưu ngày và giờ
	IP char(40),
	constraint PK_KeyWords_SEQ primary key(SEQ)
)
Insert Into KeyWords Values (N'Điện Thoại 1', GETDATE(), '10.1.1.1.1')
Insert Into KeyWords Values (N'Điện Thoại 2', GETDATE(), '10.1.1.1.1')
Insert Into KeyWords Values (N'Phone', GETDATE(), '10.1.1.1.1')
--khi chèn thiếu cột mà cột đó là indentity thì ko cần liệt kê 
Select * From KeyWords
drop table KeyWords
Create Table KeyWordsV2(
	SEQ uniqueidentifier default newID() not null,
	InputText nvarchar(40),
	InputDate datetime, --Lưu ngày và giờ
	IP char(40),
	constraint PK_KeyWordsV2_SEQ primary key(SEQ)
)
Insert Into KeyWordsV2 (InputText, InputDate, IP)
	Values (N'Điện Thoại 1', GETDATE(), '10.1.1.1.1')
Insert Into KeyWordsV2 (InputText, InputDate, IP)
	Values (N'Điện Thoại 2', GETDATE(), '10.1.1.1.1')
Insert Into KeyWordsV2 (InputText, InputDate, IP)
	Values (N'Phone', GETDATE(), '10.1.1.1.1')

Select * From KeyWordsV2

--Surrogate key
--Ý nghĩa
--1-Tạo key giả trong tình huống ko có ai làm primary key
--2-Thay thế có composite key
--3-Tránh đc hiệu ứng đổ domino
-------------
--Tạo table lưu trữ sv và cn theo học
--1 sv thì có 1 cn
--1 cn thì có n sv
--cn(1)			sv(N)
-------Natural key-------
Create Table MajorV1(
	ID char(2) not null primary key,
	Name nvarchar(30),
)
Insert Into MajorV1 Values('SB', N'Quản trị kinh doanh')
Insert Into MajorV1 Values('SE', N'Kĩ thuật phần mềm')
Insert Into MajorV1 Values('GD', N'Thiết kế đồ họa')

Create Table StudentV1(
	ID char(8) not null primary key,
	Name nvarchar(40),
	MID char(2),
	constraint FK_StudentV1_MID_MajorV1ID
		foreign key (MID) references MajorV1(ID)
		on delete set null
		on update cascade
)
Insert Into StudentV1 Values('S1', N'An', 'GD')
Insert Into StudentV1 Values('S2', N'Bình', 'GD')
Insert Into StudentV1 Values('S3', N'Cường', 'SB')
Insert Into StudentV1 Values('S4', N'Dũng', 'SB')

Select * From StudentV1

Create Table MajorV2(
	SEQ int identity(1,1) primary key,
	ID char(2) not null,
	Name nvarchar(30),
)
Insert Into MajorV2 Values('SB', N'Quản trị kinh doanh')
Insert Into MajorV2 Values('SE', N'Kĩ thuật phần mềm')
Insert Into MajorV2 Values('GD', N'Thiết kế đồ họa')

Create Table StudentV2(
	ID char(8) not null primary key,
	Name nvarchar(40),
	MID int,
	constraint FK_StudentV2_MID_MajorV2SEQ
		foreign key (MID) references MajorV2(SEQ)
)
Insert Into StudentV2 Values('S1', N'An', '1')
Insert Into StudentV2 Values('S2', N'Bình', '1')
Insert Into StudentV2 Values('S3', N'Cường', '2')
Insert Into StudentV2 Values('S4', N'Dũng', '2')

Update MajorV2 set ID = 'SS' Where ID = 'SB'
Select * From MajorV2
Select * From StudentV2

--05-SuperMaket:siêu thị
--thiết kế 1 table customer
--quản lý khách hàng gồm
--(id,name,dob,sex,numberOFInhabitants,phone,email,typeOFCustomer)

--06-PromotionGirl
	--(kỹ thuật đệ quy khóa ngoại)
	--tạo table lưu trữ thông tin các em promotion girl
	--trong đám promotion girl
	--sẽ có 1 vài em được chọn ra để quản lý các em khác chia thành nhiều team

--Lấy ra những bạn làm leader trong đám promotionGirl
	--Lấy ra nhưng thành viên của 1 leader theo mã Leader đó
	--	kèm cả leader đó
	--NV A đã lead những ai