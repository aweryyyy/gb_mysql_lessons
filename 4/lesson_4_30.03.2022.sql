-- 
-- Добавим колонку с номером паспорта
ALTER TABLE users ADD COLUMN passport_number VARCHAR(10);

-- Изменяем длину для номера паспорта
ALTER TABLE users MODIFY COLUMN passport_number VARCHAR(20);

-- Переименовываем колонку 
ALTER TABLE users RENAME COLUMN passport_number TO passport;

-- Добавляем индекс 
ALTER TABLE users ADD KEY passport_idx (passport);

DESCRIBE users;

-- Удаляем индекс
ALTER TABLE users DROP KEY passport_idx;

-- Удаляем колонку
ALTER TABLE users DROP COLUMN passport;

/*
 * Модифицируем базу
 */

-- CHECK CONSTRAINTS
-- совершенствуем таблицу дружбы
-- добавляем ограничение, что отправитель запроса на дружбу 
-- не может быть одновременно и получателем

ALTER TABLE friend_requests 
ADD CONSTRAINT sender_not_reciever_check 
CHECK (from_user_id != to_user_id);

-- добавляем ограничение, что номер телефона должен состоять из 11
-- символов и только из цифр
-- https://regex101.com/ 
ALTER TABLE users ADD CONSTRAINT phone_check CHECK(REGEXP_LIKE(phone, '^[0-9]{11}$'));

ALTER TABLE users DROP CONSTRAINT phone_check;

-- делаем foreign key на media
ALTER TABLE profiles ADD CONSTRAINT fk_profiles_media FOREIGN KEY (photo_id) REFERENCES media (id);

/* 
  C - Create = INSERT
  R - Read   = SELECT
  U - Update = UPDATE
  D - Delete = DELETE
*/

/*
 * INSERT
 * https://dev.mysql.com/doc/refman/8.0/en/insert.html
 */

-- добавляем пользователя
INSERT INTO users (id, first_name, last_name, email, phone, password_hash, created_at, updated_at) 
VALUES (DEFAULT, 'Alex', 'Stepanov', 'alex@mail.com', '89213546566', NULL, DEFAULT, DEFAULT);

-- смотрим содержимое таблицы users
SELECT * FROM users;
-- добавляем повторно того же пользователя, ошибка не возникает
INSERT IGNORE INTO users (id, first_name, last_name, email, phone, password_hash, created_at, updated_at) 
VALUES (DEFAULT, 'Alex', 'Stepanov', 'alex@mail.com', '89213546566', NULL, DEFAULT, DEFAULT);

-- не указываем default значения
INSERT users (first_name, last_name, email, phone) VALUES ('Lena', 'Stepanova', 'lena@mail.com', '89213546568');

-- явно задаем id
INSERT INTO users (id, first_name, last_name, email, phone) VALUES 
(55, 'Jane', 'Kvanov', 'jane@mail.com', '89293546560');

-- пробуем добавить id меньше текущего
INSERT INTO users (id, first_name, last_name, email, phone) VALUES 
(45, 'Jane', 'Night', 'jane_n@mail.com', '89293946560');

INSERT INTO users VALUES (DEFAULT, 'Chris', 'Ivanov', 'chris@mail.com', '89213546560', NULL, DEFAULT, DEFAULT);

-- добавляем несколько пользователей
INSERT INTO users (first_name, last_name, email, phone) 
VALUES ('Igor', 'Petrov', 'igor@mail.com', '89213549560'),
('Oksana', 'Petrova', 'oksana@mail.com', '89213549561');

-- добавляем через SET
INSERT INTO users 
SET 
	first_name = 'Iren',
	last_name =  'Sidorova',
	email = 'iren@mail.com',
    phone = '89213541560';
    
  
INSERT INTO users 
SET 
	email = 'iren1@mail.com',
	first_name = 'Iren',
	last_name =  'Sidorova',
    phone = '89213541561';


SELECT * FROM test1.users;

SELECT name, surname, email, phone FROM test1.users;


INSERT IGNORE INTO users (first_name, last_name, email, phone)
SELECT name, surname, email, phone FROM test1.users;

SELECT * FROM users;

/*
 * SELECT
 * https://dev.mysql.com/doc/refman/8.0/en/select.html
 */

-- выбираем константы
SELECT 'HELLO, world!';

-- можно выполнять математические операции и получать результат
SELECT (10 + 1) * 3;

-- получаем результат работы вcтроенной функции NOW()
SELECT NOW();

