drop database boxx;
create database boxx;

use boxx;

create table goods(
	good_id serial primary key,
	good_name varchar(4000) not null
);

create table users_type(
	user_type serial primary key,
	description varchar(4000) not null
);

create table price_type(
	price_type serial primary key,
	user_type bigint unsigned not null,
	foreign key (user_type) references users_type (user_type)
);

create table prices(
	price_id serial primary key,
	good_id bigint unsigned not null,
	price bigint not null,
	date_active_from datetime not null,
	date_active_to datetime not null,
	is_sale boolean not null,
	price_type bigint unsigned not null,
	foreign key (good_id) references goods (good_id)
	foreign key (price_type) references price_type (price_type)
);



create table images(
	image_id serial primary key,
	image blob
);

create table good_params(
	gp_id serial primary key,
	good_id bigint unsigned not null,
	good_color varchar(4000) not null,
	good_dimensions varchar(4000) not null,
	full_description text,
	characteristics text,
	image_id bigint unsigned,
	foreign key (good_id) references goods (good_id),
	foreign key (image_id) references images (image_id)
);


create table users(
	user_id serial primary key,
	user_type bigint unsigned not null,
	create_date datetime default now(),
	country_iso_id bigint unsigned not null,
	came_from varchar(1000),
	user_first_name varchar(1000) not null,
	user_last_name varchar(1000) not null,
	user_patronymic varchar(1000) not null,
	user_email varchar(1000),
	user_phone bigint unsigned not null,
	is_personal_data_collect_signed boolean default false,
	foreign key (user_type) references users_type (user_type)
);


create table user_bucket(
	user_id bigint unsigned not null,
	good_id bigint unsigned not null,
	count bigint not null,
	session_id bigint unsigned not null,
	foreign key (user_id) references users (user_id),
	foreign key (good_id) references goods (good_id)
);

create table orders_extra(
	extra_id serial primary key,
	is_shipping_needed boolean not null,
	nearest_store varchar(4000) not null,
	shipping_address varchar(4000),
	users_description text
);


create table users_orders(
	order_id serial primary key,
	user_id bigint unsigned not null,
	extra_id bigint unsigned not null,
	pay_type varchar(4000) not null,
	foreign key (user_id) references users (user_id),
	foreign key (extra_id) references orders_extra (extra_id)
);

----------------------------------------------------------------------------

insert into goods (good_id, good_name) values
(default, 'Кресло ОСКАР'),
(default, 'Кресло для отдыха АЙРИН'),
(default, 'Диван раскладной АКВА'),
(default, 'Диван раскладной 372 НОРМАН'),
(default, 'Кресло реклайнер OLIMP'),
(default, 'Диван раскладной 198 БАДЕН-БАДЕН'),
(default, 'Диван угловой правый 199 РИТТЭР'),
(default, 'Диван угловой универсальный KRONOS'),
(default, 'Диван угловой левый 199 РИТТЭР'),
(default, 'Диван угловой правый СТЕФАНИ 099');

