create database QLNT
use QLNT

create table Usr(
	userid int primary key,
	username varchar(30), 
	password varchar(30),
	email varchar(30) unique,
	phone varchar(30), 
	address varchar(50), 
	status int
)

insert into Usr(userid, username, password, email, phone, address, status)
values(1, 'Nguyen van A', '123456', 'usr1@gmail.com', '123456', 'tphcm', 1),
	(2, 'Nguyen van A', '123456', 'usr2@gmail.com', '123456', 'tphcm', 1),
	(3, 'Nguyen van A', '123456', 'usr3@gmail.com', '123456', 'tphcm', 1),
	(4, 'Nguyen van A', '123456', 'usr4@gmail.com', '123456', 'tphcm', 1),
	(5, 'Nguyen van A', '123456', 'usr5@gmail.com', '123456', 'tphcm', 1)
