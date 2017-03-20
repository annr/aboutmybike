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
-- Data for Name: type; Type: TABLE DATA; Schema: public; Owner: arobson
--

COPY type (id, label, notes, related_type_ids) FROM stdin;
1	Road	\N	\N
2	Mountain	\N	\N
3	Downhill	\N	{2}
4	Fat	\N	{2}
5	Suspension	\N	{2}
6	Hybrid	\N	\N
7	City	\N	{6}
8	Cyclo-cross	\N	{6}
9	Flat Bar Road	\N	{6}
10	Trekking	\N	{6}
11	Step-Through	\N	\N
12	Mixte	\N	{11}
13	Fixed Gear	\N	\N
14	BMX	\N	{13}
15	Track	\N	{13}
16	Cruiser	\N	\N
17	Folding	\N	\N
18	Recumbent	\N	\N
19	Tandem	\N	\N
20	Tricycle	\N	\N
21	Unicycle	\N	\N
22	Utility	\N	\N
23	Motorized	\N	\N
24	Electric	\N	\N
\.


--
-- PostgreSQL database dump complete
--

