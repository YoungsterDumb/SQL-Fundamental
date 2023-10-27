--05-SuperMarket.sql
--thiết kế 1 table customer
--quản lý khách hàng gồm
--(id,name,dob,sex,numberOFInhabitants,phone,email,typeOFCustomer)
Create Database DBK17F1_SuperMarket
Use DBK17F1_SuperMarket
Create Table Customer(
	ID char(8) not null,
	FirstName nvarchar(30) not null,
	LastName nvarchar(30) not null,
	DOB date,
	Sex char(2) null,
	numberOfInhabitants char(10) null,
	Phone char(10) null,
	Email varchar(50) null,
	typeOfCustomer char(10) not null,
)
Alter Table Customer 
	add constraint PK_Customer_ID primary key(ID)
Alter Table Customer
	add constraint UQ_Customer_Email unique(Email)


