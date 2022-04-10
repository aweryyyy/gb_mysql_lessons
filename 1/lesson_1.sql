select 1 from dual;

-- создать базу данных 
create database test_1;

-- посмотреть список бд
show databases;

-- переключиться на новую бд 
use test_1;

-- создаём таблицу 
create table test_tbl (
	id int,
    name varchar(100)
);

create table test_tbl_key (
	id int primary key,
    name varchar(100)
);

-- выбрать данные из таблицы
select * from test_tbl;
select * from test_tbl_key;

-- добавить данные в таблицу
insert test_tbl values(1, 'test1');
insert test_tbl_key values(1, 'test1');

-- обновить данные в таблице
update test_tbl set name = 'test2' where id = 1;
update test_tbl_key set name = 'test2' where id = 1;