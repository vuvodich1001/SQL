create database QlBH
go
use QLBH
create table KhachHang(
	MaKH char(4) not null,
	HoTen varchar(40),
	DiaChi varchar(50),
	SoDT varchar(20),
	NgSinh smalldatetime,
	NgDK smalldatetime,
	DoanhSo money,
)

create table NhanVien(
	MaNV char(4) not null,
	HoTen varchar(40),
	SoDT varchar(20) not null,
	NgayVL smalldatetime,
)

create table SanPham(
	MaSP char(4) not null,
	TenSP varchar(40),
	DVT varchar(20),
	NuocSX varchar(40),
	Gia money,
)
create table HoaDon(
	SoHD int not null,
	NgMH smalldatetime,
	MaKH char(4),
	MaNV char(4),
)
create table CTHD(
	SoHD int not null,
	MaSp char(4),
	SL int,
)
--Cau 1
--Tao khoa chinh
alter table KhachHang
add constraint PK_KhachHang
primary key(MaKH)

alter table NhanVien
add constraint PK_NhanVien
primary key(MaNV)

alter table SanPham
add constraint PK_SanPham
primary key(MaSP)

alter table HoaDon
add constraint PK_HoaDon
primary key(SoHD)

-- Tao khoa ngoai
alter table HoaDon
add constraint FK_HoaDon_MaKH
foreign key (MaKH) references KhachHang(MaKH)

alter table HoaDon
add constraint FK_HoaDon_MaNV
foreign key (MaNV) references NhanVien(MaNV)

alter table CTHD
add constraint FK_CTHD_MaSP
foreign key (MaSP) references SanPham(MaSP)

alter table CTHD
add constraint FK_CTHD_SoHD
foreign key (SoHD) references HoaDon(SoHD)

-- Cau 2
alter table SanPham
add GhiChu varchar(20)
-- Cau 3
alter table KhachHang
add LoaiKH tinyint
-- Cau 4
alter table SanPham
alter column GhiChu varchar(100)
-- Cau 5
alter table SanPham
drop column GhiChu
-- Cau 6
alter table KhachHang
add constraint CHK_KhachHang_LoaiKH
check (LoaiKH in ('vang lai', 'vip', 'vip'))
-- Cau 7
alter table SanPham
add constraint CHK_SanPham_DVT
check (DVT in ('cay', 'hop', 'cai', 'quyen', 'chuc'))
-- Cau 8
alter table SanPham
add constraint CHK_SanPham_Gia
check (Gia > 500)
-- Cau 9
alter table CTHD
add constraint CHK_SanPham_SL
check (SL >= 1)

-- Cau 10
alter table KhachHang
add constraint CHK_KhachHang_NgayDK
check (NgDK > NgSinh)

-- Cau 11


-- Test
insert into NhanVien values('NV01', 'Nguyen Cong Vu', '0967979521', '20200927')
insert into NhanVien values('NV02', 'Nguyen Van A', '0977979521', '20190925')
insert into NhanVien values('NV03', 'Tran Van B', '0967679521', '20180925')
insert into NhanVien values('NV04', 'Le Thi C', '0967970521', '20200127')
insert into NhanVien values('NV05', 'Nguyen Cong Vu', '0967979521', '20200927')
--import du lieu
alter table KhachHang
drop constraint CHK_KhachHang_LoaiKH

alter table KhachHang
drop column LoaiKH

--III
--Cau 1
select MaSP, TenSP from SanPham
where NuocSX = 'Trung Quoc'
--Cau 2
select MaSP, TenSP from SanPham
where DVT = 'cay' or DVT = 'quyen'
--Cau 3
select * from SanPham
where NuocSX = 'Trung Quoc' and Gia >= 30000 and Gia <= 40000
--Cau 4
select * from SanPham
where (NuocSX = 'Trung Quoc' or NuocSX = 'Thai Lan') and Gia >= 30000 and Gia <= 40000
