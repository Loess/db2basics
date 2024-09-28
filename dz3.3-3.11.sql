--Задание 3
--Напишите запросы для наполнения БД. Выполните запросы на учебной схеме БД.
--Добавьте в отчет результат выполнения запросов – скрины заполненных таблиц, результаты вызова к партициям.

--Название	Автор	Год	Страниц	Жанр	Скачиваний
--Физика невозможного	Митио Каку	2008	460	Non-fiction	2000
--Эгоистичный ген	Ричард Докинз	1989	610	Non-fiction	400
--Вы, конечно, шутите, мистер Фейнман!	Ричард Фейнман	1985	450	Non-fiction	1000
--Кюхля	Юрий Тынянов	1925	350	Исторический роман	2300
--За миллиард лет до конца света	Аркадий и Борис Стругацкие	1977	150	Фантастика	20000
--Понедельник начинается в субботу	Аркадий и Борис Стругацкие	1964	250	Фантастика	21000
--Уравнение Бога. В поисках теории всего	Митио Каку	2021	200	Non-fiction	1700

INSERT INTO student19.dz12_genres (genre_name) VALUES ('Non-fiction'),('Исторический роман'),('Фантастика');
INSERT INTO student19.dz12_authors (first_name) VALUES ('Митио Каку'),('Ричард Докинз'),('Ричард Фейнман'),('Юрий Тынянов'),('Аркадий и Борис Стругацкие');
INSERT INTO student19.dz12_books (title,author_id,publication_year,page_count,genre_id,download_count) VALUES
('Физика невозможного',                 (SELECT author_id FROM student19.dz12_authors WHERE first_name='Митио Каку'),                '2008','460',(SELECT genre_id FROM student19.dz12_genres WHERE genre_name='Non-fiction'),'2000'),
('Эгоистичный ген',                     (SELECT author_id FROM student19.dz12_authors WHERE first_name='Ричард Докинз'),             '1989','610',(SELECT genre_id FROM student19.dz12_genres WHERE genre_name='Non-fiction'),'400'),
('Вы, конечно, шутите, мистер Фейнман!',(SELECT author_id FROM student19.dz12_authors WHERE first_name='Ричард Фейнман'),            '1985','450',(SELECT genre_id FROM student19.dz12_genres WHERE genre_name='Non-fiction'),'1000'),
('Кюхля',                               (SELECT author_id FROM student19.dz12_authors WHERE first_name='Юрий Тынянов'),              '1925','350',(SELECT genre_id FROM student19.dz12_genres WHERE genre_name='Исторический роман'),'2300'),
('За миллиард лет до конца света',      (SELECT author_id FROM student19.dz12_authors WHERE first_name='Аркадий и Борис Стругацкие'),'1977','150',(SELECT genre_id FROM student19.dz12_genres WHERE genre_name='Фантастика'),'20000'),
('Понедельник начинается в субботу',    (SELECT author_id FROM student19.dz12_authors WHERE first_name='Аркадий и Борис Стругацкие'),'1964','250',(SELECT genre_id FROM student19.dz12_genres WHERE genre_name='Фантастика'),'21000'),
('Уравнение Бога. В поисках теории всего',(SELECT author_id FROM student19.dz12_authors WHERE first_name='Митио Каку'),              '2021','200',(SELECT genre_id FROM student19.dz12_genres WHERE genre_name='Non-fiction'),'1700')
;

select * from student19.dz12_books_p1;
--book_id|title          |author_id|genre_id|publication_year|price|isbn|page_count|download_count|
---------+---------------+---------+--------+----------------+-----+----+----------+--------------+
--      2|Эгоистичный ген|        7|       4|            1989|     |    |       610|           400|

select * from student19.dz12_books_p2;
--book_id|title                                 |author_id|genre_id|publication_year|price|isbn|page_count|download_count|
---------+--------------------------------------+---------+--------+----------------+-----+----+----------+--------------+
--      1|Физика невозможного                   |        6|       4|            2008|     |    |       460|          2000|
--      3|Вы, конечно, шутите, мистер Фейнман!  |        8|       4|            1985|     |    |       450|          1000|
--      4|Кюхля                                 |        9|       5|            1925|     |    |       350|          2300|
--      7|Уравнение Бога. В поисках теории всего|        6|       4|            2021|     |    |       200|          1700|

select * from student19.dz12_books_p3;
--book_id|title                           |author_id|genre_id|publication_year|price|isbn|page_count|download_count|
---------+--------------------------------+---------+--------+----------------+-----+----+----------+--------------+
--      5|За миллиард лет до конца света  |       10|       6|            1977|     |    |       150|         20000|
--      6|Понедельник начинается в субботу|       10|       6|            1964|     |    |       250|         21000|

