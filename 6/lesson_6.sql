use vk;

select 
	us.*, 
	mes.*,
	count(us.id) over (partition by mes.to_user_id) total_messages_to_user
from vk.users us
	left join vk.messages mes 
		on mes.to_user_id = us.id
where mes.id is not null
and us.id = 3;



select count(like_type)
from vk.posts_likes pl 
	left join vk.users u 
		on u.id = pl.user_id 
	left join vk.profiles p 
		on p.user_id = u.id
		and now() - interval '10' year > birthday
where pl.like_type = 1;


select 
	count(like_type), 
	case 
		when p.gender = 'f' then 'female'
		when p.gender = 'm' then 'male'
		when p.gender = 'x' then 'undefined'
		else ''
	end gender
from vk.posts_likes pl 
	left join vk.users u 
		on u.id = pl.user_id 
	left join vk.profiles p 
		on p.user_id = u.id
		and now() - interval '10' year > birthday
where pl.like_type = 1
group by 
case 
	when p.gender = 'f' then 'female'
	when p.gender = 'm' then 'male'
	when p.gender = 'x' then ''
	else ''
end;

