/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2017                    */
/* Created on:     10/30/2022 12:40:00 AM                       */
/*==============================================================*/


if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('CHITIETHOADON') and o.name = 'FK_CHITIETH_CHITIETHO_SANPHAM')
alter table CHITIETHOADON
   drop constraint FK_CHITIETH_CHITIETHO_SANPHAM
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('CHITIETHOADON') and o.name = 'FK_CHITIETH_CHITIETHO_HOADON')
alter table CHITIETHOADON
   drop constraint FK_CHITIETH_CHITIETHO_HOADON
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('HOADON') and o.name = 'FK_HOADON_MUA_KHACHHAN')
alter table HOADON
   drop constraint FK_HOADON_MUA_KHACHHAN
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('SACH') and o.name = 'FK_SACH_SANPHAMSA_SANPHAM')
alter table SACH
   drop constraint FK_SACH_SANPHAMSA_SANPHAM
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('SACH') and o.name = 'FK_SACH_THAU_NHAXUATB')
alter table SACH
   drop constraint FK_SACH_THAU_NHAXUATB
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('SACH') and o.name = 'FK_SACH_VIET_TACGIA')
alter table SACH
   drop constraint FK_SACH_VIET_TACGIA
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('SANPHAM') and o.name = 'FK_SANPHAM_CO_LOAISANP')
alter table SANPHAM
   drop constraint FK_SANPHAM_CO_LOAISANP
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('TUIXACHBALO') and o.name = 'FK_TUIXACHB_SANPHAMTU_SANPHAM')
alter table TUIXACHBALO
   drop constraint FK_TUIXACHB_SANPHAMTU_SANPHAM
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('CHITIETHOADON')
            and   name  = 'CHITIETHOADON2_FK'
            and   indid > 0
            and   indid < 255)
   drop index CHITIETHOADON.CHITIETHOADON2_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('CHITIETHOADON')
            and   name  = 'CHITIETHOADON_FK'
            and   indid > 0
            and   indid < 255)
   drop index CHITIETHOADON.CHITIETHOADON_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('CHITIETHOADON')
            and   type = 'U')
   drop table CHITIETHOADON
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('HOADON')
            and   name  = 'MUA_FK'
            and   indid > 0
            and   indid < 255)
   drop index HOADON.MUA_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('HOADON')
            and   type = 'U')
   drop table HOADON
go

if exists (select 1
            from  sysobjects
           where  id = object_id('KHACHHANG')
            and   type = 'U')
   drop table KHACHHANG
go

if exists (select 1
            from  sysobjects
           where  id = object_id('LOAISANPHAM')
            and   type = 'U')
   drop table LOAISANPHAM
go

if exists (select 1
            from  sysobjects
           where  id = object_id('NHAXUATBAN')
            and   type = 'U')
   drop table NHAXUATBAN
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('SACH')
            and   name  = 'THAU_FK'
            and   indid > 0
            and   indid < 255)
   drop index SACH.THAU_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('SACH')
            and   name  = 'VIET_FK'
            and   indid > 0
            and   indid < 255)
   drop index SACH.VIET_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('SACH')
            and   type = 'U')
   drop table SACH
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('SANPHAM')
            and   name  = 'CO_FK'
            and   indid > 0
            and   indid < 255)
   drop index SANPHAM.CO_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('SANPHAM')
            and   type = 'U')
   drop table SANPHAM
go

if exists (select 1
            from  sysobjects
           where  id = object_id('TACGIA')
            and   type = 'U')
   drop table TACGIA
go

if exists (select 1
            from  sysobjects
           where  id = object_id('TUIXACHBALO')
            and   type = 'U')
   drop table TUIXACHBALO
go

/*==============================================================*/
/* Table: CHITIETHOADON                                         */
/*==============================================================*/
create table CHITIETHOADON (
   MASP                 char(10)             not null,
   MAHD                 char(10)             not null,
   SOLUONGMUA           int                  null,
   GIABAN               float                null,
   constraint PK_CHITIETHOADON primary key (MASP, MAHD)
)
go

/*==============================================================*/
/* Index: CHITIETHOADON_FK                                      */
/*==============================================================*/




create nonclustered index CHITIETHOADON_FK on CHITIETHOADON (MASP ASC)
go

/*==============================================================*/
/* Index: CHITIETHOADON2_FK                                     */
/*==============================================================*/




create nonclustered index CHITIETHOADON2_FK on CHITIETHOADON (MAHD ASC)
go

/*==============================================================*/
/* Table: HOADON                                                */
/*==============================================================*/
create table HOADON (
   MAHD                 char(10)             not null,
   MAKH                 char(10)             null,
   NGAYXUATHD           datetime             null,
   TONGTIEN             float                null,
   SOTIENKHACHDUA       float                null,
   SOTIENTHOI           float                null,
   constraint PK_HOADON primary key (MAHD)
)
go

