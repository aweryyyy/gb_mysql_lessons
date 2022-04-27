use shop;

-- Составьте список пользователей users, 
-- которые осуществили хотя бы один заказ orders в интернет магазине.


select us.id, us.name, us.birthday_at, us.created_at, us.updated_at
from users us
	inner join orders od
		on od.user_id = us.id 
group by us.id, us.name, us.birthday_at, us.created_at, us.updated_at;

-- Выведите список товаров products и разделов catalogs, который соответствует товару.

-- и всё?
select *
from products pr
	inner join catalogs c 
		on c.id = pr.catalog_id;
	

-- (по желанию) Пусть имеется таблица рейсов flights (id, from, to) 
-- и таблица городов cities (label, name). 
-- Поля from, to и label содержат английские названия городов, поле name — русское. 
-- Выведите список рейсов flights с русскими названиями городов.

select 
	fl.id, 
	ct_from.name from_name, 
	ct_to.name to_name
from flights fl
	left join cities ct_from
		on ct.label = fl.from
	left join cities ct_to
		on ct.label = fl.to;

