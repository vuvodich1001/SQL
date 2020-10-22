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
-- PHAN 1
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

-- PHAN 2
-- Cau 1 
-- Nhap du lieu vao table NhanVien
insert into NhanVien(MaNV, HoTen, SoDT, NgayVL)
values ('NV01', 'Nguyen Nhu Nhut', '0927345678', '13/04/2006'),
	('NV02', 'Le Thi Phi Yen', '0987567390', '21/04/2006'),
	('NV03', 'Nguyen Van B', '0997047382', '27/04/2006'),
	('NV04', 'Ngo Thanh Tuan', '0913758498', '24/06/2006'),
	('NV05', 'Nguyen Thi Truc Thanh', '0918590387', '20/07/2006')

-- Nhap du lieu vao table KhachHang
insert into KhachHang(MaKH, HoTen, DiaChi, SoDT, NgSinh, NgDK, DoanhSo)
values ('KH01', 'Nguyen Van A', '731 Tran Hung Dao, Q5, TpHCM', '8823451', '22/10/1960', '22/07/2006', '13060000'),
	('KH02', 'Tran Ngoc Han', '23/5 Nguyen Trai, Q5, TpHCM', '908256478', '03/04/1974', '30/07/2006', '280000'),
	('KH03', 'Tran Ngoc Linh', '45 Nguyen Canh Chan, Q1, TpHCM', '938776266', '12/06/1980', '05/08/2006', '3860000'),
	('KH04', 'Tran Minh Long', '50/34 Le Dai Hanh, Q10, TpHCM', '917325476', '09/03/1965', '02/10/2006', '250000'),
	('KH05', 'Le Nhat Minh', '34 Truong Dinh, Q3, TpHCM', '8246108', '10/03/1950', '28/10/2006', '21000'),
	('KH06', 'Le Hoai Thuong', '227 Nguyen Van Cu, Q5, TpHCM', '8631738', '31/12/1981', '24/11/2006', '915000'),
	('KH07', 'Nguyen Van Tam', '32/3 Tran Binh Trong, Q5, TpHCM', '916783565', '06/04/1971', '01/12/2006', '12500'),
	('KH08', 'Phan Thi Thanh', '45/2 An Duong Vuong, Q5, TpHCM', '938435756', '10/01/1971', '13/12/2006', '365000'),
	('KH09', 'Le Ha Vinh', '873 Le Hong Phong, Q5, TpHCM', '8654763', '03/09/1979', '14/01/2007', '70000'),
	('KH10', 'Ha Duy Lap', '34/34B Nguyen Trai, Q1, TpHCM', '8768904', '02/05/1983', '16/01/2007', '67500')

-- Nhap du lieu vao table HoaDon
insert into HoaDon(SoHD, NgMH, MaKH, MaNV, TriGia)
values ('1001', '23/07/2006', 'KH01', 'NV01', '320000'),
	('1002', '12/08/2006', 'KH01', 'NV02', '840000'),
	('1003', '23/08/2006', 'KH02', 'NV01', '100000'),
	('1004', '01/09/2006', 'KH02', 'NV01', '180000'),
	('1005', '20/10/2006', 'KH01', 'NV02', '3800000'),
	('1006', '16/10/2006', 'KH01', 'NV03', '2430000'),
	('1007', '28/10/2006', 'KH03', 'NV03', '510000'),
	('1008', '28/10/2006', 'KH01', 'NV03', '440000'),
	('1009', '28/10/2006', 'KH03', 'NV04', '200000'),
	('1010', '01/11/2006', 'KH01', 'NV01', '5200000'),
	('1011', '04/11/2006', 'KH04', 'NV03', '250000'),
	('1012', '30/11/2006', 'KH05', 'NV03', '21000'),
	('1013', '12/12/2006', 'KH06', 'NV01', '5000'),
	('1014', '31/12/2006', 'KH03', 'NV02', '3150000'),
	('1015', '01/01/2007', 'KH06', 'NV01', '910000'),
	('1016', '01/01/2007', 'KH07', 'NV02', '12500'),
	('1017', '02/01/2007', 'KH08', 'NV03', '35000'),
	('1018', '13/01/2007', 'KH08', 'NV03', '330000'),
	('1019', '13/01/2007', 'KH01', 'NV03', '30000'),
	('1020', '14/01/2007', 'KH09', 'NV04', '70000'),
	('1021', '16/01/2007', 'KH10', 'NV03', '67500'),
	('1022', '16/01/2007', 'KH01', 'NV03', '7000'),
	('1023', '17/01/2007', 'KH02', 'NV01', '330000')

