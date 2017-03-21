--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.1
-- Dumped by pg_dump version 9.6.1

SET statement_timeout = 0;
SET lock_timeout = 0;
--SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

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
-- Name: reason id; Type: DEFAULT; Schema: public; Owner: arobson
--

ALTER TABLE ONLY reason ALTER COLUMN id SET DEFAULT nextval('reason_id_seq'::regclass);


--
-- Data for Name: reason; Type: TABLE DATA; Schema: public; Owner: arobson
--

COPY reason (id, label) FROM stdin;
1	fun
2	commute
3	work
4	fitness
5	social
6	style
7	adventure
8	thrill
9	freedom
\.


--
-- Name: reason_id_seq; Type: SEQUENCE SET; Schema: public; Owner: arobson
--

SELECT pg_catalog.setval('reason_id_seq', 9, true);


--
-- Name: reason reason_pkey; Type: CONSTRAINT; Schema: public; Owner: arobson
--

ALTER TABLE ONLY reason
    ADD CONSTRAINT reason_pkey PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--

