GO
Create database VentasComerciales
Go
Use VentasComerciales
Go


if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('COMPRADETALLE') and o.name = 'FK_COMPRADE_RELATIONS_PRODUCTO')
alter table COMPRADETALLE
   drop constraint FK_COMPRADE_RELATIONS_PRODUCTO
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('COMPRADETALLE') and o.name = 'FK_COMPRADE_RELATIONS_COMPRAHE')
alter table COMPRADETALLE
   drop constraint FK_COMPRADE_RELATIONS_COMPRAHE
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('COMPRAHEADER') and o.name = 'FK_COMPRAHE_RELATIONS_CLIENTE')
alter table COMPRAHEADER
   drop constraint FK_COMPRAHE_RELATIONS_CLIENTE
go

if exists (select 1
            from  sysobjects
           where  id = object_id('CLIENTE')
            and   type = 'U')
   drop table CLIENTE
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('COMPRADETALLE')
            and   name  = 'RELATIONSHIP_3_FK'
            and   indid > 0
            and   indid < 255)
   drop index COMPRADETALLE.RELATIONSHIP_3_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('COMPRADETALLE')
            and   name  = 'RELATIONSHIP_2_FK'
            and   indid > 0
            and   indid < 255)
   drop index COMPRADETALLE.RELATIONSHIP_2_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('COMPRADETALLE')
            and   type = 'U')
   drop table COMPRADETALLE
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('COMPRAHEADER')
            and   name  = 'RELATIONSHIP_1_FK'
            and   indid > 0
            and   indid < 255)
   drop index COMPRAHEADER.RELATIONSHIP_1_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('COMPRAHEADER')
            and   type = 'U')
   drop table COMPRAHEADER
go

if exists (select 1
            from  sysobjects
           where  id = object_id('PRODUCTO')
            and   type = 'U')
   drop table PRODUCTO
go

DROP TABLE CLIENTE;
/*==============================================================*/
/* Table: CLIENTE                                               */
/*==============================================================*/
create table CLIENTE (
   CLIENTEID            varchar(10)          not null,
   NOMBRE               varchar(50)          not null,
   DIRECCION            varchar(50)          not null,
   CODIGOPOSTAL         varchar(20)          not null,
   TIPO                 varchar(10)          not null,
   constraint PK_CLIENTE primary key (CLIENTEID)
)
go

drop table COMPRADETALLE;
/*==============================================================*/
/* Table: COMPRADETALLE                                         */
/*==============================================================*/
create table COMPRADETALLE (
   ORDENID              char(10)             not null,
   PRODUCTOID           varchar(10)          not null,
   ANIO_PROD            varchar(10)          not null,
   CANTIDADDOC          int                  not null,
   constraint PK_COMPRADETALLE primary key ( ORDENID, PRODUCTOID)
)
go

/*==============================================================*/
/* Index: RELATIONSHIP_2_FK                                     */
/*==============================================================*/




create nonclustered index RELATIONSHIP_2_FK on COMPRADETALLE (PRODUCTOID ASC)
go

/*==============================================================*/
/* Index: RELATIONSHIP_3_FK                                     */
/*==============================================================*/



/**/
create nonclustered index RELATIONSHIP_3_FK on COMPRADETALLE (CLIENTEID ASC,
  NOMBRE ASC,
  ORDENID ASC)
go

drop table COMPRAHEADER;
/*==============================================================*/
/* Table: COMPRAHEADER                                          */
/*==============================================================*/
create table COMPRAHEADER (
   CLIENTEID            varchar(10)          not null,
   ORDENID              char(10)             not null,
   DIRECCIONENTREGA     char(10)             not null,
   FECHA                DATE                 NOT NULL,
   constraint PK_COMPRAHEADER primary key (ORDENID)
)
go

/*==============================================================*/
/* Index: RELATIONSHIP_1_FK                                     */
/*==============================================================*/



/**/
create nonclustered index RELATIONSHIP_1_FK on COMPRAHEADER (CLIENTEID ASC,
  NOMBRE ASC)
go

drop table prOducto;
/*==============================================================*/
/* Table: PRODUCTO                                              */
/*==============================================================*/
create table PRODUCTO (
   PRODUCTOID           varchar(10)          not null,
   DESCRIPCION          varchar(20)          not null,
   PRECIOUNIDAD         money                not null,
   ANIO                 varchar(10)          not null,
   constraint PK_PRODUCTO primary key (PRODUCTOID,ANIO)
)
go

alter table COMPRADETALLE
   add constraint FK_COMPRADE_RELATIONS_PRODUCTO foreign key (PRODUCTOID,ANIO_PROD)
      references PRODUCTO (PRODUCTOID,ANIO)
go

alter table COMPRADETALLE
   add constraint FK_COMPRADE_RELATIONS_COMPRAHE foreign key (ORDENID)
      references COMPRAHEADER (ORDENID)
go

alter table COMPRAHEADER
   add constraint FK_COMPRAHE_RELATIONS_CLIENTE foreign key (CLIENTEID)
      references CLIENTE (CLIENTEID)
go

create table MERCADO (
	MERCADOID INT NOT NULL,
	NOMBRE VARCHAR(30) NOT NULL,
	constraint PK_MERCADO primary key (MERCADOID)
);


alter table COMPRAHEADER add MERCADOID INT NOT NULL;
alter table COMPRAHEADER add FECHA DATE NOT NULL;
alter table COMPRAHEADER adD CONSTRAINT FK_COMPRAHE_MERCADO FOREIGN KEY (MERCADOID) REFERENCES MERCADO(MERCADOID);
ALTER TABLE PRODUCTO alter column DESCRIPCION          varchar(50)          not null;
alter table COMPRAHEADER alter column DIRECCIONENTREGA     VARchar(100)             not null