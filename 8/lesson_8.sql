use vk;

-- Пусть задан некоторый пользователь. 
-- Из всех пользователей соц. сети найдите человека, который больше всех общался с выбранным пользователем (написал ему сообщений).


select 
	usr.firstname, 
	usr.lastname,
	usr_max.cnt_messages
from users usr
	inner join 
		(select distinct
			count(ms.id) over (partition by us.id) cnt_messages,
			us.id
		from users us
			inner join messages ms
				on us.id = ms.to_user_id 
		where us.id = 3
		order by 1 desc limit 1) usr_max
		on usr.id = usr_max.id;
		
-- Подсчитать общее количество лайков, которые получили пользователи младше 10 лет..
select distinct
	sum(pl.likes) over () total_likes,
	usr.id,
	usr.firstname,
	usr.lastname,
	pr.birthday 
from users usr
	inner join profiles pr
		on pr.user_id = usr.id
		-- разница между днями рождения и сегодня должна быть меньше разницы между сегодня и минус 10 лет
		and dateDIFF(sysdate(), pr.birthday) < dateDIFF(sysdate(), sysdate() - interval '10' year)
	left join posts_likes pl 
		on pl.user_id = usr.id;
		
-- Определить кто больше поставил лайков (всего): мужчины или женщины.
select sum(pl.likes) total_likes, 
	   case 
	   	when gender='x' then 'Undefined'
	   	when gender='f' then 'Female'
	   	when gender='m' then 'Male'
	   	else null
	   	end gender_description
from users u 
	left join profiles p 
		on u.id = p.user_id 
	left join posts_likes pl 
		on pl.user_id = u.id
group by gender;
		
