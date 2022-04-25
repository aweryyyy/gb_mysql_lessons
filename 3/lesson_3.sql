DROP DATABASE IF EXISTS vk;

CREATE DATABASE IF NOT EXISTS vk;

USE vk;

CREATE TABLE users(
	id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	first_name VARCHAR(150) NOT NULL,
	last_name VARCHAR(150) NOT NULL,
	email VARCHAR(150) UNIQUE NOT NULL,
	phone CHAR(11) UNIQUE NOT NULL,
	password_hash CHAR(65) DEFAULT NULL,
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	INDEX (last_name)
);


-- Заполним таблицу, добавим Петю 

INSERT INTO users 
VALUES (DEFAULT, 'Petya', 'Petukhov','petya@mail.com','99999999929','81dc9bdb52d04dc20036dbd8313ed055', DEFAULT, DEFAULT);

INSERT INTO users 
VALUES (DEFAULT, 'Vasya', 'Vasilkov', 'vasya@mail.com', '99999999919','81dc9bdb52d04dc20036dbd8313ed055', DEFAULT, DEFAULT);


CREATE TABLE profiles(
	user_id BIGINT UNSIGNED NOT NULL PRIMARY KEY,
	gender ENUM('f', 'm', 'x') NOT NULL,
	birthday DATE NOT NULL,
	photo_id BIGINT UNSIGNED,
	city VARCHAR(130),
	country VARCHAR(130),
	FOREIGN KEY (user_id) REFERENCES users (id)
);

-- Заполним таблицу, добавим профили для уже созданных Пети и Васи
-- профиль Пети
INSERT INTO profiles VALUES (1, 'm', '1997-12-01', 1, 'Moscow', 'Russia');

INSERT INTO profiles VALUES (2, 'm', '1988-11-02', 2, 'Moscow', 'Russia');

CREATE TABLE messages(
	id SERIAL PRIMARY KEY, -- SERIAL = BIGINT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE
	from_user_id BIGINT UNSIGNED NOT NULL,
	to_user_id BIGINT UNSIGNED NOT NULL,
	txt TEXT,
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	is_delivered BOOLEAN DEFAULT FALSE,
	FOREIGN KEY (from_user_id) REFERENCES users (id),
	FOREIGN KEY (to_user_id) REFERENCES users (id)
);

INSERT INTO messages VALUES (DEFAULT, 1, 2, 'Hi!', DEFAULT, DEFAULT, DEFAULT);


INSERT INTO messages VALUES (DEFAULT, 1, 2, 'Vasya!', DEFAULT, DEFAULT, DEFAULT);

INSERT INTO messages VALUES (DEFAULT, 2, 1, 'Hi, Petya', DEFAULT, DEFAULT, DEFAULT);

CREATE TABLE friend_requests(
	from_user_id BIGINT UNSIGNED NOT NULL,
	to_user_id BIGINT UNSIGNED NOT NULL,
	accepted BOOL DEFAULT FALSE,
	PRIMARY KEY (from_user_id, to_user_id),
	FOREIGN KEY (from_user_id) REFERENCES users (id),
	FOREIGN KEY (to_user_id) REFERENCES users (id)
);

ALTER TABLE friend_requests ADD CONSTRAINT CHECK(from_user_id != to_user_id);

INSERT INTO friend_requests VALUES (1, 2, DEFAULT);


CREATE TABLE communities(
	id SERIAL PRIMARY KEY,
	name VARCHAR(150) NOT NULL,
	description VARCHAR(255),
	admin_id BIGINT UNSIGNED NOT NULL,
	KEY (name),
	FOREIGN KEY (admin_id) REFERENCES users (id)
);

INSERT INTO communities VALUES (DEFAULT, 'Number1', 'I am number one', 1);

CREATE TABLE communities_users(
	community_id BIGINT UNSIGNED NOT NULL,
	user_id BIGINT UNSIGNED NOT NULL,
	PRIMARY KEY (community_id, user_id),
	FOREIGN KEY (community_id) REFERENCES communities (id),
	FOREIGN KEY (user_id) REFERENCES users (id)
);

INSERT INTO communities_users VALUES (1, 2);

CREATE TABLE media_types(
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(50) UNIQUE NOT NULL
);

INSERT INTO media_types VALUES (DEFAULT, 'изображение');
INSERT INTO media_types VALUES (DEFAULT, 'музыка');
INSERT INTO media_types VALUES (DEFAULT, 'документ');

CREATE TABLE media(
	id SERIAL PRIMARY KEY,
	user_id BIGINT UNSIGNED NOT NULL,
	media_types_id INT UNSIGNED NOT NULL,
	file_name VARCHAR(255),
	file_size BIGINT UNSIGNED,
	created_at DATETIME DEFAULT NOW(),
	updated_at DATETIME DEFAULT NOW() ON UPDATE NOW(),
	FOREIGN KEY (user_id) REFERENCES users (id),
	FOREIGN KEY (media_types_id) REFERENCES media_types (id)
);

INSERT INTO media VALUES (DEFAULT, 1, 1, 'ghj.png', 100, DEFAULT, DEFAULT);

INSERT INTO media VALUES (DEFAULT, 1, 1, 'ghj1.png', 78, DEFAULT, DEFAULT);

INSERT INTO media VALUES (DEFAULT, 2, 3, 'doc.pdf', 107, DEFAULT, DEFAULT);


-- ДЗ отсюда:


-- перечень полей:
create table posts(
	id serial primary key, -- индекс
	user_id BIGINT UNSIGNED NOT null,
	community_id BIGINT UNSIGNED NOT NULL,
	full_message text,
	short_message varchar(500) default '',
	header_text varchar(500) not null,
	FOREIGN KEY (user_id) REFERENCES users (id), -- внешний ключ
	FOREIGN KEY (community_id) REFERENCES communities (id) -- внешний ключ
);

insert into posts 
(user_id, community_id, full_message, short_message, header_text)
values
(1, 1, 'Hello there!', 'Hi', 'Greetings');

select * from vk.posts;

-- id	user_id	community_id	full_message	short_message	header_text
-- 1	1	1	Hello there!	Hi	Greetings

-- список полей
create table media_posts (
	link_id serial primary key, -- первичный ключ + индекс
	post_id bigint unsigned not null,
	media_id bigint unsigned not null,
	foreign key (post_id) references posts (id), -- внешний ключ
	foreign key (media_id) references media (id) -- внешний ключ
);

insert into media_posts
(post_id, media_id)
values (1, 3);

select 
	pp.*,  
	mm.*,
	mp.*
from vk.posts pp
	left join vk.media_posts mp
		on pp.id = mp.post_id
	left join vk.media mm
		on mm.id = mp.media_id

-- id	user_id	community_id	full_message	short_message	header_text	id	user_id	media_types_id	file_name	file_size	created_at	updated_at	link_id	post_id	media_id
-- 1	1	1	Hello there!	Hi	Greetings	3	2	3	doc.pdf	107	2022-04-10 18:23:29	2022-04-10 18:23:29	1	1	3
		
		
create table blocks (
	id serial primary key,
	object_name varchar (500) not null,
	object_id varchar (500) not null,
	comment varchar (2000),
	start_date datetime not null default current_timestamp,
	end_date datetime not null default '4012-12-31 23:59:59'
);


insert into blocks
(object_name, object_id, comment)
values ('user', 1, 'Too active');

select * from blocks;

-- id	object_name	object_id	comment	start_date	end_date
-- 1	user	1	Too active	2022-04-10 18:50:22	4012-12-31 23:59:59

		