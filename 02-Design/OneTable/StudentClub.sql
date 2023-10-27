CREATE Database Studentclub
USE Studentclub
create table CLUB (
   CID                  char(9)              not null,
   CNAME                varchar(30)          not null,
   constraint PK_CLUB primary key nonclustered (CID)
)
go

/*==============================================================*/
/* Table: REGISTER                                              */
/*==============================================================*/
create table REGISTER (
   SEQ                  int                  not null,
   SID                  char(9)              null,
   CID                  char(9)              null,
   REGISDATE            datetime             null,
   LEAVDATE             datetime             null,
   constraint PK_REGISTER primary key nonclustered (SEQ)
)
go

/*==============================================================*/
/* Index: FK_REGISTRATION_SID_STUDENTSID_FK                     */
/*==============================================================*/
create index FK_REGISTRATION_SID_STUDENTSID_FK on REGISTER (
SID ASC
)
go

/*==============================================================*/
/* Index: FK_REGISTRATION_CID_CLUBCID_FK                        */
/*==============================================================*/
create index FK_REGISTRATION_CID_CLUBCID_FK on REGISTER (
CID ASC
)
go

/*==============================================================*/z
   constraint PK_STUDENT primary key nonclustered (SID)
)
go

alter table REGISTER
   add constraint FK_REGISTER_FK_REGIST_CLUB foreign key (CID)
      references CLUB (CID)
go

alter table REGISTER
   add constraint FK_REGISTER_FK_REGIST_STUDENT foreign key (SID)
      references STUDENT (SID)
go

