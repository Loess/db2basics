--Задание 2
--Напишите запросы для наполнения БД (3 трека (можно больше), 2-3 исполнителя/группы, 1 альбом. Выполните запросы на учебной схеме БД.
--Добавьте в отчет результат выполнения запросов – скрины заполненных таблиц.

INSERT INTO student19.dz1_genres (genre_name) VALUES ('Rock'),('Pop'),('Jazz'),('Ambient');
INSERT INTO student19.dz1_artists (artist_name) VALUES ('Limp Bizkit'),('Aphex Twin'),('Красная Плесень');
INSERT INTO student19.dz1_albums (album_name,artist_id,release_year,genre_id)  VALUES
('Significant Other',(SELECT artist_id FROM student19.dz1_artists WHERE artist_name='Limp Bizkit'),'1999',(SELECT genre_id FROM student19.dz1_genres WHERE genre_name='Rock'));

INSERT INTO student19.dz1_tracks (name,artist_id,year,duration,plays,genre_id,album_id) VALUES
('Just Like This',(SELECT artist_id FROM student19.dz1_artists WHERE artist_name='Limp Bizkit'),'1999','3:35','1000',
	(SELECT genre_id FROM student19.dz1_genres WHERE genre_name='Rock'),(SELECT album_id FROM student19.dz1_albums WHERE album_name='Significant Other')),
('Nookie',(SELECT artist_id FROM student19.dz1_artists WHERE artist_name='Limp Bizkit'),'1999','4:49','0',
	(SELECT genre_id FROM student19.dz1_genres WHERE genre_name='Rock'),(SELECT album_id FROM student19.dz1_albums WHERE album_name='Significant Other')),
('Сказка о царе Салтане',(SELECT artist_id FROM student19.dz1_artists WHERE artist_name='Красная Плесень'),'1999','32:52','20',NULL,NULL),
('On',(SELECT artist_id FROM student19.dz1_artists WHERE artist_name='Aphex Twin'),'1993','3:48','20000',
	(SELECT genre_id FROM student19.dz1_genres WHERE genre_name='Ambient'),NULL)
;
