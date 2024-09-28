CREATE TABLE IF NOT EXISTS student19.dz1_tracks();
CREATE TABLE IF NOT EXISTS student19.dz1_artists();
CREATE TABLE IF NOT EXISTS student19.dz1_albums();
CREATE TABLE IF NOT EXISTS student19.dz1_genres();

ALTER TABLE IF EXISTS student19.dz1_genres
    ADD COLUMN IF NOT EXISTS genre_id                         BIGSERIAL,
    ADD COLUMN IF NOT EXISTS genre_name                       VARCHAR UNIQUE
;

ALTER TABLE IF EXISTS student19.dz1_artists
    ADD COLUMN IF NOT EXISTS artist_id                         BIGSERIAL,
    ADD COLUMN IF NOT EXISTS artist_name                       VARCHAR UNIQUE
;

ALTER TABLE IF EXISTS student19.dz1_albums
    ADD COLUMN IF NOT EXISTS album_id                         BIGSERIAL,
    ADD COLUMN IF NOT EXISTS album_name                       VARCHAR,
    ADD COLUMN IF NOT EXISTS artist_id                        SMALLINT,
    ADD COLUMN IF NOT EXISTS release_year                     SMALLINT,
    ADD COLUMN IF NOT EXISTS genre_id                         SMALLINT
;

ALTER TABLE IF EXISTS student19.dz1_tracks
    ADD COLUMN IF NOT EXISTS track_id                   BIGSERIAL,
    ADD COLUMN IF NOT EXISTS name                       VARCHAR,
    ADD COLUMN IF NOT EXISTS artist_id                  SMALLINT,
    ADD COLUMN IF NOT EXISTS year                       SMALLINT,
    ADD COLUMN IF NOT EXISTS duration                   VARCHAR,
    ADD COLUMN IF NOT EXISTS plays                      INT,
    ADD COLUMN IF NOT EXISTS genre_id                   SMALLINT,
    ADD COLUMN IF NOT EXISTS album_id                   SMALLINT
;

COMMENT ON TABLE  student19.dz1_tracks                                IS 'Таблица с музыкальными треками';
COMMENT ON COLUMN student19.dz1_tracks.track_id                       IS 'Идентификатор трека';
COMMENT ON COLUMN student19.dz1_tracks.name                           IS 'Имя трека';
COMMENT ON COLUMN student19.dz1_tracks.artist_id                      IS 'Идентификатор исполнителя';
COMMENT ON COLUMN student19.dz1_tracks.year                           IS 'Год';
COMMENT ON COLUMN student19.dz1_tracks.duration                       IS 'Длительность';
COMMENT ON COLUMN student19.dz1_tracks.plays                          IS 'Количество прослушиваний';
COMMENT ON COLUMN student19.dz1_tracks.genre_id                       IS 'Идентификатор жанра';

DO '
BEGIN
    IF NOT EXISTS (
            SELECT 1
            FROM information_schema.table_constraints
            WHERE lower(table_name) = ''dz1_genres''
              and lower(table_schema) = ''student19''
              and lower(constraint_type) = ''primary key''
        )
    THEN
        ALTER TABLE student19.dz1_genres ADD primary key (genre_id);
    END IF;
END ';
--------------
DO '
BEGIN
    IF NOT EXISTS (
            SELECT 1
            FROM information_schema.table_constraints
            WHERE lower(table_name) = ''dz1_artists''
              and lower(table_schema) = ''student19''
              and lower(constraint_type) = ''primary key''
        )
    THEN
        ALTER TABLE student19.dz1_artists ADD primary key (artist_id);
    END IF;
END ';
--------------
DO '
BEGIN
    IF NOT EXISTS (
            SELECT 1
            FROM information_schema.table_constraints
            WHERE lower(table_name) = ''dz1_albums''
              and lower(table_schema) = ''student19''
              and lower(constraint_type) = ''primary key''
        )
    THEN
        ALTER TABLE student19.dz1_albums ADD primary key (album_id);
    END IF;
END ';

DO '
BEGIN
    IF NOT EXISTS (
            SELECT 1
            FROM information_schema.table_constraints
            WHERE lower(table_name) = ''dz1_albums''
              and lower(table_schema) = ''student19''
              and lower(constraint_type) = ''foreign key''
        )
    THEN
        ALTER TABLE student19.dz1_albums ADD foreign key (artist_id) REFERENCES student19.dz1_artists(artist_id);
        ALTER TABLE student19.dz1_albums ADD foreign key (genre_id) REFERENCES student19.dz1_genres(genre_id);
    END IF;
END ';
--------------
DO '
BEGIN
    IF NOT EXISTS (
            SELECT 1
            FROM information_schema.table_constraints
            WHERE lower(table_name) = ''dz1_tracks''
              and lower(table_schema) = ''student19''
              and lower(constraint_type) = ''primary key''
        )
    THEN
        ALTER TABLE student19.dz1_tracks ADD primary key (track_id);
    END IF;
END ';

DO '
BEGIN
    IF NOT EXISTS (
            SELECT 1
            FROM information_schema.table_constraints
            WHERE lower(table_name) = ''dz1_tracks''
              and lower(table_schema) = ''student19''
              and lower(constraint_type) = ''foreign key''
        )
    THEN
        ALTER TABLE student19.dz1_tracks ADD foreign key (artist_id) REFERENCES student19.dz1_artists(artist_id);
        ALTER TABLE student19.dz1_tracks ADD foreign key (genre_id) REFERENCES student19.dz1_genres(genre_id);
        ALTER TABLE student19.dz1_tracks ADD foreign key (album_id) REFERENCES student19.dz1_albums(album_id);
    END IF;
END ';