insert into good_params (good_id, good_color, good_dimensions, full_description, characteristics) values
(1, 'ТК 305', 'РАЗМЕР
Длина
0.74
 
Глубина
0.9
 
Высота
0.91', 'Высокая спинка с наклоном и мягкие подлокотники обеспечивают удобную посадку, дополнительный комфорт создает декоративная подушка. Царга кресла обтянута искусственной кожей в цвет опорам.', '
Страна-производитель
Россия
Срок гарантии
18
Размер изделия
0.74x0.9x0.91'),
(2, 'ТК 321', 'РАЗМЕР
Длина
0.84
 
Глубина
0.75
 
Высота
0.96', 'Минималистичный дизайн, комфорт, функциональность и экологичность – вот 4 главные составляющие столь популярного сегодня скандинавского стиля. Коллекция Айрин полностью соответствует этим требованиям.', '
Страна-производитель
Россия
Срок гарантии
18
Размер изделия
0.84x0.75x0.96'),
(3, 'Savana/Chocolate', 'РАЗМЕР
Длина
2.02
 
Глубина
0.95
 
Высота
0.92', 'Бюджетная модель дивана «АКВА» обладает рядом неоспоримых достоинств: надежный механизм трансформации на каждый день, износостойкая и легкая в уходе обивка в рогожке. В комплекте к дивану подушки не идут.', '
Страна-производитель
Россия
Срок гарантии
12
Размер изделия
2.02x0.95x0.92'),
(4, '623 бежевый (Malmo 08)', 'РАЗМЕР
Длина
2.24
 
Глубина
0.97
 
Высота
0.89', 'Роскошный диван-кровать НОРМАН с легкостью заменит полноценное спальное место, сохранив при этом пространство помещения, а высокие опоры позволят упростить процесс уборки и внешне добавляют изделию легкости. Дизайн модели максимально лаконичен: практичная обивка из рогожки замедляет износ поверхностей, а мягкие цилиндрические подушечки создают ощущение уюта и комфорта. Изделие представлено в трех оттенках, чтобы подойти к любому интерьеру.', '
Страна-производитель
Россия
Срок гарантии
18
Размер изделия
2.24x0.97x0.89'),
(5, 'szary material', 'РАЗМЕР
Длина
0.72
 
Глубина
0.8
 
Высота
1.01', 'Кресло OLIMP станет любимым предметом мебели у всех членов семьи. Его конструкция позволяет откидывать спинку и выдвигать подставку под ноги, а также применять функцию раскачивания. Это идеальный вариант для комфортного отдыха или перерыва на сон.', '
Страна-производитель
Польша
Срок гарантии
18
Размер изделия
0.72x0.8x1.01'),
(6, '420 серый (Bergen Ash)', 'РАЗМЕР
Длина
2
 
Глубина
0.98
 
Высота
0.93', 'Яркий и стильный диван Баден-Баден имеет ортопедическое спальное место с независимым пружинным блоком ТFK, которое идентично полноценному матрасу. Материал обивки велюр, он легко поддается сухой чистке, мягкий, бархатистый и прекрасно смотрится. В Баден-Бадене гармонично слились функциональность и современный дизайн.', '
Страна-производитель
Россия
Срок гарантии
18
Размер изделия
2x0.98x0.93'),
(7, '454 серо-бежевый', 'РАЗМЕР
Длина
2.58
 
Глубина
1.65
 
Высота
0.9', 'Стильный угловой диван Риттэр с широкими удобными подлокотниками и набором подушек разного размера — воплощение комфорта и уюта. С помощью выдвижного механизма модель легко превращается в большую двуспальную кровать. Особую элегантность этому классическому дивану придает велюровая обивка в контрастных цветах.', '
Страна-производитель
Россия
Срок гарантии
18
Размер изделия
2.58x1.65x0.9'),
(8, 'Alfa 16', 'РАЗМЕР
Длина
2.48
 
Глубина
1.66
 
Высота
0.94', 'Шикарный угловой диван Kronos декорирован элементами из натурального дерева. Подушки спинки имеют 2 положения для максимально комфорта и удобства эксплуатации как в сложенном так и разложенном виде.', '
Страна-производитель
Польша
Срок гарантии
6
Размер изделия
2.48x1.66x0.94'),
(9, '454 серо-бежевый', 'РАЗМЕР
Длина
2.58
 
Глубина
1.65
 
Высота
0.9', 'Стильный угловой диван Риттэр с широкими удобными подлокотниками и набором подушек разного размера — воплощение комфорта и уюта. С помощью выдвижного механизма модель легко превращается в большую двуспальную кровать. Особую элегантность этому классическому дивану придает велюровая обивка в контрастных цветах.', '
Страна-производитель
Россия
Срок гарантии
18
Размер изделия
2.58x1.65x0.9'),
(10, '475 кор', 'РАЗМЕР
Длина
2.55
 
Глубина
1.65
 
Высота
0.9', 'Модель дивана Стефани, престижного европейского дизайна, приятно удивит Вас скромной ценой. Владельца этого дивана порадует глубокая и комфортная посадка днем и просторное высокое спальное место для отдыха ночью. В большой бельевой ящик поместятся все спальные принадлежности, которые для удобства изолированы от замков механизма. Изделие обтянуто высококачественной велюровой тканью насыщенного, глубокого цвета. Пышные мягкие подушки входят в комплект и сделают ваш интерьер еще уютнее. Каркас дивана выполнен из массива дерева, что обеспечивает высокую прочность и долгий срок службы. Стефани - это серьезный, стильный диван для современной квартиры.', '
Страна-производитель
Россия
Срок гарантии
18
Размер изделия
2.55x1.65x0.9');

insert into users_type (description) values
('физическое лицо'),
('юридическое лицо');

insert into price_type (user_type) values
('1'),
('2');


insert into prices (good_id, price, date_active_from, date_active_to, is_sale, price_type) values
(1, 16499, date'2021-06-01', date'4012-12-31', 0, 1),
(2, 16499, date'2022-02-15', date'4012-12-31', 0, 1),
(3, 25999, date'2022-04-23', date'4012-12-31', 0, 1),
(4, 39999, date'2021-06-01', date'4012-12-31', 0, 1),
(5, 42199, date'2021-06-01', date'4012-12-31', 0, 1),
(6, 42499, date'2021-06-01', date'4012-12-31', 0, 1),
(7, 62999, date'2022-04-23', date'4012-12-31', 0, 1),
(8, 62999, date'2022-04-23', date'4012-12-31', 0, 1),
(9, 62999, date'2022-02-15', date'4012-12-31', 0, 1),
(10, 63999, date'2021-06-01', date'4012-12-31', 0, 1),
(6, 42499, date'2022-04-26', date'2022-05-01', 1, 1),
(8, 62999, date'2022-04-26', date'2022-05-01', 1, 1),
(10, 63999, date'2022-04-26', date'2022-05-01', 1, 1);




insert into users (user_type, create_date,country_iso_id,came_from, user_first_name, user_last_name, user_patronymic, user_phone, is_personal_data_collect_signed) values
(1, date'2020-12-12', 643, 'google.com', 'Иванов', 'Иван', '-', 999888775544, 1),
(1, date'2021-04-19', 643, 'yandex.ru', 'Петров', 'Александр', '-', 999765276776, 1),
(1, date'2021-08-25', 643, 'yandex.ru', 'Сидоров', 'Павел', '-', 999641778008, 1),
(1, date'2021-12-31', 643, 'yandex.ru', 'Лысенко', 'Надежда', 'Андреевна', 999518279240, 1),
(1, date'2022-05-08', 643, 'yandex.ru', 'Авдеева', 'Наталия', 'Сергеевна', 999394780472, 1),
(1, date'2022-09-13', 643, 'yandex.ru', 'Борисов', 'Дмитрий', '-', 999271281704, 1),
(1, date'2023-01-19', 643, 'yandex.ru', 'Балабанов', 'Григорий', '-', 999147782936, 0),
(1, date'2023-05-27', 643, 'ad.context.ru', 'Жукова', 'Татьяна', 'Андреевна', 999024284168, 1),
(1, date'2023-10-02', 643, 'ad.context.ru', 'Нестеров', 'Никита', 'Петрович', 998900785400, 1),
(1, date'2024-02-07', 643, 'ad.context.ru', 'Конев', 'Василий', 'Артёмович', 998777286632, 1);





insert into user_bucket (user_id, good_id, count, session_id) values
(1,3,2,1),
(1,6,1,1),
(4,8,1,2),
(3,3,2,3);

create table orders_extra(
	extra_id serial primary key,
	is_shipping_needed boolean not null,
	nearest_store varchar(4000) not null,
	shipping_address varchar(4000),
	users_description text
);

create table users_orders(
	order_id serial primary key,
	user_id bigint unsigned not null,
	extra_id bigint unsigned not null,
	pay_type varchar(4000) not null,
	foreign key (user_id) references users (user_id),
	foreign key (extra_id) references orders_extra (extra_id)
);

create table orders(
	order_id bigint unsigned not null,
	good_id bigint unsigned not null,
	foreign key (order_id) references users_orders (order_id),
	foreign key (good_id) references goods (good_id)
);


insert into orders (order_id, good_id) values
(3, 5),
(3, 8),
(3,6),
(4, 3),
(4,4);


insert into users_orders (user_id, extra_id, pay_type) values
(7, 1, 'оплата картой'),
(4, 2, 'оплата наличными');

insert into orders_extra (is_shipping_needed, nearest_store, shipping_address, users_description) values
(0, 'ул. Академика Янгеля, 45', null, null),
(1, 'ул. Льва Толстого, 1', 'ул. Ленина, 90', 'доставка 13.06');

create or replace view all_users_orders as
select 
	concat(uu.user_first_name, ' ', uu.user_patronymic, ' ', uu.user_last_name) user_name,
	uu.user_phone,
	uu.is_personal_data_collect_signed,
	gd.good_name,
	oo.order_id
from users_orders uo 
	inner join users uu
		on uu.user_id = uo.user_id 
	inner join orders_extra oe 
		on oe.extra_id = uo.extra_id
	inner join orders oo
		on oo.order_id = uo.order_id 
	inner join goods gd
		on gd.good_id = oo.good_id;

create or replace view users_unsigned_agreement as
select *
from users
where is_personal_data_collect_signed = 0;
	




-- товары распродажи
select *
from goods gd
	inner join prices pr
		on pr.good_id = gd.good_id 
		and pr.is_sale = 1;

-- количество товаров по заказам + среднее кол-во товаров в заказе
select 
	count(good_id) count_of_goods_by_order, 
	round(avg(count(good_id)) over (), 2) average_goods_in_orders, 
	order_id 
from orders o
group by order_id;

-- количество товаров в корзинах юзеров, которые не приняли соглашение о персоданных
select 
	count(good_id) total_bucket_goods,
	user_id
from user_bucket ub
where user_id in 
	(select user_id 
	 from users 
	 where is_personal_data_collect_signed = 0);
	 
	
create function add_sale_for_good (p_good_id bigint,
											  p_date_start datetime,
											  p_date_end datetime,
											  p_price bigint,
											  p_price_type bigint)
returns boolean
begin
	insert into prices
		(good_id, price, date_active_from, date_active_to, is_sale, price_type)
	select  
		p_good_id,
		p_price,
		p_date_start,
		p_date_end,
		1 as is_sale,
		p_price_type
	from dual;
	return true;
end;


SET GLOBAL log_bin_trust_function_creators = 1;
