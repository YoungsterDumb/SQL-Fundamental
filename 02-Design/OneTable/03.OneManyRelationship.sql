--03-OneManyRelationship
CREATE DATABASE DBK17F2_OneManyRelationship
USE DBK17F2_OneManyRelationship

Create Table City(
	ID int not null,
	Name nvarchar(40),
)
Alter Table City
	add constraint PK_City_ID primary key(ID)
Alter Table City
	add constraint UQ_City_Name Unique(Name)

Insert Into City Values(1, N'TP.HCM')
Insert Into City Values(2, N'TP.Hà Nội')
Insert Into City Values(3, N'Bình Dương')
Insert Into City Values(4, N'Tây Ninh')
Insert Into City Values(5, N'Đắk Lắk')
Insert Into City Values(6, N'Bắc Kạn')

--Tạo table lưu các sv đi thi: Candidate: ứng viên
Create Table Candidate(
	ID char(5) not null,
	LastName nvarchar(15) not null,
	FirstName nvarchar(30) not null,
	CityID int,
)
Alter Table Candidate
	add constraint PK_Candidate_ID primary key(ID)
Alter Table Candidate
	add constraint PK_Candidate_CityID_tblCityID
		foreign key (CityID) references City(ID)
--1 sv thì đến từ 1 tp, 
--1 tp thì có nhiều sv
--tp(1): gốc|Root --- sv(N)nhánh|branch
Insert Into Candidate Values ('C1', N'Nguyễn', N'An', 1)
Insert Into Candidate Values ('C2', N'Lê', N'Bình', 1)
Insert Into Candidate Values ('C3', N'Võ', N'Cường', 2)
Insert Into Candidate Values ('C4', N'Phạm', N'Dũng', 3)
Insert Into Candidate Values ('C5', N'Trần', N'Em', 4)

--Ôn Tập SQL
--1.Liệt Kê Danh Sách Sinh Viên
Select * From Candidate
--2.Liệt kê danh sách sinh viên kèm theo thông tin của tp
Select c1.*, c2.Name as [City Name] 
From Candidate c1 left join City c2 On c1.CityID = c2.ID
--2.1.Liệt kê danh sách các tĩnh kèm thông tin sinh viên
Select c1.*, c2.Name as [City Name] 
From Candidate c1 right join City c2 On c1.CityID = c2.ID
--3. in ra các sinh viên ở thành phố hồ chí minh
Select * From Candidate 
Where CityID = (Select ID From City 
Where Name = 'TP.HCM')
--
Select c1.*, c2.Name as [City Name] 
From Candidate c1 left join City c2 On c1.CityID = c2.ID
Where c2.Name = 'TP.HCM'
--4.đếm xem có bao nhiêu sinh viên
Select count(ID) as NoOfCan From Candidate
--đếm xem mỗi tĩnh có bao nhiêu sinh viên
Select c2.ID, count(c1.ID) as NoOfCan From City c2 left join Candidate c1 
On c1.CityID = c2.ID Group By c2.ID
--đếm xem thành phố hồ chí minh có bao nhiêu sinh viên
Select Name, count(c1.ID) as NoOfCan From City c2 left join Candidate c1 
On c1.CityID = c2.ID Group By Name Having Name = 'TP.HCM'
--tĩnh nào nhiều sinh viên nhất
Select Name, count(c1.ID) as NoOfCan 
From City c2 left join Candidate c1 
On c1.CityID = c2.ID Group By Name 
Having count(c1.ID) >= All(Select count(c1.ID) as NoOfCan 
From City c2 left join Candidate c1 
On c1.CityID = c2.ID Group By Name)

--Hiện tượng đổ domino
--điều j sẽ xảy ra nếu như anh xóa đi 1 tỉnh thành 
--nếu 1 bên xóa | update thì bên N sẽ như thế nào
--nếu N bên xóa | update thì bên 1 sẽ như thế nào
Delete City Where ID = '1'
--Vi phạm FK, vì gốc đã mọc rễ rồi, em muốn xóa nó
--thì phải xóa hết rễ của thành phố đó
Delete City Where ID = '5'
--Vì City có mã là 5 chưa có sv nào liên kết
--Gốc chưa có rễ thì không bị ràng buộc

--Nếu như anh xóa bên 1 thì bên N sẽ ntn?
--Để xóa bên 1 thì phải xóa các nhành liên kết bên N trc
--Nếu anh xóa bên nhiều thì sao? Bên 1 chả sao cả
--Muốn update mã của Bình Dương về từ 3 thành 333
Update City set ID = '333' Where ID = '3'
--update giống delete

--Tạo hiệu ứng domino để thỏa nhu cầu, xóa hay update 1 thì N sẽ cập nhật theo
--DominoV2

Create Table CityV2(
	ID int not null,
	Name nvarchar(40),
)
Alter Table CityV2
	add constraint PK_CityV2_ID primary key(ID)
Alter Table CityV2
	add constraint UQ_CityV2_Name Unique(Name)

Insert Into CityV2 Values(1, N'TP.HCM')
Insert Into CityV2 Values(2, N'TP.Hà Nội')
Insert Into CityV2 Values(3, N'Bình Dương')
Insert Into CityV2 Values(4, N'Tây Ninh')
Insert Into CityV2 Values(5, N'Đắk Lắk')
Insert Into CityV2 Values(6, N'Bắc Kạn')

--Tạo table lưu các sv đi thi: Candidate: ứng viên
Create Table CandidateV2(
	ID char(5) not null,
	LastName nvarchar(15) not null,
	FirstName nvarchar(30) not null,
	CityID int,
)
Alter Table CandidateV2
	add constraint PK_CandidateV2_ID primary key(ID)
Alter Table CandidateV2
	add constraint PK_CandidateV2_CityID_tblCityV2ID
		foreign key (CityID) references CityV2(ID)
			on delete set null -- nếu gốc xóa, rễ set null
			on update cascade -- nếu update thì rễ ăn theo

Insert Into CandidateV2 Values ('C1', N'Nguyễn', N'An', 1)
Insert Into CandidateV2 Values ('C2', N'Lê', N'Bình', 1)
Insert Into CandidateV2 Values ('C3', N'Võ', N'Cường', 2)
Insert Into CandidateV2 Values ('C4', N'Phạm', N'Dũng', 3)
Insert Into CandidateV2 Values ('C5', N'Trần', N'Em', 4)

Delete CityV2 Where ID = '1'
Select * From CandidateV2

Delete CityV2 Where ID = '4'

Update CityV2 set ID = '333' Where ID = '3'