--Напишите запрос для получения списка rowid записей в таблицах с книгами, авторами и жанрами.
SELECT 'books' AS table_name, book_id AS id FROM student19.dz12_books
UNION ALL
SELECT 'authors' AS table_name, author_id AS id FROM student19.dz12_authors
UNION ALL
SELECT 'genres' AS table_name, genre_id AS id FROM student19.dz12_genres;
--Проведите анализ значений rowid, приложите информацию в отчет.
--table_name|id|
------------+--+
--books     | 2|
--books     | 1|
--books     | 3|
--books     | 4|
--books     | 7|
--books     | 5|
--books     | 6|
--authors   | 6|
--authors   | 7|
--authors   | 8|
--authors   | 9|
--authors   |10|
--genres    | 4|
--genres    | 5|
--genres    | 6|

--Напишите запросы, чтобы проверить, какие книги находятся в партициях p1, p2, p3. Приложите запросы и результаты их выполнения в отчет.
select * from student19.dz12_books_p1;
select * from student19.dz12_books_p2;
select * from student19.dz12_books_p3;
-- результаты см. выше

--Задание 4
--Составьте индекс по автору книги.
CREATE INDEX idx_author_id ON student19.dz12_books (author_id);
--Добавьте результаты выполнения в отчет.
--Updated Rows	0
--Query	CREATE INDEX idx_author_id ON student19.dz12_books (author_id)
--Start time	Sat Sep 28 21:10:22 MSK 2024
--Finish time	Sat Sep 28 21:10:22 MSK 2024

--Задание 5
--Составьте запрос для определения суммы скачиваний книг в жанре «исторический роман».
select SUM(download_count) from student19.dz12_books
WHERE genre_id = (select genre_id FROM student19.dz12_genres WHERE genre_name = 'Исторический роман');
--Добавьте результаты выполнения в отчет.
--sum |
------+
--2300|

--Задание 6
--Составьте запрос для определения суммы скачиваний по жанрам.
select g.genre_name, SUM(b.download_count) AS total_downloads
FROM student19.dz12_genres AS g
JOIN student19.dz12_books AS b ON g.genre_id = b.genre_id
GROUP BY g.genre_name;
--genre_name        |total_downloads|
--------------------+---------------+
--Non-fiction       |           5100|
--Исторический роман|           2300|
--Фантастика        |          41000|

--Задание 7
--Составьте запрос определения среднего числа скачиваний у авторов.
SELECT a.first_name AS author_name, AVG(b.download_count) AS average_downloads
FROM student19.dz12_authors AS a
JOIN student19.dz12_books AS b ON a.author_id = b.author_id
GROUP BY author_name;
--Добавьте результаты выполнения в отчет.
--author_name               |average_downloads    |
----------------------------+---------------------+
--Аркадий и Борис Стругацкие|   20500.000000000000|
--Митио Каку                |1850.0000000000000000|
--Ричард Докинз             | 400.0000000000000000|
--Ричард Фейнман            |1000.0000000000000000|
--Юрий Тынянов              |2300.0000000000000000|

--Задание 8
--Составьте запрос для определения суммы числа скачиваний по авторам.
SELECT a.first_name, SUM(b.download_count) AS total_downloads
from student19.dz12_authors AS a
join student19.dz12_books AS b ON a.author_id = b.author_id
GROUP by a.first_name;
--Добавьте результаты выполнения в отчет.
--first_name                |total_downloads|
----------------------------+---------------+
--Аркадий и Борис Стругацкие|          41000|
--Митио Каку                |           3700|
--Ричард Докинз             |            400|
--Ричард Фейнман            |           1000|
--Юрий Тынянов              |           2300|

--Задание 9
--Составьте запрос для определения количества книг у каждого автора.
SELECT a.first_name, COUNT(b.book_id) AS book_count
FROM student19.dz12_authors AS a
LEFT JOIN student19.dz12_books AS b ON a.author_id = b.author_id
GROUP BY a.first_name;
--Добавьте результаты выполнения в отчет.
--first_name                |book_count|
----------------------------+----------+
--Юрий Тынянов              |         1|
--Ричард Фейнман            |         1|
--Митио Каку                |         2|
--Аркадий и Борис Стругацкие|         2|
--Ричард Докинз             |         1|

