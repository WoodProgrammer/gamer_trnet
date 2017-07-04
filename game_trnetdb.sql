--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.7
-- Dumped by pg_dump version 9.5.7

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- Name: logfunction(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION logfunction() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
IF (TG_OP = 'DELETE') THEN
insert into log (username,date,name,operation,price,genre_id,logo,game_id,company_id) values (user,now(),OLD.name,'D',OLD.price,OLD.genre_id,OLD.logo,OLD.id,OLD.company_id);
return OLD;
ELSIF(TG_OP = 'UPDATE') THEN
insert into log (username,date,name,operation,price,genre_id,logo,game_id,company_id) values (user,now(),OLD.name,'U',OLD.price,OLD.genre_id,OLD.logo,NEW.id,OLD.company_id);
return OLD;
ELSIF (TG_OP = 'INSERT') THEN
insert into log (username,date,name,operation,price,genre_id,logo,game_id,company_id) values(user,now(),NEW.name,'I',NEW.price,NEW.genre_id,NEW.logo,NEW.id,NEW.company_id);
return NEW;
end if;
return null;
end;$$;


ALTER FUNCTION public.logfunction() OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: emir
--

CREATE TABLE auth_group (
    id integer NOT NULL,
    name character varying(80) NOT NULL
);


ALTER TABLE auth_group OWNER TO emir;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: emir
--

CREATE SEQUENCE auth_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_group_id_seq OWNER TO emir;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: emir
--

ALTER SEQUENCE auth_group_id_seq OWNED BY auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: emir
--

CREATE TABLE auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE auth_group_permissions OWNER TO emir;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: emir
--

CREATE SEQUENCE auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_group_permissions_id_seq OWNER TO emir;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: emir
--

ALTER SEQUENCE auth_group_permissions_id_seq OWNED BY auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: emir
--

CREATE TABLE auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE auth_permission OWNER TO emir;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: emir
--

CREATE SEQUENCE auth_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_permission_id_seq OWNER TO emir;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: emir
--

ALTER SEQUENCE auth_permission_id_seq OWNED BY auth_permission.id;


--
-- Name: auth_user; Type: TABLE; Schema: public; Owner: emir
--

CREATE TABLE auth_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(30) NOT NULL,
    last_name character varying(30) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL
);


ALTER TABLE auth_user OWNER TO emir;

--
-- Name: auth_user_groups; Type: TABLE; Schema: public; Owner: emir
--

