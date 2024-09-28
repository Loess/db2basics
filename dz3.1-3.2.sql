--Задание 1
--Напишите запросы для создания таблицы, cпроектированной в Домашнем задании №1 Базы данных электронных книг, добавьте связи между таблицами. Выполните запросы на учебной схеме БД.
--Done in dz1.2.sql

--Задание 2
--Для таблицы со список книг добавьте разделы партиционирования методом Range по количеству скачиваний:
--P1: число скачиваний меньше 1000;
--P2: число скачиваний больше или равно 1000 и меньше 10000;
--P3: число скачиваний больше или равно 10000.
--Добавьте в отчет результаты выполнения запросов (например, скрин схемы БД).

DROP TABLE IF EXISTS student19.dz12_books cascade;
CREATE TABLE IF NOT EXISTS student19.dz12_books(
book_id                         BIGSERIAL,
title                           VARCHAR NOT NULL,
author_id                        SMALLINT,
genre_id                         SMALLINT,
publication_year                 SMALLINT,
price                            DECIMAL(10, 2),
ISBN                             VARCHAR(20),
page_count                        SMALLINT,
download_count                    INT
) partition by RANGE (download_count);
ALTER TABLE student19.dz12_books ADD foreign key (author_id) REFERENCES student19.dz12_authors(author_id);
ALTER TABLE student19.dz12_books ADD foreign key (genre_id) REFERENCES student19.dz12_genres(genre_id);

CREATE TABLE IF NOT EXISTS student19.dz12_books_P1 PARTITION OF student19.dz12_books
	FOR VALUES FROM (0) TO (1000);
CREATE TABLE IF NOT EXISTS student19.dz12_books_P2 PARTITION OF student19.dz12_books
	FOR VALUES FROM (1000) TO (10000);
CREATE TABLE IF NOT EXISTS student19.dz12_books_P3 PARTITION OF student19.dz12_books
	FOR VALUES FROM (10000) TO (maxvalue);
