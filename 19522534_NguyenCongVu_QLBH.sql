-- Tao database QLBH
create database QlBH
go
use QLBH
-- Tao cac bang
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
	TriGia money,
)
create table CTHD(
	SoHD int not null,
	MaSp char(4) not null,
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

alter table CTHD
add constraint PK_CTHD
primary key(SoHD, MaSP)

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
alter column LoaiKH varchar(20)

alter table KhachHang
add constraint CHK_KhachHang_LoaiKH
check (LoaiKH in ('vang lai', 'vip', 'thuong'))

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
check (SL > 1)

-- Cau 10
alter table KhachHang
add constraint CHK_KhachHang_NgayDK
check (NgDK > NgSinh)

-- Test import du lieu vao table NhanVien
insert into NhanVien values('NV01', 'Nguyen Cong Vu', '0967979521', '20200927')
insert into NhanVien values('NV02', 'Nguyen Van A', '0977979521', '20190925')
insert into NhanVien values('NV03', 'Tran Van B', '0967679521', '20180925')
insert into NhanVien values('NV04', 'Le Thi C', '0967970521', '20200127')

-- Truy van
-- Cac ham dem tim max, min, avg, sum
select * from CTHD
select max(SL) as SoLuongNhoNhat from CTHD
select count(SL) as TongSoLuong from CTHD
select sum(SL) as TongSoLuong from CTHD
select avg(SL) as TrungBinh from CTHD

-- Nhung ma sp bat dau bang chu B (LIKE), co the mo rong ra de tim kiem tuong tu
select * from CTHD 
where MaSp like 'B%'
select count(nv.MaNV) as SoLuongNhanVien, count(hd.MaKH) as SoLuongHoaDon from NhanVien nv, HoaDon hd
select distinct * from NhanVien, HoaDon

-- Phan 2
-- Cau 1 import du lieu bang file exel
-- Cau 2
select * into SanPham1 from SanPham
select * into KhachHang1 from KhachHang

-- Cau 3
update SanPham1 
set Gia = Gia + Gia * 0.05
where (NuocSX = 'Thai Lan')

-- Cau 4
update SanPham1
set Gia = Gia - Gia * 0.05
where (NuocSX = 'Trung Quoc' and Gia < 10000)

-- Cau 5
update KhachHang1
set LoaiKH = 'Vip'
where (NgDK < 1/1/2007 and DoanhSo >= 10000000 or NgDK >= 1/1/2007 and DoanhSo >= 2000000) 

-- Phan 3
-- Cau 1
select MaSP, TenSP from SanPham where (NuocSX = 'Trung Quoc')

-- Cau 2
select MaSP, TenSP from SanPham where (DVT = 'cay' or DVT = 'quyen')

-- Cau 3
select MaSP, TenSP from SanPham where (MaSP like 'B%01')
--c2: select MaSP, TenSP from SanPham where (left(MaSP, 1) = 'B' and right(MaSP, 2) = '01')

-- Cau 4
select MaSP, TenSP from SanPham where (NuocSX = 'Trung Quoc' and (Gia between 30000 and 40000))

-- Cau 5
select MaSP, TenSP from SanPham where (NuocSX = 'Trung Quoc' or NuocSX = 'Thai Lan' ) and (Gia between 30000 and 40000)

-- Cau 6
select SoHD, TriGia from HoaDon where (NgMH = '1/1/2007' or NgMH = '2/1/2007')

-- Cau 7
select SoHD, TriGia from HoaDon where (NgMH >= '1/1/2007' and NgMH <= '1/1/2007') order by SoHD asc, TriGia desc

-- Cau 8
select hd.MaKH, kh.Hoten from HoaDon hd, KhachHang kh where (hd.NgMH = '1/1/2007' and hd.MaKH = kh.MaKH)

-- Cau 9
select hd.SoHD, hd.TriGia from HoaDon hd, NhanVien nv where (NgMH = '28/10/2006' and hd.MaNV = nv.MaNV and nv.HoTen = 'Nguyen Van B')

-- Cau 10
select distinct ct.MaSP, sp.TenSP from SanPham sp, KhachHang kh, HoaDon hd, CTHD ct
where ((hd.NgMH between '1/10/2006' and '31/10/2006') and hd.MaKH = kh.MaKH and ct.SoHD =  hd.SoHD and kh.Hoten = 'Nguyen Van A' and ct.MaSP = sp.MaSP)

-- Cau 11
select SoHD from CTHD  where (MaSP = 'BB01' or MaSP = 'BB02')

-- Cau 12
select SoHD from CTHD where (MaSP = 'BB01' or MaSp = 'BB02') and (SL between 10 and 20) 