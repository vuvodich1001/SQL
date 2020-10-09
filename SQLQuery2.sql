use testDB
select * from NhanVien
select * from Khachhang
alter table Khachhang
add constraint PK_Khachhang
primary key (MAKH)