--02-Trigger.sql
--trigger: cò súng
--trigger nó giống hàm(proc)
--proc là hàm thụ động
--	khi nào anh gọi thì nó mới chạy
----
--trigger nó làm hàm chủ động
--	khi thỏa điều kiện nào đó, nó sẽ tự chạy

--khi mà ta chạy 1 dòng insert
--	object mà ta đã insert sẽ được bỏ vào table inserted trước
--	khi nó được insert vào table dữ liệu
CREATE DATABASE DBK17F1_Trigger
USE DBK17F1_Trigger

CREATE TABLE tbl_Barn(
	ID int not null primary key,
	Name nvarchar(30) not null,
	Amount int not null
)

Insert into tbl_Barn values ('1', N'Number1', '10')
Insert into tbl_Barn values ('2', N'String', '15')

Create table tbl_Orders(
	SEQ int identity,
	CusID char(8) not null,
	ProID int not null,
	Amount int not null,
)
--tạo trigger canh sự kiện insert của Orders
 Create trigger trg_OrdersInsert On tbl_Orders after insert as
 Begin
	update tbl_Barn
		set Amount = b.Amount - (Select Amount from inserted Where ProID = b.ID)
		from tbl_Barn b join inserted i on b.ID = i.ProID
 End

 Insert into tbl_Orders values ('CUS002', '2', '2')
 Insert into tbl_Orders values ('CUS003', '1', '5')

 Create trigger trg_OrdersDelete on tbl_Orders for delete as
 Begin
	update tbl_Barn
	set Amount = b.Amount + (Select Amount From deleted
							 Where ProID = b.ID)
	From tbl_Barn b join deleted d on b.ID = d.ProID
 End

 Delete tbl_Orders Where SEQ = '2'

 Select * From tbl_Barn
 Select * From tbl_Orders
 --------
Create trigger trg_OrdersUpdate On tbl_Orders after update as
Begin
	update tbl_Barn 
	set Amount = b.Amount +
	(Select Amount From deleted Where ProID = b.ID) - 
	(Select Amount From inserted Where ProID = b.ID)
	From tbl_Barn b join deleted d on b.ID = d.ProID
End
