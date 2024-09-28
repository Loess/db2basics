--Задание 3
--Составьте запрос для поиска исполнителей, у которых есть треки в жанре “N” (например, рок).
--Добавьте в отчет результат выполнения запроса.

SELECT a.artist_name FROM student19.dz1_artists a
JOIN student19.dz1_tracks t ON a.artist_id = t.artist_id
JOIN student19.dz1_genres g ON t.genre_id = g.genre_id
WHERE g.genre_name = 'Ambient';

--Result:
--artist_name|
-------------+
--Aphex Twin |

--Задание 4
--Составьте запрос для поиска исполнителей, у которых нет ни одного трека в жанре “M” (например, кантри).
--Добавьте в отчет результат выполнения запроса.

SELECT a.artist_name FROM student19.dz1_artists a
WHERE a.artist_id NOT IN (
    SELECT t.artist_id FROM student19.dz1_tracks t
    JOIN student19.dz1_genres g ON t.genre_id = g.genre_id
    WHERE g.genre_name = 'Pop'
);

--Result:
--artist_name    |
-----------------+
--Limp Bizkit    |
--Aphex Twin     |
--Красная Плесень|

--Задание 5
--Составьте запрос для поиска треков в жанре “Х” (например, поп) с числом прослушиваний, более 30000.
--Добавьте в отчет результат выполнения запроса.

SELECT t.name,g.genre_name,t.plays FROM student19.dz1_tracks t
JOIN student19.dz1_genres g ON t.genre_id = g.genre_id
WHERE g.genre_name = 'Ambient' AND t.plays > 300;

--Result:
--name|genre_name|plays|
------+----------+-----+
--On  |Ambient   |20000|

--Задание 6
--Составьте запрос для поиска исполнителей жанра Y (например, рэп), у которых среднее число прослушиваний треков более 20 000 000.
--Добавьте в отчет результат выполнения запроса.

SELECT a.artist_name, AVG(t.plays) AS avg_plays FROM student19.dz1_artists a
JOIN student19.dz1_tracks t ON a.artist_id = t.artist_id
JOIN student19.dz1_genres g ON t.genre_id = g.genre_id
WHERE g.genre_name = 'Rock'
GROUP BY a.artist_name
HAVING AVG(t.plays) > 20;

--Result:
--artist_name|avg_plays           |
-------------+--------------------+
--Limp Bizkit|500.0000000000000000|

--Задание 7
--Составьте запрос для определения суммы прослушиваний песен в жанре “M”.
--Добавьте результаты выполнения в отчет.

SELECT SUM(t.plays) AS total_plays FROM student19.dz1_tracks t
JOIN student19.dz1_genres g ON t.genre_id = g.genre_id
WHERE g.genre_name = 'Rock';

--Result:
--total_plays|
-------------+
--       1000|

--Задание 8
--Составьте запрос для определения суммы прослушиваний по жанрам, отсортированным по возрастанию количества прослушиваний.

SELECT g.genre_name, SUM(t.plays) AS total_plays FROM student19.dz1_tracks t
JOIN student19.dz1_genres g ON t.genre_id = g.genre_id
GROUP BY g.genre_name
ORDER BY total_plays ASC;

--Result:
--genre_name|total_plays|
------------+-----------+
--Rock      |       1000|
--Ambient   |      20000|

--Задание 9
--Составьте запрос определения среднего числа прослушиваний у исполнителей, отсортированных по убыванию количества прослушиваний.
--Добавьте результаты выполнения в отчет.

SELECT a.artist_name, AVG(t.plays) AS avg_plays FROM student19.dz1_artists a
JOIN student19.dz1_tracks t ON a.artist_id = t.artist_id
GROUP BY a.artist_name
ORDER BY avg_plays DESC;

--Result:
--artist_name    |avg_plays           |
-----------------+--------------------+
--Aphex Twin     |  20000.000000000000|
--Limp Bizkit    |500.0000000000000000|
--Красная Плесень| 20.0000000000000000|

--Задание 10
--Составьте запрос для определения суммы числа прослушиваний по исполнителям, отсортированным по возрастанию числа прослушиваний.
--Добавьте результаты выполнения в отчет.

SELECT a.artist_name, SUM(t.plays) AS total_plays FROM student19.dz1_artists a
JOIN student19.dz1_tracks t ON a.artist_id = t.artist_id
GROUP BY a.artist_name
ORDER BY total_plays ASC;

--Result:
--artist_name    |total_plays|
-----------------+-----------+
--Красная Плесень|         20|
--Limp Bizkit    |       1000|
--Aphex Twin     |      20000|

--Задание 11
--Составьте запрос для определения количества песен у каждого исполнителя.
--Добавьте результаты выполнения в отчет.