CREATE TABLE auth_user_groups (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE auth_user_groups OWNER TO emir;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: emir
--

CREATE SEQUENCE auth_user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_user_groups_id_seq OWNER TO emir;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: emir
--

ALTER SEQUENCE auth_user_groups_id_seq OWNED BY auth_user_groups.id;


--
-- Name: auth_user_id_seq; Type: SEQUENCE; Schema: public; Owner: emir
--

CREATE SEQUENCE auth_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_user_id_seq OWNER TO emir;

--
-- Name: auth_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: emir
--

ALTER SEQUENCE auth_user_id_seq OWNED BY auth_user.id;


--
-- Name: auth_user_user_permissions; Type: TABLE; Schema: public; Owner: emir
--

CREATE TABLE auth_user_user_permissions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE auth_user_user_permissions OWNER TO emir;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: emir
--

CREATE SEQUENCE auth_user_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_user_user_permissions_id_seq OWNER TO emir;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: emir
--

ALTER SEQUENCE auth_user_user_permissions_id_seq OWNED BY auth_user_user_permissions.id;


--
-- Name: company; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE company (
    id integer NOT NULL,
    name character varying(100)
);


ALTER TABLE company OWNER TO postgres;

--
-- Name: company_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE company_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE company_id_seq OWNER TO postgres;

--
-- Name: company_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE company_id_seq OWNED BY company.id;


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: emir
--

CREATE TABLE django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE django_admin_log OWNER TO emir;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: emir
--

CREATE SEQUENCE django_admin_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE django_admin_log_id_seq OWNER TO emir;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: emir
--

ALTER SEQUENCE django_admin_log_id_seq OWNED BY django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: emir
--

CREATE TABLE django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE django_content_type OWNER TO emir;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: emir
--

CREATE SEQUENCE django_content_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE django_content_type_id_seq OWNER TO emir;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: emir
--

ALTER SEQUENCE django_content_type_id_seq OWNED BY django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: emir
--

CREATE TABLE django_migrations (
    id integer NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE django_migrations OWNER TO emir;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: emir
--

CREATE SEQUENCE django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE django_migrations_id_seq OWNER TO emir;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: emir
--

ALTER SEQUENCE django_migrations_id_seq OWNED BY django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: emir
--

CREATE TABLE django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE django_session OWNER TO emir;

--
-- Name: epinmain_game; Type: TABLE; Schema: public; Owner: emir
--

CREATE TABLE epinmain_game (
    id integer NOT NULL,
    name character varying(225) NOT NULL,
    game_pin_price double precision NOT NULL,
    created_at date NOT NULL,
    popularity integer NOT NULL,
    game_logo character varying(250) NOT NULL,
    genre_id integer NOT NULL
);


ALTER TABLE epinmain_game OWNER TO emir;

--
-- Name: epinmain_game_id_seq; Type: SEQUENCE; Schema: public; Owner: emir
--

CREATE SEQUENCE epinmain_game_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE epinmain_game_id_seq OWNER TO emir;

--
-- Name: epinmain_game_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: emir
--

ALTER SEQUENCE epinmain_game_id_seq OWNED BY epinmain_game.id;


--
-- Name: epinmain_genre; Type: TABLE; Schema: public; Owner: emir
--

CREATE TABLE epinmain_genre (
    id integer NOT NULL,
    name character varying(225) NOT NULL
);


ALTER TABLE epinmain_genre OWNER TO emir;

--
-- Name: epinmain_genre_id_seq; Type: SEQUENCE; Schema: public; Owner: emir
--

CREATE SEQUENCE epinmain_genre_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE epinmain_genre_id_seq OWNER TO emir;

--
-- Name: epinmain_genre_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: emir
--

ALTER SEQUENCE epinmain_genre_id_seq OWNED BY epinmain_genre.id;


--
-- Name: epinmain_log; Type: TABLE; Schema: public; Owner: emir
--

CREATE TABLE epinmain_log (
    id integer NOT NULL,
    log_raise character varying(225) NOT NULL,
    created_at timestamp with time zone NOT NULL,
    ip_addr character varying(225) NOT NULL
);


ALTER TABLE epinmain_log OWNER TO emir;

--
-- Name: epinmain_log_id_seq; Type: SEQUENCE; Schema: public; Owner: emir
--

CREATE SEQUENCE epinmain_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE epinmain_log_id_seq OWNER TO emir;

--
-- Name: epinmain_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: emir
--

ALTER SEQUENCE epinmain_log_id_seq OWNED BY epinmain_log.id;


--
-- Name: epinmain_profile; Type: TABLE; Schema: public; Owner: emir
--

CREATE TABLE epinmain_profile (
    id integer NOT NULL,
    birth_date date,
    status boolean NOT NULL,
    user_id integer NOT NULL,
    balance double precision NOT NULL
);


ALTER TABLE epinmain_profile OWNER TO emir;

--
-- Name: epinmain_profile_id_seq; Type: SEQUENCE; Schema: public; Owner: emir
--

CREATE SEQUENCE epinmain_profile_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE epinmain_profile_id_seq OWNER TO emir;

--
-- Name: epinmain_profile_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: emir
--

ALTER SEQUENCE epinmain_profile_id_seq OWNED BY epinmain_profile.id;


--
-- Name: epinmain_sale; Type: TABLE; Schema: public; Owner: emir
--

CREATE TABLE epinmain_sale (
    id integer NOT NULL,
    amount double precision NOT NULL,
    created_at timestamp with time zone NOT NULL,
    game_id_id integer NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE epinmain_sale OWNER TO emir;

--
-- Name: epinmain_sale_id_seq; Type: SEQUENCE; Schema: public; Owner: emir
--

CREATE SEQUENCE epinmain_sale_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE epinmain_sale_id_seq OWNER TO emir;

--
-- Name: epinmain_sale_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: emir
--

ALTER SEQUENCE epinmain_sale_id_seq OWNED BY epinmain_sale.id;


--
-- Name: game; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE game (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    price real NOT NULL,
    popularity integer NOT NULL,
    created_date timestamp without time zone DEFAULT now() NOT NULL,
    update_date timestamp without time zone DEFAULT now() NOT NULL,
    logo character varying(200),
    genre_id integer NOT NULL,
    company_id integer NOT NULL,
    CONSTRAINT game_price_check CHECK ((price > (0)::double precision))
);


ALTER TABLE game OWNER TO postgres;

--
-- Name: game_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE game_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE game_id_seq OWNER TO postgres;

--
-- Name: game_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE game_id_seq OWNED BY game.id;


--
-- Name: genre; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE genre (
    id integer NOT NULL,
    name character varying(40) NOT NULL
);


ALTER TABLE genre OWNER TO postgres;

--
-- Name: genre_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE genre_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE genre_id_seq OWNER TO postgres;

--
-- Name: genre_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE genre_id_seq OWNED BY genre.id;


--
-- Name: log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE log (
    id integer NOT NULL,
    username character varying(40) DEFAULT 'Guest'::character varying,
    date timestamp without time zone NOT NULL,
    name character varying(40) NOT NULL,
    operation character varying(1) NOT NULL,
    price real NOT NULL,
    genre_id integer NOT NULL,
    logo text,
    game_id integer NOT NULL,
    company_id integer NOT NULL
);


ALTER TABLE log OWNER TO postgres;

--
-- Name: log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE log_id_seq OWNER TO postgres;

--
-- Name: log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE log_id_seq OWNED BY log.id;


--
-- Name: sale; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE sale (
    id integer NOT NULL,
    user_id integer NOT NULL,
    game_id integer NOT NULL,
    c_date timestamp without time zone DEFAULT now(),
    amount real NOT NULL,
    CONSTRAINT sale_amount_check CHECK ((amount > (0)::double precision))
);


ALTER TABLE sale OWNER TO postgres;

--
-- Name: sale_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE sale_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sale_id_seq OWNER TO postgres;

--
-- Name: sale_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE sale_id_seq OWNED BY sale.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE users (
    id integer NOT NULL,
    username character varying(15) NOT NULL,
    password text NOT NULL,
    email text NOT NULL,
    c_date timestamp without time zone DEFAULT now(),
    full_name character varying(40),
    status boolean DEFAULT true NOT NULL,
    balance real DEFAULT 0 NOT NULL,
    lastlogin timestamp without time zone DEFAULT now() NOT NULL,
    admin boolean DEFAULT false NOT NULL
);


ALTER TABLE users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: emir
--

ALTER TABLE ONLY auth_group ALTER COLUMN id SET DEFAULT nextval('auth_group_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: emir
--

ALTER TABLE ONLY auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('auth_group_permissions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: emir
--

ALTER TABLE ONLY auth_permission ALTER COLUMN id SET DEFAULT nextval('auth_permission_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: emir
--

ALTER TABLE ONLY auth_user ALTER COLUMN id SET DEFAULT nextval('auth_user_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: emir
--

ALTER TABLE ONLY auth_user_groups ALTER COLUMN id SET DEFAULT nextval('auth_user_groups_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: emir
--

ALTER TABLE ONLY auth_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('auth_user_user_permissions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY company ALTER COLUMN id SET DEFAULT nextval('company_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: emir
--

ALTER TABLE ONLY django_admin_log ALTER COLUMN id SET DEFAULT nextval('django_admin_log_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: emir
--

ALTER TABLE ONLY django_content_type ALTER COLUMN id SET DEFAULT nextval('django_content_type_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: emir
--

ALTER TABLE ONLY django_migrations ALTER COLUMN id SET DEFAULT nextval('django_migrations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: emir
--

ALTER TABLE ONLY epinmain_game ALTER COLUMN id SET DEFAULT nextval('epinmain_game_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: emir
--

ALTER TABLE ONLY epinmain_genre ALTER COLUMN id SET DEFAULT nextval('epinmain_genre_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: emir
--

ALTER TABLE ONLY epinmain_log ALTER COLUMN id SET DEFAULT nextval('epinmain_log_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: emir
--

ALTER TABLE ONLY epinmain_profile ALTER COLUMN id SET DEFAULT nextval('epinmain_profile_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: emir
--

ALTER TABLE ONLY epinmain_sale ALTER COLUMN id SET DEFAULT nextval('epinmain_sale_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY game ALTER COLUMN id SET DEFAULT nextval('game_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY genre ALTER COLUMN id SET DEFAULT nextval('genre_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY log ALTER COLUMN id SET DEFAULT nextval('log_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sale ALTER COLUMN id SET DEFAULT nextval('sale_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: emir
--

COPY auth_group (id, name) FROM stdin;
\.


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: emir
--

SELECT pg_catalog.setval('auth_group_id_seq', 1, false);


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: emir
--

COPY auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: emir
--

SELECT pg_catalog.setval('auth_group_permissions_id_seq', 1, false);


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: emir
--

COPY auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add game	1	add_game
2	Can change game	1	change_game
3	Can delete game	1	delete_game
4	Can add genre	2	add_genre
5	Can change genre	2	change_genre
6	Can delete genre	2	delete_genre
7	Can add log	3	add_log
8	Can change log	3	change_log
9	Can delete log	3	delete_log
10	Can add profile	4	add_profile
11	Can change profile	4	change_profile
12	Can delete profile	4	delete_profile
13	Can add sale	5	add_sale
14	Can change sale	5	change_sale
15	Can delete sale	5	delete_sale
16	Can add log entry	6	add_logentry
17	Can change log entry	6	change_logentry
18	Can delete log entry	6	delete_logentry
19	Can add permission	7	add_permission
20	Can change permission	7	change_permission
21	Can delete permission	7	delete_permission
22	Can add group	8	add_group
23	Can change group	8	change_group
24	Can delete group	8	delete_group
25	Can add user	9	add_user
26	Can change user	9	change_user
27	Can delete user	9	delete_user
28	Can add content type	10	add_contenttype
29	Can change content type	10	change_contenttype
30	Can delete content type	10	delete_contenttype
31	Can add session	11	add_session
32	Can change session	11	change_session
33	Can delete session	11	delete_session
\.


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: emir
--

SELECT pg_catalog.setval('auth_permission_id_seq', 33, true);


--
-- Data for Name: auth_user; Type: TABLE DATA; Schema: public; Owner: emir
--

COPY auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) FROM stdin;
1	pbkdf2_sha256$36000$0twM1seUknTL$lSA4W+JfJbpKBc+W16b0x7uoMR++hXHzIQenAJL1tUM=	2017-06-29 12:06:08.147385+03	t	admin			a@a.com	t	t	2017-06-29 12:05:04.674496+03
2	pbkdf2_sha256$36000$sFkZzB6tGwoU$+8nf8QQ/1mQzCAM3GkOHpmPhkCw39E0jD1SQ4CvLv58=	2017-06-29 16:53:29.416356+03	f	emirozbir			emirozbir@gmail.com	f	t	2017-06-29 14:07:59.161488+03
\.


--
-- Data for Name: auth_user_groups; Type: TABLE DATA; Schema: public; Owner: emir
--

COPY auth_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: emir
--

SELECT pg_catalog.setval('auth_user_groups_id_seq', 1, false);


--
-- Name: auth_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: emir
--

SELECT pg_catalog.setval('auth_user_id_seq', 2, true);


--
-- Data for Name: auth_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: emir
--

COPY auth_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: emir
--

SELECT pg_catalog.setval('auth_user_user_permissions_id_seq', 1, false);


--
-- Data for Name: company; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY company (id, name) FROM stdin;
1	d
\.


--
-- Name: company_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('company_id_seq', 1, true);


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: emir
--

COPY django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
\.


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: emir
--

SELECT pg_catalog.setval('django_admin_log_id_seq', 1, false);


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: emir
--

COPY django_content_type (id, app_label, model) FROM stdin;
1	epinmain	game
2	epinmain	genre
3	epinmain	log
4	epinmain	profile
5	epinmain	sale
6	admin	logentry
7	auth	permission
8	auth	group
9	auth	user
10	contenttypes	contenttype
11	sessions	session
\.


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: emir
--

SELECT pg_catalog.setval('django_content_type_id_seq', 11, true);


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: emir
--

COPY django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2017-06-29 10:53:39.136894+03
2	auth	0001_initial	2017-06-29 10:53:40.697294+03
3	admin	0001_initial	2017-06-29 10:53:41.309687+03
4	admin	0002_logentry_remove_auto_add	2017-06-29 10:53:41.43053+03
5	contenttypes	0002_remove_content_type_name	2017-06-29 10:53:41.51922+03
6	auth	0002_alter_permission_name_max_length	2017-06-29 10:53:41.564688+03
7	auth	0003_alter_user_email_max_length	2017-06-29 10:53:41.932256+03
8	auth	0004_alter_user_username_opts	2017-06-29 10:53:41.974627+03
9	auth	0005_alter_user_last_login_null	2017-06-29 10:53:42.033949+03
10	auth	0006_require_contenttypes_0002	2017-06-29 10:53:42.063774+03
11	auth	0007_alter_validators_add_error_messages	2017-06-29 10:53:42.102406+03
12	auth	0008_alter_user_username_max_length	2017-06-29 10:53:42.220878+03
13	epinmain	0001_initial	2017-06-29 10:53:43.345682+03
14	epinmain	0002_auto_20170616_2216	2017-06-29 10:53:43.683397+03
15	epinmain	0003_profile_balance	2017-06-29 10:53:43.966403+03
16	sessions	0001_initial	2017-06-29 10:53:44.637325+03
\.


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: emir
--

SELECT pg_catalog.setval('django_migrations_id_seq', 16, true);


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: emir
--

COPY django_session (session_key, session_data, expire_date) FROM stdin;
z09e8mbz9ypmjtlslp0iwwzhmwn046oa	YTc2YzdiZDlhYzQxZWZjYWViNzU0YmI3ZjdlZjI4ZDk3MGRkMjc4Yzp7ImdhbWUiOlsiYSIsInMiLCJkIiwiYSIsInMiLCJkIiwiYSIsInMiLCJkIiwiYSIsInMiLCJkIl0sImdhbWVfbW9uZXlfY291bnQiOlsiYSIsInMiLCJkIiwiYSIsInMiLCJkIiwiYSIsInMiLCJkIiwiYSIsInMiLCJkIl0sImNhcnRfZGF0YSAiOlsiMSIsIjIiLCIzIiwiMSIsIjIiLCIzIiwiMSIsIjIiLCIzIiwibCIsIm8iLCJsIiwiMSIsIjIiLCIzIiwibCIsIm8iLCJsIiwiMSIsIjIiLCIzIiwibCIsIm8iLCJsIl0sImNhcnRfZGF0YSI6WyJnYW1lX21vbmV5X2NvdW50IiwiZ2FtZV9uYW1lIiwiZ2FtZV9tb25leV9jb3VudCIsImdhbWVfbmFtZSIsImdhbWVfbW9uZXlfY291bnQiLCJnYW1lX25hbWUiXX0=	2017-07-17 16:09:35.145504+03
3mjke21xcymwwcg455z6p97pljkp240u	NWE1OGJjNTY5NWU1OWQ3NjYzMWRjNDE2MDI5MDIzMzg3NzgzZTM4ZDp7Imxhbmd1YWdlIjoidHIiLCJfYXV0aF91c2VyX2lkIjoiMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiZjdkODhlYTE0YTZhNTIyZDk1OTQ1Mjc4N2M5MTlkNzE2YzAyNTNmZSJ9	2017-07-13 16:53:47.25323+03
ftudoeq4lhfz8agbxo0dumube6gvjmcr	NDNlODFiM2Q2MDU2N2ExZTUxN2U0ODEyNmViNjdmNjg5Y2UwYTY2ZDp7fQ==	2017-07-18 10:11:45.670188+03
\.


--
-- Data for Name: epinmain_game; Type: TABLE DATA; Schema: public; Owner: emir
--

COPY epinmain_game (id, name, game_pin_price, created_at, popularity, game_logo, genre_id) FROM stdin;
\.


--
-- Name: epinmain_game_id_seq; Type: SEQUENCE SET; Schema: public; Owner: emir
--

SELECT pg_catalog.setval('epinmain_game_id_seq', 1, false);


--
-- Data for Name: epinmain_genre; Type: TABLE DATA; Schema: public; Owner: emir
--

COPY epinmain_genre (id, name) FROM stdin;
\.


--
-- Name: epinmain_genre_id_seq; Type: SEQUENCE SET; Schema: public; Owner: emir
--

SELECT pg_catalog.setval('epinmain_genre_id_seq', 1, false);


--
-- Data for Name: epinmain_log; Type: TABLE DATA; Schema: public; Owner: emir
--

COPY epinmain_log (id, log_raise, created_at, ip_addr) FROM stdin;
\.


--
-- Name: epinmain_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: emir
--

SELECT pg_catalog.setval('epinmain_log_id_seq', 1, false);


--
-- Data for Name: epinmain_profile; Type: TABLE DATA; Schema: public; Owner: emir
--

COPY epinmain_profile (id, birth_date, status, user_id, balance) FROM stdin;
1	2010-09-09	t	2	0
\.


--
-- Name: epinmain_profile_id_seq; Type: SEQUENCE SET; Schema: public; Owner: emir
--

SELECT pg_catalog.setval('epinmain_profile_id_seq', 1, true);


--
-- Data for Name: epinmain_sale; Type: TABLE DATA; Schema: public; Owner: emir
--

COPY epinmain_sale (id, amount, created_at, game_id_id, user_id) FROM stdin;
\.


--
-- Name: epinmain_sale_id_seq; Type: SEQUENCE SET; Schema: public; Owner: emir
--

SELECT pg_catalog.setval('epinmain_sale_id_seq', 1, false);


--
-- Data for Name: game; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY game (id, name, price, popularity, created_date, update_date, logo, genre_id, company_id) FROM stdin;
6	b	1	1	2017-07-03 14:39:38.833548	2017-07-03 14:39:38.833548	\N	1	1
\.


--
-- Name: game_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('game_id_seq', 6, true);


--
-- Data for Name: genre; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY genre (id, name) FROM stdin;
1	RPG
2	Sport
\.


--
-- Name: genre_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('genre_id_seq', 259199, true);


--
-- Data for Name: log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY log (id, username, date, name, operation, price, genre_id, logo, game_id, company_id) FROM stdin;
8	postgres	2017-07-03 14:39:38.833548	a	I	1	1	\N	6	1
9	postgres	2017-07-03 14:40:55.669449	a	U	1	1	\N	6	1
\.


--
-- Name: log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('log_id_seq', 9, true);


--
-- Data for Name: sale; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY sale (id, user_id, game_id, c_date, amount) FROM stdin;
\.


--
-- Name: sale_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('sale_id_seq', 1, false);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY users (id, username, password, email, c_date, full_name, status, balance, lastlogin, admin) FROM stdin;
\.


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('users_id_seq', 1, false);


--
-- Name: auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: emir
--

ALTER TABLE ONLY auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: emir
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: emir
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: emir
--

ALTER TABLE ONLY auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: emir
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: emir
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: emir
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups_user_id_group_id_94350c0c_uniq; Type: CONSTRAINT; Schema: public; Owner: emir
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_group_id_94350c0c_uniq UNIQUE (user_id, group_id);


--
-- Name: auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: emir
--

ALTER TABLE ONLY auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: emir
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions_user_id_permission_id_14a6b632_uniq; Type: CONSTRAINT; Schema: public; Owner: emir
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_permission_id_14a6b632_uniq UNIQUE (user_id, permission_id);


--
-- Name: auth_user_username_key; Type: CONSTRAINT; Schema: public; Owner: emir
--

ALTER TABLE ONLY auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);


--
-- Name: company_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY company
    ADD CONSTRAINT company_pkey PRIMARY KEY (id);


--
-- Name: django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: emir
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: emir
--

ALTER TABLE ONLY django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: emir
--

ALTER TABLE ONLY django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: emir
--

ALTER TABLE ONLY django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: emir
--

ALTER TABLE ONLY django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: epinmain_game_pkey; Type: CONSTRAINT; Schema: public; Owner: emir
--

ALTER TABLE ONLY epinmain_game
    ADD CONSTRAINT epinmain_game_pkey PRIMARY KEY (id);


--
-- Name: epinmain_genre_name_a1e10240_uniq; Type: CONSTRAINT; Schema: public; Owner: emir
--

ALTER TABLE ONLY epinmain_genre
    ADD CONSTRAINT epinmain_genre_name_a1e10240_uniq UNIQUE (name);


--
-- Name: epinmain_genre_pkey; Type: CONSTRAINT; Schema: public; Owner: emir
--

ALTER TABLE ONLY epinmain_genre
    ADD CONSTRAINT epinmain_genre_pkey PRIMARY KEY (id);


--
-- Name: epinmain_log_pkey; Type: CONSTRAINT; Schema: public; Owner: emir
--

ALTER TABLE ONLY epinmain_log
    ADD CONSTRAINT epinmain_log_pkey PRIMARY KEY (id);


--
-- Name: epinmain_profile_pkey; Type: CONSTRAINT; Schema: public; Owner: emir
--

ALTER TABLE ONLY epinmain_profile
    ADD CONSTRAINT epinmain_profile_pkey PRIMARY KEY (id);


--
-- Name: epinmain_profile_user_id_key; Type: CONSTRAINT; Schema: public; Owner: emir
--

ALTER TABLE ONLY epinmain_profile
    ADD CONSTRAINT epinmain_profile_user_id_key UNIQUE (user_id);


--
-- Name: epinmain_sale_pkey; Type: CONSTRAINT; Schema: public; Owner: emir
--

ALTER TABLE ONLY epinmain_sale
    ADD CONSTRAINT epinmain_sale_pkey PRIMARY KEY (id);


--
-- Name: game_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY game
    ADD CONSTRAINT game_name_key UNIQUE (name);


--
-- Name: game_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY game
    ADD CONSTRAINT game_pkey PRIMARY KEY (id);


--
-- Name: genre_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY genre
    ADD CONSTRAINT genre_name_key UNIQUE (name);


--
-- Name: genre_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY genre
    ADD CONSTRAINT genre_pkey PRIMARY KEY (id);


--
-- Name: log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY log
    ADD CONSTRAINT log_pkey PRIMARY KEY (id);


--
-- Name: sale_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sale
    ADD CONSTRAINT sale_pkey PRIMARY KEY (id);


--
-- Name: users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: emir
--

CREATE INDEX auth_group_name_a6ea08ec_like ON auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: emir
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: emir
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: emir
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON auth_permission USING btree (content_type_id);


--
-- Name: auth_user_groups_group_id_97559544; Type: INDEX; Schema: public; Owner: emir
--

CREATE INDEX auth_user_groups_group_id_97559544 ON auth_user_groups USING btree (group_id);


--
-- Name: auth_user_groups_user_id_6a12ed8b; Type: INDEX; Schema: public; Owner: emir
--

CREATE INDEX auth_user_groups_user_id_6a12ed8b ON auth_user_groups USING btree (user_id);


--
-- Name: auth_user_user_permissions_permission_id_1fbb5f2c; Type: INDEX; Schema: public; Owner: emir
--

CREATE INDEX auth_user_user_permissions_permission_id_1fbb5f2c ON auth_user_user_permissions USING btree (permission_id);


--
-- Name: auth_user_user_permissions_user_id_a95ead1b; Type: INDEX; Schema: public; Owner: emir
--

CREATE INDEX auth_user_user_permissions_user_id_a95ead1b ON auth_user_user_permissions USING btree (user_id);


--
-- Name: auth_user_username_6821ab7c_like; Type: INDEX; Schema: public; Owner: emir
--

CREATE INDEX auth_user_username_6821ab7c_like ON auth_user USING btree (username varchar_pattern_ops);


--
-- Name: cname_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cname_idx ON company USING btree (name);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: emir
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: emir
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: emir
--

CREATE INDEX django_session_expire_date_a5c62663 ON django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: emir
--

CREATE INDEX django_session_session_key_c0390e0f_like ON django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: epinmain_game_genre_id_93455568; Type: INDEX; Schema: public; Owner: emir
--

CREATE INDEX epinmain_game_genre_id_93455568 ON epinmain_game USING btree (genre_id);


--
-- Name: epinmain_genre_name_a1e10240_like; Type: INDEX; Schema: public; Owner: emir
--

CREATE INDEX epinmain_genre_name_a1e10240_like ON epinmain_genre USING btree (name varchar_pattern_ops);


--
-- Name: epinmain_sale_game_id_id_6fd3055d; Type: INDEX; Schema: public; Owner: emir
--

CREATE INDEX epinmain_sale_game_id_id_6fd3055d ON epinmain_sale USING btree (game_id_id);


--
-- Name: epinmain_sale_user_id_e4e7df32; Type: INDEX; Schema: public; Owner: emir
--

CREATE INDEX epinmain_sale_user_id_e4e7df32 ON epinmain_sale USING btree (user_id);


--
-- Name: logt; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER logt AFTER INSERT OR DELETE OR UPDATE ON game FOR EACH ROW EXECUTE PROCEDURE logfunction();


--
-- Name: auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: emir
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: emir
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: emir
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups_group_id_97559544_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: emir
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_97559544_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups_user_id_6a12ed8b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: emir
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_6a12ed8b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: emir
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: emir
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: emir
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log_user_id_c564eba6_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: emir
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: epinmain_game_genre_id_93455568_fk_epinmain_genre_id; Type: FK CONSTRAINT; Schema: public; Owner: emir
--

ALTER TABLE ONLY epinmain_game
    ADD CONSTRAINT epinmain_game_genre_id_93455568_fk_epinmain_genre_id FOREIGN KEY (genre_id) REFERENCES epinmain_genre(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: epinmain_profile_user_id_c90d08c0_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: emir
--

ALTER TABLE ONLY epinmain_profile
    ADD CONSTRAINT epinmain_profile_user_id_c90d08c0_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: epinmain_sale_game_id_id_6fd3055d_fk_epinmain_game_id; Type: FK CONSTRAINT; Schema: public; Owner: emir
--

ALTER TABLE ONLY epinmain_sale
    ADD CONSTRAINT epinmain_sale_game_id_id_6fd3055d_fk_epinmain_game_id FOREIGN KEY (game_id_id) REFERENCES epinmain_game(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: epinmain_sale_user_id_e4e7df32_fk_epinmain_profile_id; Type: FK CONSTRAINT; Schema: public; Owner: emir
--

ALTER TABLE ONLY epinmain_sale
    ADD CONSTRAINT epinmain_sale_user_id_e4e7df32_fk_epinmain_profile_id FOREIGN KEY (user_id) REFERENCES epinmain_profile(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: game_company_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY game
    ADD CONSTRAINT game_company_id_fkey FOREIGN KEY (company_id) REFERENCES company(id);


--
-- Name: game_genre_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY game
    ADD CONSTRAINT game_genre_id_fkey FOREIGN KEY (genre_id) REFERENCES genre(id);


--
-- Name: sale_game_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sale
    ADD CONSTRAINT sale_game_id_fkey FOREIGN KEY (game_id) REFERENCES game(id);


--
-- Name: sale_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sale
    ADD CONSTRAINT sale_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- Name: django_migrations; Type: ACL; Schema: public; Owner: emir
--

REVOKE ALL ON TABLE django_migrations FROM PUBLIC;
REVOKE ALL ON TABLE django_migrations FROM emir;
GRANT ALL ON TABLE django_migrations TO emir;
GRANT ALL ON TABLE django_migrations TO taha;
GRANT ALL ON TABLE django_migrations TO sercan;
GRANT ALL ON TABLE django_migrations TO halilabi;
GRANT ALL ON TABLE django_migrations TO yagmur;


--
-- Name: django_migrations_id_seq; Type: ACL; Schema: public; Owner: emir
--

REVOKE ALL ON SEQUENCE django_migrations_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE django_migrations_id_seq FROM emir;
GRANT ALL ON SEQUENCE django_migrations_id_seq TO emir;
GRANT ALL ON SEQUENCE django_migrations_id_seq TO taha;
GRANT ALL ON SEQUENCE django_migrations_id_seq TO sercan;
GRANT ALL ON SEQUENCE django_migrations_id_seq TO halilabi;
GRANT ALL ON SEQUENCE django_migrations_id_seq TO yagmur;


--
-- Name: game; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE game FROM PUBLIC;
REVOKE ALL ON TABLE game FROM postgres;
GRANT ALL ON TABLE game TO postgres;
GRANT ALL ON TABLE game TO admin;
GRANT ALL ON TABLE game TO emir;
GRANT ALL ON TABLE game TO taha;
GRANT ALL ON TABLE game TO sercan;
GRANT ALL ON TABLE game TO halilabi;
GRANT ALL ON TABLE game TO yagmur;
GRANT ALL ON TABLE game TO halil;


--
-- Name: game_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE game_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE game_id_seq FROM postgres;
GRANT ALL ON SEQUENCE game_id_seq TO postgres;
GRANT ALL ON SEQUENCE game_id_seq TO admin;
GRANT ALL ON SEQUENCE game_id_seq TO emir;
GRANT ALL ON SEQUENCE game_id_seq TO taha;
GRANT ALL ON SEQUENCE game_id_seq TO sercan;
GRANT ALL ON SEQUENCE game_id_seq TO halilabi;
GRANT ALL ON SEQUENCE game_id_seq TO yagmur;
GRANT ALL ON SEQUENCE game_id_seq TO halil;


--
-- Name: genre; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE genre FROM PUBLIC;
REVOKE ALL ON TABLE genre FROM postgres;
GRANT ALL ON TABLE genre TO postgres;
GRANT ALL ON TABLE genre TO emir;
GRANT ALL ON TABLE genre TO taha;
GRANT ALL ON TABLE genre TO sercan;
GRANT ALL ON TABLE genre TO yagmur;
GRANT ALL ON TABLE genre TO halil;


--
-- Name: genre_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE genre_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE genre_id_seq FROM postgres;
GRANT ALL ON SEQUENCE genre_id_seq TO postgres;
GRANT ALL ON SEQUENCE genre_id_seq TO emir;
GRANT ALL ON SEQUENCE genre_id_seq TO taha;
GRANT ALL ON SEQUENCE genre_id_seq TO sercan;
GRANT ALL ON SEQUENCE genre_id_seq TO yagmur;
GRANT ALL ON SEQUENCE genre_id_seq TO halil;


--
-- Name: log; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE log FROM PUBLIC;
REVOKE ALL ON TABLE log FROM postgres;
GRANT ALL ON TABLE log TO postgres;
GRANT ALL ON TABLE log TO admin;
GRANT ALL ON TABLE log TO emir;
GRANT ALL ON TABLE log TO taha;
GRANT ALL ON TABLE log TO sercan;
GRANT ALL ON TABLE log TO yagmur;
GRANT ALL ON TABLE log TO halil;


--
-- Name: log_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE log_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE log_id_seq FROM postgres;
GRANT ALL ON SEQUENCE log_id_seq TO postgres;
GRANT ALL ON SEQUENCE log_id_seq TO admin;
GRANT ALL ON SEQUENCE log_id_seq TO emir;
GRANT ALL ON SEQUENCE log_id_seq TO taha;
GRANT ALL ON SEQUENCE log_id_seq TO sercan;
GRANT ALL ON SEQUENCE log_id_seq TO yagmur;
GRANT ALL ON SEQUENCE log_id_seq TO halil;


--
-- Name: sale; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE sale FROM PUBLIC;
REVOKE ALL ON TABLE sale FROM postgres;
GRANT ALL ON TABLE sale TO postgres;
GRANT ALL ON TABLE sale TO emir;
GRANT ALL ON TABLE sale TO taha;
GRANT ALL ON TABLE sale TO sercan;
GRANT ALL ON TABLE sale TO yagmur;


--
-- Name: sale_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE sale_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE sale_id_seq FROM postgres;
GRANT ALL ON SEQUENCE sale_id_seq TO postgres;
GRANT ALL ON SEQUENCE sale_id_seq TO emir;
GRANT ALL ON SEQUENCE sale_id_seq TO taha;
GRANT ALL ON SEQUENCE sale_id_seq TO sercan;
GRANT ALL ON SEQUENCE sale_id_seq TO yagmur;


--
-- Name: users; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE users FROM PUBLIC;
REVOKE ALL ON TABLE users FROM postgres;
GRANT ALL ON TABLE users TO postgres;
GRANT ALL ON TABLE users TO emir;
GRANT ALL ON TABLE users TO taha;
GRANT ALL ON TABLE users TO sercan;
GRANT ALL ON TABLE users TO yagmur;


--
-- Name: users_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE users_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE users_id_seq FROM postgres;
GRANT ALL ON SEQUENCE users_id_seq TO postgres;
GRANT ALL ON SEQUENCE users_id_seq TO emir;
GRANT ALL ON SEQUENCE users_id_seq TO taha;
GRANT ALL ON SEQUENCE users_id_seq TO sercan;
GRANT ALL ON SEQUENCE users_id_seq TO yagmur;


--
-- PostgreSQL database dump complete
--

