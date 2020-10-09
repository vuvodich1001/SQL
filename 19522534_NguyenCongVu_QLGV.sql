-- Tao database QLGV
create database QLGV
go
use QLGV
-- Tao cac bang va khoa chinh
create table Khoa(
	MaKh varchar(4),
	TenKh varchar(20),
	NgTLap smalldatetime,
	TrKh char(4),
	constraint PK_Khoa primary key(MaKh)
)

create table MonHoc(
	MaMH varchar(10),
	TenMH varchar(40),
	TCLT tinyint,
	TCTH tinyint,
	MaKh varchar(4),
	constraint PK_MonHoc primary key(MaMH)
)

create table DieuKien(
	MaMH varchar(10),
	MaMH_Truoc varchar(10),
	constraint PK_DieuKine primary key(MaMH, MaMH_Truoc)
)

create table GiaoVien(
	MaGV char(4),
	HoTen varchar(40),
	HocVi varchar(10),
	HocHam varchar(10),
	GioiTinh varchar(3),
	NgSinh smalldatetime,
	NgVL smalldatetime,
	HeSo numeric(4, 2),
	MucLuong money,
	MaKh varchar(4),
	constraint PK_GiaoVien primary key(MaGV)
)


create table Lop(
	MaLop char(3),
	TenLop varchar(40),
	TrLop char(5),
	SiSo tinyint,
	MaGVCN char(4), 
	constraint PK_Lop primary key(MaLop)
)

create table HocVien(
	MaHV char(5),
	Ho varchar(10),
	Ten varchar(10),
	NgSinh smalldatetime,
	GioiTinh varchar(3),
	NoiSinh varchar(40), 
	MaLop char(3), 
	constraint PK_HocVien primary key(MaHV)
)

create table GiangDay(
	MaLop char(3),
	MaMH varchar(10),
	MaGV char(4),
	HocKy tinyint,
	Nam smallint,
	TuNgay smalldatetime,
	DenNgay smalldatetime,
	constraint PK_GiangDay primary key(MaLop, MaMH)
)

create table KetQuaThi(
	MaHV char(5),
	MaMH varchar(10),
	LanThi tinyint,
	NgThi smalldatetime,
	Diem numeric(4, 2),
	KetQua varchar(10),
	constraint PK_KetQuaThi primary key(MaHV, MaMH, LanThi)
)

-- Cau 1 
-- Tao Khoa ngoai va khoa chinh (da tao o tren)
alter table GiaoVien
add constraint FK_GiaoVien
foreign key (MaKh) references Khoa(MaKh)

--fix 
alter table Khoa 
add constraint FK_Khoa
foreign key (TrKh) references GiaoVien(MaGV)

alter table MonHoc
add constraint FK_MonHoc
foreign key (MaKh) references Khoa(MaKh)

alter table Lop
add constraint FK_Lop_MaGVCN
foreign key (MaGVCN) references GiaoVien(MaGV)

-- fix
alter table Lop
add constraint FK_Lop_TrLop
foreign key (TrLop) references HocVien(MaHV)

alter table  GiangDay
add constraint FK_GiangDay_MaMH
foreign key (MaMH) references MonHoc(MaMH)

alter table GiangDay
add constraint FK_GiangDay_MaGV
foreign key (MaGV) references GiaoVien(MaGV)

alter table GiangDay
add constraint FK_GiangDay_MaLop
foreign key (MaLop) references Lop(MaLop)

alter table DieuKien
add constraint FK_DieuKien_MaMH
foreign key (MaMH) references MonHoc(MaMH)

alter table DieuKien
add constraint FK_DieuKien_MaMHTruoc
foreign key (MaMH_Truoc) references MonHoc(MaMH)

alter table KetQuaThi
add constraint FK_KetQuaThi_MaHV
foreign key (MaHV) references HocVien(MaHV)

alter table KetQuaThi
add constraint FK_KetQuaThi_MaMh
foreign key (MaMh) references MonHoc(MaMH)

alter table HocVien
add constraint FK_HocVien
foreign key (MaLop) references Lop(MaLop)

-- them 3  column ghichu, diemtb, xep loai
alter table HocVien
add GhiChu varchar(10)

alter table HocVien
add DiemTB numeric(4, 2)

alter table HocVien
add XepLoai varchar(10)

-- Cau 2 da co san khi tao table
-- Cau 3
alter table GiaoVien
add constraint CHK_GiaoVien_GioiTinh
check (GioiTinh in ('Nam', 'Nu'))

alter table HocVien
add constraint CHK_HocVien_GioiTinh
check (GioiTinh in ('Nam', 'Nu'))

-- Cau 4
alter table KetQuaThi
alter column Diem numeric(4, 2)

-- Cau 5
update KetQuaThi
set KetQua = 'Dat'
where (Diem >= 5)

update KetQuaThi
set KetQua = 'Khong Dat'
where (Diem < 5)

-- Cau 6
alter table KetQuaThi
add constraint CHK_KetQuaThi_LanThi
check (Lanthi <= 3)

-- Cau 7
alter table GiangDay
add constraint CHK_GiangDay_HocKy
check (HocKy >= 1 and HocKy <= 3)

-- Cau 8
alter table GiaoVien
add constraint CHK_GiangDay_HocVi
check (HocVi in ('CN', 'KS', 'Ths', 'TS', 'PtS'))

-- Cau 9, Cau 10 ...

