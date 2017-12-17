GO
Create database Produccion 
Go
Use Produccion 
Go


DROP table HISTORIALPRODUCCION ;
DROP TABLE PRODUCTO;


/*==============================================================*/
/* Table: HISTORIALPRODUCCION                                   */
/*==============================================================*/
create table HISTORIALPRODUCCION (
   CODIGO               int                 not null,
   ANIO                 VARCHAR(10)          not null,
   VOLUMENPROD          int                 not null,
   COSTODOC             MONEY                not null,
   constraint PK_HISTORIALPRODUCCION primary key (CODIGO,ANIO)
);

/*==============================================================*/
/* Index: ENTITY_2_PK                                           */
/*==============================================================*/
create unique index ENTITY_2_PK on HISTORIALPRODUCCION (
CODIGO
);

/*==============================================================*/
/* Table: PRODUCTO                                              */
/*==============================================================*/
create table PRODUCTO (
   CODIGO               int                 not null,
   DESCRIPCION          VARCHAR(50)          not null,
   GRUPO                VARCHAR(20)          not null,
   constraint PK_PRODUCTO primary key (CODIGO)
);

/*==============================================================*/
/* Index: PRODUCTO_PK                                           */
/*==============================================================*/
create unique index PRODUCTO_PK on PRODUCTO (
CODIGO,
DESCRIPCION
);

alter table HISTORIALPRODUCCION
   add constraint FK_HISTORIA_RELATIONS_PRODUCTO foreign key (CODIGO)
      references PRODUCTO (CODIGO);

