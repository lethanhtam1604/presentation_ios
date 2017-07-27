-- Database: presentation

-- DROP DATABASE presentation;

CREATE DATABASE presentation
  WITH OWNER = postgres
       ENCODING = 'UTF8'
       TABLESPACE = pg_default
       LC_COLLATE = 'C'
       LC_CTYPE = 'C'
       CONNECTION LIMIT = -1;

       -- Table: public.image

-- DROP TABLE public.image;

CREATE TABLE public.image
(
  id bigint NOT NULL DEFAULT nextval('images_id_seq'::regclass),
  code text,
  is_sent integer DEFAULT 0,
  width bigint,
  height bigint,
  pos_x bigint,
  pos_y bigint,
  CONSTRAINT images_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE public.image
  OWNER TO postgres;
-- Table: public.text

-- DROP TABLE public.text;

CREATE TABLE public.text
(
  id bigint NOT NULL DEFAULT nextval('text_id_seq'::regclass),
  text text,
  is_sent integer DEFAULT 0,
  del_flag boolean NOT NULL DEFAULT false,
  width bigint,
  height bigint,
  pos_x bigint,
  pos_y bigint,
  CONSTRAINT text_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE public.text
  OWNER TO postgres;


