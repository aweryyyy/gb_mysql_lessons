use vk;

select * from users;


insert into users
(first_name, last_name, email, phone)
values
('Pavel', 'Brabrabra', 'brabra@yahoo.com', '9879875645'),
('Lisa', 'Laloeva', 'lialalo@gmail.com', '9998885542');

-- id	first_name	last_name	email	phone	password_hash	created_at	updated_at
-- 1	Petya	Petukhov	petya@mail.com	99999999929	81dc9bdb52d04dc20036dbd8313ed055	2022-04-10 18:22:29	2022-04-10 18:22:29
-- 2	Vasya	Vasilkov	vasya@mail.com	99999999919	81dc9bdb52d04dc20036dbd8313ed055	2022-04-10 18:22:34	2022-04-10 18:22:34
-- 3	Pavel	Brabrabra	brabra@yahoo.com	9879875645		2022-04-10 19:00:02	2022-04-10 19:00:02
-- 4	Lisa	Laloeva	lialalo@gmail.com	9998885542		2022-04-10 19:00:02	2022-04-10 19:00:02


select 
	distinct 
		first_name 
from vk.users
order by id asc;


select * from vk.profiles;

alter table vk.profiles add is_active bool default true;

-- user_id	gender	birthday	photo_id	city	country	is_active
-- 1	m	1997-12-01	1	Moscow	Russia	1
-- 2	m	1988-11-02	2	Moscow	Russia	1

update vk.profiles
set is_active = false 
where birthday > now() - interval '18' year;

select * from vk.messages m 
-- id	from_user_id	to_user_id	txt	created_at	updated_at	is_delivered
-- 1	1	2	Hi!	2022-04-10 18:22:52	2022-04-10 18:22:52	0
-- 2	1	2	Vasya!	2022-04-10 18:22:54	2022-04-10 18:22:54	0
-- 3	2	1	Hi, Petya	2022-04-10 18:22:55	2022-04-10 18:22:55	0

select * from vk.messages m 
where m.created_at > now() 
	or m.updated_at > now();

delete from vk.messages 
where m.created_at > now() 
	or m.updated_at > now();





