/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2017                    */
/* Created on:     10/24/2022 8:00:00 PM                        */
/*==============================================================*/


if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('BAIBAO') and o.name = 'FK_BAIBAO_TACGIACHI_TACGIA')
alter table BAIBAO
   drop constraint FK_BAIBAO_TACGIACHI_TACGIA
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('CAUHOI') and o.name = 'FK_CAUHOI_DATCAUHOI_NHAKHOAH')
alter table CAUHOI
   drop constraint FK_CAUHOI_DATCAUHOI_NHAKHOAH
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('CAUHOI') and o.name = 'FK_CAUHOI_DUOCDATCA_BAIBAO')
alter table CAUHOI
   drop constraint FK_CAUHOI_DUOCDATCA_BAIBAO
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('CHITIETDANHGIA') and o.name = 'FK_CHITIETD_DANHGIA_NHAKHOAH')
alter table CHITIETDANHGIA
   drop constraint FK_CHITIETD_DANHGIA_NHAKHOAH
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('CHITIETDANHGIA') and o.name = 'FK_CHITIETD_DUOCDANHG_BAIBAO')
alter table CHITIETDANHGIA
   drop constraint FK_CHITIETD_DUOCDANHG_BAIBAO
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('CHITIETTHAMGIAVIETBAO') and o.name = 'FK_CHITIETT_DUOCVIET_BAIBAO')
alter table CHITIETTHAMGIAVIETBAO
   drop constraint FK_CHITIETT_DUOCVIET_BAIBAO
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('CHITIETTHAMGIAVIETBAO') and o.name = 'FK_CHITIETT_VIET_TACGIA')
alter table CHITIETTHAMGIAVIETBAO
   drop constraint FK_CHITIETT_VIET_TACGIA
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
            and   name  = 'DUOCDATCAUHOI_FK'
            and   indid > 0
            and   indid < 255)
   drop index CAUHOI.DUOCDATCAUHOI_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('CAUHOI')
            and   name  = 'DATCAUHOI_FK'
            and   indid > 0
            and   indid < 255)
   drop index CAUHOI.DATCAUHOI_FK
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
            and   name  = 'DANHGIA_FK'
            and   indid > 0
            and   indid < 255)
   drop index CHITIETDANHGIA.DANHGIA_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('CHITIETDANHGIA')
            and   name  = 'DUOCDANHGIA_FK'
            and   indid > 0
            and   indid < 255)
   drop index CHITIETDANHGIA.DUOCDANHGIA_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('CHITIETDANHGIA')
            and   type = 'U')
   drop table CHITIETDANHGIA
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('CHITIETTHAMGIAVIETBAO')
            and   name  = 'DUOCVIET_FK'
            and   indid > 0
            and   indid < 255)
   drop index CHITIETTHAMGIAVIETBAO.DUOCVIET_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('CHITIETTHAMGIAVIETBAO')
            and   name  = 'VIET_FK'
            and   indid > 0
            and   indid < 255)
   drop index CHITIETTHAMGIAVIETBAO.VIET_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('CHITIETTHAMGIAVIETBAO')
            and   type = 'U')
   drop table CHITIETTHAMGIAVIETBAO
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

/*==============================================================*/
/* Table: BAIBAO                                                */
/*==============================================================*/
create table BAIBAO (
   MABAIBAO             char(10)             not null,
   EMAILTGC             varchar(100)         not null,
   TUADE                varchar(30)          null,
   TOMTAT               text                 null,
   TENFILELUUTRU        varchar(50)          null,
   constraint PK_BAIBAO primary key (MABAIBAO)
)
go

/*==============================================================*/
/* Index: TACGIACHINH_FK                                        */
/*==============================================================*/




create nonclustered index TACGIACHINH_FK on BAIBAO (EMAILTGC ASC)
go

/*==============================================================*/
/* Table: CAUHOI                                                */
/*==============================================================*/
create table CAUHOI (
   MABAIBAO             char(10)             not null,
   EMAILNKH             varchar(100)         not null,
   STT                  int                  not null,
   NOIDUNGCAUHOI        text                 null,
   constraint PK_CauHoi primary key (MABAIBAO, EMAILNKH, STT)
)
go

/*==============================================================*/
/* Index: DATCAUHOI_FK                                          */
/*==============================================================*/




create nonclustered index DATCAUHOI_FK on CAUHOI (EMAILNKH ASC)
go

/*==============================================================*/
/* Index: DUOCDATCAUHOI_FK                                      */
/*==============================================================*/




