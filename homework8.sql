Установил и настроил postgres. Сделал пользователя и дал права на использования БД geodata.
В БД goedata создал три таблицы, с ключами и индексами. 
Загрузить БД не удалось, я так понимаю нужны специальный скрипт устанавливать чтобы можно было использовать БД mqsql.

CREATE SCHEMA geodata
    AUTHORIZATION postgres;

GRANT USAGE ON SCHEMA geodata TO alex WITH GRANT OPTION;

GRANT ALL ON SCHEMA geodata TO postgres;

CREATE TABLE geodata.country
(
    id_country smallint NOT NULL,
    name_country character varying COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT country_pkey PRIMARY KEY (id_country)
)

TABLESPACE pg_default;

ALTER TABLE geodata.country
    OWNER to postgres;
-- Index: name_country_index

CREATE INDEX name_country_index
    ON geodata.country USING btree
    (name_country COLLATE pg_catalog."default" ASC NULLS LAST)
    INCLUDE(name_country)
    TABLESPACE pg_default;



CREATE TABLE geodata.region
(
    id_region bigint NOT NULL,
    id_country smallint NOT NULL,
    name_region character varying COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT region_pkey PRIMARY KEY (id_region),
    CONSTRAINT id_region_uniq UNIQUE (id_region),
    CONSTRAINT id_country_region FOREIGN KEY (id_region)
        REFERENCES geodata.country (id_country) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE geodata.region
    OWNER to postgres;

COMMENT ON CONSTRAINT id_country_region ON geodata.region
    IS 'внешний ключ на таблицу страна';

-- Index: id_region

CREATE UNIQUE INDEX id_region
    ON geodata.region USING btree
    (id_region ASC NULLS LAST)
    INCLUDE(id_region)
    TABLESPACE pg_default;

-- Index: name_index

CREATE INDEX name_index
    ON geodata.region USING btree
    (name_region COLLATE pg_catalog."default" ASC NULLS LAST)
    INCLUDE(name_region)
    TABLESPACE pg_default;


CREATE TABLE geodata.city
(
    id_city bigint NOT NULL,
    id_country smallint NOT NULL,
    id_region bigint,
    name_city character varying COLLATE pg_catalog."default" NOT NULL,
    important smallint,
    CONSTRAINT city_pkey PRIMARY KEY (id_city),
    CONSTRAINT fk_id_country_city FOREIGN KEY (id_country)
        REFERENCES geodata.country (id_country) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT fk_id_region_city FOREIGN KEY (id_region)
        REFERENCES geodata.region (id_region) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE geodata.city
    OWNER to postgres;

COMMENT ON CONSTRAINT fk_id_country_city ON geodata.city
    IS 'внешний ключ от города к таблице страна';
COMMENT ON CONSTRAINT fk_id_region_city ON geodata.city
    IS 'внешний ключ города на регион';
-- Index: city_name

CREATE INDEX city_name
    ON geodata.city USING btree
    (name_city COLLATE pg_catalog."default" ASC NULLS LAST)
    INCLUDE(name_city)
    TABLESPACE pg_default;
-- Index: fki_fk_id_country_city

CREATE INDEX fki_fk_id_country_city
    ON geodata.city USING btree
    (id_country ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: fki_fk_id_region_city

CREATE INDEX fki_fk_id_region_city
    ON geodata.city USING btree
    (id_region ASC NULLS LAST)
    TABLESPACE pg_default;
    
    
    Запросы к БД
    
insert into geodata.country (id_country, name_country)
values (1, 'Россия'), (2, 'Украина'), (3, 'Белоруссия')

insert into geodata.region (id_region, id_country, name_region)
values (1, 1, 'Московская область'), (2, 1, 'Республика Татарстан'), (3, 1, 'Волгоградская область')

insert into geodata.city (id_city, id_country, id_region, name_city, important)
values (3, 1, 2, 'Казань', 1), (4, 1, 3, 'Волгоград', 1)

select * from geodata.region

select * from geodata.city
where id_region = 2

select town.name_city, town.id_country 
from geodata.city as town
join geodata.country as co
on co.id_country = town.id_country 
    
    
