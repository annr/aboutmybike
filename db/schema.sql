--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.1
-- Dumped by pg_dump version 9.6.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
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
-- Name: era; Type: TYPE; Schema: public; Owner: arobson
--

CREATE TYPE era AS ENUM (
    'Recent',
    '00s',
    '90s',
    '80s',
    '70s',
    'Mid-Century',
    'Early 1900s',
    'Late 1800s'
);


ALTER TYPE era OWNER TO arobson;

--
-- Name: market_size_type; Type: TYPE; Schema: public; Owner: arobson
--

CREATE TYPE market_size_type AS ENUM (
    'A',
    'B',
    'C'
);


ALTER TYPE market_size_type OWNER TO arobson;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: amb_user; Type: TABLE; Schema: public; Owner: arobson
--

CREATE TABLE amb_user (
    id integer NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    last_login timestamp with time zone,
    username text,
    facebook_id bigint,
    name text,
    first_name text,
    last_name text,
    facebook_link text,
    gender text,
    locale text,
    email character varying(254),
    website text
);


ALTER TABLE amb_user OWNER TO arobson;

--
-- Name: bike; Type: TABLE; Schema: public; Owner: arobson
--

CREATE TABLE bike (
    id integer NOT NULL,
    brand_unlinked text,
    model_unlinked text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    user_id integer NOT NULL,
    description text,
    notes text,
    nickname text,
    manufacturer_id integer,
    model_id integer,
    serial_number text,
    main_photo_path text,
    type_ids integer[],
    reason_ids integer[],
    status integer
);


ALTER TABLE bike OWNER TO arobson;

--
-- Name: bike_id_seq; Type: SEQUENCE; Schema: public; Owner: arobson
--

CREATE SEQUENCE bike_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE bike_id_seq OWNER TO arobson;

--
-- Name: bike_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: arobson
--

ALTER SEQUENCE bike_id_seq OWNED BY bike.id;


--
-- Name: bike_info; Type: TABLE; Schema: public; Owner: arobson
--

CREATE TABLE bike_info (
    bike_id integer NOT NULL,
    year smallint,
    era text,
    speeds text,
    handlebars text,
    brakes text,
    color text,
    details jsonb
);


ALTER TABLE bike_info OWNER TO arobson;

--
-- Name: city; Type: TABLE; Schema: public; Owner: arobson
--

CREATE TABLE city (
    id integer NOT NULL,
    name text,
    state text,
    country text
);


ALTER TABLE city OWNER TO arobson;

--
-- Name: city_id_seq; Type: SEQUENCE; Schema: public; Owner: arobson
--

CREATE SEQUENCE city_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE city_id_seq OWNER TO arobson;

--
-- Name: city_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: arobson
--

ALTER SEQUENCE city_id_seq OWNED BY city.id;


--
-- Name: country; Type: TABLE; Schema: public; Owner: arobson
--

CREATE TABLE country (
    name text,
    code text NOT NULL
);


ALTER TABLE country OWNER TO arobson;

--
-- Name: manufacturer; Type: TABLE; Schema: public; Owner: arobson
--

CREATE TABLE manufacturer (
    id integer NOT NULL,
    name text NOT NULL,
    company_web_url text,
    year_established integer,
    notes text,
    discontinued boolean,
    wikipedia_url text,
    market_size market_size_type,
    country text,
    bike_index_id integer
);


ALTER TABLE manufacturer OWNER TO arobson;

--
-- Name: manufacturer_id_seq; Type: SEQUENCE; Schema: public; Owner: arobson
--

CREATE SEQUENCE manufacturer_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE manufacturer_id_seq OWNER TO arobson;

--
-- Name: manufacturer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: arobson
--

ALTER SEQUENCE manufacturer_id_seq OWNED BY manufacturer.id;


--
-- Name: model; Type: TABLE; Schema: public; Owner: arobson
--

CREATE TABLE model (
    id integer NOT NULL,
    manufacturer_id integer,
    name text NOT NULL,
    year_introduced integer,
    year_discontinued integer,
    notes text,
    web_url text,
    source text,
    style_id integer,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    type_ids integer[]
);


