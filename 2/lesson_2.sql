create database example;

use example;

create table users (
	id serial primary key,
	name varchar (500)
);

describe users;
-- Field	Type	Null	Key	Default	Extra
-- id	int	NO	PRI		
-- name	varchar(500)	YES		


-- mysqldump -u root -p example > example.sql
-- mysql -u root -p sample < example.sql


use sample;

describe users;
-- Field	Type	Null	Key	Default	Extra
-- id	int	NO	PRI		
-- name	varchar(500)	YES			