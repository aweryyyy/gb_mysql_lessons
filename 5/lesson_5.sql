use vk;

-- Пусть в таблице users поля created_at и updated_at оказались незаполненными. Заполните их текущими датой и временем.

select * from users;

update vk.users 
set created_at = null, updated_at = null;


-- id	first_name	last_name	email	phone	password_hash	created_at	updated_at
-- 1	Petya	Petukhov	petya@mail.com	99999999929	81dc9bdb52d04dc20036dbd8313ed055		
-- 2	Vasya	Vasilkov	vasya@mail.com	99999999919	81dc9bdb52d04dc20036dbd8313ed055		
-- 3	Pavel	Brabrabra	brabra@yahoo.com	9879875645			
-- 4	Lisa	Laloeva	lialalo@gmail.com	9998885542			

update vk.users 
set created_at = now(), updated_at = now();

-- id	first_name	last_name	email	phone	password_hash	created_at	updated_at
-- 1	Petya	Petukhov	petya@mail.com	99999999929	81dc9bdb52d04dc20036dbd8313ed055	2022-04-10 19:29:41	2022-04-10 19:29:41
-- 2	Vasya	Vasilkov	vasya@mail.com	99999999919	81dc9bdb52d04dc20036dbd8313ed055	2022-04-10 19:29:41	2022-04-10 19:29:41
-- 3	Pavel	Brabrabra	brabra@yahoo.com	9879875645		2022-04-10 19:29:41	2022-04-10 19:29:41
-- 4	Lisa	Laloeva	lialalo@gmail.com	9998885542		2022-04-10 19:29:41	2022-04-10 19:29:41


-- Таблица users была неудачно спроектирована. 
-- Записи created_at и updated_at были заданы типом VARCHAR 
-- и в них долгое время помещались значения в формате "20.10.2017 8:10". 
-- Необходимо преобразовать поля к типу DATETIME, сохранив введеные ранее значения.

create table vk.users_bak
as select * from vk.users;

update vk.users 
set created_at = null, updated_at = null;

alter table vk.users modify created_at varchar(200);
alter table vk.users modify updated_at varchar(200);


describe vk.users;

-- Field	Type	Null	Key	Default	Extra
-- id	bigint unsigned	NO	PRI		auto_increment
-- first_name	varchar(150)	NO			
-- last_name	varchar(150)	NO	MUL		
-- email	varchar(150)	NO	UNI		
-- phone	char(11)	NO	UNI		
-- password_hash	char(65)	YES			
-- created_at	varchar(200)	YES			
-- updated_at	varchar(200)	YES			

update vk.users 
set created_at = date'2022-04-10', updated_at = date'2022-04-11';

select * from vk.users u 

-- id	first_name	last_name	email	phone	password_hash	created_at	updated_at
-- 1	Petya	Petukhov	petya@mail.com	99999999929	81dc9bdb52d04dc20036dbd8313ed055	2022-04-10	2022-04-11
-- 2	Vasya	Vasilkov	vasya@mail.com	99999999919	81dc9bdb52d04dc20036dbd8313ed055	2022-04-10	2022-04-11
-- 3	Pavel	Brabrabra	brabra@yahoo.com	9879875645		2022-04-10	2022-04-11
-- 4	Lisa	Laloeva	lialalo@gmail.com	9998885542		2022-04-10	2022-04-11

alter table vk.users modify created_at datetime;
alter table vk.users modify updated_at datetime;

-- id	first_name	last_name	email	phone	password_hash	created_at	updated_at
-- 1	Petya	Petukhov	petya@mail.com	99999999929	81dc9bdb52d04dc20036dbd8313ed055	2022-04-10 00:00:00	2022-04-11 00:00:00
-- 2	Vasya	Vasilkov	vasya@mail.com	99999999919	81dc9bdb52d04dc20036dbd8313ed055	2022-04-10 00:00:00	2022-04-11 00:00:00
-- 3	Pavel	Brabrabra	brabra@yahoo.com	9879875645		2022-04-10 00:00:00	2022-04-11 00:00:00
-- 4	Lisa	Laloeva	lialalo@gmail.com	9998885542		2022-04-10 00:00:00	2022-04-11 00:00:00

-- а также, сохранился бекап, на всякий случай в vk.users_bak

-- В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры: 
-- 0, если товар закончился и выше нуля, если на складе имеются запасы. 
-- Необходимо отсортировать записи таким образом, 
-- чтобы они выводились в порядке увеличения значения value. 
-- Однако, нулевые запасы должны выводиться в конце, после всех записей.


create table vk.storehouses_products (value bigint);

insert into vk.storehouses_products (value)
values (0), (0), (1000), (150000), (200), (90);

select * from vk.storehouses_products;

-- value
-- 0
-- 0
-- 1000
-- 150000
-- 200
-- 90

select value from vk.storehouses_products
order by value = 0 asc, value asc

-- value
-- 90
-- 200
-- 1000
-- 150000
-- 0
-- 0


-- (по желанию) Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае. 
-- Месяцы заданы в виде списка английских названий ('may', 'august')


create table vk.alter_users (user_name varchar(200), date_birth varchar(200));

insert into vk.alter_users (user_name, date_birth)
values ('Petya', 'january'), ('Vova', 'febriary'), ('Misha', 'may'), ('Gosha', 'june'), ('Lesha', 'august');

select * from vk.alter_users

-- user_name	date_birth
-- Petya	january
-- Vova	febriary
-- Misha	may
-- Gosha	june
-- Lesha	august


select *
from vk.alter_users
where date_birth = 'may' 
	or date_birth = 'august';

-- user_name	date_birth
-- Misha	may
-- Lesha	august

-- (по желанию) Из таблицы catalogs извлекаются записи при помощи запроса. 
-- SELECT * FROM catalogs WHERE id IN (5, 1, 2); 
-- Отсортируйте записи в порядке, заданном в списке IN.

create table catalogs (id bigint);

insert into catalogs (id) values (1), (2), (3), (4), (5), (6);


select * from catalogs
where id in (5, 1, 2)
order by field(id, 5, 1, 2)

-- id
-- 5
-- 1
-- 2



-- агрегация данных
-- (баг mysql с avg, https://bugs.mysql.com/bug.php?id=9874)
select FROM_UNIXTIME(AVG(UNIX_TIMESTAMP(birthday)))
from vk.users us
	left join vk.profiles pr 
		on pr.user_id = us.id 
where pr.birthday is not null;


-- это что-то дикое, мне не нравится такое решение, но оно работает :\
select count(birthday),
	lower(
		date_format( 
			str_to_date(	
				concat(
					convert(
						year(now()), char), '-',
					convert(
						substr(birthday, 6, 2), char),'-',
					convert(
						substr(birthday, 9, 2), char)),'%Y-%m-%d'), '%W'))
from vk.users us
	left join vk.profiles pr 
		on pr.user_id = us.id 
where pr.birthday is not null
group by 
	lower(
		date_format( 
			str_to_date(	
				concat(
					convert(
						year(now()), char), '-',
					convert(
						substr(birthday, 6, 2), char),'-',
					convert(
						substr(birthday, 9, 2), char)),'%Y-%m-%d'), '%W'));