ALTER TABLE model OWNER TO arobson;

--
-- Name: model_id_seq; Type: SEQUENCE; Schema: public; Owner: arobson
--

CREATE SEQUENCE model_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE model_id_seq OWNER TO arobson;

--
-- Name: model_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: arobson
--

ALTER SEQUENCE model_id_seq OWNED BY model.id;


--
-- Name: photo; Type: TABLE; Schema: public; Owner: arobson
--

CREATE TABLE photo (
    id integer NOT NULL,
    original_file text,
    file_path text,
    bike_id integer,
    user_id integer,
    metadata jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE photo OWNER TO arobson;

--
-- Name: photo_id_seq; Type: SEQUENCE; Schema: public; Owner: arobson
--

CREATE SEQUENCE photo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE photo_id_seq OWNER TO arobson;

--
-- Name: photo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: arobson
--

ALTER SEQUENCE photo_id_seq OWNED BY photo.id;


--
-- Name: reason; Type: TABLE; Schema: public; Owner: arobson
--

CREATE TABLE reason (
    id integer NOT NULL,
    label text
);


ALTER TABLE reason OWNER TO arobson;

--
-- Name: reason_id_seq; Type: SEQUENCE; Schema: public; Owner: arobson
--

CREATE SEQUENCE reason_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE reason_id_seq OWNER TO arobson;

--
-- Name: reason_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: arobson
--

ALTER SEQUENCE reason_id_seq OWNED BY reason.id;


--
-- Name: session; Type: TABLE; Schema: public; Owner: arobson
--

CREATE TABLE session (
    sid character varying NOT NULL,
    sess json NOT NULL,
    expire timestamp(6) without time zone NOT NULL
);


ALTER TABLE session OWNER TO arobson;

--
-- Name: story; Type: TABLE; Schema: public; Owner: arobson
--

CREATE TABLE story (
    id integer NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    text text,
    user_id integer
);


ALTER TABLE story OWNER TO arobson;

--
-- Name: story_id_seq; Type: SEQUENCE; Schema: public; Owner: arobson
--

CREATE SEQUENCE story_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE story_id_seq OWNER TO arobson;

--
-- Name: story_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: arobson
--

ALTER SEQUENCE story_id_seq OWNED BY story.id;


--
-- Name: theft; Type: TABLE; Schema: public; Owner: arobson
--

CREATE TABLE theft (
    id integer NOT NULL,
    reported_at timestamp with time zone,
    description text,
    bike_id integer,
    owner_id integer,
    recovered_at timestamp with time zone
);


ALTER TABLE theft OWNER TO arobson;

--
-- Name: theft_id_seq; Type: SEQUENCE; Schema: public; Owner: arobson
--

CREATE SEQUENCE theft_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE theft_id_seq OWNER TO arobson;

--
-- Name: theft_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: arobson
--

ALTER SEQUENCE theft_id_seq OWNED BY theft.id;


--
-- Name: type; Type: TABLE; Schema: public; Owner: arobson
--

CREATE TABLE type (
    id integer NOT NULL,
    label text,
    notes text,
    related_type_ids integer[]
);


ALTER TABLE type OWNER TO arobson;

--
-- Name: user_id_seq; Type: SEQUENCE; Schema: public; Owner: arobson
--

CREATE SEQUENCE user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE user_id_seq OWNER TO arobson;

--
-- Name: user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: arobson
--

ALTER SEQUENCE user_id_seq OWNED BY amb_user.id;


--
-- Name: user_photo; Type: TABLE; Schema: public; Owner: arobson
--

CREATE TABLE user_photo (
    id integer NOT NULL,
    user_id integer,
    web_url text NOT NULL,
    source text DEFAULT '''facebook'''::text,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE user_photo OWNER TO arobson;

--
-- Name: user_photo_id_seq; Type: SEQUENCE; Schema: public; Owner: arobson
--

CREATE SEQUENCE user_photo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE user_photo_id_seq OWNER TO arobson;

--
-- Name: user_photo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: arobson
--

ALTER SEQUENCE user_photo_id_seq OWNED BY user_photo.id;


--
-- Name: amb_user id; Type: DEFAULT; Schema: public; Owner: arobson
--

ALTER TABLE ONLY amb_user ALTER COLUMN id SET DEFAULT nextval('user_id_seq'::regclass);


--
-- Name: bike id; Type: DEFAULT; Schema: public; Owner: arobson
--

ALTER TABLE ONLY bike ALTER COLUMN id SET DEFAULT nextval('bike_id_seq'::regclass);


--
-- Name: city id; Type: DEFAULT; Schema: public; Owner: arobson
--

ALTER TABLE ONLY city ALTER COLUMN id SET DEFAULT nextval('city_id_seq'::regclass);


--
-- Name: manufacturer id; Type: DEFAULT; Schema: public; Owner: arobson
--

ALTER TABLE ONLY manufacturer ALTER COLUMN id SET DEFAULT nextval('manufacturer_id_seq'::regclass);


--
-- Name: model id; Type: DEFAULT; Schema: public; Owner: arobson
--

ALTER TABLE ONLY model ALTER COLUMN id SET DEFAULT nextval('model_id_seq'::regclass);


--
-- Name: photo id; Type: DEFAULT; Schema: public; Owner: arobson
--

ALTER TABLE ONLY photo ALTER COLUMN id SET DEFAULT nextval('photo_id_seq'::regclass);


--
-- Name: reason id; Type: DEFAULT; Schema: public; Owner: arobson
--

ALTER TABLE ONLY reason ALTER COLUMN id SET DEFAULT nextval('reason_id_seq'::regclass);


--
-- Name: story id; Type: DEFAULT; Schema: public; Owner: arobson
--

ALTER TABLE ONLY story ALTER COLUMN id SET DEFAULT nextval('story_id_seq'::regclass);


--
-- Name: theft id; Type: DEFAULT; Schema: public; Owner: arobson
--

ALTER TABLE ONLY theft ALTER COLUMN id SET DEFAULT nextval('theft_id_seq'::regclass);


--
-- Name: user_photo id; Type: DEFAULT; Schema: public; Owner: arobson
--

ALTER TABLE ONLY user_photo ALTER COLUMN id SET DEFAULT nextval('user_photo_id_seq'::regclass);


--
-- Name: bike_info bike_info_pkey; Type: CONSTRAINT; Schema: public; Owner: arobson
--

ALTER TABLE ONLY bike_info
    ADD CONSTRAINT bike_info_pkey PRIMARY KEY (bike_id);


--
-- Name: bike bike_pkey; Type: CONSTRAINT; Schema: public; Owner: arobson
--

ALTER TABLE ONLY bike
    ADD CONSTRAINT bike_pkey PRIMARY KEY (id);


--
-- Name: city city_pkey; Type: CONSTRAINT; Schema: public; Owner: arobson
--

ALTER TABLE ONLY city
    ADD CONSTRAINT city_pkey PRIMARY KEY (id);


--
-- Name: country country_pkey; Type: CONSTRAINT; Schema: public; Owner: arobson
--

ALTER TABLE ONLY country
    ADD CONSTRAINT country_pkey PRIMARY KEY (code);


--
-- Name: manufacturer manufacturer_name_key; Type: CONSTRAINT; Schema: public; Owner: arobson
--

ALTER TABLE ONLY manufacturer
    ADD CONSTRAINT manufacturer_name_key UNIQUE (name);


--
-- Name: manufacturer manufacturer_pkey; Type: CONSTRAINT; Schema: public; Owner: arobson
--

ALTER TABLE ONLY manufacturer
    ADD CONSTRAINT manufacturer_pkey PRIMARY KEY (id);


--
-- Name: model model_pkey; Type: CONSTRAINT; Schema: public; Owner: arobson
--

ALTER TABLE ONLY model
    ADD CONSTRAINT model_pkey PRIMARY KEY (id);


--
-- Name: photo photo_pkey; Type: CONSTRAINT; Schema: public; Owner: arobson
--

ALTER TABLE ONLY photo
    ADD CONSTRAINT photo_pkey PRIMARY KEY (id);


--
-- Name: reason reason_pkey; Type: CONSTRAINT; Schema: public; Owner: arobson
--

ALTER TABLE ONLY reason
    ADD CONSTRAINT reason_pkey PRIMARY KEY (id);


--
-- Name: session session_pkey; Type: CONSTRAINT; Schema: public; Owner: arobson
--

ALTER TABLE ONLY session
    ADD CONSTRAINT session_pkey PRIMARY KEY (sid);


--
-- Name: story story_pkey; Type: CONSTRAINT; Schema: public; Owner: arobson
--

ALTER TABLE ONLY story
    ADD CONSTRAINT story_pkey PRIMARY KEY (id);


--
-- Name: theft theft_pkey; Type: CONSTRAINT; Schema: public; Owner: arobson
--

ALTER TABLE ONLY theft
    ADD CONSTRAINT theft_pkey PRIMARY KEY (id);


--
-- Name: user_photo user_photo_pkey; Type: CONSTRAINT; Schema: public; Owner: arobson
--

ALTER TABLE ONLY user_photo
    ADD CONSTRAINT user_photo_pkey PRIMARY KEY (id);


--
-- Name: amb_user user_pkey; Type: CONSTRAINT; Schema: public; Owner: arobson
--

ALTER TABLE ONLY amb_user
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- Name: bike_info bike_info_bike_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: arobson
--

ALTER TABLE ONLY bike_info
    ADD CONSTRAINT bike_info_bike_id_fkey FOREIGN KEY (bike_id) REFERENCES bike(id) ON DELETE CASCADE;


--
-- Name: manufacturer country_code; Type: FK CONSTRAINT; Schema: public; Owner: arobson
--

ALTER TABLE ONLY manufacturer
    ADD CONSTRAINT country_code FOREIGN KEY (country) REFERENCES country(code);


--
-- Name: bike manufacturer_id; Type: FK CONSTRAINT; Schema: public; Owner: arobson
--

ALTER TABLE ONLY bike
    ADD CONSTRAINT manufacturer_id FOREIGN KEY (manufacturer_id) REFERENCES manufacturer(id);


--
-- Name: bike model_id; Type: FK CONSTRAINT; Schema: public; Owner: arobson
--

ALTER TABLE ONLY bike
    ADD CONSTRAINT model_id FOREIGN KEY (model_id) REFERENCES model(id);


--
-- Name: model model_manufacturer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: arobson
--

ALTER TABLE ONLY model
    ADD CONSTRAINT model_manufacturer_id_fkey FOREIGN KEY (manufacturer_id) REFERENCES manufacturer(id);


--
-- Name: photo photo_bike_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: arobson
--

ALTER TABLE ONLY photo
    ADD CONSTRAINT photo_bike_id_fkey FOREIGN KEY (bike_id) REFERENCES bike(id) ON DELETE CASCADE;


--
-- Name: photo photo_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: arobson
--

ALTER TABLE ONLY photo
    ADD CONSTRAINT photo_user_id_fkey FOREIGN KEY (user_id) REFERENCES amb_user(id) ON DELETE CASCADE;


--
-- Name: story story_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: arobson
--

ALTER TABLE ONLY story
    ADD CONSTRAINT story_user_id_fkey FOREIGN KEY (user_id) REFERENCES amb_user(id) ON DELETE CASCADE;


--
-- Name: theft theft_bike_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: arobson
--

ALTER TABLE ONLY theft
    ADD CONSTRAINT theft_bike_id_fkey FOREIGN KEY (bike_id) REFERENCES bike(id) ON DELETE CASCADE;


--
-- Name: theft theft_owner_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: arobson
--

ALTER TABLE ONLY theft
    ADD CONSTRAINT theft_owner_id_fkey FOREIGN KEY (owner_id) REFERENCES amb_user(id);


--
-- Name: bike user_id; Type: FK CONSTRAINT; Schema: public; Owner: arobson
--

ALTER TABLE ONLY bike
    ADD CONSTRAINT user_id FOREIGN KEY (user_id) REFERENCES amb_user(id);


--
-- Name: user_photo user_photo_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: arobson
--

ALTER TABLE ONLY user_photo
    ADD CONSTRAINT user_photo_user_id_fkey FOREIGN KEY (user_id) REFERENCES amb_user(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