-- выбираем всё из таблицы users
SELECT * FROM users;

-- выбираем только фамилии и имена из users
SELECT last_name, first_name FROM users;

-- выбираем только уникальные имена
SELECT DISTINCT first_name FROM users;

-- выбираем фамили и имена, соединяем их в строку с помощью функции CONCAT, получаем первую букву имени с помощью функции SUBSTR
SELECT CONCAT(last_name, ' ', SUBSTR(first_name,1,1), '.') AS name FROM users;

-- выбираем четырех пользователей
SELECT * FROM users LIMIT 4;

-- выбираем шесть пользователей, пропустив первых четырех
SELECT * FROM users LIMIT 6 OFFSET 4;

-- аналогично предыдущему запросу
SELECT * FROM users LIMIT 4,6;

-- отсортировываем пользователей по убыванию (DESC) по идентификаторы
SELECT * FROM users ORDER BY id DESC;

-- выбираем 10 рандомных пользователей
SELECT * FROM users ORDER BY RAND() LIMIT 10;

-- выбираем пользователя с id = 5 
SELECT * FROM users WHERE id = 5;

-- выбираем пользователей с id больше или равном 5 
SELECT * FROM users WHERE id >= 5;

-- IN используются для сравнения проверяемого значения поля с заданным списком. 
-- Этот список значений указывается в  скобках справа от оператора IN.
-- SELECT * FROM users WHERE id = 1 OR id = 8 OR id = 55 OR id = 56;
-- Выбираем пользователей с идентификаторами 1,8,55,56
SELECT * FROM users WHERE id IN (1, 8, 55, 56);

-- выбираем пользователей с id больше или равном 5 и меньши или равном 10
SELECT * FROM users WHERE id >= 5 AND id <= 10;

-- аналогично предыдущему запросу, но с использованием BETWEEN ... END
SELECT * FROM users WHERE id BETWEEN 5 AND 10;

-- находим всех пользователей, у которых не задан пароль
SELECT * FROM users WHERE password_hash IS NULL;

-- находим всех пользователей с установленным паролем
SELECT * FROM users WHERE password_hash IS NOT NULL;

-- ищем пользователей с именем Ольга
SELECT * FROM users WHERE first_name = 'Ольга';

-- ищем пользователей с именами 'Лена', 'Елена'
SELECT * FROM users WHERE first_name IN ('Лена', 'Елена');

-- ищем пользователей с именем по маске '%л_на'
SELECT * FROM users WHERE first_name LIKE '%л_на';

-- ищем пользователей с id больше 100 ИЛИ email rlantry8@pen.io
SELECT * FROM users WHERE id > 100 OR email = 'rlantry8@pen.io';

/*
 * UPDATE
 * https://dev.mysql.com/doc/refman/8.0/en/update.html 
*/

-- добавим сообщения
INSERT INTO messages (from_user_id, to_user_id, txt)
VALUES (45, 55, 'Hi!');

INSERT INTO messages (from_user_id, to_user_id, txt)
VALUES (45, 55, 'I hate you!');

SELECT * FROM messages;

-- изменение текста сообщения с id = 7
UPDATE messages 
SET txt = 'I love you' WHERE id = 7;

-- изменение статуса сообщения на "прочитано" (id_delivered = 1) для всех сообщений
UPDATE messages 
SET is_delivered = 1;

-- изменяем текст сообщений, которые отправлены пользователю с id = 2
UPDATE messages 
SET txt = 'Hello!' WHERE to_user_id = 2;

-- устанавливаем password_hash в NULL  
UPDATE users 
SET password_hash = NULL
WHERE id = 1; 

/*
 * DELETE
 * https://dev.mysql.com/doc/refman/8.0/en/delete.html 
 * TRUNCATE
 * https://dev.mysql.com/doc/refman/8.0/en/truncate-table.html
*/

-- удаляем пользователя с фамилией Stepanov
SELECT * FROM users WHERE last_name = 'Stepanov';

DELETE FROM users WHERE last_name = 'Stepanov';

-- удаляем пользователей с id между 100 и 200
DELETE FROM users WHERE id >= 100 AND id <= 200;

SELECT * FROM users;

-- очищаем таблицу с сообщениями
TRUNCATE TABLE messages;

SELECT * FROM messages;

-- пытаемся очистить таблицу пользователей, появится ошибка (сработает ограничение внешнего ключа)
-- TRUNCATE TABLE users;