--Задание 10
--Добавьте в список жанров несколько новых жанров: детектив, фэнтези, биография.
INSERT INTO student19.dz12_genres (genre_name) VALUES ('Детектив'),('Фэнтези'),('Биография');
--Напишите JOIN запросы для таблиц жанры и книги: INNER JOIN, LEFT OUTER JOIN, RIGHT OUTER JOIN, FULL JOIN.
--Добавьте результаты выполнения в отчет.
SELECT g.genre_name, b.title, b.download_count FROM student19.dz12_genres g
INNER JOIN student19.dz12_books b ON g.genre_id = b.genre_id;
--genre_name        |title                                 |download_count|
--------------------+--------------------------------------+--------------+
--Non-fiction       |Уравнение Бога. В поисках теории всего|          1700|
--Non-fiction       |Вы, конечно, шутите, мистер Фейнман!  |          1000|
--Non-fiction       |Физика невозможного                   |          2000|
--Non-fiction       |Эгоистичный ген                       |           400|
--Исторический роман|Кюхля                                 |          2300|
--Фантастика        |Понедельник начинается в субботу      |         21000|
--Фантастика        |За миллиард лет до конца света        |         20000|

SELECT g.genre_name, b.title, b.download_count FROM student19.dz12_genres g
left OUTER JOIN student19.dz12_books b ON g.genre_id = b.genre_id;
--genre_name        |title                                 |download_count|
--------------------+--------------------------------------+--------------+
--Non-fiction       |Уравнение Бога. В поисках теории всего|          1700|
--Non-fiction       |Вы, конечно, шутите, мистер Фейнман!  |          1000|
--Non-fiction       |Физика невозможного                   |          2000|
--Non-fiction       |Эгоистичный ген                       |           400|
--Исторический роман|Кюхля                                 |          2300|
--Фантастика        |Понедельник начинается в субботу      |         21000|
--Фантастика        |За миллиард лет до конца света        |         20000|
--Детектив          |                                      |              |
--Фэнтези           |                                      |              |
--Биография         |                                      |              |

SELECT g.genre_name, b.title, b.download_count FROM student19.dz12_genres g
RIGHT OUTER JOIN student19.dz12_books b ON g.genre_id = b.genre_id;
--genre_name        |title                                 |download_count|
--------------------+--------------------------------------+--------------+
--Non-fiction       |Уравнение Бога. В поисках теории всего|          1700|
--Non-fiction       |Вы, конечно, шутите, мистер Фейнман!  |          1000|
--Non-fiction       |Физика невозможного                   |          2000|
--Non-fiction       |Эгоистичный ген                       |           400|
--Исторический роман|Кюхля                                 |          2300|
--Фантастика        |Понедельник начинается в субботу      |         21000|
--Фантастика        |За миллиард лет до конца света        |         20000|

SELECT g.genre_name, b.title, b.download_count FROM student19.dz12_genres g
FULL OUTER JOIN student19.dz12_books b ON g.genre_id = b.genre_id;
--genre_name        |title                                 |download_count|
--------------------+--------------------------------------+--------------+
--Non-fiction       |Уравнение Бога. В поисках теории всего|          1700|
--Non-fiction       |Вы, конечно, шутите, мистер Фейнман!  |          1000|
--Non-fiction       |Физика невозможного                   |          2000|
--Non-fiction       |Эгоистичный ген                       |           400|
--Исторический роман|Кюхля                                 |          2300|
--Фантастика        |Понедельник начинается в субботу      |         21000|
--Фантастика        |За миллиард лет до конца света        |         20000|
--Детектив          |                                      |              |
--Фэнтези           |                                      |              |
--Биография         |                                      |              |


--Задание 11
--Добавьте в список книгу:
--Доктор Живаго	Борис Пастернак	1955	660	NULL	20300
INSERT INTO student19.dz12_books (title,author_id,publication_year,page_count,genre_id,download_count) VALUES
('Доктор Живаго',(SELECT author_id FROM student19.dz12_authors WHERE first_name='Борис Пастернак'),'1955','660',NULL,'20300');
--т.к. SELECT author_id FROM student19.dz12_authors WHERE first_name='Борис Пастернак' === NULL, в поле автора книги будет NULL

--Напишите запрос по выводу списка жанров книг, для которых нет книг в таблице (с учетом особенностей сравнения с NULL).
--Добавьте результаты выполнения в отчет.
SELECT g.genre_name FROM student19.dz12_genres g
LEFT JOIN student19.dz12_books b ON g.genre_id = b.genre_id
WHERE b.genre_id IS NULL;
--genre_name|
------------+
--Детектив  |
--Фэнтези   |
--Биография |
