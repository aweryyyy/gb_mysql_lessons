/* Урок 8. Сложные запросы * /

/* INNER JOIN */
/* Выведем имя и фамилию администраторов сообществ. */

SELECT * FROM users INNER JOIN communities ON users.id = communities.admin_id;

/* LEFT JOIN */
/* Вывести всех пользователей и сообщества, где они создатели, если такие есть. */
SELECT * FROM users LEFT JOIN communities ON users.id = communities.admin_id;

/* RIGHT JOIN */
/* Вывести всех пользователей и сообщества, где они создатели, если такие есть. */
SELECT * FROM communities RIGHT JOIN users ON users.id = communities.admin_id;

ALTER TABLE communities MODIFY admin_id BIGINT UNSIGNED;

INSERT INTO communities (name, description) VALUES ('community_name', 'i have no admin');

/* Вывести сообщества без администратора */
SELECT * FROM users RIGHT JOIN communities ON users.id = communities.admin_id
WHERE users.id IS NULL;

/* Вывести пользователей, которые не создавали сообщества. */
SELECT users.id, firstname, lastname  FROM users LEFT JOIN communities ON users.id = communities.admin_id 
WHERE communities.id IS NULL;

/* FULL OUTER JOIN */
SELECT * FROM users LEFT JOIN communities ON users.id = communities.admin_id
UNION
SELECT * FROM users RIGHT JOIN communities ON users.id = communities.admin_id;

/* Вывести пользователей, которые не создавали сообщества и сообщества без администратора. */

SELECT * FROM users LEFT JOIN communities ON users.id = communities.admin_id WHERE communities.id IS NULL
UNION
SELECT * FROM users RIGHT JOIN communities ON users.id = communities.admin_id WHERE users.id IS NULL;

SELECT * FROM users, communities WHERE users.id = communities.admin_id;

/* CROSS JOIN*/
SELECT * FROM users, communities;

SELECT * FROM users JOIN communities;

/* Задание 1. Выводим данные пользователя. */
SELECT firstname, lastname, gender, birthday FROM users JOIN profiles ON users.id = profiles.user_id;

/* Задание 2. Выводим данные пользователя с красивым полом и возрастом. */
SELECT 
	firstname, 
	lastname, 
	CASE gender
		WHEN 'f' THEN 'female'
		WHEN 'm' THEN 'male'
		ELSE 'not defined'
	END AS gender, 
	TIMESTAMPDIFF(YEAR, birthday, NOW()) AS age
FROM users JOIN profiles ON users.id = profiles.user_id;

/* Задание 3. Выводим все медифайлы пользователей. */
SELECT u.id, firstname, lastname, file_name, media_types_id FROM users AS u JOIN media AS m ON u.id = m.user_id;

/* Задание 4. Выводим все медифайлы пользователя c id = 2. */
SELECT u.id, firstname, lastname, file_name, media_types_id FROM users AS u JOIN media AS m ON u.id = m.user_id
WHERE u.id = 2;

/* Задание 5. Выводим изображения пользователей. */
SELECT u.id, firstname, lastname, file_name, media_types_id FROM users AS u JOIN media AS m ON u.id = m.user_id
WHERE media_types_id = 1;

-- 'image'

SELECT u.id, u.firstname, u.lastname, m.file_name, mt.name FROM users u JOIN media m ON u.id = m.user_id
JOIN media_types mt ON m.media_types_id = mt.id WHERE mt.name = 'image';

/* Задание 6. Выводим все отправленные сообщения пользователя с email = greenfelder.antwan@example.org. */
SELECT m.from_user_id, m.to_user_id, m.txt  FROM messages m JOIN users u 
ON u.id = m.from_user_id WHERE u.email = 'greenfelder.antwan@example.org';

/*  Задание 7. Выводим все полученные сообщения пользователя с email = greenfelder.antwan@example.org. */
SELECT from_user_id, to_user_id, txt FROM messages m JOIN users u 
ON m.to_user_id = u.id WHERE u.email = 'greenfelder.antwan@example.org';

/* Задание 8. Выводим все сообщения пользователя с email = greenfelder.antwan@example.org. */
SELECT from_user_id, to_user_id, txt FROM messages m JOIN users u 
ON m.from_user_id = u.id OR m.to_user_id = u.id 
WHERE u.email = 'greenfelder.antwan@example.org';