SELECT a.artist_name, COUNT(t.track_id) AS count_of_tracks FROM student19.dz1_artists a
JOIN student19.dz1_tracks t ON a.artist_id = t.artist_id
GROUP BY a.artist_name
ORDER BY count_of_tracks DESC;

--Result:
--artist_name    |count_of_tracks|
-----------------+---------------+
--Limp Bizkit    |              2|
--Красная Плесень|              1|
--Aphex Twin     |              1|

--Задание 12
--Добавьте в список жанров несколько новых жанров.
--Напишите JOIN запросы для таблиц исполнители и песни: INNER JOIN, LEFT OUTER JOIN, RIGHT OUTER JOIN, FULL JOIN.
--Добавьте результаты выполнения в отчет.

INSERT INTO student19.dz1_genres (genre_name) VALUES
('Electronic'),
('Industrial'),
('Classical'),
('Blues');

--INNER JOIN возвращает только записи, у которых есть соответствия в обеих таблицах
SELECT a.artist_name, t.name AS track_name, t.year, t.duration, t.plays FROM student19.dz1_artists a
INNER JOIN student19.dz1_tracks t ON a.artist_id = t.artist_id;
--Result:
--artist_name    |track_name           |year|duration|plays|
-----------------+---------------------+----+--------+-----+
--Красная Плесень|Сказка о царе Салтане|1999|32:52   |   20|
--Aphex Twin     |On                   |1993|3:48    |20000|
--Limp Bizkit    |Just Like This       |1999|3:35    | 1000|
--Limp Bizkit    |Nookie               |1999|4:49    |    0|

--LEFT OUTER JOIN возвращает только левые записи, если неь соответствия в правой таблице - заполнение NULL
SELECT a.artist_name, t.name AS track_name, t.year, t.duration, t.plays FROM student19.dz1_artists a
LEFT OUTER JOIN student19.dz1_tracks t ON a.artist_id = t.artist_id;
--результат не изменится, т.к. в обеих таблицах есть полные соотвествтвия
--artist_name    |track_name           |year|duration|plays|
-----------------+---------------------+----+--------+-----+
--Красная Плесень|Сказка о царе Салтане|1999|32:52   |   20|
--Aphex Twin     |On                   |1993|3:48    |20000|
--Limp Bizkit    |Just Like This       |1999|3:35    | 1000|
--Limp Bizkit    |Nookie               |1999|4:49    |    0|

--RIGHT OUTER JOIN возвращает только правые записи, если неь соответствия в левой таблице - заполнение NULL
SELECT a.artist_name, t.name AS track_name, t.year, t.duration, t.plays FROM student19.dz1_artists a
RIGHT OUTER JOIN student19.dz1_tracks t ON a.artist_id = t.artist_id;
--результат не изменится, т.к. в обеих таблицах есть полные соотвествтвия
--artist_name    |track_name           |year|duration|plays|
-----------------+---------------------+----+--------+-----+
--Красная Плесень|Сказка о царе Салтане|1999|32:52   |   20|
--Aphex Twin     |On                   |1993|3:48    |20000|
--Limp Bizkit    |Just Like This       |1999|3:35    | 1000|
--Limp Bizkit    |Nookie               |1999|4:49    |    0|

--FULL JOIN -- выводит декартово проиведение двух таблиц, вывод также не изменится в моем примере:
SELECT a.artist_name, t.name AS track_name, t.year, t.duration, t.plays FROM student19.dz1_artists a
FULL JOIN student19.dz1_tracks t ON a.artist_id = t.artist_id;
--artist_name    |track_name           |year|duration|plays|
-----------------+---------------------+----+--------+-----+
--Красная Плесень|Сказка о царе Салтане|1999|32:52   |   20|
--Aphex Twin     |On                   |1993|3:48    |20000|
--Limp Bizkit    |Just Like This       |1999|3:35    | 1000|
--Limp Bizkit    |Nookie               |1999|4:49    |    0|

--Задание 13
--Добавьте в список песню какого-либо исполнителя, заполнив ее жанр значением NULL.
INSERT INTO student19.dz1_tracks (name, artist_id, year, duration, plays, genre_id, album_id)
VALUES ('Come To Daddy', (SELECT artist_id FROM student19.dz1_artists WHERE artist_name = 'Aphex Twin'), '1997', '4:19', 99999, NULL, NULL);
--Напишите запрос по выводу списка жанров, для которых нет песен в таблице (с учетом особенностей сравнения с NULL).
--Добавьте результаты выполнения в отчет.
SELECT g.genre_name FROM student19.dz1_genres g
LEFT OUTER JOIN student19.dz1_tracks t ON g.genre_id = t.genre_id
WHERE t.genre_id IS NULL;

--Result:
--genre_name|
------------+
--Pop       |
--Jazz      |
--Electronic|
--Industrial|
--Classical |
--Blues     |
