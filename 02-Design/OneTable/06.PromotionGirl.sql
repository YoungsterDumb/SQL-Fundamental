--06-PromotionGirl.sql
	--(kỹ thuật đệ quy khóa ngoại)
	--tạo table lưu trữ thông tin các em promotion girl
	--trong đám promotion girl
	--sẽ có 1 vài em được chọn ra để quản lý các em khác chia thành nhiều team

--Lấy ra những bạn làm leader trong đám promotionGirl
	--Lấy ra nhưng thành viên của 1 leader theo mã Leader đó
	--	kèm cả leader đó
	--NV A đã lead những ai
Create Database DBK17F1_PromotionGirl
Use DBK17F1_PromotionGirl
Create Table PromotionGirl(
	ID char(8) not null primary key,
	Name nvarchar(30) not null,
	Phone char(10),
	LID char(8) not null,
	constraint FK_PromotionGirl_LID_ID
		foreign key (LID) references PromotionGirl(ID)
)
Insert Into PromotionGirl Values ('G50', N'Hoa', null, 'G50')
Insert Into PromotionGirl Values ('G51', N'Lê', null, 'G51')
Insert Into PromotionGirl Values ('G52', N'Tuyết Tuyết', null, 'G52')
Insert Into PromotionGirl Values ('G1', N'Lan', null, 'G50')
insert into PromotionGirl values('G2',N'Hồng',null,'G50')
insert into PromotionGirl values('G3',N'Huệ',null,'G50')
insert into PromotionGirl values('G4',N'Lài',null,'G50')
insert into PromotionGirl values('G10',N'Mơ',null,'G51')
insert into PromotionGirl values('G11',N'Mận',null,'G51')
insert into PromotionGirl values('G12',N'Đào',null,'G51')
insert into PromotionGirl values('G13',N'Cam',null,'G51')
insert into PromotionGirl values('G20',N'Hường',null,'G52')
insert into PromotionGirl values('G21',N'Xuân',null,'G52')
insert into PromotionGirl values('G22',N'Tím',null,'G52')
insert into PromotionGirl values('G23',N'Hồng Hồng',null,'G52')

--ID		Name		Team
--G1		Lan			  1
--G2		Hue			  2
--G3		Hong		  1
--G4		Tra			  2
--G5		Mai			  2

select * from PromotionGirl
--một table mà số dòng của nó quan hệ với chính cách dòng trong table đó
--người ta gọi là quan hệ đệ quy