/* Задание 9. Выводим все сообщения пользователя с email = greenfelder.antwan@example.org c именем получателя. */

SELECT 
	CONCAT(u1.firstname, ' ' , u1.lastname) AS from_user,
	txt,
	CONCAT(u2.firstname, ' ', u2.lastname) AS to_user,
	m.created_at 
FROM messages m 
JOIN users u1 ON m.from_user_id = u1.id 
JOIN users u2 ON m.to_user_id = u2.id 
WHERE u1.email = 'greenfelder.antwan@example.org' OR u2.email = 'greenfelder.antwan@example.org'
ORDER BY created_at DESC;

/* Задание 10. Выводим диалог между пользователями с id = 1 и id = 2. */
SELECT 
	CONCAT(u1.firstname, ' ', u1.lastname) AS from_user,
	txt,
	CONCAT(u2.firstname, ' ', u2.lastname) AS to_user,
	m.created_at 
FROM messages m 
JOIN users u1 ON m.from_user_id = u1.id 
JOIN users u2 ON m.to_user_id = u2.id 
WHERE (m.from_user_id = 1 AND m.to_user_id = 2) OR (m.from_user_id = 2 AND m.to_user_id = 1)
ORDER BY m.created_at DESC;

/* Задание 11. Выводим количество друзей. */
SELECT 
	u.id,
	COUNT(*)
FROM users u JOIN friend_requests fr 
ON fr.from_user_id = u.id OR fr.to_user_id = u.id
WHERE request_type = 1
GROUP BY u.id;


SELECT 
	u.id,
	COUNT(*)
FROM users u JOIN friend_requests fr ON fr.from_user_id = u.id OR fr.to_user_id = u.id
JOIN friend_requests_types frt ON fr.request_type = frt.id
WHERE frt.name = 'accepted'
GROUP BY u.id;

/* Задание 12. Выводим пользователей с количеством друзей больше 5. */
SELECT 
	u.id,
	COUNT(*) AS cnt
FROM users u JOIN friend_requests fr ON fr.from_user_id = u.id OR fr.to_user_id = u.id
JOIN friend_requests_types frt ON fr.request_type = frt.id
WHERE frt.name = 'accepted'
GROUP BY u.id
HAVING cnt > 5;

/* Задание 13. Выводим все посты пользователя с количеством лайков. 'greenfelder.antwan@example.org'  */

SELECT p.id, COUNT(*) FROM posts p 
JOIN posts_likes pl ON p.id = pl.post_id 
JOIN users u ON p.user_id = u.id
WHERE u.email = 'greenfelder.antwan@example.org' AND pl.like_type = 1
GROUP BY p.id;

/* Задание 14. Выводим всех друзей пользователя с id = 1. */
SELECT 
	DISTINCT u.id, u.firstname, u.lastname 
FROM users u 
JOIN friend_requests fr ON fr.from_user_id = u.id OR fr.to_user_id = u.id 
JOIN friend_requests_types frt ON fr.request_type = frt.id 
WHERE (fr.from_user_id = 1 OR fr.to_user_id = 1) AND frt.name = 'accepted' AND u.id != 1;

/* Задание 14.1 Выводим всех друзей пользователя с id = 1, с которыми он взаимно обменялся заявками. */
SELECT 
	u.id, u.firstname, u.lastname, COUNT(*) AS cnt
FROM users u 
JOIN friend_requests fr ON fr.from_user_id = u.id OR fr.to_user_id = u.id 
JOIN friend_requests_types frt ON fr.request_type = frt.id 
WHERE (fr.from_user_id = 1 OR fr.to_user_id = 1) AND frt.name = 'accepted' AND u.id != 1
GROUP BY u.id
HAVING cnt = 2;

/* Задание 15. Выводим все положительно разрешенные заявки для пользователя с id = 1. */
SELECT 
	CONCAT(u1.firstname, ' ', u1.lastname) AS from_user,
	CONCAT(u2.firstname,' ', u2.lastname) AS to_user
FROM friend_requests fr 
JOIN users u1 ON fr.from_user_id = u1.id 
JOIN users u2 ON fr.to_user_id = u2.id
JOIN friend_requests_types frt ON fr.request_type = frt.id
WHERE (fr.from_user_id = 1 OR fr.to_user_id = 1) AND frt.name = 'accepted';