create nonclustered index DUOCDATCAUHOI_FK on CAUHOI (MABAIBAO ASC)
go

/*==============================================================*/
/* Table: CHITIETDANHGIA                                        */
/*==============================================================*/
create table CHITIETDANHGIA (
   EMAILNKH             varchar(100)         not null,
   MABAIBAO             char(10)             not null,
   NHANXETCHUNG         text                 null,
   DIEMCHATLUONG        float                null,
   DIEMDOCDAO           float                null,
   DIEMTUONGTHICH       float                null,
   DIEMTRINHBAY         float                null,
   KHANANGTIENCU        char(5)              null,
   constraint PK_ChiTietDanhGia primary key (EMAILNKH, MABAIBAO)
)
go

/*==============================================================*/
/* Index: DUOCDANHGIA_FK                                        */
/*==============================================================*/




create nonclustered index DUOCDANHGIA_FK on CHITIETDANHGIA (MABAIBAO ASC)
go

/*==============================================================*/
/* Index: DANHGIA_FK                                            */
/*==============================================================*/




create nonclustered index DANHGIA_FK on CHITIETDANHGIA (EMAILNKH ASC)
go

/*==============================================================*/
/* Table: CHITIETTHAMGIAVIETBAO                                 */
/*==============================================================*/
create table CHITIETTHAMGIAVIETBAO (
   MABAIBAO             char(10)             not null,
   EMAILTG              varchar(100)         not null,
   constraint PK_ChiTietThamGiaVietBao primary key (MABAIBAO, EMAILTG)
)
go

/*==============================================================*/
/* Index: VIET_FK                                               */
/*==============================================================*/




create nonclustered index VIET_FK on CHITIETTHAMGIAVIETBAO (EMAILTG ASC)
go

/*==============================================================*/
/* Index: DUOCVIET_FK                                           */
/*==============================================================*/




create nonclustered index DUOCVIET_FK on CHITIETTHAMGIAVIETBAO (MABAIBAO ASC)
go

/*==============================================================*/
/* Table: NHAKHOAHOC                                            */
/*==============================================================*/
create table NHAKHOAHOC (
   EMAILNKH             varchar(100)         not null,
   HONKH                varchar(30)          null,
   TENNKH               varchar(10)          null,
   SODIENTHOAI          char(10)             null,
   HOCVINKH             varchar(20)          null,
   CHUCVINKH            varchar(20)          null,
   NHUNGHUONGNGHIENCUU  varchar(50)          null,
   constraint PK_NHAKHOAHOC primary key (EMAILNKH)
)
go

/*==============================================================*/
/* Table: TACGIA                                                */
/*==============================================================*/
create table TACGIA (
   EMAILTG              varchar(100)         not null,
   HOTG                 varchar(30)          null,
   TENTG                varchar(10)          null,
   BOMON                varchar(50)          null,
   KHOA                 varchar(50)          null,
   TRUONGCONGTAC        varchar(50)          null,
   HOCVITG              varchar(20)          null,
   CHUCVITG             varchar(20)          null,
   constraint PK_TACGIA primary key (EMAILTG)
)
go

alter table BAIBAO
   add constraint FK_BAIBAO_TACGIACHI_TACGIA foreign key (EMAILTGC)
      references TACGIA (EMAILTG)
go

alter table CAUHOI
   add constraint FK_CAUHOI_DATCAUHOI_NHAKHOAH foreign key (EMAILNKH)
      references NHAKHOAHOC (EMAILNKH)
go

alter table CAUHOI
   add constraint FK_CAUHOI_DUOCDATCA_BAIBAO foreign key (MABAIBAO)
      references BAIBAO (MABAIBAO)
go

alter table CHITIETDANHGIA
   add constraint FK_CHITIETD_DANHGIA_NHAKHOAH foreign key (EMAILNKH)
      references NHAKHOAHOC (EMAILNKH)
go

alter table CHITIETDANHGIA
   add constraint FK_CHITIETD_DUOCDANHG_BAIBAO foreign key (MABAIBAO)
      references BAIBAO (MABAIBAO)
go

alter table CHITIETTHAMGIAVIETBAO
   add constraint FK_CHITIETT_DUOCVIET_BAIBAO foreign key (MABAIBAO)
      references BAIBAO (MABAIBAO)
go

alter table CHITIETTHAMGIAVIETBAO
   add constraint FK_CHITIETT_VIET_TACGIA foreign key (EMAILTG)
      references TACGIA (EMAILTG)
go

