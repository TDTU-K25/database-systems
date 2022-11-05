/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2017                    */
/* Created on:     10/30/2022 1:00:00 AM                        */
/*==============================================================*/


if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('BAIBAO') and o.name = 'FK_BAIBAO_TACGIACHI_TACGIA')
alter table BAIBAO
   drop constraint FK_BAIBAO_TACGIACHI_TACGIA
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('CAUHOI') and o.name = 'FK_CAUHOI_CAUHOI_BAIBAO')
alter table CAUHOI
   drop constraint FK_CAUHOI_CAUHOI_BAIBAO
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('CAUHOI') and o.name = 'FK_CAUHOI_CAUHOI2_NHAKHOAH')
alter table CAUHOI
   drop constraint FK_CAUHOI_CAUHOI2_NHAKHOAH
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('CHITIETDANHGIA') and o.name = 'FK_CHITIETD_CHITIETDA_NHAKHOAH')
alter table CHITIETDANHGIA
   drop constraint FK_CHITIETD_CHITIETDA_NHAKHOAH
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('CHITIETDANHGIA') and o.name = 'FK_CHITIETD_CHITIETDA_BAIBAO')
alter table CHITIETDANHGIA
   drop constraint FK_CHITIETD_CHITIETDA_BAIBAO
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('THAMGIAVIETBAO') and o.name = 'FK_THAMGIAV_THAMGIAVI_BAIBAO')
alter table THAMGIAVIETBAO
   drop constraint FK_THAMGIAV_THAMGIAVI_BAIBAO
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('THAMGIAVIETBAO') and o.name = 'FK_THAMGIAV_THAMGIAVI_TACGIA')
alter table THAMGIAVIETBAO
   drop constraint FK_THAMGIAV_THAMGIAVI_TACGIA
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('BAIBAO')
            and   name  = 'TACGIACHINH_FK'
            and   indid > 0
            and   indid < 255)
   drop index BAIBAO.TACGIACHINH_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('BAIBAO')
            and   type = 'U')
   drop table BAIBAO
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('CAUHOI')
            and   name  = 'CAUHOI2_FK'
            and   indid > 0
            and   indid < 255)
   drop index CAUHOI.CAUHOI2_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('CAUHOI')
            and   name  = 'CAUHOI_FK'
            and   indid > 0
            and   indid < 255)
   drop index CAUHOI.CAUHOI_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('CAUHOI')
            and   type = 'U')
   drop table CAUHOI
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('CHITIETDANHGIA')
            and   name  = 'CHITIETDANHGIA2_FK'
            and   indid > 0
            and   indid < 255)
   drop index CHITIETDANHGIA.CHITIETDANHGIA2_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('CHITIETDANHGIA')
            and   name  = 'CHITIETDANHGIA_FK'
            and   indid > 0
            and   indid < 255)
   drop index CHITIETDANHGIA.CHITIETDANHGIA_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('CHITIETDANHGIA')
            and   type = 'U')
   drop table CHITIETDANHGIA
go

if exists (select 1
            from  sysobjects
           where  id = object_id('NHAKHOAHOC')
            and   type = 'U')
   drop table NHAKHOAHOC
go

if exists (select 1
            from  sysobjects
           where  id = object_id('TACGIA')
            and   type = 'U')
   drop table TACGIA
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('THAMGIAVIETBAO')
            and   name  = 'THAMGIAVIETBAO2_FK'
            and   indid > 0
            and   indid < 255)
   drop index THAMGIAVIETBAO.THAMGIAVIETBAO2_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('THAMGIAVIETBAO')
            and   name  = 'THAMGIAVIETBAO_FK'
            and   indid > 0
            and   indid < 255)
   drop index THAMGIAVIETBAO.THAMGIAVIETBAO_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('THAMGIAVIETBAO')
            and   type = 'U')
   drop table THAMGIAVIETBAO
go

/*==============================================================*/
/* Table: BAIBAO                                                */
/*==============================================================*/
create table BAIBAO (
   MABAIBAO             char(10)             not null,
   EMAILTG              varchar(100)         not null,
   TUADE                nvarchar(30)         null,
   TOMTAT               nvarchar(255)        null,
   TENFILELUUTRU        varchar(50)          null,
   constraint PK_BAIBAO primary key (MABAIBAO)
)
go

/*==============================================================*/
/* Index: TACGIACHINH_FK                                        */
/*==============================================================*/




create nonclustered index TACGIACHINH_FK on BAIBAO (EMAILTG ASC)
go

/*==============================================================*/
/* Table: CAUHOI                                                */
/*==============================================================*/
create table CAUHOI (
   MABAIBAO             char(10)             not null,
   EMAILNKH             varchar(100)         not null,
   STT                  int                  not null,
   NOIDUNGCAUHOI        nvarchar(255)        null,
   constraint PK_CAUHOI primary key (MABAIBAO, EMAILNKH, STT)
)
go

