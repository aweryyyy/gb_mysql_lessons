-- В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных. Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте транзакции.
START transaction;

insert into sample.users
(select id, name from shop.users where id = 1);

commit;


select * from sample.users;

id	name
1	Геннадий

-- Создайте представление, которое выводит название name товарной позиции из таблицы products и соответствующее название каталога name из таблицы catalogs.

select * from products p
	left join catalogs c 
		on c.id = p.catalog_id 

create or replace view product_catalog as 
select p.name product_name, 
	   c.name catalog_name
	from products p
		left join catalogs c 
			on c.id = p.catalog_id ;
			
select * from product_catalog;

product_name	catalog_name
Intel Core i3-8100	Процессоры
Intel Core i5-7400	Процессоры
AMD FX-8320E	Процессоры
AMD FX-8320	Процессоры
ASUS ROG MAXIMUS X HERO	Материнские платы
Gigabyte H310M S2H	Материнские платы
MSI B250M GAMING PRO	Материнские платы