-- Nhap du lieu vao table SanPham
 insert into SanPham(MaSP, TenSP, DVT, NuocSX, Gia)
 values ('BC01', 'But chi', 'cay', 'Singapore', '3000'),
	('BC02', 'But chi', 'cay', 'Singapore', '5000'),
	('BC03', 'But chi', 'cay', 'Viet Nam', '3500'),
	('BC04', 'But chi', 'hop', 'Viet Nam', '30000'),
	('BB01', 'But bi', 'cay', 'Viet Nam', '5000'),
	('BB02', 'But bi', 'cay', 'Trung Quoc', '7000'),
	('BB03', 'But bi', 'hop', 'Thai Lan', '100000'),
	('TV01', 'Tap 100 giay mong', 'quyen', 'Trung Quoc', '2500'),
	('TV02', 'Tap 200 giay mong', 'quyen', 'Trung Quoc', '4500'),
	('TV03', 'Tap 100 giay tot', 'quyen', 'Viet Nam', '3000'),
	('TV04', 'Tap 200 giay tot', 'quyen', 'Viet Nam', '5500'),
	('TV05', 'Tap 100 trang', 'chuc', 'Viet Nam', '23000'),
	('TV06', 'Tap 200 trang', 'chuc', 'Viet Nam', '53000'),
	('TV07', 'Tap 100 trang', 'chuc', 'Trung Quoc', '34000'),
	('ST01', 'So tay 500 trang', 'quyen', 'Trung Quoc', '40000'),
	('ST02', 'So tay loai 1', 'quyen', 'Viet Nam', '55000'),
	('ST03', 'So tay loai 2', 'quyen', 'Viet Nam', '51000'),
	('ST04', 'So tay', 'quyen', 'Thai Lan', '55000'),
	('ST05', 'So tay mong', 'quyen', 'Thai Lan', '20000'),
	('ST06', 'Phan viet bang', 'hop', 'Viet Nam', '5000'),
	('ST07', 'Phan khong bui', 'hop', 'Viet Nam', '7000'),
	('ST08', 'Bong bang', 'cai', 'Viet Nam', '1000'),
	('ST09', 'But long', 'cay', 'Viet Nam', '5000'),
	('ST10', 'But long', 'cay', 'Trung Quoc', '7000')

-- Nhap du lieu vao table CTHD 
insert into CTHD(SoHD, MaSP, SL)
values ('1001', 'TV02', '10'),
	('1001', 'ST01', '5'),
	('1001', 'BC01', '5'),
	('1001', 'BC02', '10'),
	('1001', 'ST08', '10'),
	('1002', 'BC04', '20'),
	('1002', 'BB01', '20'),
	('1002', 'BB02', '20'),
	('1003', 'BB03', '10'),
	('1004', 'TV01', '20'),
	('1004', 'TV02', '10'),
	('1004', 'TV03', '10'),
	('1004', 'TV04', '10'),
	('1005', 'TV05', '50'),
	('1005', 'TV06', '50'),
	('1006', 'TV07', '20'),
	('1006', 'ST01', '30'),
	('1006', 'ST02', '10'),
	('1007', 'ST03', '10'),
	('1008', 'ST04', '8'),
	('1009', 'ST05', '10'),
	('1010', 'TV07', '50'),
	('1010', 'ST07', '50'),
	('1010', 'ST08', '100'),
	('1010', 'ST04', '50'),
	('1010', 'TV03', '100'),
	('1011', 'ST06', '50'),
	('1012', 'ST07', '3'),
	('1013', 'ST08', '5'),
	('1014', 'BC02', '80'),
	('1014', 'BB02', '100'),
	('1014', 'BC04', '60'),
	('1014', 'BB01', '50'),
	('1015', 'BB02', '30'),
	('1015', 'BB03', '7'),
	('1016', 'TV01', '5'),
	('1017', 'TV02', '1'),
	('1017', 'TV03', '1'),
	('1017', 'TV04', '5'),
	('1018', 'ST04', '6'),
	('1019', 'ST05', '1'),
	('1019', 'ST06', '2'),
	('1020', 'ST07', '10'),
	('1021', 'ST08', '5'),
	('1021', 'TV01', '7'),
	('1021', 'TV02', '10'),
	('1022', 'ST07', '1'),
	('1023', 'ST04', '6')

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

--PHAN 3
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

