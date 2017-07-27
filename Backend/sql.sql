-- Table: public.user_roll

-- DROP TABLE public.user_roll;

CREATE TABLE public.user_roll
(
  id bigint NOT NULL DEFAULT nextval('user_roll_id_seq'::regclass),
  role_name character varying(100),
  useraccount_list integer[],
  funcprivil_list integer[],
  del_flag integer DEFAULT 0,
  created_time timestamp without time zone,
  updated_time timestamp without time zone,
  CONSTRAINT user_roll_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE public.user_roll
  OWNER TO postgres;

-- Trigger: insert_user_roll_modifytime on public.user_roll

-- DROP TRIGGER insert_user_roll_modifytime ON public.user_roll;

CREATE TRIGGER insert_user_roll_modifytime
  BEFORE INSERT
  ON public.user_roll
  FOR EACH ROW
  EXECUTE PROCEDURE public.insert_modified_column();

-- Trigger: update_user_roll_modifytime on public.user_roll

-- DROP TRIGGER update_user_roll_modifytime ON public.user_roll;

CREATE TRIGGER update_user_roll_modifytime
  BEFORE UPDATE
  ON public.user_roll
  FOR EACH ROW
  EXECUTE PROCEDURE public.update_modified_column();

-- Table: public.other_history

-- DROP TABLE public.other_history;

CREATE TABLE public.other_history
(
  id bigint NOT NULL DEFAULT nextval('"TheOtherHistory_id_seq"'::regclass),
  functcategory_list integer[],
  del_flag integer DEFAULT 0,
  created_time timestamp without time zone,
  updated_time timestamp without time zone,
  CONSTRAINT other_history_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE public.other_history
  OWNER TO postgres;

-- Trigger: insert_other_history_modifytime on public.other_history

-- DROP TRIGGER insert_other_history_modifytime ON public.other_history;

CREATE TRIGGER insert_other_history_modifytime
  BEFORE INSERT
  ON public.other_history
  FOR EACH ROW
  EXECUTE PROCEDURE public.insert_modified_column();

-- Trigger: update_other_history_modifytime on public.other_history

-- DROP TRIGGER update_other_history_modifytime ON public.other_history;

CREATE TRIGGER update_other_history_modifytime
  BEFORE UPDATE
  ON public.other_history
  FOR EACH ROW
  EXECUTE PROCEDURE public.update_modified_column();

-- Table: public.login_history

-- DROP TABLE public.login_history;

CREATE TABLE public.login_history
(
  login_datetime timestamp without time zone,
  logout_datetime timestamp without time zone,
  timeout_datetime timestamp without time zone,
  login_sessionnumber integer,
  login_terminalno integer,
  del_flag integer DEFAULT 0,
  created_time timestamp without time zone,
  updated_time timestamp without time zone,
  id bigint NOT NULL DEFAULT nextval('login_history_id_seq'::regclass),
  CONSTRAINT login_history_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE public.login_history
  OWNER TO postgres;

-- Trigger: insert_login_history_modifytime on public.login_history

-- DROP TRIGGER insert_login_history_modifytime ON public.login_history;

CREATE TRIGGER insert_login_history_modifytime
  BEFORE INSERT
  ON public.login_history
  FOR EACH ROW
  EXECUTE PROCEDURE public.insert_modified_column();

-- Trigger: update_login_history_modifytime on public.login_history

-- DROP TRIGGER update_login_history_modifytime ON public.login_history;

CREATE TRIGGER update_login_history_modifytime
  BEFORE UPDATE
  ON public.login_history
  FOR EACH ROW
  EXECUTE PROCEDURE public.update_modified_column();

-- Table: public.function_privilege

-- DROP TABLE public.function_privilege;

CREATE TABLE public.function_privilege
(
  id bigint NOT NULL DEFAULT nextval('function_privilege_id_seq'::regclass),
  privilege_name character varying(100),
  userroll_list integer[],
  functcategory_id integer,
  del_flag integer DEFAULT 0,
  created_time timestamp without time zone,
  updated_time timestamp without time zone,
  CONSTRAINT function_privilege_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE public.function_privilege
  OWNER TO postgres;

-- Trigger: insert_function_privilege_modifytime on public.function_privilege

-- DROP TRIGGER insert_function_privilege_modifytime ON public.function_privilege;

CREATE TRIGGER insert_function_privilege_modifytime
  BEFORE INSERT
  ON public.function_privilege
  FOR EACH ROW
  EXECUTE PROCEDURE public.insert_modified_column();

-- Trigger: update_function_privilege_modifytime on public.function_privilege

-- DROP TRIGGER update_function_privilege_modifytime ON public.function_privilege;

CREATE TRIGGER update_function_privilege_modifytime
  BEFORE UPDATE
  ON public.function_privilege
  FOR EACH ROW
  EXECUTE PROCEDURE public.update_modified_column();

-- Table: public.function_category

-- DROP TABLE public.function_category;

CREATE TABLE public.function_category
(
  id bigint NOT NULL DEFAULT nextval('function_category_id_seq'::regclass),
  category_name character varying(100),
  otherhistory_list integer[],
  del_flag integer DEFAULT 0,
  created_time timestamp without time zone,
  updated_time timestamp without time zone,
  CONSTRAINT function_category_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE public.function_category
  OWNER TO postgres;

-- Trigger: insert_function_category_modifytime on public.function_category

-- DROP TRIGGER insert_function_category_modifytime ON public.function_category;

CREATE TRIGGER insert_function_category_modifytime
  BEFORE INSERT
  ON public.function_category
  FOR EACH ROW
  EXECUTE PROCEDURE public.insert_modified_column();

-- Trigger: update_function_category_modifytime on public.function_category

-- DROP TRIGGER update_function_category_modifytime ON public.function_category;

CREATE TRIGGER update_function_category_modifytime
  BEFORE UPDATE
  ON public.function_category
  FOR EACH ROW
  EXECUTE PROCEDURE public.update_modified_column();

