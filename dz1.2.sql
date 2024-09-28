CREATE TABLE IF NOT EXISTS student19.dz12_genres();
CREATE TABLE IF NOT EXISTS student19.dz12_authors();
CREATE TABLE IF NOT EXISTS student19.dz12_books();
CREATE TABLE IF NOT EXISTS student19.dz12_users();
CREATE TABLE IF NOT EXISTS student19.dz12_purchases();


ALTER TABLE IF EXISTS student19.dz12_genres
    ADD COLUMN IF NOT EXISTS genre_id                         BIGSERIAL PRIMARY KEY,
    ADD COLUMN IF NOT EXISTS genre_name                       VARCHAR UNIQUE
;

ALTER TABLE IF EXISTS student19.dz12_authors
    ADD COLUMN IF NOT EXISTS author_id                        BIGSERIAL PRIMARY KEY,
    ADD COLUMN IF NOT EXISTS first_name                       VARCHAR,
    ADD COLUMN IF NOT EXISTS last_name                        VARCHAR,
    ADD COLUMN IF NOT EXISTS bio                              TEXT
;

ALTER TABLE IF EXISTS student19.dz12_books
    ADD COLUMN IF NOT EXISTS book_id                         BIGSERIAL PRIMARY KEY,
    ADD COLUMN IF NOT EXISTS title                           VARCHAR NOT NULL,
    ADD COLUMN IF NOT EXISTS author_id                        SMALLINT,
    ADD COLUMN IF NOT EXISTS genre_id                         SMALLINT,
    ADD COLUMN IF NOT EXISTS publication_year                 SMALLINT,
    ADD COLUMN IF NOT EXISTS price                            DECIMAL(10, 2) NOT NULL,
    ADD COLUMN IF NOT EXISTS ISBN                             VARCHAR(20) UNIQUE
;
DO '
BEGIN
    IF NOT EXISTS (
            SELECT 1
            FROM information_schema.table_constraints
            WHERE lower(table_name) = ''dz12_books''
              and lower(table_schema) = ''student19''
              and lower(constraint_type) = ''foreign key''
        )
    THEN
        ALTER TABLE student19.dz12_books ADD foreign key (author_id) REFERENCES student19.dz12_authors(author_id);
        ALTER TABLE student19.dz12_books ADD foreign key (genre_id) REFERENCES student19.dz12_genres(genre_id);
    END IF;
END ';


ALTER TABLE IF EXISTS student19.dz12_users
    ADD COLUMN IF NOT EXISTS user_id                    BIGSERIAL PRIMARY KEY,
    ADD COLUMN IF NOT EXISTS username                   VARCHAR,
    ADD COLUMN IF NOT EXISTS first_name                 VARCHAR,
    ADD COLUMN IF NOT EXISTS last_name                  VARCHAR,
    ADD COLUMN IF NOT EXISTS email                      VARCHAR UNIQUE NOT NULL,
    ADD COLUMN IF NOT EXISTS passwordhash               VARCHAR NOT NULL
;

ALTER TABLE IF EXISTS student19.dz12_purchases
    ADD COLUMN IF NOT EXISTS purchase_id                      BIGSERIAL PRIMARY KEY,
    ADD COLUMN IF NOT EXISTS user_id                          INT NOT NULL,
    ADD COLUMN IF NOT EXISTS book_id                          INT NOT NULL,
    ADD COLUMN IF NOT EXISTS purchase_price                   DECIMAL(10, 2) NOT NULL,
    ADD COLUMN IF NOT EXISTS purchase_date                    TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
;
DO '
BEGIN
    IF NOT EXISTS (
            SELECT 1
            FROM information_schema.table_constraints
            WHERE lower(table_name) = ''dz12_purchases''
              and lower(table_schema) = ''student19''
              and lower(constraint_type) = ''foreign key''
        )
    THEN
        ALTER TABLE student19.dz12_purchases ADD foreign key (user_id) REFERENCES student19.dz12_users(user_id);
        ALTER TABLE student19.dz12_purchases ADD foreign key (book_id) REFERENCES student19.dz12_books(book_id);
    END IF;
END ';