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

SET search_path = public, pg_catalog;

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
-- Name: amb_user id; Type: DEFAULT; Schema: public; Owner: arobson
--

ALTER TABLE ONLY amb_user ALTER COLUMN id SET DEFAULT nextval('user_id_seq'::regclass);


--
-- Data for Name: amb_user; Type: TABLE DATA; Schema: public; Owner: arobson
--

COPY amb_user (id, created_at, last_login, username, facebook_id, name, first_name, last_name, facebook_link, gender, locale, email, website) FROM stdin;
1	2017-03-18 10:55:48.161761-07	\N	ann	10210812525663069	\N	Ann	Robson	\N	female	\N	nosbora@gmail.com	\N
4	2017-03-20 10:54:23.043457-07	\N	aero	\N	\N	Ann	Robson	\N	female	\N	anno.robson@gmail.com	\N
5	2017-03-20 10:55:09.03946-07	\N	lpc	\N	\N	Leslie	Chong	\N	female	\N	leslie.chong@gmail.com	\N
2	2017-03-20 10:51:32.493725-07	\N	jerome	\N	\N	Jerome	Tavé	\N	male	\N	jerometave@gmail.com	\N
3	2017-03-20 10:52:33.010915-07	\N	wildechild	\N	\N	Josie	Robson	\N	female	\N	jwrobson@gmail.com	\N
\.


--
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: arobson
--

SELECT pg_catalog.setval('user_id_seq', 3, true);


--
-- Name: amb_user user_pkey; Type: CONSTRAINT; Schema: public; Owner: arobson
--

ALTER TABLE ONLY amb_user
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--