/*==============================================================*/
/* Index: MUA_FK                                                */
/*==============================================================*/




create nonclustered index MUA_FK on HOADON (MAKH ASC)
go

/*==============================================================*/
/* Table: KHACHHANG                                             */
/*==============================================================*/
create table KHACHHANG (
   MAKH                 char(10)             not null,
   HO                   nvarchar(30)         null,
   TEN                  nvarchar(10)         null,
   NGAYSINH             datetime             null,
   GIOITINH             nchar(5)             null,
   DIACHI               nvarchar(50)         null,
   SODIENTHOAI          char(10)             null,
   constraint PK_KHACHHANG primary key (MAKH)
)
go

/*==============================================================*/
/* Table: LOAISANPHAM                                           */
/*==============================================================*/
create table LOAISANPHAM (
   MALOAISP             char(10)             not null,
   TENLOAISP            nvarchar(30)         null,
   constraint PK_LOAISANPHAM primary key (MALOAISP)
)
go

/*==============================================================*/
/* Table: NHAXUATBAN                                            */
/*==============================================================*/
create table NHAXUATBAN (
   MANHAXUATBAN         char(10)             not null,
   TENNHAXUATBAN        nvarchar(50)         null,
   DIACHILIENLAC        nvarchar(100)        null,
   SODIENTHOAI          char(10)             null,
   constraint PK_NHAXUATBAN primary key (MANHAXUATBAN)
)
go

/*==============================================================*/
/* Table: SACH                                                  */
/*==============================================================*/
create table SACH (
   MASP                 char(10)             not null,
   MATACGIA             char(10)             null,
   MANHAXUATBAN         char(10)             null,
   NAMXUATBAN           int                  null,
   constraint PK_SACH primary key (MASP)
)
go

/*==============================================================*/
/* Index: VIET_FK                                               */
/*==============================================================*/




create nonclustered index VIET_FK on SACH (MATACGIA ASC)
go

/*==============================================================*/
/* Index: THAU_FK                                               */
/*==============================================================*/




create nonclustered index THAU_FK on SACH (MANHAXUATBAN ASC)
go

/*==============================================================*/
/* Table: SANPHAM                                               */
/*==============================================================*/
create table SANPHAM (
   MASP                 char(10)             not null,
   MALOAISP             char(10)             null,
   TENSP                nvarchar(50)         null,
   GIABAN               float                null,
   SOLUONGTONKHO        int                  null,
   MOTA                 nvarchar(255)        null,
   constraint PK_SANPHAM primary key (MASP)
)
go

/*==============================================================*/
/* Index: CO_FK                                                 */
/*==============================================================*/




create nonclustered index CO_FK on SANPHAM (MALOAISP ASC)
go

/*==============================================================*/
/* Table: TACGIA                                                */
/*==============================================================*/
create table TACGIA (
   MATACGIA             char(10)             not null,
   HOTEN                nvarchar(50)         null,
   NAMSINH              int                  null,
   BUTDANH              nvarchar(30)         null,
   constraint PK_TACGIA primary key (MATACGIA)
)
go

/*==============================================================*/
/* Table: TUIXACHBALO                                           */
/*==============================================================*/
create table TUIXACHBALO (
   MASP                 char(10)             not null,
   KICHCO               nvarchar(20)         null,
   CHATLIEU             nvarchar(20)         null,
   MAUSAC               nvarchar(20)         null,
   constraint PK_TUIXACHBALO primary key (MASP)
)
go

alter table CHITIETHOADON
   add constraint FK_CHITIETH_CHITIETHO_SANPHAM foreign key (MASP)
      references SANPHAM (MASP)
go

alter table CHITIETHOADON
   add constraint FK_CHITIETH_CHITIETHO_HOADON foreign key (MAHD)
      references HOADON (MAHD)
go

alter table HOADON
   add constraint FK_HOADON_MUA_KHACHHAN foreign key (MAKH)
      references KHACHHANG (MAKH)
go

alter table SACH
   add constraint FK_SACH_SANPHAMSA_SANPHAM foreign key (MASP)
      references SANPHAM (MASP)
go

alter table SACH
   add constraint FK_SACH_THAU_NHAXUATB foreign key (MANHAXUATBAN)
      references NHAXUATBAN (MANHAXUATBAN)
go

alter table SACH
   add constraint FK_SACH_VIET_TACGIA foreign key (MATACGIA)
      references TACGIA (MATACGIA)
go

alter table SANPHAM
   add constraint FK_SANPHAM_CO_LOAISANP foreign key (MALOAISP)
      references LOAISANPHAM (MALOAISP)
go

alter table TUIXACHBALO
   add constraint FK_TUIXACHB_SANPHAMTU_SANPHAM foreign key (MASP)
      references SANPHAM (MASP)
go

