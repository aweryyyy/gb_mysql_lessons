-- Создайте базу данных example, разместите в ней таблицу users, состоящую из двух столбцов, числового id и строкового name.

create database example;

use example;

create table users (id int primary key, name varchar(500));

-- Создайте дамп базы данных example из предыдущего задания, разверните содержимое дампа в новую базу данных sample.

-- использую консоль

-- C:\Users\awery>mysqldump -u root -p example > c://dump_db/example_dump.sql
-- Enter password: ********

-- C:\Users\awery>mysql -u root -p
-- Enter password: ********
-- Welcome to the MySQL monitor.  Commands end with ; or \g.
-- Your MySQL connection id is 102
-- Server version: 8.0.28 MySQL Community Server - GPL

-- Copyright (c) 2000, 2022, Oracle and/or its affiliates.

-- Oracle is a registered trademark of Oracle Corporation and/or its
-- affiliates. Other names may be trademarks of their respective
-- owners.

-- Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

-- mysql> create database sample;
-- Query OK, 1 row affected (0.01 sec)

-- mysql> exit
-- Bye

-- C:\Users\awery>mysqldump -u root -p sample < c://dump_db/example_dump.sql
-- Enter password: ********
-- -- MySQL dump 10.13  Distrib 8.0.28, for Win64 (x86_64)
-- --
-- -- Host: localhost    Database: sample
-- -- ------------------------------------------------------
-- -- Server version       8.0.28

-- /*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
-- /*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
-- /*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
-- /*!50503 SET NAMES utf8mb4 */;
-- /*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
-- /*!40103 SET TIME_ZONE='+00:00' */;
-- /*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
-- /*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
-- /*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
-- /*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
-- /*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

-- /*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
-- /*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
-- /*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
-- /*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
-- /*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
-- /*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
-- /*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- -- Dump completed on 2022-02-22 21:56:34

-- C:\Users\awery>mysql -u root -p
-- Enter password: ********
-- Welcome to the MySQL monitor.  Commands end with ; or \g.
-- Your MySQL connection id is 104
-- Server version: 8.0.28 MySQL Community Server - GPL

-- Copyright (c) 2000, 2022, Oracle and/or its affiliates.

-- Oracle is a registered trademark of Oracle Corporation and/or its
-- affiliates. Other names may be trademarks of their respective
-- owners.

-- Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

-- mysql> use sample;
-- Database changed
-- mysql> show tables;
-- +------------------+
-- | Tables_in_sample |
-- +------------------+
-- | users            |
-- +------------------+
-- 1 row in set (0.00 sec)

-- mysql> exit
-- Bye

-- C:\Users\awery>


-- сделать бекап 100 строк таблицы help_keyword 
-- C:\Users\awery>mysqldump -u root -p mysql help_keyword --opt --where="1 = 1 order by help_keyword_id limit 100" > c://dump_db/one_tab.sql
-- Enter password: ********
