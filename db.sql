-- DROP DATABASE IF EXISTS "examenPython";
CREATE DATABASE "examenPython"            
            TABLESPACE = pg_default
            OWNER = postgres;
-- ddl-end --

-- object: public.seg_usuarios | type: TABLE --
-- DROP TABLE IF EXISTS public.seg_usuarios CASCADE;
CREATE TABLE public.seg_usuarios (
            login text NOT NULL,
            pswd text NOT NULL,
            nombre text,
            email text,
            usr_activo text,
            CONSTRAINT seg_usuarios_pkey PRIMARY KEY (login)
);
-- ddl-end --
ALTER TABLE public.seg_usuarios OWNER TO postgres;
-- ddl-end --
-- object: public.seg_grupos_grupo_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.seg_grupos_grupo_id_seq CASCADE;
CREATE SEQUENCE public.seg_grupos_grupo_id_seq
            INCREMENT BY 1
            MINVALUE 1
            MAXVALUE 2147483647
            START WITH 1
            CACHE 1
            NO CYCLE
            OWNED BY NONE;
-- ddl-end --
ALTER SEQUENCE public.seg_grupos_grupo_id_seq OWNER TO postgres;
-- ddl-end --
-- object: public.seg_grupos | type: TABLE --
-- DROP TABLE IF EXISTS public.seg_grupos CASCADE;
CREATE TABLE public.seg_grupos (
            grupo_id integer NOT NULL DEFAULT nextval('public.seg_grupos_grupo_id_seq'::regclass),
            descripcion text,
            CONSTRAINT seg_grupos_pkey PRIMARY KEY (grupo_id)
);
-- ddl-end --
ALTER TABLE public.seg_grupos OWNER TO postgres;
-- ddl-end --
-- object: descripcion | type: INDEX --
-- DROP INDEX IF EXISTS public.descripcion CASCADE;
CREATE UNIQUE INDEX descripcion ON public.seg_grupos
            USING btree
            (
              descripcion
            )
            WITH (FILLFACTOR = 90);
-- ddl-end --
-- object: public.seg_usuarios_grupos | type: TABLE --
-- DROP TABLE IF EXISTS public.seg_usuarios_grupos CASCADE;
CREATE TABLE public.seg_usuarios_grupos (
            login text NOT NULL,
            grupo_id integer NOT NULL,
            CONSTRAINT seg_users_groups_pkey PRIMARY KEY (login,grupo_id)
);
-- ddl-end --
ALTER TABLE public.seg_usuarios_grupos OWNER TO postgres;
-- ddl-end --
-- object: seg_usuarios_grupos_pkey | type: INDEX --
-- DROP INDEX IF EXISTS public.seg_usuarios_grupos_pkey CASCADE;
CREATE UNIQUE INDEX seg_usuarios_grupos_pkey ON public.seg_usuarios_grupos
            USING btree
            (
              login,
              grupo_id
            )
            WITH (FILLFACTOR = 90);
-- ddl-end --
-- object: public.seg_apps | type: TABLE --
-- DROP TABLE IF EXISTS public.seg_apps CASCADE;
CREATE TABLE public.seg_apps (
            app_nombre text NOT NULL,
            app_tipo text,
            descripcion text,
            CONSTRAINT seg_apps_pkey PRIMARY KEY (app_nombre)
);
-- ddl-end --
ALTER TABLE public.seg_apps OWNER TO postgres;
-- ddl-end --
-- object: public.seg_grupos_apps | type: TABLE --
-- DROP TABLE IF EXISTS public.seg_grupos_apps CASCADE;
CREATE TABLE public.seg_grupos_apps (
            grupo_id integer NOT NULL,
            app_nombre text NOT NULL,
            priv_access text,
            priv_insert text,
            priv_delete text,
            priv_update text,
            priv_export text,
            priv_print text,
            CONSTRAINT seg_grupos_apps_pkey PRIMARY KEY (grupo_id,app_nombre)
);
-- ddl-end --
ALTER TABLE public.seg_grupos_apps OWNER TO postgres;
-- ddl-end --
-- object: usuarios_grupos_fk | type: CONSTRAINT --
-- ALTER TABLE public.seg_usuarios_grupos DROP CONSTRAINT IF EXISTS usuarios_grupos_fk CASCADE;
ALTER TABLE public.seg_usuarios_grupos ADD CONSTRAINT usuarios_grupos_fk FOREIGN KEY (login)
REFERENCES public.seg_usuarios (login) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --
-- object: grupos_usuarios_fk | type: CONSTRAINT --
-- ALTER TABLE public.seg_usuarios_grupos DROP CONSTRAINT IF EXISTS grupos_usuarios_fk CASCADE;
ALTER TABLE public.seg_usuarios_grupos ADD CONSTRAINT grupos_usuarios_fk FOREIGN KEY (grupo_id)
REFERENCES public.seg_grupos (grupo_id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --
-- object: grupos_apps_fk | type: CONSTRAINT --
-- ALTER TABLE public.seg_grupos_apps DROP CONSTRAINT IF EXISTS grupos_apps_fk CASCADE;
ALTER TABLE public.seg_grupos_apps ADD CONSTRAINT grupos_apps_fk FOREIGN KEY (grupo_id)
REFERENCES public.seg_grupos (grupo_id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --
-- object: apps_grupos_fk | type: CONSTRAINT --
-- ALTER TABLE public.seg_grupos_apps DROP CONSTRAINT IF EXISTS apps_grupos_fk CASCADE;
ALTER TABLE public.seg_grupos_apps ADD CONSTRAINT apps_grupos_fk FOREIGN KEY (app_nombre)
REFERENCES public.seg_apps (app_nombre) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --
-- object: "grant_CU_eb94f049ac" | type: PERMISSION --
GRANT CREATE,USAGE
   ON SCHEMA public
   TO postgres;
-- ddl-end --
-- object: "grant_CU_cd8e46e7b6" | type: PERMISSION --
GRANT CREATE,USAGE
   ON SCHEMA public
   TO PUBLIC;
-- ddl-end --