/*==============================================================*/
/* Index: CAUHOI_FK                                             */
/*==============================================================*/




create nonclustered index CAUHOI_FK on CAUHOI (MABAIBAO ASC)
go

/*==============================================================*/
/* Index: CAUHOI2_FK                                            */
/*==============================================================*/




create nonclustered index CAUHOI2_FK on CAUHOI (EMAILNKH ASC)
go

/*==============================================================*/
/* Table: CHITIETDANHGIA                                        */
/*==============================================================*/
create table CHITIETDANHGIA (
   EMAILNKH             varchar(100)         not null,
   MABAIBAO             char(10)             not null,
   NHANXETCHUNG         nvarchar(255)        null,
   DIEMCHATLUONG        float                null,
   DIEMDOCDAO           float                null,
   DIEMTUONGTHICH       float                null,
   DIEMTRINHBAY         float                null,
   KHANANGTIENCU        char(5)              null,
   constraint PK_CHITIETDANHGIA primary key (EMAILNKH, MABAIBAO)
)
go

/*==============================================================*/
/* Index: CHITIETDANHGIA_FK                                     */
/*==============================================================*/




create nonclustered index CHITIETDANHGIA_FK on CHITIETDANHGIA (EMAILNKH ASC)
go

/*==============================================================*/
/* Index: CHITIETDANHGIA2_FK                                    */
/*==============================================================*/




create nonclustered index CHITIETDANHGIA2_FK on CHITIETDANHGIA (MABAIBAO ASC)
go

/*==============================================================*/
/* Table: NHAKHOAHOC                                            */
/*==============================================================*/
create table NHAKHOAHOC (
   EMAILNKH             varchar(100)         not null,
   HONKH                nvarchar(30)         null,
   TENNKH               nvarchar(10)         null,
   SODIENTHOAI          char(10)             null,
   HOCVINKH             nvarchar(20)         null,
   CHUCVINKH            nvarchar(20)         null,
   NHUNGHUONGNGHIENCUU  nvarchar(50)         null,
   constraint PK_NHAKHOAHOC primary key (EMAILNKH)
)
go

/*==============================================================*/
/* Table: TACGIA                                                */
/*==============================================================*/
create table TACGIA (
   EMAILTG              varchar(100)         not null,
   HOTG                 nvarchar(30)         null,
   TENTG                nvarchar(10)         null,
   BOMON                nvarchar(50)         null,
   KHOA                 nvarchar(50)         null,
   TRUONGCONGTAC        nvarchar(50)         null,
   HOCVITG              nvarchar(20)         null,
   CHUCVITG             nvarchar(20)         null,
   constraint PK_TACGIA primary key (EMAILTG)
)
go

/*==============================================================*/
/* Table: THAMGIAVIETBAO                                        */
/*==============================================================*/
create table THAMGIAVIETBAO (
   MABAIBAO             char(10)             not null,
   EMAILTG              varchar(100)         not null,
   constraint PK_THAMGIAVIETBAO primary key (MABAIBAO, EMAILTG)
)
go

/*==============================================================*/
/* Index: THAMGIAVIETBAO_FK                                     */
/*==============================================================*/




create nonclustered index THAMGIAVIETBAO_FK on THAMGIAVIETBAO (MABAIBAO ASC)
go

/*==============================================================*/
/* Index: THAMGIAVIETBAO2_FK                                    */
/*==============================================================*/




create nonclustered index THAMGIAVIETBAO2_FK on THAMGIAVIETBAO (EMAILTG ASC)
go

alter table BAIBAO
   add constraint FK_BAIBAO_TACGIACHI_TACGIA foreign key (EMAILTG)
      references TACGIA (EMAILTG)
go

alter table CAUHOI
   add constraint FK_CAUHOI_CAUHOI_BAIBAO foreign key (MABAIBAO)
      references BAIBAO (MABAIBAO)
go

alter table CAUHOI
   add constraint FK_CAUHOI_CAUHOI2_NHAKHOAH foreign key (EMAILNKH)
      references NHAKHOAHOC (EMAILNKH)
go

alter table CHITIETDANHGIA
   add constraint FK_CHITIETD_CHITIETDA_NHAKHOAH foreign key (EMAILNKH)
      references NHAKHOAHOC (EMAILNKH)
go

alter table CHITIETDANHGIA
   add constraint FK_CHITIETD_CHITIETDA_BAIBAO foreign key (MABAIBAO)
      references BAIBAO (MABAIBAO)
go

alter table THAMGIAVIETBAO
   add constraint FK_THAMGIAV_THAMGIAVI_BAIBAO foreign key (MABAIBAO)
      references BAIBAO (MABAIBAO)
go

alter table THAMGIAVIETBAO
   add constraint FK_THAMGIAV_THAMGIAVI_TACGIA foreign key (EMAILTG)
      references TACGIA (EMAILTG)
go

