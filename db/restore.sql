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
    type_ids integer[],
    reason_ids integer[],
    status integer,
    main_photo_id integer
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
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone
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
-- Data for Name: bike; Type: TABLE DATA; Schema: public; Owner: arobson
--

COPY bike (id, brand_unlinked, model_unlinked, created_at, updated_at, user_id, description, notes, nickname, manufacturer_id, model_id, serial_number, type_ids, reason_ids, status, main_photo_id) FROM stdin;
1	\N	\N	2017-03-18 10:57:19.372048-07	2017-03-18 10:57:19.372048-07	1	SOME PEOPLE SAY YOU ARE GOING THE WRONG WAY, WHEN IT IS SIMPLY A WAY OF YOUR OWN.	\N	Angelina	\N	\N	123 and 234	\N	{1,4,5,8,9}	1	256
\.


--
-- Name: bike_id_seq; Type: SEQUENCE SET; Schema: public; Owner: arobson
--

SELECT pg_catalog.setval('bike_id_seq', 1, true);


--
-- Data for Name: bike_info; Type: TABLE DATA; Schema: public; Owner: arobson
--

COPY bike_info (bike_id, year, era, speeds, handlebars, brakes, color, details) FROM stdin;
1	\N	1990s	\N	\N	\N	#000000	\N
\.


--
-- Data for Name: city; Type: TABLE DATA; Schema: public; Owner: arobson
--

COPY city (id, name, state, country) FROM stdin;
\.


--
-- Name: city_id_seq; Type: SEQUENCE SET; Schema: public; Owner: arobson
--

SELECT pg_catalog.setval('city_id_seq', 1, false);


--
-- Data for Name: country; Type: TABLE DATA; Schema: public; Owner: arobson
--

COPY country (name, code) FROM stdin;
Afghanistan	AF
Åland Islands	AX
Albania	AL
Algeria	DZ
American Samoa	AS
Andorra	AD
Angola	AO
Anguilla	AI
Antarctica	AQ
Antigua and Barbuda	AG
Argentina	AR
Armenia	AM
Aruba	AW
Australia	AU
Austria	AT
Azerbaijan	AZ
Bahamas	BS
Bahrain	BH
Bangladesh	BD
Barbados	BB
Belarus	BY
Belgium	BE
Belize	BZ
Benin	BJ
Bermuda	BM
Bhutan	BT
Bolivia, Plurinational State of	BO
Bonaire, Sint Eustatius and Saba	BQ
Bosnia and Herzegovina	BA
Botswana	BW
Bouvet Island	BV
Brazil	BR
British Indian Ocean Territory	IO
Brunei Darussalam	BN
Bulgaria	BG
Burkina Faso	BF
Burundi	BI
Cambodia	KH
Cameroon	CM
Canada	CA
Cape Verde	CV
Cayman Islands	KY
Central African Republic	CF
Chad	TD
Chile	CL
China	CN
Christmas Island	CX
Cocos (Keeling) Islands	CC
Colombia	CO
Comoros	KM
Congo	CG
Congo, the Democratic Republic of the	CD
Cook Islands	CK
Costa Rica	CR
Côte d'Ivoire	CI
Croatia	HR
Cuba	CU
Curaçao	CW
Cyprus	CY
Czech Republic	CZ
Denmark	DK
Djibouti	DJ
Dominica	DM
Dominican Republic	DO
Ecuador	EC
Egypt	EG
El Salvador	SV
Equatorial Guinea	GQ
Eritrea	ER
Estonia	EE
Ethiopia	ET
Falkland Islands (Malvinas)	FK
Faroe Islands	FO
Fiji	FJ
Finland	FI
France	FR
French Guiana	GF
French Polynesia	PF
French Southern Territories	TF
Gabon	GA
Gambia	GM
Georgia	GE
Germany	DE
Ghana	GH
Gibraltar	GI
Greece	GR
Greenland	GL
Grenada	GD
Guadeloupe	GP
Guam	GU
Guatemala	GT
Guernsey	GG
Guinea	GN
Guinea-Bissau	GW
Guyana	GY
Haiti	HT
Heard Island and McDonald Islands	HM
Holy See (Vatican City State)	VA
Honduras	HN
Hong Kong	HK
Hungary	HU
Iceland	IS
India	IN
Indonesia	ID
Iran, Islamic Republic of	IR
Iraq	IQ
Ireland	IE
Isle of Man	IM
Israel	IL
Italy	IT
Jamaica	JM
Japan	JP
Jersey	JE
Jordan	JO
Kazakhstan	KZ
Kenya	KE
Kiribati	KI
Korea, Democratic People's Republic of	KP
Korea, Republic of	KR
Kuwait	KW
Kyrgyzstan	KG
Lao People's Democratic Republic	LA
Latvia	LV
Lebanon	LB
Lesotho	LS
Liberia	LR
Libya	LY
Liechtenstein	LI
Lithuania	LT
Luxembourg	LU
Macao	MO
Macedonia, the Former Yugoslav Republic of	MK
Madagascar	MG
Malawi	MW
Malaysia	MY
Maldives	MV
Mali	ML
Malta	MT
Marshall Islands	MH
Martinique	MQ
Mauritania	MR
Mauritius	MU
Mayotte	YT
Mexico	MX
Micronesia, Federated States of	FM
Moldova, Republic of	MD
Monaco	MC
Mongolia	MN
Montenegro	ME
Montserrat	MS
Morocco	MA
Mozambique	MZ
Myanmar	MM
Namibia	NA
Nauru	NR
Nepal	NP
Netherlands	NL
New Caledonia	NC
New Zealand	NZ
Nicaragua	NI
Niger	NE
Nigeria	NG
Niue	NU
Norfolk Island	NF
Northern Mariana Islands	MP
Norway	NO
Oman	OM
Pakistan	PK
Palau	PW
Palestine, State of	PS
Panama	PA
Papua New Guinea	PG
Paraguay	PY
Peru	PE
Philippines	PH
Pitcairn	PN
Poland	PL
Portugal	PT
Puerto Rico	PR
Qatar	QA
Réunion	RE
Romania	RO
Russian Federation	RU
Rwanda	RW
Saint Barthélemy	BL
Saint Helena, Ascension and Tristan da Cunha	SH
Saint Kitts and Nevis	KN
Saint Lucia	LC
Saint Martin (French part)	MF
Saint Pierre and Miquelon	PM
Saint Vincent and the Grenadines	VC
Samoa	WS
San Marino	SM
Sao Tome and Principe	ST
Saudi Arabia	SA
Senegal	SN
Serbia	RS
Seychelles	SC
Sierra Leone	SL
Singapore	SG
Sint Maarten (Dutch part)	SX
Slovakia	SK
Slovenia	SI
Solomon Islands	SB
Somalia	SO
South Africa	ZA
South Georgia and the South Sandwich Islands	GS
South Sudan	SS
Spain	ES
Sri Lanka	LK
Sudan	SD
Suriname	SR
Svalbard and Jan Mayen	SJ
Swaziland	SZ
Sweden	SE
Switzerland	CH
Syrian Arab Republic	SY
Taiwan, Province of China	TW
Tajikistan	TJ
Tanzania, United Republic of	TZ
Thailand	TH
Timor-Leste	TL
Togo	TG
Tokelau	TK
Tonga	TO
Trinidad and Tobago	TT
Tunisia	TN
Turkey	TR
Turkmenistan	TM
Turks and Caicos Islands	TC
Tuvalu	TV
Uganda	UG
Ukraine	UA
United Arab Emirates	AE
United Kingdom	GB
United States	US
United States Minor Outlying Islands	UM
Uruguay	UY
Uzbekistan	UZ
Vanuatu	VU
Venezuela, Bolivarian Republic of	VE
Viet Nam	VN
Virgin Islands, British	VG
Virgin Islands, U.S.	VI
Wallis and Futuna	WF
Western Sahara	EH
Yemen	YE
Zambia	ZM
Zimbabwe	ZW
\.


--
-- Data for Name: manufacturer; Type: TABLE DATA; Schema: public; Owner: arobson
--

COPY manufacturer (id, name, company_web_url, year_established, notes, discontinued, wikipedia_url, market_size, country, bike_index_id) FROM stdin;
5913	Answer BMX		\N	\N	\N	\N	\N	\N	394
5914	Apollo	http://www.apollobikes.com/	\N	\N	\N	\N	\N	\N	1099
5915	Aqua Sphere		\N	\N	\N	\N	\N	\N	396
5916	Aquamira		\N	\N	\N	\N	\N	\N	397
5917	Arai		\N	\N	\N	\N	\N	\N	398
5918	Ares	http://www.aresbikes.com/	\N	\N	\N	\N	\N	\N	1379
5919	Argon 18	http://www.argon18bike.com/velo.html	\N	\N	\N	\N	\N	\N	32
5920	Asama	http://www.asamabicycles.com/	\N	\N	\N	\N	\N	\N	1081
5921	Assos		\N	\N	\N	\N	\N	\N	399
5922	Atala		\N	\N	\N	\N	\N	\N	17
5923	Atomlab	http://www.atomlab.com/	\N	\N	\N	\N	\N	\N	400
5924	Author	http://www.author.eu/	\N	\N	\N	\N	\N	\N	33
5925	Avalon	http://www.walmart.com/	\N	\N	\N	\N	\N	\N	1126
5926	Avanti	http://www.avantibikes.com/nz/	\N	\N	\N	\N	\N	\N	34
5927	Aventón	http://aventonbikes.com/	\N	\N	\N	\N	\N	\N	1059
5928	Avid		\N	\N	\N	\N	\N	\N	401
5929	Axiom		\N	\N	\N	\N	\N	\N	402
5930	Axle Release		\N	\N	\N	\N	\N	\N	403
5931	Azonic	http://www.oneal.com/index.php/home/azonic-prime	\N	\N	\N	\N	\N	\N	1156
5932	Azor	http://www.azor.nl/	\N	\N	\N	\N	\N	\N	1120
5933	Aztec		\N	\N	\N	\N	\N	\N	404
5934	Azzuri	http://www.azzurribikes.com/	\N	\N	\N	\N	\N	\N	1101
5935	BCA		\N	\N	\N	\N	\N	\N	410
5936	BH Bikes (Beistegui Hermanos)	http://bhbikes-us.com	\N	\N	\N	\N	\N	\N	36
5937	BMC	http://www.bmc-racing.com	\N	\N	\N	\N	\N	\N	359
5938	BOB	http://www.bobgear.com/bike-trailers	\N	\N	\N	\N	\N	\N	424
5939	BONT		\N	\N	\N	\N	\N	\N	429
5940	BOX		\N	\N	\N	\N	\N	\N	431
5941	BSD		\N	\N	\N	\N	\N	\N	437
5942	BSP	http://www.bsp-fietsen.nl/	\N	\N	\N	\N	\N	\N	1491
5943	BULLS Bikes	http://www.bullsbikesusa.com/	\N	\N	\N	\N	\N	\N	1402
5944	Bacchetta	http://www.bacchettabikes.com/	\N	\N	\N	\N	\N	\N	989
5945	Backpacker's Pantry		\N	\N	\N	\N	\N	\N	405
5946	Backward Circle	http://www.backwardcircle.com/	\N	\N	\N	\N	\N	\N	1025
5947	Badger Bikes	http://www.badgerbikes.com/	\N	\N	\N	\N	\N	\N	1486
5948	Bahco		\N	\N	\N	\N	\N	\N	406
5949	Bailey	http://www.bailey-bikes.com	\N	\N	\N	\N	\N	\N	958
5950	Baladeo		\N	\N	\N	\N	\N	\N	407
5951	Bamboocycles	http://bamboocycles.com/	\N	\N	\N	\N	\N	\N	1307
5952	Banjo Brothers		\N	\N	\N	\N	\N	\N	408
5953	Banshee Bikes	http://www.bansheebikes.com	\N	\N	\N	\N	\N	\N	1066
5954	Bantam (Bantam Bicycle Works)	http://www.bantambicycles.com/	\N	\N	\N	\N	\N	\N	1362
5955	Bar Mitts		\N	\N	\N	\N	\N	\N	409
5956	Barracuda	http://www.barracudabikes.co.uk/	\N	\N	\N	\N	\N	\N	1134
5957	Basso	http://www.bassobikes.com/	\N	\N	\N	\N	\N	\N	35
5958	Stevens	http://www.stevensbikes.de/2014/index.php	\N	\N	\N	\N	\N	\N	1108
5959	Stevenson Custom Bicycles	http://stevensoncustombikes.com/	\N	\N	\N	\N	\N	\N	1229
5960	Stinner	http://www.stinnerframeworks.com/	\N	\N	\N	\N	\N	\N	1482
5961	Stoemper	http://stoemper.com/	\N	\N	\N	\N	\N	\N	960
5962	Stolen Bicycle Co.		\N	\N	\N	\N	\N	\N	352
5963	Stop Flats 2		\N	\N	\N	\N	\N	\N	817
5964	Strada Customs	http://www.stradacustoms.com	\N	\N	\N	\N	\N	\N	939
5965	Stradalli Cycles	http://www.carbonroadbikebicyclecycling.com/	\N	\N	\N	\N	\N	\N	1210
5966	Straitline		\N	\N	\N	\N	\N	\N	818
5967	Strawberry Bicycle	http://www.strawberrybicycle.com/	\N	\N	\N	\N	\N	\N	1382
5968	Strida		\N	\N	\N	\N	\N	\N	314
5969	Strider	http://www.striderbikes.com/	\N	\N	\N	\N	\N	\N	819
5970	Stromer	http://www.stromerbike.com/en/us	\N	\N	\N	\N	\N	\N	1243
5971	Strong Frames	http://www.strongframes.com/	\N	\N	\N	\N	\N	\N	1177
5972	Sturmey-Archer		\N	\N	\N	\N	\N	\N	820
5973	Stålhästen	http://www.stalhasten.eu/st%C3%A5lh%C3%A4sten	\N	\N	\N	\N	\N	\N	1072
5974	Subrosa	http://subrosabrand.com/	\N	\N	\N	\N	\N	\N	821
5975	Suelo		\N	\N	\N	\N	\N	\N	822
5976	Sugino		\N	\N	\N	\N	\N	\N	823
5977	Sun		\N	\N	\N	\N	\N	\N	315
5978	Sun Ringle		\N	\N	\N	\N	\N	\N	824
5979	SunRace	http://www.sunrace.com/	\N	\N	\N	\N	\N	\N	825
5980	Sunday	http://www.sundaybikes.com	\N	\N	\N	\N	\N	\N	355
5981	Sunn	https://www.facebook.com/sunn.bicycle	\N	\N	\N	\N	\N	\N	1086
5982	Suomi		\N	\N	\N	\N	\N	\N	826
5983	Supercross	http://www.supercrossbmx.com/	\N	\N	\N	\N	\N	\N	1496
5984	Superfeet		\N	\N	\N	\N	\N	\N	827
5985	Supernova		\N	\N	\N	\N	\N	\N	828
5986	Surly	http://surlybikes.com	\N	\N	\N	\N	\N	\N	112
5987	Surrey	http://www.internationalsurreyco.com	\N	\N	\N	\N	\N	\N	1191
5988	Sutherlands		\N	\N	\N	\N	\N	\N	829
5989	Suunto		\N	\N	\N	\N	\N	\N	830
5990	Suzuki		\N	\N	\N	\N	\N	\N	318
5991	Sweetpea Bicycles	http://www.sweetpeabicycles.com/	\N	\N	\N	\N	\N	\N	1252
5992	Swingset	http://www.swingsetbicycles.com/	\N	\N	\N	\N	\N	\N	1275
5993	Swix		\N	\N	\N	\N	\N	\N	832
5994	Swobo	http://shop.swobo.com/	\N	\N	\N	\N	\N	\N	963
5995	SyCip	http://sycip.com/	\N	\N	\N	\N	\N	\N	1234
5996	Syncros	http://www.syncros.com/syncros/us/en/	\N	\N	\N	\N	\N	\N	1504
5997	Syntace		\N	\N	\N	\N	\N	\N	833
5998	T Mat Pro		\N	\N	\N	\N	\N	\N	834
5999	TET Cycles (Tom Teesdale Bikes)	http://tetcycles.com/	\N	\N	\N	\N	\N	\N	1232
6000	TH Industries		\N	\N	\N	\N	\N	\N	842
6001	TI Cycles of India		\N	\N	\N	\N	\N	\N	323
6002	TRP		\N	\N	\N	\N	\N	\N	864
6003	TYR		\N	\N	\N	\N	\N	\N	870
6004	Tacx	https://www.tacx.com/	\N	\N	\N	\N	\N	\N	835
6005	Takara	http://takarabikes.com/	\N	\N	\N	\N	\N	\N	949
6006	Talisman		\N	\N	\N	\N	\N	\N	1037
6007	Tallac	http://tallachouse.com/	\N	\N	\N	\N	\N	\N	1370
6008	Tamer		\N	\N	\N	\N	\N	\N	836
6009	Tange-Seiki		\N	\N	\N	\N	\N	\N	837
6010	Tangent Products		\N	\N	\N	\N	\N	\N	838
6011	Tati Cycles	http://taticycles.com/	\N	\N	\N	\N	\N	\N	1209
6012	Taylor Bicycles (Paul Taylor)	http://taylorbicycles.blogspot.com/	\N	\N	\N	\N	\N	\N	1294
6013	Tec Labs		\N	\N	\N	\N	\N	\N	839
6014	Tektro		\N	\N	\N	\N	\N	\N	840
6015	Tern	http://www.ternbicycles.com/us/	\N	\N	\N	\N	\N	\N	976
6016	Terra Trike	http://www.terratrike.com/	\N	\N	\N	\N	\N	\N	1306
6017	Terrible One	http://www.terribleone.com	\N	\N	\N	\N	\N	\N	1299
6018	Terrot		\N	\N	\N	\N	\N	\N	319
6019	Terry	http://www.terrybicycles.com/	\N	\N	\N	\N	\N	\N	841
6020	The Arthur Pequegnat Clock Company		\N	\N	\N	\N	\N	\N	37
6808	Alps	\N	\N	\N	f	\N	\N	\N	\N
6809	Amanda (Tokyo)	\N	\N	\N	f	\N	\N	\N	\N
6810	Amuna (written "AMVNA", manufactured by Matsumoto Cycle, Sendai)	\N	\N	\N	f	\N	\N	\N	\N
6811	A.N. Design Works (Core Japan, Tokyo)	\N	\N	\N	f	\N	\N	\N	\N
6812	Araya	\N	\N	\N	f	\N	\N	\N	\N
6813	ARES	\N	\N	\N	f	\N	\N	\N	\N
6814	Asuka (Nara)	\N	\N	\N	f	\N	\N	\N	\N
6815	Baramon (Kurume)	\N	\N	\N	f	\N	\N	\N	\N
6816	Cateye	\N	\N	\N	f	\N	\N	\N	\N
6817	Cherubim (Machida, Tokyo)	\N	\N	\N	f	\N	\N	\N	\N
6818	Crafted (Fukui)	\N	\N	\N	f	\N	\N	\N	\N
6819	Deki	\N	\N	\N	f	\N	\N	\N	\N
6820	Elan	\N	\N	\N	f	\N	\N	\N	\N
6821	Emme Akko (Miyako)	\N	\N	\N	f	\N	\N	\N	\N
6823	Fury	\N	\N	\N	f	\N	\N	\N	\N
6824	Ganwell (Kyoto)	\N	\N	\N	f	\N	\N	\N	\N
6825	Hirose (Kodaira, Tokyo)	\N	\N	\N	f	\N	\N	\N	\N
6826	Holks	\N	\N	\N	f	\N	\N	\N	\N
6827	Honjo (Tottori)	\N	\N	\N	f	\N	\N	\N	\N
6828	Ikesho	\N	\N	\N	f	\N	\N	\N	\N
6829	Iribe (Nara)	\N	\N	\N	f	\N	\N	\N	\N
6830	Kalavinka (made by Tsukumo, Tokyo)	\N	\N	\N	f	\N	\N	\N	\N
6831	Kusano Engineering (Tokyo)	\N	\N	\N	f	\N	\N	\N	\N
6832	Mikado	\N	\N	\N	f	\N	\N	\N	\N
6833	Kiyo Miyazawa (Tokyo)	\N	\N	\N	f	\N	\N	\N	\N
6834	Miyuki (Tokyo)	\N	\N	\N	f	\N	\N	\N	\N
6837	Nakagawa (Osaka)	\N	\N	\N	f	\N	\N	\N	\N
6838	Nakamichi	\N	\N	\N	f	\N	\N	\N	\N
6839	Ono	\N	\N	\N	f	\N	\N	\N	\N
6840	Polaris	\N	\N	\N	f	\N	\N	\N	\N
6841	Project M (Tsukuba, Ibaraki)	\N	\N	\N	f	\N	\N	\N	\N
6842	Raizin (Kiryu, Gunma)	\N	\N	\N	f	\N	\N	\N	\N
6843	Ravanello (made by Takamura, Tokyo)	\N	\N	\N	f	\N	\N	\N	\N
6844	Reminton	\N	\N	\N	f	\N	\N	\N	\N
6845	Sannow	\N	\N	\N	f	\N	\N	\N	\N
6846	Shimazaki (Tokyo)	\N	\N	\N	f	\N	\N	\N	\N
6847	Silk	\N	\N	\N	f	\N	\N	\N	\N
6848	Smith	\N	\N	\N	f	\N	\N	\N	\N
6849	Suntour	\N	\N	\N	f	\N	\N	\N	\N
6850	Tano	\N	\N	\N	f	\N	\N	\N	\N
6851	Toei (Kawaguchi, Saitama)	\N	\N	\N	f	\N	\N	\N	\N
6852	Tokyobike	\N	\N	\N	f	\N	\N	\N	\N
6853	Tsunoda (Nagoya, Japan — also manufactured Lotus brand)	\N	\N	\N	f	\N	\N	\N	\N
6854	Tubagra	\N	\N	\N	f	\N	\N	\N	\N
6855	Vigore (Kyoto)	\N	\N	\N	f	\N	\N	\N	\N
6856	Vlaams	\N	\N	\N	f	\N	\N	\N	\N
6857	Vogue (made by Orient, Kamakura)	\N	\N	\N	f	\N	\N	\N	\N
6858	Zebrakenko	\N	\N	\N	f	\N	\N	\N	\N
6859	Zunow (Osaka)	\N	\N	\N	f	\N	\N	\N	\N
6867	SunTour	\N	\N	\N	f	\N	\N	\N	\N
5586	Giant	http://www.giant-bicycles.com/	\N	\N	\N	\N	\N	\N	153
6021	The Bicycle Forge	http://www.bicycleforge.com/	\N	\N	\N	\N	\N	\N	1080
6022	The Hive		\N	\N	\N	\N	\N	\N	844
6023	Thinksport		\N	\N	\N	\N	\N	\N	846
6024	Thomson		\N	\N	\N	\N	\N	\N	847
6025	Thorn Cycles		\N	\N	\N	\N	\N	\N	321
6026	Throne Cycles	http://thronecycles.com/	\N	\N	\N	\N	\N	\N	1386
6027	Thruster	http://walmart.com	\N	\N	\N	\N	\N	\N	1161
6028	Thule	http://www.thule.com	\N	\N	\N	\N	\N	\N	848
6029	Ti Cycles	http://ticycles.com/	\N	\N	\N	\N	\N	\N	985
6030	Tigr	http://tigrlock.com	\N	\N	\N	\N	\N	\N	111
6031	Timbuk2		\N	\N	\N	\N	\N	\N	849
6032	Time	http://www.time-sport.com/	\N	\N	\N	\N	\N	\N	850
6033	Timex		\N	\N	\N	\N	\N	\N	851
6034	Tioga		\N	\N	\N	\N	\N	\N	852
6035	Titan	http://www.titanracingbikes.com/	\N	\N	\N	\N	\N	\N	991
6036	Titus	http://www.titusti.com	\N	\N	\N	\N	\N	\N	1043
6037	Toko		\N	\N	\N	\N	\N	\N	853
6038	Tomac	http://www.tomac.com.au/	\N	\N	\N	\N	\N	\N	1380
6039	Tommasini	http://tommasinibicycle.com/	\N	\N	\N	\N	\N	\N	1162
6040	Tommaso	http://tommasobikes.com/	\N	\N	\N	\N	\N	\N	970
6041	Tony Hawk	http://www.toysrus.com/	\N	\N	\N	\N	\N	\N	1164
6042	Topeak		\N	\N	\N	\N	\N	\N	854
6043	TorHans		\N	\N	\N	\N	\N	\N	855
6044	Torelli	http://www.torelli.com/	\N	\N	\N	\N	\N	\N	1145
6045	Torker		\N	\N	\N	\N	\N	\N	324
6046	Tour de France	http://cyclefg.com/	\N	\N	\N	\N	\N	\N	1163
6047	Tout Terrain	http://www.en.tout-terrain.de/	\N	\N	\N	\N	\N	\N	1505
6048	Toyo	http://toyoframe.com/	\N	\N	\N	\N	\N	\N	1342
6049	Traitor	http://www.traitorcycles.com	\N	\N	\N	\N	\N	\N	1271
6050	Transit	http://www.performancebike.com/bikes/CategoryDisplay?catalogId=10551&storeId=10052&categoryId=400763&langId=-1&parent_category_rn=400345&top_category=400345&pageView=	\N	\N	\N	\N	\N	\N	1273
6051	Transition Bikes	http://www.transitionbikes.com/	\N	\N	\N	\N	\N	\N	1019
6052	Tranz-X		\N	\N	\N	\N	\N	\N	856
6053	Trayl	http://traylcycling.com/	\N	\N	\N	\N	\N	\N	1400
6054	Tree		\N	\N	\N	\N	\N	\N	857
6055	Trek	http://www.trekbikes.com/us/en/	\N	\N	\N	\N	A	\N	47
6056	Tressostar		\N	\N	\N	\N	\N	\N	858
6057	TriFlow		\N	\N	\N	\N	\N	\N	859
6058	Profile Design		\N	\N	\N	\N	\N	\N	727
6059	Profile Racing		\N	\N	\N	\N	\N	\N	728
6060	Prologo		\N	\N	\N	\N	\N	\N	730
6061	Promax		\N	\N	\N	\N	\N	\N	731
6062	Propain	https://www.propain-bikes.com/	\N	\N	\N	\N	\N	\N	1503
6063	Prophete	http://www.prophete.de/	\N	\N	\N	\N	\N	\N	272
6064	Puch	http://www.puch.at/	\N	\N	\N	\N	\N	\N	88
6065	Pure City	http://purecitycycles.com/	\N	\N	\N	\N	\N	\N	1394
6066	Pure Fix	http://purefixcycles.com/	\N	\N	\N	\N	\N	\N	947
6067	Python	http://www.pythonbikes.com/	\N	\N	\N	\N	\N	\N	1045
6068	Python Pro	http://pythonpro.dk/	\N	\N	\N	\N	\N	\N	1298
6069	Q-Outdoor		\N	\N	\N	\N	\N	\N	732
6070	Q-Tubes		\N	\N	\N	\N	\N	\N	733
6071	QBP		\N	\N	\N	\N	\N	\N	734
6072	Quadrant Cycle Company		\N	\N	\N	\N	\N	\N	273
6073	Quest		\N	\N	\N	\N	\N	\N	736
6074	Quik Stik		\N	\N	\N	\N	\N	\N	737
6075	Quintana Roo	http://www.quintanarootri.com/	\N	\N	\N	\N	\N	\N	275
6076	R12		\N	\N	\N	\N	\N	\N	738
6077	RIH	http://www.rih.nl	\N	\N	\N	\N	\N	\N	1001
6078	RPM		\N	\N	\N	\N	\N	\N	760
6079	RRB (Rat Rod Bikes)	https://www.facebook.com/ratrodbikescom	\N	\N	\N	\N	\N	\N	945
6080	RST		\N	\N	\N	\N	\N	\N	761
6081	Rabeneick	http://www.rabeneick.de/bikes/	\N	\N	\N	\N	\N	\N	1296
6082	RaceFace		\N	\N	\N	\N	\N	\N	739
6083	Racktime		\N	\N	\N	\N	\N	\N	740
6084	Radio Bike Co	http://www.radiobikes.com/	\N	\N	\N	\N	\N	\N	1388
6085	Radio Flyer	http://www.radioflyer.com/trikes.html	\N	\N	\N	\N	\N	\N	276
6086	Raleigh	http://www.raleighusa.com/	\N	\N	\N	\N	A	\N	277
6087	Ram	http://www.ram-bikes.com/eng/	\N	\N	\N	\N	\N	\N	997
6088	Rambler	http://en.wikipedia.org/wiki/Rambler_(bicycle)	\N	\N	\N	\N	\N	\N	278
6089	Rans Designs	http://www.rans.com/	\N	\N	\N	\N	\N	\N	279
6090	RavX	http://ravx.com/	\N	\N	\N	\N	\N	\N	1409
6091	Rawland Cycles	https://www.rawlandcycles.com/	\N	\N	\N	\N	\N	\N	1078
6092	Razor	http://www.razor.com/	\N	\N	\N	\N	\N	\N	280
6093	ReTale		\N	\N	\N	\N	\N	\N	745
6094	Redline	http://www.redlinebicycles.com	\N	\N	\N	\N	\N	\N	955
6095	Redlof		\N	\N	\N	\N	\N	\N	1041
6096	Reflect Sports		\N	\N	\N	\N	\N	\N	741
6097	Regina	http://www.reginabikes.it/	\N	\N	\N	\N	\N	\N	1076
6098	Rema		\N	\N	\N	\N	\N	\N	742
6099	Renthal		\N	\N	\N	\N	\N	\N	743
6100	René Herse	http://www.renehersebicycles.com/	\N	\N	\N	\N	\N	\N	170
6101	Republic	http://www.republicbike.com/	\N	\N	\N	\N	\N	\N	971
6102	Republic of China		\N	\N	\N	\N	\N	\N	254
6103	Resist		\N	\N	\N	\N	\N	\N	744
6104	Retrospec	http://www.retrospecbicycles.com/	\N	\N	\N	\N	\N	\N	1180
6105	Revelate Designs		\N	\N	\N	\N	\N	\N	746
5315	Batavus	http://www.batavus.com/	\N	\N	\N	\N	\N	\N	18
5316	Bazooka	http://www.bazookasports.com/	\N	\N	\N	\N	\N	\N	1223
5317	BeOne	http://www.beone-bikes.com/	\N	\N	\N	\N	\N	\N	1044
5318	Beater Bikes	http://beaterbikes.net/	\N	\N	\N	\N	\N	\N	1024
5319	Bell		\N	\N	\N	\N	\N	\N	1235
5320	Bellwether		\N	\N	\N	\N	\N	\N	411
5321	Benotto		\N	\N	\N	\N	\N	\N	1110
5322	Bergamont	http://www.bergamont.de/	\N	\N	\N	\N	\N	\N	1031
5323	Bertoni		\N	\N	\N	\N	\N	\N	1383
5324	Bertucci		\N	\N	\N	\N	\N	\N	412
5325	Bianchi	http://www.bianchi.com/	\N	\N	\N	\N	A	\N	129
5326	Bickerton		\N	\N	\N	\N	\N	\N	39
5327	Bicycle Research		\N	\N	\N	\N	\N	\N	413
5328	Big Agnes Inc		\N	\N	\N	\N	\N	\N	414
5329	Big Cat Bikes	http://www.bigcatbikes.com/	\N	\N	\N	\N	\N	\N	1501
5330	Big Shot	http://www.bigshotbikes.com/	\N	\N	\N	\N	\N	\N	1152
5331	Bike Fit Systems		\N	\N	\N	\N	\N	\N	415
5332	Bike Friday	http://bikefriday.com/	\N	\N	\N	\N	\N	\N	40
5333	Bike Mielec	http://www.bikemielec.com/	\N	\N	\N	\N	\N	\N	1017
5334	Bike Ribbon		\N	\N	\N	\N	\N	\N	416
5335	Bike-Aid		\N	\N	\N	\N	\N	\N	417
5336	Bike-Eye		\N	\N	\N	\N	\N	\N	418
5337	Bike-O-Vision		\N	\N	\N	\N	\N	\N	419
5338	Bike4Life		\N	\N	\N	\N	\N	\N	1148
5339	BikeE recumbents		\N	\N	\N	\N	\N	\N	1100
5340	Bikes Belong		\N	\N	\N	\N	\N	\N	420
5341	Bikeverywhere		\N	\N	\N	\N	\N	\N	421
5342	Bilenky Cycle Works	http://www.bilenky.com/Home.html	\N	\N	\N	\N	\N	\N	41
5343	Biomega	http://biomega.dk/biomega.aspx	\N	\N	\N	\N	\N	\N	42
5344	BionX		\N	\N	\N	\N	\N	\N	422
5345	Birdy	http://www.birdybike.com/	\N	\N	\N	\N	\N	\N	255
5346	Biria	http://www.biria.com/	\N	\N	\N	\N	\N	\N	944
5347	Birmingham Small Arms Company		\N	\N	\N	\N	\N	\N	43
5348	Bishop	http://bishopbikes.com/	\N	\N	\N	\N	\N	\N	1350
5349	Black Diamond		\N	\N	\N	\N	\N	\N	423
5350	Black Market	http://www.blackmarketbikes.com	\N	\N	\N	\N	\N	\N	109
5351	Black Mountain Cycles	http://www.blackmtncycles.com/	\N	\N	\N	\N	\N	\N	1178
5352	Black Sheep Bikes	http://blacksheepbikes.com/	\N	\N	\N	\N	\N	\N	1034
5353	Blix	http://blixbike.com/	\N	\N	\N	\N	\N	\N	1512
5354	Blue (Blue Competition Cycles)	http://www.rideblue.com/	\N	\N	\N	\N	\N	\N	1167
5355	Blue Sky Cycle Carts	http://blueskycyclecarts.com/	\N	\N	\N	\N	\N	\N	1506
5356	Boardman Bikes	http://www.boardmanbikes.com/	\N	\N	\N	\N	\N	\N	44
5357	Bobbin	http://www.bobbinbikes.co.uk/	\N	\N	\N	\N	\N	\N	1032
5358	BodyGlide		\N	\N	\N	\N	\N	\N	425
5359	Boeshield		\N	\N	\N	\N	\N	\N	426
5360	Bohemian Bicycles	http://www.bohemianbicycles.com/	\N	\N	\N	\N	\N	\N	45
5361	Bondhus		\N	\N	\N	\N	\N	\N	427
5362	Bonk Breaker		\N	\N	\N	\N	\N	\N	428
5363	Boo Bicycles	http://boobicycles.com/	\N	\N	\N	\N	\N	\N	1286
5364	Boreal	http://borealbikes.com/	\N	\N	\N	\N	\N	\N	1304
5365	Borealis (fat bikes)	http://www.fatbike.com/	\N	\N	\N	\N	\N	\N	1305
5366	Boreas Gear		\N	\N	\N	\N	\N	\N	430
5367	Borile	http://www.borile.it/gb_chi.html	\N	\N	\N	\N	\N	\N	48
5368	Bottecchia	http://www.bottecchia.co.uk/	\N	\N	\N	\N	\N	\N	49
5369	Boulder Bicycles	http://www.renehersebicycles.com/Randonneur%20bikes.htm	\N	\N	\N	\N	\N	\N	1016
5370	Box Bike Collective	http://www.boxbikecollective.com/	\N	\N	\N	\N	\N	\N	1485
5371	Brannock Device Co.		\N	\N	\N	\N	\N	\N	432
5372	Brasil & Movimento	http://www.brasilemovimento.com.br	\N	\N	\N	\N	\N	\N	51
5373	Brave Soldier		\N	\N	\N	\N	\N	\N	433
5374	Breadwinner	http://breadwinnercycles.com/	\N	\N	\N	\N	\N	\N	1354
5375	Breakbrake17 Bicycle Co.	http://breakbrake17.com/	\N	\N	\N	\N	\N	\N	1363
5376	Breezer	http://www.breezerbikes.com/	\N	\N	\N	\N	B	\N	941
5377	Brennabor	http://brennabor.pl/	\N	\N	\N	\N	\N	\N	52
5378	Bridgestone	http://www.bridgestone.com/	\N	\N	\N	\N	B	\N	53
5379	Brilliant Bicycle	http://brilliant.co/	\N	\N	\N	\N	\N	\N	1381
5380	British Eagle		\N	\N	\N	\N	\N	\N	54
5381	Broakland	http://www.broakland.com/	\N	\N	\N	\N	\N	\N	1483
5382	Brodie	http://www.brodiebikes.com/2014/	\N	\N	\N	\N	\N	\N	1128
5383	Broke Bikes	https://brokebik.es/	\N	\N	\N	\N	\N	\N	1246
5384	Brompton Bicycle	http://www.brompton.co.uk/	\N	\N	\N	\N	\N	\N	55
5385	Brooklyn Bicycle Co.	http://www.brooklynbicycleco.com/	\N	\N	\N	\N	\N	\N	1098
5386	Brooks England LTD.	http://www.brooksengland.com/	\N	\N	\N	\N	\N	\N	435
5387	Browning		\N	\N	\N	\N	\N	\N	1239
5388	Brunswick Corporation	http://www.brunswick.com/	\N	\N	\N	\N	\N	\N	56
5389	Brush Research		\N	\N	\N	\N	\N	\N	436
5390	Budnitz	http://budnitzbicycles.com/	\N	\N	\N	\N	\N	\N	1265
5391	Buff		\N	\N	\N	\N	\N	\N	438
5392	Burley		\N	\N	\N	\N	\N	\N	439
5393	Burley Design	http://www.burley.com/	\N	\N	\N	\N	\N	\N	57
5394	Bushnell		\N	\N	\N	\N	\N	\N	440
5395	Buzzy's		\N	\N	\N	\N	\N	\N	441
5396	CCM		\N	\N	\N	\N	\N	\N	271
5397	CDI Torque Products		\N	\N	\N	\N	\N	\N	450
5398	CETMA Cargo	http://cetmacargo.com/	\N	\N	\N	\N	\N	\N	1369
5399	CHUMBA Racing	http://chumbabikes.com/	\N	\N	\N	\N	\N	\N	72
5400	CRUD		\N	\N	\N	\N	\N	\N	468
5401	CST		\N	\N	\N	\N	\N	\N	469
5402	CVLN (Civilian)	http://www.ridecvln.com/	\N	\N	\N	\N	\N	\N	1093
5403	CX Tape		\N	\N	\N	\N	\N	\N	471
5404	Caffelatex		\N	\N	\N	\N	\N	\N	442
5405	Calcott Brothers		\N	\N	\N	\N	\N	\N	58
5406	Calfee Design	http://www.calfeedesign.com/	\N	\N	\N	\N	\N	\N	59
5407	California Springs		\N	\N	\N	\N	\N	\N	443
5408	Caloi	http://www.caloi.com/home/	\N	\N	\N	\N	\N	\N	60
5409	Camelbak	http://www.camelbak.com/	\N	\N	\N	\N	\N	\N	444
5410	Camillus		\N	\N	\N	\N	\N	\N	445
5411	Campagnolo	http://www.campagnolo.com/	\N	\N	\N	\N	\N	\N	446
5412	Campion Cycle Company		\N	\N	\N	\N	\N	\N	61
5413	Cane Creek	http://www.canecreek.com/	\N	\N	\N	\N	\N	\N	447
5414	Canfield Brothers	http://canfieldbrothers.com/	\N	\N	\N	\N	\N	\N	1183
5415	Dawes Cycles	http://www.dawescycles.com/	\N	\N	\N	\N	\N	\N	93
5416	De Rosa	http://www.derosanews.com/	\N	\N	\N	\N	\N	\N	96
5417	DeBernardi	http://www.zarbikes.com/zar/about-debernardi.html	\N	\N	\N	\N	\N	\N	1087
5418	DeFeet		\N	\N	\N	\N	\N	\N	483
5419	DeSalvo Cycles	http://www.desalvocycles.com/	\N	\N	\N	\N	\N	\N	1244
5420	Decathlon	http://www.decathlon.fr	\N	\N	\N	\N	\N	\N	1300
5421	Deco		\N	\N	\N	\N	\N	\N	481
5422	Deda Elementi		\N	\N	\N	\N	\N	\N	482
5423	Deity	http://www.deitycomponents.com/	\N	\N	\N	\N	\N	\N	1008
5424	Del Sol	http://www.ridedelsol.com/bikes	\N	\N	\N	\N	\N	\N	1131
5425	Della Santa	http://dellasanta.com/	\N	\N	\N	\N	\N	\N	1346
5426	Delta		\N	\N	\N	\N	\N	\N	484
5427	Deluxe		\N	\N	\N	\N	\N	\N	485
5428	Demolition		\N	\N	\N	\N	\N	\N	486
5429	Den Beste Sykkel	http://www.dbs.no/	\N	\N	\N	\N	\N	\N	95
5430	Dengfu	http://dengfubikes.com/	\N	\N	\N	\N	\N	\N	1242
5431	Derby Cycle	http://www.derby-cycle.com/en.html	\N	\N	\N	\N	\N	\N	5
5432	Dermatone		\N	\N	\N	\N	\N	\N	487
5433	Dero		\N	\N	\N	\N	\N	\N	488
5434	Detroit Bikes	http://detroitbikes.com/	\N	\N	\N	\N	\N	\N	1206
5435	Deuter		\N	\N	\N	\N	\N	\N	489
5436	Devinci	http://www.devinci.com/home.html	\N	\N	\N	\N	\N	\N	97
5437	Di Blasi Industriale	http://www.diblasi.it/?lng=en	\N	\N	\N	\N	\N	\N	98
5438	Dia-Compe		\N	\N	\N	\N	\N	\N	490
5439	DiaTech		\N	\N	\N	\N	\N	\N	491
5440	Diadora	http://www.diadoraamerica.com/	\N	\N	\N	\N	\N	\N	1237
5441	Diamant	http://www.diamantrad.com/home/	\N	\N	\N	\N	\N	\N	99
5442	Diamondback	http://www.diamondback.com/	\N	\N	\N	\N	A	\N	199
5443	Dicta		\N	\N	\N	\N	\N	\N	492
5444	Dillenger	http://dillengerelectricbikes.com/	\N	\N	\N	\N	\N	\N	1513
5445	Dimension		\N	\N	\N	\N	\N	\N	494
5446	Discwing		\N	\N	\N	\N	\N	\N	495
5447	Doberman	http://dobermannbikes.blogspot.com	\N	\N	\N	\N	\N	\N	1
5448	Dodici Milano	http://www.dodicicicli.com/	\N	\N	\N	\N	\N	\N	967
5449	Dolan	http://www.dolan-bikes.com/	\N	\N	\N	\N	\N	\N	1057
5450	Dorel Industries	http://www.dorel.com/	\N	\N	\N	\N	\N	\N	6
5451	Downtube	http://www.downtube.com	\N	\N	\N	\N	\N	\N	1395
5452	Dual Eyewear		\N	\N	\N	\N	\N	\N	499
5453	Dualco		\N	\N	\N	\N	\N	\N	500
5454	Dynacraft	http://www.dynacraftbike.com/	\N	\N	\N	\N	\N	\N	121
5455	Dynamic Bicycles	http://www.dynamicbicycles.com/	\N	\N	\N	\N	\N	\N	1208
5456	Dyno		\N	\N	\N	\N	\N	\N	927
5457	E-Case		\N	\N	\N	\N	\N	\N	503
5458	E. C. Stearns Bicycle Agency		\N	\N	\N	\N	\N	\N	310
5459	EAI (Euro Asia Imports)	http://www.euroasiaimports.com/aboutus.asp	\N	\N	\N	\N	\N	\N	356
5460	EBC		\N	\N	\N	\N	\N	\N	506
5461	EG Bikes (Metronome)	http://www.egbike.com/	\N	\N	\N	\N	\N	\N	1277
5462	EK USA		\N	\N	\N	\N	\N	\N	508
5463	EMC Bikes	http://www.emcbikes.com/	\N	\N	\N	\N	\N	\N	1200
5464	ENVE Composites		\N	\N	\N	\N	\N	\N	516
5465	ESI		\N	\N	\N	\N	\N	\N	521
5466	EVS Sports		\N	\N	\N	\N	\N	\N	523
5467	EZ Pedaler (EZ Pedaler electric bikes)	http://www.ezpedaler.com/	\N	\N	\N	\N	\N	\N	1356
5468	Eagle Bicycle Manufacturing Company		\N	\N	\N	\N	\N	\N	124
5469	Eagles Nest Outfitters		\N	\N	\N	\N	\N	\N	504
5470	East Germany	http://www.easternbikes.com/dealers/	\N	\N	\N	\N	\N	\N	183
5471	Eastern	http://easternbikes.com/	\N	\N	\N	\N	\N	\N	505
5472	Easton	https://www.eastoncycling.com/	\N	\N	\N	\N	\N	\N	1508
5473	Easy Motion	http://www.emotionbikesusa.com/	\N	\N	\N	\N	\N	\N	1196
5474	Ebisu	http://www.jitensha.com/eng/aboutframes_e.html	\N	\N	\N	\N	\N	\N	973
5475	Eddy Merckx	http://www.eddymerckx.be/	\N	\N	\N	\N	\N	\N	225
5476	Edinburgh Bicycle Co-operative	http://www.edinburghbicycle.com/	\N	\N	\N	\N	\N	\N	1028
5477	EighthInch	http://www.eighthinch.com	\N	\N	\N	\N	\N	\N	1090
5478	Electra	http://www.electrabike.com/	\N	\N	\N	\N	B	\N	125
5479	Elevn Technologies		\N	\N	\N	\N	\N	\N	510
5480	Elite SRL		\N	\N	\N	\N	\N	\N	511
5481	Elliptigo	http://www.elliptigo.com/	\N	\N	\N	\N	\N	\N	1233
5482	Ellis	http://www.elliscycles.com/	\N	\N	\N	\N	\N	\N	1236
5483	Ellis Briggs	http://www.ellisbriggscycles.co.uk/	\N	\N	\N	\N	\N	\N	126
5484	Ellsworth	http://www.ellsworthride.com	\N	\N	\N	\N	A	\N	127
5485	Emilio Bozzi		\N	\N	\N	\N	\N	\N	128
5486	Endurance Films		\N	\N	\N	\N	\N	\N	512
5487	Enduro		\N	\N	\N	\N	\N	\N	513
5488	Endurox		\N	\N	\N	\N	\N	\N	514
5489	Energizer		\N	\N	\N	\N	\N	\N	515
5490	Engin Cycles	http://www.engincycles.com/	\N	\N	\N	\N	\N	\N	1365
5491	Enigma Titanium	http://www.enigmabikes.com/	\N	\N	\N	\N	\N	\N	130
5492	Epic		\N	\N	\N	\N	\N	\N	517
5493	Ergon		\N	\N	\N	\N	\N	\N	519
5494	Erickson Bikes	http://www.ericksonbikes.com/	\N	\N	\N	\N	\N	\N	1498
5495	Esbit		\N	\N	\N	\N	\N	\N	520
5496	Europa	http://www.europacycles.com.au/	\N	\N	\N	\N	\N	\N	1103
5497	Evelo	http://www.evelo.com/	\N	\N	\N	\N	\N	\N	1281
5498	Eveready		\N	\N	\N	\N	\N	\N	522
5499	Evil	http://www.evil-bikes.com	\N	\N	\N	\N	\N	\N	1048
5500	Evo	http://evobicycle.com/	\N	\N	\N	\N	\N	\N	1389
5501	Excess Components		\N	\N	\N	\N	\N	\N	524
5502	Exustar		\N	\N	\N	\N	\N	\N	525
5503	Ezee	http://ezeebike.com/	\N	\N	\N	\N	\N	\N	1407
5504	FBM	http://fbmbmx.com	\N	\N	\N	\N	\N	\N	529
5505	FRAMED	http://www.framedbikes.com/	\N	\N	\N	\N	\N	\N	1269
5506	FSA (Full Speed Ahead)		\N	\N	\N	\N	\N	\N	543
5507	Faggin	http://www.fagginbikes.com/en	\N	\N	\N	\N	\N	\N	1259
5508	Failure	http://www.failurebikes.com/	\N	\N	\N	\N	\N	\N	1009
5509	Fairdale	http://fairdalebikes.com/	\N	\N	\N	\N	\N	\N	526
5510	Falco Bikes	http://www.falcobike.com/	\N	\N	\N	\N	\N	\N	1358
5511	Falcon	http://www.falconcycles.co.uk/CORP/aboutFalcon.html	\N	\N	\N	\N	\N	\N	132
5512	Faraday	http://www.faradaybikes.com/	\N	\N	\N	\N	\N	\N	1256
5513	Fast Wax		\N	\N	\N	\N	\N	\N	528
5514	Fat City Cycles		\N	\N	\N	\N	\N	\N	134
5515	Fatback	http://fatbackbikes.com/	\N	\N	\N	\N	\N	\N	1056
5516	Fausto Coppi		\N	\N	\N	\N	\N	\N	1217
5517	Federal	http://www.federalbikes.com	\N	\N	\N	\N	\N	\N	113
5518	Felt	http://www.feltbicycles.com/	\N	\N	\N	\N	B	\N	136
5519	Fetish	https://www.facebook.com/FetishCycles	\N	\N	\N	\N	\N	\N	1168
5520	Fezzari	http://www.fezzari.com/	\N	\N	\N	\N	\N	\N	1169
5521	FiberFix		\N	\N	\N	\N	\N	\N	530
5522	Fiction		\N	\N	\N	\N	\N	\N	531
5523	Field	http://www.fieldcycles.com/	\N	\N	\N	\N	\N	\N	140
5524	Finish Line		\N	\N	\N	\N	\N	\N	532
5525	Finite		\N	\N	\N	\N	\N	\N	533
5526	Firefly Bicycles	http://fireflybicycles.com/	\N	\N	\N	\N	\N	\N	1376
5527	Firefox	http://www.firefoxbikes.com/	\N	\N	\N	\N	\N	\N	1153
5528	Firenze		\N	\N	\N	\N	\N	\N	1064
5529	Firmstrong	http://www.firmstrong.com/	\N	\N	\N	\N	\N	\N	1065
5530	First Endurance		\N	\N	\N	\N	\N	\N	534
5531	Fit bike Co.		\N	\N	\N	\N	\N	\N	353
5532	Fizik		\N	\N	\N	\N	\N	\N	535
5533	Fleet Velo	http://fleetvelo.com/fv/	\N	\N	\N	\N	\N	\N	370
5534	Fleetwing		\N	\N	\N	\N	\N	\N	138
5535	Flybikes		\N	\N	\N	\N	\N	\N	536
5536	Flying Pigeon	http://flyingpigeon-la.com/	\N	\N	\N	\N	\N	\N	141
5537	Flying Scot	http://www.flying-scot.com/core/welcome.html	\N	\N	\N	\N	\N	\N	142
5538	Flyxii	http://www.flyxii.com/	\N	\N	\N	\N	\N	\N	1378
5539	Focale44	http://www.focale44bikes.com/	\N	\N	\N	\N	\N	\N	966
5540	Focus	http://www.focus-bikes.com/int/en/home.html	\N	\N	\N	\N	\N	\N	143
5541	Foggle		\N	\N	\N	\N	\N	\N	537
5542	Fokhan		\N	\N	\N	\N	\N	\N	1049
5543	Folmer & Schwing		\N	\N	\N	\N	\N	\N	158
5544	Fondriest	http://www.fondriestbici.com	\N	\N	\N	\N	\N	\N	1094
5545	Forge Bikes	http://forgebikes.com/	\N	\N	\N	\N	\N	\N	1079
5546	Formula		\N	\N	\N	\N	\N	\N	538
5547	Fortified (lights)	http://fortifiedbike.com/	\N	\N	\N	\N	\N	\N	1359
5548	Foundry Cycles	http://foundrycycles.com/	\N	\N	\N	\N	\N	\N	539
5549	Fox		\N	\N	\N	\N	\N	\N	540
5550	Fram	http://wsid9d3eg.homepage.t-online.de	\N	\N	\N	\N	\N	\N	146
5551	Frances	http://francescycles.com/	\N	\N	\N	\N	\N	\N	1345
5552	Francesco Moser (F. Moser)	http://www.mosercycles.com/	\N	\N	\N	\N	\N	\N	1221
5553	Freddie Grubb		\N	\N	\N	\N	\N	\N	147
5554	Free Agent	http://www.freeagentbmx.com/	\N	\N	\N	\N	\N	\N	1102
5555	Free Spirit		\N	\N	\N	\N	\N	\N	1172
5556	Freedom		\N	\N	\N	\N	\N	\N	541
5557	Freeload		\N	\N	\N	\N	\N	\N	542
5558	FuelBelt		\N	\N	\N	\N	\N	\N	544
5559	Fuji	http://www.fujibikes.com/	\N	\N	\N	\N	A	\N	101
5560	Fulcrum		\N	\N	\N	\N	\N	\N	545
5561	Fyxation	http://www.fyxation.com/	\N	\N	\N	\N	\N	\N	546
5562	G Sport		\N	\N	\N	\N	\N	\N	547
5563	G-Form		\N	\N	\N	\N	\N	\N	548
5564	GMC		\N	\N	\N	\N	\N	\N	1138
5565	GT Bicycles	http://www.gtbicycles.com/	\N	\N	\N	\N	A	\N	119
5566	GU		\N	\N	\N	\N	\N	\N	568
5567	Gamut		\N	\N	\N	\N	\N	\N	549
5568	Gardin		\N	\N	\N	\N	\N	\N	1014
5569	Garmin		\N	\N	\N	\N	\N	\N	550
5570	Gary Fisher	http://www.trekbikes.com/us/en/collections/gary_fisher/	\N	\N	\N	\N	A	\N	149
5571	Gates Carbon Drive		\N	\N	\N	\N	\N	\N	551
5572	Gateway		\N	\N	\N	\N	\N	\N	552
5573	Gavin	http://www.gavinbikes.com/	\N	\N	\N	\N	\N	\N	1171
5574	Gazelle	http://www.gazelle.us.com/	\N	\N	\N	\N	\N	\N	150
5575	Gear Aid		\N	\N	\N	\N	\N	\N	553
5576	Gear Clamp		\N	\N	\N	\N	\N	\N	554
5577	Gear Up		\N	\N	\N	\N	\N	\N	555
5578	Geax		\N	\N	\N	\N	\N	\N	556
5579	GenZe	http://www.genze.com	\N	\N	\N	\N	\N	\N	1510
5580	Gendron Bicycles	http://www.gendron-bicycles.ca/	\N	\N	\N	\N	\N	\N	151
5581	Genesis	http://www.genesisbikes.co.uk/	\N	\N	\N	\N	\N	\N	1137
5582	Genuine Innovations		\N	\N	\N	\N	\N	\N	557
5583	Geotech	http://www.geotechbikes.com	\N	\N	\N	\N	\N	\N	1303
5584	Gepida	http://www.gepida.eu/	\N	\N	\N	\N	\N	\N	152
5585	Ghost	http://www.ghost-bikes.com	\N	\N	\N	\N	\N	\N	1245
5587	Gibbon Slacklines		\N	\N	\N	\N	\N	\N	558
5588	Gilmour	http://www.gilmourbicycles.us/	\N	\N	\N	\N	\N	\N	1185
5589	Gineyea	http://www.gineyea.com/	\N	\N	\N	\N	\N	\N	1499
5590	Giordano	http://giordanobicycles.com/	\N	\N	\N	\N	\N	\N	1174
5591	Gitane	http://www.gitaneusa.com/	\N	\N	\N	\N	B	\N	86
5592	Glacier Glove		\N	\N	\N	\N	\N	\N	559
5593	Gladiator Cycle Company	http://www.cyclesgladiator.com/	\N	\N	\N	\N	\N	\N	154
5594	Globe	http://www.specialized.com/us/en/bikes/globe	\N	\N	\N	\N	\N	\N	943
5595	Gnome et Rhône		\N	\N	\N	\N	\N	\N	155
5596	GoGirl		\N	\N	\N	\N	\N	\N	560
5597	Gocycle	http://gocycle.com/	\N	\N	\N	\N	\N	\N	1396
5598	Gomier		\N	\N	\N	\N	\N	\N	1288
5599	Gore		\N	\N	\N	\N	\N	\N	561
5600	Gormully & Jeffery		\N	\N	\N	\N	\N	\N	156
5601	Grab On		\N	\N	\N	\N	\N	\N	562
5602	Grabber		\N	\N	\N	\N	\N	\N	563
5603	Graber		\N	\N	\N	\N	\N	\N	564
5604	Graflex	http://graflex.org/	\N	\N	\N	\N	\N	\N	157
5605	Granite Gear		\N	\N	\N	\N	\N	\N	565
5606	Gravity	http://www.bikesdirect.com/	\N	\N	\N	\N	\N	\N	566
5607	Greenfield		\N	\N	\N	\N	\N	\N	567
5608	Greenspeed	http://www.greenspeed.com.au/	\N	\N	\N	\N	\N	\N	1083
5609	Gudereit	http://www.gudereit.de	\N	\N	\N	\N	\N	\N	1266
5610	Guerciotti	http://www.guerciotti.it/	\N	\N	\N	\N	\N	\N	159
5611	Gunnar	http://gunnarbikes.com/site/	\N	\N	\N	\N	\N	\N	986
5612	Guru	http://www.gurucycles.com/en	\N	\N	\N	\N	\N	\N	1193
5613	Guyot Designs		\N	\N	\N	\N	\N	\N	569
5614	H Plus Son		\N	\N	\N	\N	\N	\N	570
5615	Marinoni	http://www.marinoni.qc.ca/indexEN.html	\N	\N	\N	\N	\N	\N	1158
5616	Mars Cycles	http://www.marscycles.com/	\N	\N	\N	\N	\N	\N	1484
5617	Marson		\N	\N	\N	\N	\N	\N	641
5618	Maruishi	http://en.maruishi-bike.com.cn/	\N	\N	\N	\N	\N	\N	1036
5619	Marukin	http://www.marukin-bicycles.com/	\N	\N	\N	\N	\N	\N	1175
5620	Marzocchi		\N	\N	\N	\N	\N	\N	642
5621	Masi	http://www.masibikes.com	\N	\N	\N	\N	B	\N	104
5622	Master Lock	http://www.masterlockbike.com	\N	\N	\N	\N	\N	\N	108
5623	Matchless		\N	\N	\N	\N	\N	\N	220
5624	Matra	http://matra.com/pre-home/?___SID=U	\N	\N	\N	\N	\N	\N	221
5625	Maverick	http://www.maverickbike.com/	\N	\N	\N	\N	\N	\N	1159
5626	Mavic		\N	\N	\N	\N	\N	\N	643
5627	Maxcom	http://maxcombike.com/	\N	\N	\N	\N	\N	\N	1497
5628	Maxit		\N	\N	\N	\N	\N	\N	644
5629	Maxxis		\N	\N	\N	\N	\N	\N	645
5630	Mechanical Threads		\N	\N	\N	\N	\N	\N	646
5631	Meiser		\N	\N	\N	\N	\N	\N	647
5632	Melon Bicycles	http://www.melonbicycles.com/	\N	\N	\N	\N	\N	\N	222
5633	Mercian Cycles	http://www.merciancycles.co.uk/	\N	\N	\N	\N	\N	\N	223
5634	Mercier	http://www.cyclesmercier.com	\N	\N	\N	\N	\N	\N	931
5635	Merida Bikes	http://www.merida.com	\N	\N	\N	\N	\N	\N	65
5636	Merlin	http://www.merlinbike.com/	\N	\N	\N	\N	\N	\N	224
5637	Merrell		\N	\N	\N	\N	\N	\N	648
5638	MetaBikes	http://meta-bikes.com/	\N	\N	\N	\N	\N	\N	988
5639	Metric Hardware		\N	\N	\N	\N	\N	\N	649
5640	Metrofiets	https://metrofiets.com	\N	\N	\N	\N	\N	\N	1364
5641	Micajah C. Henley		\N	\N	\N	\N	\N	\N	167
5642	Micargi	http://micargibicycles.com/	\N	\N	\N	\N	\N	\N	1165
5643	Miche		\N	\N	\N	\N	\N	\N	650
5644	Michelin		\N	\N	\N	\N	\N	\N	651
5645	MicroShift		\N	\N	\N	\N	\N	\N	652
5646	Miele bicycles	http://www.mielebicycles.com/home.html	\N	\N	\N	\N	\N	\N	226
5647	Mikkelsen	http://www.mikkelsenframes.com/	\N	\N	\N	\N	B	\N	1187
5648	Milwaukee Bicycle Co.	http://www.benscycle.net/	\N	\N	\N	\N	\N	\N	227
5649	Minoura		\N	\N	\N	\N	\N	\N	653
5650	MirraCo 	http://mirrabikeco.com/	\N	\N	\N	\N	\N	\N	1012
5651	Mirrycle		\N	\N	\N	\N	\N	\N	654
5652	Mission Bicycles	https://www.missionbicycle.com/	\N	\N	\N	\N	B	\N	990
5653	Miyata	http://www.miyatabicycles.com/	\N	\N	\N	\N	\N	\N	229
5654	Mizutani		\N	\N	\N	\N	\N	\N	1166
5655	Modolo	http://www.modolo.eu/	\N	\N	\N	\N	\N	\N	1398
5656	Momentum	http://www.pedalmomentum.com/	\N	\N	\N	\N	\N	\N	1387
5657	Monark	http://www.monarkexercise.se/	\N	\N	\N	\N	\N	\N	87
5658	Mondia	http://en.wikipedia.org/wiki/Mondia	\N	\N	\N	\N	\N	\N	230
5659	Mondraker	http://www.mondraker.com/	\N	\N	\N	\N	\N	\N	1263
5660	Mongoose	http://www.mongoose.com/	\N	\N	\N	\N	A	\N	118
5661	Montague	http://www.montaguebikes.com/	\N	\N	\N	\N	\N	\N	656
5662	Moots Cycles	http://moots.com/	\N	\N	\N	\N	B	\N	232
5663	Mophie		\N	\N	\N	\N	\N	\N	658
5664	Mosaic	http://mosaiccycles.com/	\N	\N	\N	\N	\N	\N	1351
5665	Moser Cicli	http://www.ciclimoser.com/	\N	\N	\N	\N	\N	\N	233
5666	Mosh		\N	\N	\N	\N	\N	\N	1284
5667	Mosso	http://www.mosso.com.tw/	\N	\N	\N	\N	\N	\N	1302
5668	Moth Attack	http://mothattack.com/	\N	\N	\N	\N	\N	\N	1349
5669	Motiv	http://www.motivelectricbikes.com	\N	\N	\N	\N	\N	\N	984
5670	Motobecane	http://www.motobecane.com/	\N	\N	\N	\N	B	\N	234
5671	Moulden		\N	\N	\N	\N	\N	\N	1050
5672	Moulton Bicycle	http://www.moultonbicycles.co.uk/	\N	\N	\N	\N	\N	\N	235
5673	Mountain Cycles		\N	\N	\N	\N	\N	\N	1283
5674	Mountainsmith		\N	\N	\N	\N	\N	\N	659
5675	Mr. Tuffy		\N	\N	\N	\N	\N	\N	660
5676	Mucky Nutz 	http://muckynutz.com/	\N	\N	\N	\N	\N	\N	1509
5677	Muddy Fox	http://www.muddyfoxusa.com/	\N	\N	\N	\N	\N	\N	237
5678	Murray		\N	\N	\N	\N	\N	\N	236
5679	Mutant Bikes		\N	\N	\N	\N	\N	\N	664
5680	Mutiny	http://www.mutinybikes.com/	\N	\N	\N	\N	\N	\N	1067
5681	Müsing (Musing)	http://www.muesing-bikes.de/	\N	\N	\N	\N	\N	\N	1361
5682	N Gear		\N	\N	\N	\N	\N	\N	665
5683	NEMO		\N	\N	\N	\N	\N	\N	671
5684	NS Bikes	http://www.ns-bikes.com/	\N	\N	\N	\N	\N	\N	1011
5685	Nakamura	http://www.nakamura.no/	\N	\N	\N	\N	\N	\N	1285
5686	Naked	http://timetogetnaked.com/	\N	\N	\N	\N	\N	\N	1250
5687	Nalgene		\N	\N	\N	\N	\N	\N	666
5688	Nantucket Bike Basket Company		\N	\N	\N	\N	\N	\N	667
5689	Nashbar	http://Nashbar.com	\N	\N	\N	\N	\N	\N	957
5690	Nathan		\N	\N	\N	\N	\N	\N	668
5691	National	http://nationalmoto.com/	\N	\N	\N	\N	\N	\N	238
5692	Native		\N	\N	\N	\N	\N	\N	669
5693	Neil Pryde	http://www.neilprydebikes.com/	\N	\N	\N	\N	\N	\N	240
5694	Nema		\N	\N	\N	\N	\N	\N	670
5695	Neobike	http://www.allproducts.com/bike/neobike/	\N	\N	\N	\N	\N	\N	241
5696	New Albion	http://newalbioncycles.com/	\N	\N	\N	\N	\N	\N	1071
5697	New Balance		\N	\N	\N	\N	\N	\N	672
5698	Next	http://next-bike.com/	\N	\N	\N	\N	\N	\N	123
5699	Niner	http://www.ninerbikes.com/	\N	\N	\N	\N	\N	\N	1022
5700	Nirve	http://www.nirve.com/	\N	\N	\N	\N	\N	\N	1176
5701	Nishiki	http://nishiki.com/	\N	\N	\N	\N	\N	\N	243
5702	Nite Ize		\N	\N	\N	\N	\N	\N	673
5703	NiteRider		\N	\N	\N	\N	\N	\N	674
5704	Nitto		\N	\N	\N	\N	\N	\N	675
5705	Nokon		\N	\N	\N	\N	\N	\N	676
5706	Nomad Cargo	https://www.facebook.com/NomadCargo	\N	\N	\N	\N	\N	\N	1408
5707	Norco Bikes	http://www.norco.com/	\N	\N	\N	\N	\N	\N	244
5708	Norman Cycles	http://www.normanmotorcycles.org.uk/	\N	\N	\N	\N	\N	\N	245
5709	North Shore Billet		\N	\N	\N	\N	\N	\N	677
5710	Northrock	http://www.northrockbikes.com/	\N	\N	\N	\N	\N	\N	1021
5711	Novara		\N	\N	\N	\N	\N	\N	246
5712	NuVinci		\N	\N	\N	\N	\N	\N	679
5713	Nukeproof	http://nukeproof.com/	\N	\N	\N	\N	\N	\N	1282
5714	Nymanbolagen		\N	\N	\N	\N	\N	\N	248
5715	Worksman Cycles	http://www.worksmancycles.com/	\N	\N	\N	\N	\N	\N	346
5716	World Jerseys		\N	\N	\N	\N	\N	\N	912
5717	Wright Cycle Company		\N	\N	\N	\N	\N	\N	347
5718	X-Fusion		\N	\N	\N	\N	\N	\N	914
5719	X-Lab		\N	\N	\N	\N	\N	\N	915
5720	X-Treme	http://www.x-tremescooters.com	\N	\N	\N	\N	\N	\N	1077
5721	Xds	http://www.xdsbicycles.com/	\N	\N	\N	\N	\N	\N	1343
5722	Xootr		\N	\N	\N	\N	\N	\N	348
5723	Xpedo		\N	\N	\N	\N	\N	\N	916
5724	Xtracycle	http://www.xtracycle.com/	\N	\N	\N	\N	\N	\N	1007
5725	YST		\N	\N	\N	\N	\N	\N	920
5726	Yakima		\N	\N	\N	\N	\N	\N	917
5727	Yaktrax		\N	\N	\N	\N	\N	\N	918
5728	Yamaguchi Bicycles	http://www.yamaguchibike.com/content/Index	\N	\N	\N	\N	\N	\N	349
5729	Yamaha		\N	\N	\N	\N	\N	\N	350
5730	Yankz		\N	\N	\N	\N	\N	\N	919
5731	Yeti	http://www.yeticycles.com	\N	\N	\N	\N	B	\N	1091
5732	Yuba	http://yubabikes.com/	\N	\N	\N	\N	\N	\N	1003
5733	Yurbuds		\N	\N	\N	\N	\N	\N	921
5734	Zensah		\N	\N	\N	\N	\N	\N	922
5735	Zigo		\N	\N	\N	\N	\N	\N	351
5736	Zinn Cycles	http://zinncycles.com	\N	\N	\N	\N	\N	\N	1215
5737	Zipp Speed Weaponry		\N	\N	\N	\N	\N	\N	923
5738	Zoic		\N	\N	\N	\N	\N	\N	924
5739	Zoom		\N	\N	\N	\N	\N	\N	925
5740	Zoot		\N	\N	\N	\N	\N	\N	926
5741	Zycle Fix	http://zyclefix.com/	\N	\N	\N	\N	\N	\N	1182
5742	b'Twin	http://www.btwin.com/en/home	\N	\N	\N	\N	\N	\N	1073
5743	beixo	http://www.beixo.com/	\N	\N	\N	\N	\N	\N	1368
5744	de Fietsfabriek 	http://www.defietsfabriek.nl/	\N	\N	\N	\N	\N	\N	1122
5745	di Florino		\N	\N	\N	\N	\N	\N	1119
5746	e*thirteen		\N	\N	\N	\N	\N	\N	502
5747	eGear		\N	\N	\N	\N	\N	\N	507
5748	eZip	http://www.currietech.com/	\N	\N	\N	\N	\N	\N	1170
5749	eflow (Currietech)	http://www.currietech.com/	\N	\N	\N	\N	\N	\N	1280
5750	elete		\N	\N	\N	\N	\N	\N	509
5751	epicRIDES		\N	\N	\N	\N	\N	\N	518
6325	Incredibell		\N	\N	\N	\N	\N	\N	596
5752	k.bedford customs	http://www.kbedfordcustoms.com/	\N	\N	\N	\N	\N	\N	1445
5753	liteloc	http://litelok.com/	\N	\N	\N	\N	\N	\N	1401
5754	nuun		\N	\N	\N	\N	\N	\N	678
5755	silverback	http://www.silverbacklab.com/	\N	\N	\N	\N	\N	\N	1479
5756	sixthreezero	http://www.sixthreezero.com/	\N	\N	\N	\N	\N	\N	1006
5757	van Andel/Bakfiets	http://www.bakfiets.nl/	\N	\N	\N	\N	\N	\N	1121
5758	O-Stand		\N	\N	\N	\N	\N	\N	680
5759	O2		\N	\N	\N	\N	\N	\N	681
5760	ODI		\N	\N	\N	\N	\N	\N	682
5761	OHM	http://ohmcycles.com/	\N	\N	\N	\N	\N	\N	1262
5762	Odyssey		\N	\N	\N	\N	\N	\N	683
5763	Ohio Travel Bag		\N	\N	\N	\N	\N	\N	684
5764	Olmo	http://www.olmobikes.com/	\N	\N	\N	\N	\N	\N	1211
5765	Omnium	http://omniumcargo.dk/	\N	\N	\N	\N	\N	\N	1384
5766	On-One (On One)	http://www.on-one.co.uk/	\N	\N	\N	\N	\N	\N	1226
5767	OnGuard		\N	\N	\N	\N	\N	\N	686
5768	One Way		\N	\N	\N	\N	\N	\N	685
5769	Opel	http://opelbikes.com/	\N	\N	\N	\N	\N	\N	249
5770	Optic Nerve		\N	\N	\N	\N	\N	\N	687
5771	Optimus		\N	\N	\N	\N	\N	\N	688
5772	Opus	http://opusbike.com/en/	\N	\N	\N	\N	\N	\N	1074
5773	Orange Seal		\N	\N	\N	\N	\N	\N	689
5774	Orange mountain bikes	http://www.orangebikes.co.uk/	\N	\N	\N	\N	\N	\N	250
5775	Orbea	http://www.orbea.com/us-en/	\N	\N	\N	\N	\N	\N	251
5776	Orbit	http://www.orbit-cycles.co.uk/	\N	\N	\N	\N	\N	\N	980
5777	Orient Bikes	http://www.orient-bikes.gr/en	\N	\N	\N	\N	\N	\N	252
5778	Origin8 (Origin-8)	http://www.origin-8.com/	\N	\N	\N	\N	\N	\N	948
5779	Ortlieb		\N	\N	\N	\N	\N	\N	690
5780	Other		\N	\N	\N	\N	\N	\N	100
5781	Otis Guy	http://www.otisguycycles.com/	\N	\N	\N	\N	\N	\N	1347
5782	Oury		\N	\N	\N	\N	\N	\N	691
5783	OutGo		\N	\N	\N	\N	\N	\N	692
5784	Owl 360		\N	\N	\N	\N	\N	\N	693
5785	Oyama	http://www.oyama.eu/	\N	\N	\N	\N	\N	\N	1033
5786	Ozone		\N	\N	\N	\N	\N	\N	694
5787	PDW		\N	\N	\N	\N	\N	\N	702
5788	POC		\N	\N	\N	\N	\N	\N	715
5789	PUBLIC bikes	http://publicbikes.com/	\N	\N	\N	\N	B	\N	974
5790	Pace Sportswear		\N	\N	\N	\N	\N	\N	695
5791	Paceline Products		\N	\N	\N	\N	\N	\N	696
5792	Pacific Cycle	http://www.pacific-cycles.com/	\N	\N	\N	\N	\N	\N	115
5793	PackTowl		\N	\N	\N	\N	\N	\N	697
5794	Pake	http://www.pakebikes.com	\N	\N	\N	\N	\N	\N	365
5795	Panaracer		\N	\N	\N	\N	\N	\N	698
5796	Panasonic		\N	\N	\N	\N	B	\N	239
5797	Paper Bicycle	http://www.paper-bicycle.com/	\N	\N	\N	\N	\N	\N	1147
5798	Park		\N	\N	\N	\N	\N	\N	699
5799	Parkpre	http://www.parkpre.com/	\N	\N	\N	\N	\N	\N	1023
5800	Parlee	http://www.parleecycles.com	\N	\N	\N	\N	B	\N	700
5801	Pasculli	http://www.pasculli.de	\N	\N	\N	\N	\N	\N	1444
5802	Pashley Cycles	http://www.pashley.co.uk/	\N	\N	\N	\N	\N	\N	256
5803	Patria	http://www.patria.net/en/bicycles/	\N	\N	\N	\N	\N	\N	257
5804	Paul	http://www.paulcomp.com/	\N	\N	\N	\N	\N	\N	701
5805	Pearl Izumi		\N	\N	\N	\N	\N	\N	703
5806	Pedco		\N	\N	\N	\N	\N	\N	704
5807	Pedego	http://www.pedegoelectricbikes.com/	\N	\N	\N	\N	\N	\N	1114
5808	Pedersen bicycle	http://www.pedersenbicycles.com/	\N	\N	\N	\N	\N	\N	258
5809	Pedro's		\N	\N	\N	\N	\N	\N	705
5810	Pegasus	http://www.pegasus-bikes.de/startseite/	\N	\N	\N	\N	\N	\N	1404
5811	Pegoretti	http://www.gitabike.com/cgi-bin/shop/pegoretti_loadhome.cgi?file=pegoretti.html	\N	\N	\N	\N	\N	\N	1142
5812	Penguin Brands		\N	\N	\N	\N	\N	\N	706
5813	Pereira	http://www.pereiracycles.com/	\N	\N	\N	\N	\N	\N	1189
5814	Performance	http://www.performancebike.com/bikes	\N	\N	\N	\N	\N	\N	1061
5815	Peugeot	http://www.peugeot.com/en/products-services/cycles	\N	\N	\N	\N	B	\N	102
5816	Phat Cycles	http://www.phatcycles.com/	\N	\N	\N	\N	\N	\N	1062
5817	Phil Wood		\N	\N	\N	\N	\N	\N	707
5818	Philips		\N	\N	\N	\N	\N	\N	708
5819	Phillips Cycles	http://www.phillipscycles.co.uk/	\N	\N	\N	\N	\N	\N	260
5820	Phoenix	http://www.cccme.org.cn/	\N	\N	\N	\N	\N	\N	261
5821	Phorm		\N	\N	\N	\N	\N	\N	709
5822	Pierce-Arrow	http://www.pierce-arrow.org	\N	\N	\N	\N	\N	\N	262
5823	Pilen	http://www.pilencykel.se/site/en/home	\N	\N	\N	\N	\N	\N	1202
5824	Pinarello	http://www.racycles.com/	\N	\N	\N	\N	\N	\N	263
5825	Pinhead	http://www.pinheadcomponents.com/	\N	\N	\N	\N	\N	\N	710
5826	Pinnacle (Evans Cycles)	https://www.evanscycles.com/pinnacle_b	\N	\N	\N	\N	\N	\N	1511
5827	Pitlock	http://www.pitlock.com/	\N	\N	\N	\N	\N	\N	992
5828	Pivot	http://www.pivotcycles.com/	\N	\N	\N	\N	\N	\N	1105
5829	Planet Bike		\N	\N	\N	\N	\N	\N	711
5830	Planet X	http://www.planet-x-bikes.co.uk/	\N	\N	\N	\N	\N	\N	264
5831	Platypus		\N	\N	\N	\N	\N	\N	712
5832	Pletscher		\N	\N	\N	\N	\N	\N	713
5833	Po Campo		\N	\N	\N	\N	\N	\N	714
5834	Pocket Bicycles		\N	\N	\N	\N	\N	\N	265
5835	Pogliaghi	http://en.wikipedia.org/wiki/Pogliaghi	\N	\N	\N	\N	\N	\N	266
5836	Polar		\N	\N	\N	\N	\N	\N	716
5837	Polar Bottles		\N	\N	\N	\N	\N	\N	717
5838	Polygon	http://www.polygonbikes.com/	\N	\N	\N	\N	\N	\N	1104
5839	Pope Manufacturing Company		\N	\N	\N	\N	\N	\N	267
5840	Power Grips		\N	\N	\N	\N	\N	\N	718
5841	PowerBar		\N	\N	\N	\N	\N	\N	719
5842	PowerTap		\N	\N	\N	\N	\N	\N	720
5843	Premium	http://www.premiumbmx.com/	\N	\N	\N	\N	\N	\N	1141
5844	Price	http://www.price-bikes.ch/	\N	\N	\N	\N	\N	\N	1375
5845	Primal Wear		\N	\N	\N	\N	\N	\N	721
5846	Primo		\N	\N	\N	\N	\N	\N	722
5847	Primus Mootry (PM Cycle Fabrication)	http://www.primusmootry.com/	\N	\N	\N	\N	\N	\N	1340
5848	Princeton Tec		\N	\N	\N	\N	\N	\N	723
5849	Principia	http://www.principia.dk/gb/	\N	\N	\N	\N	\N	\N	975
5850	Priority Bicycles	http://www.prioritybicycles.com/	\N	\N	\N	\N	\N	\N	1390
5851	Private label		\N	\N	\N	\N	\N	\N	211
5852	Pro-tec		\N	\N	\N	\N	\N	\N	724
5853	ProBar		\N	\N	\N	\N	\N	\N	725
5854	ProGold		\N	\N	\N	\N	\N	\N	729
5855	Problem Solvers		\N	\N	\N	\N	\N	\N	726
5856	Procycle Group	http://www.procycle.com/en/default.asp	\N	\N	\N	\N	\N	\N	269
5857	Prodeco	http://prodecotech.com/	\N	\N	\N	\N	\N	\N	1160
5858	24seven	http://www.leisurelakesbikes.com/bikes/bmx-bikes/b/24seven	\N	\N	\N	\N	\N	\N	7
5859	333Fab	http://www.333fab.com/	\N	\N	\N	\N	\N	\N	1410
5860	3G	http://www.3gbikes.com/	\N	\N	\N	\N	\N	\N	1125
5861	3T		\N	\N	\N	\N	B	\N	375
5862	3rd Eye		\N	\N	\N	\N	\N	\N	374
5863	3rensho		\N	\N	\N	\N	\N	\N	1112
5864	45North		\N	\N	\N	\N	\N	\N	376
5865	4ZA		\N	\N	\N	\N	\N	\N	377
5866	6KU	http://6kubikes.com	\N	\N	\N	\N	\N	\N	1274
5867	9 zero 7	https://www.facebook.com/9Zero7Bikes	\N	\N	\N	\N	\N	\N	1113
5868	A-Class		\N	\N	\N	\N	\N	\N	378
5869	A-bike	http://www.a-bike.co.uk/	\N	\N	\N	\N	\N	\N	8
5870	A2B e-bikes	http://www.wearea2b.com/us/	\N	\N	\N	\N	\N	\N	1212
5871	ABI		\N	\N	\N	\N	\N	\N	380
5872	ACS		\N	\N	\N	\N	\N	\N	384
5873	AGang	http://www.agang.eu	\N	\N	\N	\N	\N	\N	1255
5874	ALAN	http://www.alanbike.it/	\N	\N	\N	\N	\N	\N	24
5875	AMF		\N	\N	\N	\N	\N	\N	29
5876	AXA	http://www.axa-stenman.com/en/bicycle-components/locks/frame-locks/defender/	\N	\N	\N	\N	\N	\N	1268
5877	Aardvark		\N	\N	\N	\N	\N	\N	379
5878	Abici	http://www.abici-italia.it/en/index.html	\N	\N	\N	\N	\N	\N	9
5879	Abus	http://www.abus.com/eng/Mobile-Security/Bike-safety-and-security/Locks	\N	\N	\N	\N	\N	\N	107
5880	Accelerade		\N	\N	\N	\N	\N	\N	382
5881	Accell	http://www.accell-group.com/uk/accell-group.asp	\N	\N	\N	\N	\N	\N	10
5882	Access	https://www.performancebike.com/	\N	\N	\N	\N	\N	\N	1042
5883	Acros		\N	\N	\N	\N	\N	\N	383
5884	Acstar	http://www.acstar.cz/	\N	\N	\N	\N	\N	\N	1293
5885	Adams (Trail a bike)	http://www.trail-a-bike.com/	\N	\N	\N	\N	\N	\N	1258
5886	Adolphe Clément		\N	\N	\N	\N	\N	\N	77
5887	Adventure Medical Kits		\N	\N	\N	\N	\N	\N	385
5888	Advocate	http://advocatecycles.com/	\N	\N	\N	\N	\N	\N	1480
5889	Aegis	http://www.aegisbicycles.com/home.html	\N	\N	\N	\N	B	\N	1260
5890	Aerofix Cycles	http://www.aerofixcycles.com/	\N	\N	\N	\N	\N	\N	1002
5891	Affinity Cycles	http://affinitycycles.com/	\N	\N	\N	\N	\N	\N	1199
5892	AheadSet		\N	\N	\N	\N	\N	\N	386
5893	Airborne	http://www.airbornebicycles.com/	\N	\N	\N	\N	\N	\N	1133
5894	Aist Bicycles	http://aist-bike.com/	\N	\N	\N	\N	\N	\N	23
5895	Aladdin		\N	\N	\N	\N	\N	\N	387
5896	Alcyon		\N	\N	\N	\N	\N	\N	25
5897	Alex		\N	\N	\N	\N	\N	\N	388
5898	Alexander Leutner & Co.		\N	\N	\N	\N	\N	\N	214
5899	Alien Bikes	http://alienbikes.com/	\N	\N	\N	\N	\N	\N	1013
5900	Alienation		\N	\N	\N	\N	\N	\N	389
5901	Alite Designs		\N	\N	\N	\N	\N	\N	390
5902	All City	http://allcitycycles.com	\N	\N	\N	\N	B	\N	371
5903	Alldays & Onions		\N	\N	\N	\N	\N	\N	26
5904	Alliance	http://alliancebicycles.com/	\N	\N	\N	\N	\N	\N	1257
5905	Alton	http://altonus.com/	\N	\N	\N	\N	\N	\N	1366
5906	American Bicycle Company		\N	\N	\N	\N	\N	\N	27
5907	American Classic		\N	\N	\N	\N	\N	\N	391
5908	American Machine and Foundry		\N	\N	\N	\N	\N	\N	28
5909	American Star Bicycle		\N	\N	\N	\N	\N	\N	31
5910	Amoeba	http://www.amoebaparts.com/	\N	\N	\N	\N	\N	\N	1355
5911	And		\N	\N	\N	\N	\N	\N	392
5912	Andiamo		\N	\N	\N	\N	\N	\N	393
6106	Revolights	http://revolights.com/	\N	\N	\N	\N	\N	\N	1227
6107	Rhythm		\N	\N	\N	\N	\N	\N	747
6108	Ribble	http://www.ribblecycles.co.uk/	\N	\N	\N	\N	\N	\N	1046
6109	Ride2		\N	\N	\N	\N	\N	\N	748
6110	Ridgeback	http://www.ridgeback.co.uk/	\N	\N	\N	\N	\N	\N	281
6111	Ridley	http://www.ridley-bikes.com/be/nl/intro	\N	\N	\N	\N	\N	\N	749
6112	Riese und Müller	http://www.en.r-m.de/	\N	\N	\N	\N	\N	\N	283
6113	Ritchey	http://ritcheylogic.com/	\N	\N	\N	\N	\N	\N	750
6114	Ritte	http://rittecycles.com/	\N	\N	\N	\N	\N	\N	1051
6115	Rivendell Bicycle Works	http://www.rivbike.com/	\N	\N	\N	\N	\N	\N	285
6116	Roadmaster		\N	\N	\N	\N	\N	\N	30
6117	Roberts Cycles	http://www.robertscycles.com/	\N	\N	\N	\N	\N	\N	286
6118	Robin Hood	http://www.robinhoodcycles.com/	\N	\N	\N	\N	\N	\N	287
6119	Rock Lobster	http://www.rocklobstercycles.com/	\N	\N	\N	\N	\N	\N	1135
6120	Rock-N-Roll		\N	\N	\N	\N	\N	\N	751
6121	RockShox		\N	\N	\N	\N	\N	\N	752
6122	Rocky Mountain Bicycles		\N	\N	\N	\N	A	\N	270
6123	Rocky Mounts		\N	\N	\N	\N	\N	\N	753
6124	Rodriguez	http://www.rodbikes.com/	\N	\N	\N	\N	\N	\N	1124
6125	Rohloff		\N	\N	\N	\N	\N	\N	754
6126	Rokform		\N	\N	\N	\N	\N	\N	755
6127	Rola		\N	\N	\N	\N	\N	\N	756
6128	Rosko	http://rosko.cc	\N	\N	\N	\N	\N	\N	1478
6129	Ross	http://www.randyrrross.com/	\N	\N	\N	\N	\N	\N	288
6130	Rossignol		\N	\N	\N	\N	\N	\N	757
6131	Rossin	http://rossinbikes.it/	\N	\N	\N	\N	\N	\N	1069
6132	Rover Company	http://www.randyrrross.com/	\N	\N	\N	\N	\N	\N	289
6133	Rowbike	http://www.rowbike.com/	\N	\N	\N	\N	\N	\N	290
6134	Rox		\N	\N	\N	\N	\N	\N	758
6135	Royal		\N	\N	\N	\N	\N	\N	759
6136	Royce Union 	http://royceunionbikes.com/	\N	\N	\N	\N	\N	\N	1000
6137	Rudge-Whitworth		\N	\N	\N	\N	\N	\N	291
6138	Ryde	http://www.ryde.nl/	\N	\N	\N	\N	\N	\N	1493
6139	S and M (S&M)	http://www.sandmbikes.com	\N	\N	\N	\N	\N	\N	361
6140	S and S		\N	\N	\N	\N	\N	\N	762
6141	SCOTT	http://www.scott-sports.com/global/en/	\N	\N	\N	\N	A	\N	296
6142	SDG		\N	\N	\N	\N	\N	\N	770
6143	SE Bikes (SE Racing)	http://www.sebikes.com	\N	\N	\N	\N	\N	\N	363
6144	SKS		\N	\N	\N	\N	\N	\N	788
6145	SLS3		\N	\N	\N	\N	\N	\N	790
6146	SR Suntour		\N	\N	\N	\N	\N	\N	806
6147	SRAM	http://www.sram.com	\N	\N	\N	\N	\N	\N	807
6148	SST		\N	\N	\N	\N	\N	\N	808
6149	START		\N	\N	\N	\N	\N	\N	811
6150	SWEAT GUTR		\N	\N	\N	\N	\N	\N	831
6151	Salomon		\N	\N	\N	\N	\N	\N	763
6152	Salsa	http://salsacycles.com/	\N	\N	\N	\N	B	\N	764
6153	Salt (BMX)	http://saltbmx.com	\N	\N	\N	\N	\N	\N	1502
6154	SaltStick		\N	\N	\N	\N	\N	\N	766
6155	Samchuly	http://www.samchuly.co.kr/main/main.html	\N	\N	\N	\N	\N	\N	292
6156	Sancineto		\N	\N	\N	\N	\N	\N	1186
6157	Sanderson	http://sanderson-cycles.com	\N	\N	\N	\N	\N	\N	1038
6158	Santa Cruz	http://www.santacruzbicycles.com/en	\N	\N	\N	\N	B	\N	965
6159	Santana Cycles	http://www.santanatandem.com/	\N	\N	\N	\N	\N	\N	293
6160	Saracen Cycles	http://www.saracen.co.uk/	\N	\N	\N	\N	\N	\N	294
6161	Saris		\N	\N	\N	\N	\N	\N	767
6162	Satori	http://www.satoribike.com/	\N	\N	\N	\N	\N	\N	1489
6163	Scania AB	http://scania.com/	\N	\N	\N	\N	\N	\N	295
6164	Scattante	http://www.performancebike.com/webapp/wcs/stores/servlet/SubCategory_10052_10551_400759_-1_400345_400345	\N	\N	\N	\N	\N	\N	942
6165	Schindelhauer	http://www.schindelhauerbikes.com/	\N	\N	\N	\N	\N	\N	1228
6166	Schmidt (Wilfried Schmidt Maschinenbau)	http://www.nabendynamo.de/	\N	\N	\N	\N	\N	\N	1495
6167	Schwalbe		\N	\N	\N	\N	\N	\N	768
6168	Schwinn	http://www.schwinnbikes.com/	\N	\N	\N	\N	A	\N	117
6169	Scotty		\N	\N	\N	\N	\N	\N	769
6170	Seal Line		\N	\N	\N	\N	\N	\N	771
6171	Sears Roebuck		\N	\N	\N	\N	\N	\N	1027
6172	Season	http://seasonbikesbmx.com/	\N	\N	\N	\N	\N	\N	1020
6173	Seattle Sports Company		\N	\N	\N	\N	\N	\N	772
6174	Sekai		\N	\N	\N	\N	\N	\N	1143
6175	Sekine		\N	\N	\N	\N	\N	\N	1058
6176	Selle Anatomica	http://selleanatomica.com	\N	\N	\N	\N	\N	\N	1289
6177	Selle Italia		\N	\N	\N	\N	\N	\N	773
6178	Selle Royal		\N	\N	\N	\N	\N	\N	774
6179	Selle San Marco		\N	\N	\N	\N	\N	\N	775
6180	Serfas	https://www.serfas.com/	\N	\N	\N	\N	\N	\N	1399
6181	Serotta	http://serotta.com/	\N	\N	\N	\N	\N	\N	297
6182	Sette	http://www.settebikes.com/	\N	\N	\N	\N	\N	\N	1297
6183	Seven Cycles	http://www.sevencycles.com/	\N	\N	\N	\N	\N	\N	298
6184	Shadow Conspiracy	http://www.theshadowconspiracy.com/	\N	\N	\N	\N	\N	\N	845
6185	Shelby Cycle Company		\N	\N	\N	\N	\N	\N	299
6186	Sherpani		\N	\N	\N	\N	\N	\N	776
6187	Shimano	http://bike.shimano.com	\N	\N	\N	\N	A	\N	366
6188	Shinola	http://www.shinola.com/	\N	\N	\N	\N	B	\N	1096
6189	Shogun		\N	\N	\N	\N	\N	\N	962
6190	Shredder	http://lilshredder.com/	\N	\N	\N	\N	\N	\N	1010
6191	Sidi		\N	\N	\N	\N	\N	\N	777
6192	Sierra Designs		\N	\N	\N	\N	\N	\N	778
6193	Sigma		\N	\N	\N	\N	\N	\N	779
6194	Silca		\N	\N	\N	\N	\N	\N	780
6195	Simcoe	http://simcoebicycles.com/	\N	\N	\N	\N	\N	\N	1392
6196	Simple Green		\N	\N	\N	\N	\N	\N	781
6197	Simplon	http://www.simplon.com	\N	\N	\N	\N	\N	\N	1270
6198	Simson		\N	\N	\N	\N	\N	\N	300
6199	Sinclair Research	http://www.sinclairzx.com/	\N	\N	\N	\N	\N	\N	301
6200	Singletrack Solutions		\N	\N	\N	\N	\N	\N	782
6201	Sinz		\N	\N	\N	\N	\N	\N	783
6202	Six-Eleven	http://sixelevenbicycleco.com/	\N	\N	\N	\N	\N	\N	1353
6203	SixSixOne		\N	\N	\N	\N	\N	\N	784
6204	Skadi		\N	\N	\N	\N	\N	\N	785
6205	Skinz		\N	\N	\N	\N	\N	\N	786
6206	Skratch Labs		\N	\N	\N	\N	\N	\N	787
6207	Skyway 		\N	\N	\N	\N	\N	\N	999
6208	Slime		\N	\N	\N	\N	\N	\N	789
6209	Smartwool		\N	\N	\N	\N	\N	\N	791
6210	SockGuy		\N	\N	\N	\N	\N	\N	792
6211	Sohrab Cycles	http://www.sohrab-cycles.com/index.php	\N	\N	\N	\N	\N	\N	303
6212	Solex	http://www.solexworld.com/en/	\N	\N	\N	\N	\N	\N	305
6213	Solio		\N	\N	\N	\N	\N	\N	794
6214	Solé (Sole bicycles)	http://www.solebicycles.com/	\N	\N	\N	\N	\N	\N	304
6215	Soma	http://www.somafab.com	\N	\N	\N	\N	B	\N	368
6216	Somec	http://www.somec.com/	\N	\N	\N	\N	\N	\N	306
6217	Sondors	http://gosondors.com/	\N	\N	\N	\N	\N	\N	1411
6218	Sonoma	http://sonomabike.com/	\N	\N	\N	\N	\N	\N	1197
6219	Soulcraft	http://www.soulcraftbikes.com	\N	\N	\N	\N	\N	\N	1267
6220	Source		\N	\N	\N	\N	\N	\N	795
6221	Spalding Bicycles		\N	\N	\N	\N	\N	\N	364
6222	Sparta B.V.		\N	\N	\N	\N	\N	\N	21
6223	Specialized	http://www.specialized.com/us/en/home/	\N	\N	\N	\N	A	\N	307
6224	Spectrum	http://www.spectrum-cycles.com/	\N	\N	\N	\N	\N	\N	1276
6225	Speedfil		\N	\N	\N	\N	\N	\N	797
6226	Speedwell bicycles		\N	\N	\N	\N	\N	\N	308
6227	Spenco		\N	\N	\N	\N	\N	\N	798
6228	Spicer	http://www.spicercycles.com/	\N	\N	\N	\N	\N	\N	1207
6229	SpiderTech		\N	\N	\N	\N	\N	\N	799
6230	Spike	http://spikeparts.com/	\N	\N	\N	\N	\N	\N	1030
6231	Spinskins		\N	\N	\N	\N	\N	\N	800
6232	Splendid Cycles	http://www.splendidcycles.com/	\N	\N	\N	\N	\N	\N	1500
6233	Spooky	http://www.spookybikes.com	\N	\N	\N	\N	\N	\N	953
6234	SportRack		\N	\N	\N	\N	\N	\N	803
6235	Sportlegs		\N	\N	\N	\N	\N	\N	801
6236	Sportourer		\N	\N	\N	\N	\N	\N	802
6237	Spot	http://spotbrand.com/	\N	\N	\N	\N	\N	\N	1053
6238	Sprintech		\N	\N	\N	\N	\N	\N	804
6239	Squeal Out		\N	\N	\N	\N	\N	\N	805
6240	Squire	http://www.squirelocks.co.uk/security_advice/secure_your_bicycle.html	\N	\N	\N	\N	\N	\N	110
6241	St. Tropez		\N	\N	\N	\N	\N	\N	1018
6242	Stages cycling (Power meters)	http://www.stagescycling.com/stagespower	\N	\N	\N	\N	\N	\N	1360
6243	Staiger	http://www.staiger-fahrrad.de/	\N	\N	\N	\N	\N	\N	12
6244	Stan's No Tubes		\N	\N	\N	\N	\N	\N	809
6245	Standard Byke	http://www.standardbyke.com/	\N	\N	\N	\N	\N	\N	1144
6246	Stanley		\N	\N	\N	\N	\N	\N	810
6247	Stanridge Speed	http://www.stanridgespeed.com/	\N	\N	\N	\N	\N	\N	1154
6248	State Bicycle Co.	http://www.statebicycle.com/	\N	\N	\N	\N	\N	\N	961
6249	Steadyrack		\N	\N	\N	\N	\N	\N	812
6250	Steelman Cycles	http://www.steelmancycles.com/	\N	\N	\N	\N	\N	\N	1357
6251	Stein		\N	\N	\N	\N	\N	\N	813
6252	Stein Trikes	http://www.steintrikes.com/index.php	\N	\N	\N	\N	\N	\N	979
6253	Stelber Cycle Corp		\N	\N	\N	\N	\N	\N	311
6254	Stella		\N	\N	\N	\N	\N	\N	312
6255	Stem CAPtain		\N	\N	\N	\N	\N	\N	814
6256	Sterling Bicycle Co.		\N	\N	\N	\N	\N	\N	313
6257	Steve Potts	http://www.stevepottsbicycles.com	\N	\N	\N	\N	\N	\N	983
6258	HBBC (Huntington Beach Bicycle, Co)	http://hbbcinc.com/	\N	\N	\N	\N	\N	\N	1214
6259	HED		\N	\N	\N	\N	\N	\N	576
6260	HP Velotechnik	http://www.hpvelotechnik.com	\N	\N	\N	\N	\N	\N	1204
6261	Haibike (Currietech)	http://www.currietech.com/	\N	\N	\N	\N	\N	\N	1279
6262	Hallstrom	http://www.hallstrom.no/	\N	\N	\N	\N	\N	\N	1373
6263	Halo		\N	\N	\N	\N	\N	\N	571
6264	Hammer Nutrition		\N	\N	\N	\N	\N	\N	572
6265	Hampsten Cycles	http://www.hampsten.com/	\N	\N	\N	\N	\N	\N	1371
6266	Handsome Cycles	http://www.handsomecycles.com	\N	\N	\N	\N	B	\N	934
6267	Handspun		\N	\N	\N	\N	\N	\N	573
6268	Hanford	https://www.facebook.com/pages/Hanford-Cycles/230458813647205	\N	\N	\N	\N	\N	\N	1238
6269	Haro	http://www.harobikes.com	\N	\N	\N	\N	A	\N	105
6270	Harry Quinn		\N	\N	\N	\N	\N	\N	162
6271	Harvey Cycle Works	http://harveykevin65.wix.com/harveycycleworks	\N	\N	\N	\N	\N	\N	1097
6272	Hasa	http://www.hasa.com.tw/	\N	\N	\N	\N	\N	\N	1181
6273	Hase bikes	http://hasebikes.com/	\N	\N	\N	\N	\N	\N	163
6274	Hayes		\N	\N	\N	\N	\N	\N	574
6275	Head		\N	\N	\N	\N	\N	\N	164
6276	Headsweats		\N	\N	\N	\N	\N	\N	575
6277	Heinkel	http://www.heinkeltourist.com/	\N	\N	\N	\N	\N	\N	166
6278	Helkama	http://www.helkamavelox.fi/en/	\N	\N	\N	\N	\N	\N	165
6279	Hercules Fahrrad GmbH & Co		\N	\N	\N	\N	\N	\N	11
6280	Heritage	http://www.heritagebicycles.com/	\N	\N	\N	\N	\N	\N	995
6281	Herkelmann	http://www.herkelmannbikes.com/	\N	\N	\N	\N	\N	\N	1216
6282	Hero Cycles Ltd	http://www.herocycles.com/	\N	\N	\N	\N	\N	\N	169
6283	Heron	http://www.heronbicycles.com/	\N	\N	\N	\N	\N	\N	1201
6284	Hetchins	http://www.hetchins.org/	\N	\N	\N	\N	\N	\N	171
6285	High Gear		\N	\N	\N	\N	\N	\N	577
6286	Highland		\N	\N	\N	\N	\N	\N	578
6287	Hija de la Coneja	https://www.facebook.com/hijadelaconeja	\N	\N	\N	\N	\N	\N	1155
6288	Hillman	http://hillmancycles.com.au	\N	\N	\N	\N	\N	\N	172
6289	Hinton Cycles	http://www.hintoncycles.com/	\N	\N	\N	\N	\N	\N	1377
6290	Hirschfeld		\N	\N	\N	\N	\N	\N	1149
6291	Hirzl		\N	\N	\N	\N	\N	\N	579
6292	Hobson		\N	\N	\N	\N	\N	\N	580
6293	Hoffman	http://hoffmanbikes.com/	\N	\N	\N	\N	\N	\N	951
6294	Holdsworth	http://www.holdsworthbikes.co.uk/	\N	\N	\N	\N	\N	\N	174
6295	Honey Stinger		\N	\N	\N	\N	\N	\N	581
6296	Hope		\N	\N	\N	\N	\N	\N	582
6297	House of Talents		\N	\N	\N	\N	\N	\N	583
6298	Hozan		\N	\N	\N	\N	\N	\N	584
6299	HubBub		\N	\N	\N	\N	\N	\N	585
6300	Hudz		\N	\N	\N	\N	\N	\N	586
6301	Huffy	http://www.huffybikes.com	\N	\N	\N	\N	A	\N	175
6302	Hufnagel	http://www.hufnagelcycles.com/	\N	\N	\N	\N	\N	\N	1173
6303	Humangear		\N	\N	\N	\N	\N	\N	587
6304	Humber	http://en.wikipedia.org/wiki/Humber_(bicycle)	\N	\N	\N	\N	\N	\N	176
6305	Humble Frameworks	http://www.humbleframeworks.cc	\N	\N	\N	\N	\N	\N	954
6306	Hunter	http://www.huntercycles.com/	\N	\N	\N	\N	\N	\N	972
6307	Hurricane Components		\N	\N	\N	\N	\N	\N	588
6308	Hurtu	http://en.wikipedia.org/wiki/Hurtu	\N	\N	\N	\N	\N	\N	177
6309	Hutchinson		\N	\N	\N	\N	\N	\N	589
6310	Hyalite Equipment		\N	\N	\N	\N	\N	\N	590
6311	Hydrapak		\N	\N	\N	\N	\N	\N	591
6312	Hyper	http://www.hyperbicycles.com/	\N	\N	\N	\N	\N	\N	1136
6313	IBEX	http://ibexbikes.com/	\N	\N	\N	\N	\N	\N	592
6314	ICE Trikes (Inspired Cycle Engineering )	http://www.icetrikes.co/	\N	\N	\N	\N	\N	\N	1109
6315	IMBA		\N	\N	\N	\N	\N	\N	595
6316	IRD (Interloc Racing Design)	http://www.interlocracing.com/	\N	\N	\N	\N	\N	\N	1492
6317	IRO Cycles	http://www.irocycle.com	\N	\N	\N	\N	\N	\N	938
6318	ISM		\N	\N	\N	\N	\N	\N	601
6319	IZIP (Currietech)	http://www.currietech.com/	\N	\N	\N	\N	\N	\N	1278
6320	Ibis	http://www.ibiscycles.com/bikes/	\N	\N	\N	\N	\N	\N	179
6321	Ice Trekkers		\N	\N	\N	\N	\N	\N	593
6322	IceToolz		\N	\N	\N	\N	\N	\N	594
6323	Ideal Bikes	http://www.idealbikes.net/	\N	\N	\N	\N	\N	\N	180
6324	Identiti	http://www.identitibikes.com/	\N	\N	\N	\N	\N	\N	1070
6326	Independent Fabrication	http://www.ifbikes.com/	\N	\N	\N	\N	\N	\N	184
6327	Industrieverband Fahrzeugbau		\N	\N	\N	\N	\N	\N	182
6328	Industry Nine		\N	\N	\N	\N	\N	\N	597
6329	Infini		\N	\N	\N	\N	\N	\N	598
6330	Inglis (Retrotec)	http://ingliscycles.com/	\N	\N	\N	\N	\N	\N	1352
6331	Innerlight Cycles	http://www.innerlightcycles.com/	\N	\N	\N	\N	\N	\N	1184
6332	Innova		\N	\N	\N	\N	\N	\N	599
6333	Inspired	http://www.inspiredbicycles.com/	\N	\N	\N	\N	\N	\N	1405
6334	Intense	http://intensecycles.com/	\N	\N	\N	\N	\N	\N	600
6335	Iride Bicycles	http://www.irideusa.com/	\N	\N	\N	\N	\N	\N	185
6336	Iron Horse Bicycles	http://www.ironhorsebikes.com/	\N	\N	\N	\N	\N	\N	116
6337	Islabikes	http://www.islabikes.com/	\N	\N	\N	\N	\N	\N	1063
6338	Issimo Designs		\N	\N	\N	\N	\N	\N	602
6339	Italvega	http://en.wikipedia.org/wiki/Italvega	\N	\N	\N	\N	\N	\N	186
6340	Itera plastic bicycle		\N	\N	\N	\N	\N	\N	187
6341	Iver Johnson		\N	\N	\N	\N	\N	\N	188
6342	Iverson		\N	\N	\N	\N	\N	\N	189
6343	JMC Bicycles	http://www.jmccycles.com/	\N	\N	\N	\N	\N	\N	190
6344	JP Weigle's		\N	\N	\N	\N	\N	\N	608
6345	Jagwire		\N	\N	\N	\N	\N	\N	603
6346	Jamis	http://www.jamisbikes.com/usa/index.html	\N	\N	\N	\N	A	\N	201
6347	Jan Jansen	http://www.janjanssen.nl/index.php	\N	\N	\N	\N	\N	\N	1123
6348	Jandd		\N	\N	\N	\N	\N	\N	604
6349	Javelin	http://www.javbike.com/	\N	\N	\N	\N	\N	\N	1194
6350	Jelly Belly		\N	\N	\N	\N	\N	\N	605
6351	JetBoil		\N	\N	\N	\N	\N	\N	606
6352	Jittery Joe's		\N	\N	\N	\N	\N	\N	607
6353	John Cherry bicycles	http://www.sandsmachine.com/bp_chery.htm	\N	\N	\N	\N	\N	\N	1085
6354	John Deere 		\N	\N	\N	\N	\N	\N	998
6355	Jorg & Olif	http://jorgandolif.com	\N	\N	\N	\N	\N	\N	1222
6356	Juiced Riders	http://www.juicedriders.com/	\N	\N	\N	\N	\N	\N	1406
6357	Juliana Bicycles	http://www.julianabicycles.com/en/us	\N	\N	\N	\N	\N	\N	1241
6358	Cannondale	http://www.cannondale.com/	\N	\N	\N	\N	A	\N	62
6359	Canyon bicycles	http://www.canyon.com/	\N	\N	\N	\N	\N	\N	63
6360	Cardiff	http://www.cardiffltd.com/	\N	\N	\N	\N	\N	\N	1490
6361	Carmichael Training Systems		\N	\N	\N	\N	\N	\N	448
6362	Carrera bicycles	http://www.carrera-podium.it/	\N	\N	\N	\N	\N	\N	64
6363	CatEye		\N	\N	\N	\N	\N	\N	449
6364	Catrike	http://www.catrike.com/	\N	\N	\N	\N	\N	\N	66
6365	Cayne	http://www.sun.bike/	\N	\N	\N	\N	\N	\N	1179
6366	Centurion	http://www.centurion.de/en_int	\N	\N	\N	\N	\N	\N	68
6367	CeramicSpeed		\N	\N	\N	\N	\N	\N	451
6368	Cervélo	http://www.cervelo.com/en/	\N	\N	\N	\N	B	\N	69
6369	Chadwick		\N	\N	\N	\N	\N	\N	452
6370	Challenge		\N	\N	\N	\N	\N	\N	453
6371	Charge	http://www.chargebikes.com/	\N	\N	\N	\N	\N	\N	940
6372	Chariot	http://www.thule.com/en-us/us/products/active-with-kids	\N	\N	\N	\N	\N	\N	1129
6373	Chase		\N	\N	\N	\N	\N	\N	454
6374	Chater-Lea		\N	\N	\N	\N	\N	\N	70
6375	Chicago Bicycle Company		\N	\N	\N	\N	\N	\N	71
6376	Chris King		\N	\N	\N	\N	\N	\N	455
6377	Christiania Bikes	http://christianiabikes.com/en/	\N	\N	\N	\N	\N	\N	1247
6378	Chromag	http://www.chromagbikes.com	\N	\N	\N	\N	\N	\N	456
6379	Cielo	http://cielo.chrisking.com/	\N	\N	\N	\N	\N	\N	1218
6380	Cignal		\N	\N	\N	\N	\N	\N	1084
6381	Cilo		\N	\N	\N	\N	\N	\N	73
6382	Cinelli	http://www.cinelli-usa.com/	\N	\N	\N	\N	\N	\N	74
6383	Ciocc	http://www.ciocc.it/	\N	\N	\N	\N	\N	\N	1130
6384	Citizen Bike	http://www.citizenbike.com/	\N	\N	\N	\N	\N	\N	1068
6385	City Bicycles Company	http://citybicycleco.com	\N	\N	\N	\N	\N	\N	937
6386	Civia	http://www.civiacycles.com	\N	\N	\N	\N	\N	\N	372
6387	Clark-Kent		\N	\N	\N	\N	\N	\N	75
6388	Claud Butler	http://claudbutler.co.uk/	\N	\N	\N	\N	\N	\N	76
6389	Clean Bottle		\N	\N	\N	\N	\N	\N	457
6390	Clement		\N	\N	\N	\N	\N	\N	458
6391	Cloud Nine		\N	\N	\N	\N	\N	\N	459
6392	Club Roost		\N	\N	\N	\N	\N	\N	460
6393	Co-Motion	http://www.co-motion.com/	\N	\N	\N	\N	\N	\N	78
6394	Coker Tire	http://www.cokertire.com/	\N	\N	\N	\N	\N	\N	79
6395	Colnago	http://www.colnago.com/bicycles/	\N	\N	\N	\N	B	\N	80
6396	Colony	http://www.colonybmx.com	\N	\N	\N	\N	\N	\N	1225
6397	Colossi	http://www.colossicycling.com/	\N	\N	\N	\N	\N	\N	1374
6398	Columbia		\N	\N	\N	\N	\N	\N	1146
6399	Columbus Tubing	http://www.columbustubi.com/	\N	\N	\N	\N	\N	\N	1295
6400	Competition Cycles Services		\N	\N	\N	\N	\N	\N	461
6401	Condor	http://www.condorcycles.com/	\N	\N	\N	\N	\N	\N	959
6402	Conor	http://www.conorbikes.com/	\N	\N	\N	\N	\N	\N	978
6403	Continental		\N	\N	\N	\N	\N	\N	462
6404	Contour Sport		\N	\N	\N	\N	\N	\N	463
6405	Cook Bros. Racing		\N	\N	\N	\N	\N	\N	1060
6406	Cooper Bikes	http://www.cooperbikes.com	\N	\N	\N	\N	\N	\N	936
6407	Corima	http://www.corima.com/	\N	\N	\N	\N	\N	\N	81
6408	Corratec	http://www.corratec.com/	\N	\N	\N	\N	\N	\N	1205
6409	Cortina Cycles	http://www.cortinacycles.com/	\N	\N	\N	\N	\N	\N	82
6410	Cove	http://covebike.com/	\N	\N	\N	\N	\N	\N	1139
6411	Craft		\N	\N	\N	\N	\N	\N	464
6412	Crank Brothers		\N	\N	\N	\N	\N	\N	465
6413	Crank2	http://www.crank-2.com	\N	\N	\N	\N	\N	\N	1220
6414	Crazy Creek		\N	\N	\N	\N	\N	\N	466
6415	Create	http://www.createbikes.com/	\N	\N	\N	\N	\N	\N	1095
6416	Creme Cycles	http://cremecycles.com	\N	\N	\N	\N	\N	\N	1224
6417	Crescent Moon		\N	\N	\N	\N	\N	\N	467
6418	Crew	http://crewbikeco.com/	\N	\N	\N	\N	\N	\N	1253
6419	Critical Cycles	http://www.criticalcycles.com/	\N	\N	\N	\N	\N	\N	935
6420	Crumpton	http://www.crumptoncycles.com/	\N	\N	\N	\N	\N	\N	1348
6421	Cruzbike	http://cruzbike.com/	\N	\N	\N	\N	\N	\N	1391
6422	Cube	http://www.cube.eu/en/cube-bikes/	\N	\N	\N	\N	\N	\N	83
6423	CueClip		\N	\N	\N	\N	\N	\N	470
6424	Cuevas	https://www.facebook.com/CUEVAS-BIKES-209970107454/	\N	\N	\N	\N	\N	\N	1488
6425	Cult	http://www.cultcrew.com	\N	\N	\N	\N	\N	\N	362
6426	Currie Technology (Currietech)	http://www.currietech.com/	\N	\N	\N	\N	\N	\N	1115
6427	Currys	http://www.currys.co.uk/gbuk/index.html	\N	\N	\N	\N	\N	\N	84
6428	Curtlo	http://www.curtlo.com/	\N	\N	\N	\N	\N	\N	1397
6429	Cyclamatic		\N	\N	\N	\N	\N	\N	1367
6430	Cycle Dog		\N	\N	\N	\N	\N	\N	472
6431	Cycle Force Group	http://www.cyclefg.com/	\N	\N	\N	\N	\N	\N	89
6432	Cycle Stuff		\N	\N	\N	\N	\N	\N	473
6433	CycleAware		\N	\N	\N	\N	\N	\N	474
6434	CycleOps		\N	\N	\N	\N	\N	\N	475
6435	CyclePro		\N	\N	\N	\N	\N	\N	964
6436	Cycles Fanatic	http://www.cyclesfanatic.com/	\N	\N	\N	\N	\N	\N	1291
6437	Cycles Follis		\N	\N	\N	\N	\N	\N	145
6438	Cycles Toussaint	http://www.cyclestoussaint.com/	\N	\N	\N	\N	\N	\N	1385
6439	Cycleurope	http://www.cycleurope.com	\N	\N	\N	\N	\N	\N	4
6440	Cyclo		\N	\N	\N	\N	\N	\N	476
6441	Cycloc		\N	\N	\N	\N	\N	\N	477
6442	Cyfac	http://www.cyfac.fr/index.aspx	\N	\N	\N	\N	\N	\N	90
6443	CygoLite		\N	\N	\N	\N	\N	\N	478
6444	Cytosport		\N	\N	\N	\N	\N	\N	479
6445	DAJO		\N	\N	\N	\N	\N	\N	480
6446	DEAN	http://www.deanbikes.com	\N	\N	\N	\N	\N	\N	1203
6447	DHS	http://www.dhsbike.hu/	\N	\N	\N	\N	\N	\N	1127
6448	DIG BMX		\N	\N	\N	\N	\N	\N	493
6449	DK Bikes	http://www.dkbicycles.com/	\N	\N	\N	\N	\N	\N	1132
6450	DMR Bikes	http://www.dmrbikes.com/	\N	\N	\N	\N	\N	\N	496
6451	DNP		\N	\N	\N	\N	\N	\N	497
6452	DT Swiss		\N	\N	\N	\N	\N	\N	498
6453	DZ Nuts		\N	\N	\N	\N	\N	\N	501
6454	Da Bomb Bikes	http://www.dabombbike.com/	\N	\N	\N	\N	\N	\N	91
6455	Daccordi	http://www.daccordicicli.com/	\N	\N	\N	\N	\N	\N	1292
6456	Dahon	http://www.dahon.com/	\N	\N	\N	\N	B	\N	92
6457	Davidson	http://davidsonbicycles.com/	\N	\N	\N	\N	\N	\N	1219
6458	K-Edge		\N	\N	\N	\N	\N	\N	609
6459	K2	http://www.k2bike.com/	\N	\N	\N	\N	\N	\N	192
6460	KBC		\N	\N	\N	\N	\N	\N	613
6461	KHS Bicycles	http://khsbicycles.com/	\N	\N	\N	\N	\N	\N	196
6462	KMC		\N	\N	\N	\N	\N	\N	621
6463	KS		\N	\N	\N	\N	\N	\N	626
6464	KT Tape		\N	\N	\N	\N	\N	\N	627
6465	KTM	http://www.ktm.com/us/ready-to-race.html	\N	\N	\N	\N	\N	\N	208
6466	KW Bicycle	http://www.kwcycles.com/	\N	\N	\N	\N	\N	\N	1107
6467	Kalkhoff	http://www.kalkhoff-bikes.com/	\N	\N	\N	\N	\N	\N	977
6468	Kalloy		\N	\N	\N	\N	\N	\N	610
6469	Katadyn		\N	\N	\N	\N	\N	\N	611
6470	Kazam		\N	\N	\N	\N	\N	\N	612
6471	Keith Bontrager	http://bontrager.com/history	\N	\N	\N	\N	\N	\N	46
6472	Kelly	http://www.kellybike.com/index.html	\N	\N	\N	\N	\N	\N	1487
6473	Kellys Bicycles	http://www.kellysbike.com/	\N	\N	\N	\N	\N	\N	1116
6474	Kenda		\N	\N	\N	\N	\N	\N	614
6475	Kent	http://www.kentbicycles.com/	\N	\N	\N	\N	\N	\N	193
6476	Kestrel	http://www.kestrelbicycles.com/	\N	\N	\N	\N	\N	\N	194
6477	Kettler	http://www.kettler.co.uk/	\N	\N	\N	\N	\N	\N	195
6478	Kind Bar		\N	\N	\N	\N	\N	\N	615
6479	Kinesis	http://www.kinesisbikes.co.uk/	\N	\N	\N	\N	\N	\N	616
6480	Kinesis Industry	http://www.kinesis.com.tw/	\N	\N	\N	\N	\N	\N	198
6481	Kinetic		\N	\N	\N	\N	\N	\N	617
6482	Kinetic Koffee		\N	\N	\N	\N	\N	\N	618
6483	Kink	http://www.kinkbmx.com	\N	\N	\N	\N	\N	\N	358
6484	Kinn	http://www.kinnbikes.com/	\N	\N	\N	\N	\N	\N	1403
6485	Kirk	http://www.kirkframeworks.com/	\N	\N	\N	\N	\N	\N	1150
6486	Kish Fabrication	http://www.kishbike.com/	\N	\N	\N	\N	\N	\N	1029
6487	Kiss My Face		\N	\N	\N	\N	\N	\N	619
6488	Klean Kanteen		\N	\N	\N	\N	\N	\N	620
6489	Klein Bikes		\N	\N	\N	\N	A	\N	325
6490	Knog		\N	\N	\N	\N	\N	\N	622
6491	Knolly	http://knollybikes.com/	\N	\N	\N	\N	\N	\N	1213
6492	Koga-Miyata	http://www.koga.com/koga_uk/	\N	\N	\N	\N	\N	\N	20
6493	Kogel	http://http://www.kogel.cc/	\N	\N	\N	\N	\N	\N	1507
6494	Kogswell Cycles		\N	\N	\N	\N	\N	\N	205
6495	Kona	http://www.konaworld.com/	\N	\N	\N	\N	B	\N	203
6496	Kool Kovers		\N	\N	\N	\N	\N	\N	623
6497	Kool-Stop		\N	\N	\N	\N	\N	\N	624
6498	Kreitler		\N	\N	\N	\N	\N	\N	625
6499	Kron	http://kronbikes.com/	\N	\N	\N	\N	\N	\N	1190
6500	Kronan	http://www.kronan.com/en/cykel	\N	\N	\N	\N	\N	\N	206
6501	Kross SA	http://www.kross.pl/	\N	\N	\N	\N	\N	\N	207
6502	Kryptonite	http://www.kryptonitelock.com/Pages/Home.aspx	\N	\N	\N	\N	\N	\N	106
6503	Kuat		\N	\N	\N	\N	\N	\N	628
6504	Kuota	http://www.kuota.it/index.php	\N	\N	\N	\N	\N	\N	209
6505	Kustom Kruiser		\N	\N	\N	\N	\N	\N	1140
6506	Kuwahara	http://kuwahara-bike.com/	\N	\N	\N	\N	\N	\N	210
6507	LDG (Livery Design Gruppe)	http://liverydesigngruppe.com/	\N	\N	\N	\N	\N	\N	1230
6508	LOW//	http://lowbicycles.com/	\N	\N	\N	\N	\N	\N	1026
6509	Land Shark	http://landsharkbicycles.com/	\N	\N	\N	\N	\N	\N	1344
6510	Lapierre	http://www.lapierre-bikes.co.uk/	\N	\N	\N	\N	\N	\N	929
6511	Larry Vs Harry	http://www.larryvsharry.com/english/	\N	\N	\N	\N	\N	\N	1015
6512	Laurin & Klement		\N	\N	\N	\N	\N	\N	212
6513	Lazer		\N	\N	\N	\N	\N	\N	629
6514	LeMond Racing Cycles	https://en.wikipedia.org/wiki/LeMond_Racing_Cycles	\N	\N	\N	\N	\N	\N	213
6515	Leader Bikes	http://www.leaderbikeusa.com	\N	\N	\N	\N	\N	\N	933
6516	Leg Lube		\N	\N	\N	\N	\N	\N	630
6517	Legacy Frameworks	http://legacyframeworks.com/	\N	\N	\N	\N	\N	\N	952
6518	Leopard	http://www.leopardcycles.com/	\N	\N	\N	\N	\N	\N	1372
6519	Lezyne		\N	\N	\N	\N	\N	\N	631
6520	Light My Fire		\N	\N	\N	\N	\N	\N	633
6521	Light and Motion		\N	\N	\N	\N	\N	\N	632
6522	Lightning Cycle Dynamics	http://www.lightningbikes.com/	\N	\N	\N	\N	\N	\N	1035
6523	Lightspeed	http://www.litespeed.com/	\N	\N	\N	\N	\N	\N	1111
6524	Linus	http://www.linusbike.com/	\N	\N	\N	\N	B	\N	950
6525	Liotto (Cicli Liotto Gino & Figli)	http://www.liotto.com/	\N	\N	\N	\N	\N	\N	1261
6526	Litespeed	http://www.litespeed.com/	\N	\N	\N	\N	\N	\N	215
6527	Liteville	http://www.liteville.de/	\N	\N	\N	\N	\N	\N	1240
6528	Lizard Skins		\N	\N	\N	\N	\N	\N	634
6529	Loctite		\N	\N	\N	\N	\N	\N	635
6530	Loekie	http://www.loekie.nl/	\N	\N	\N	\N	\N	\N	19
6531	Lonely Planet		\N	\N	\N	\N	\N	\N	636
6532	Look	http://www.lookcycle.com/	\N	\N	\N	\N	\N	\N	369
6533	Lotus		\N	\N	\N	\N	\N	\N	217
6534	Louis Garneau	http://www.louisgarneau.com	\N	\N	\N	\N	\N	\N	637
6535	Louison Bobet		\N	\N	\N	\N	\N	\N	216
6536	Lycoming Engines	http://www.lycoming.textron.com/	\N	\N	\N	\N	\N	\N	94
6537	Lynskey	http://www.lynskeyperformance.com/	\N	\N	\N	\N	\N	\N	1088
6538	M Essentials		\N	\N	\N	\N	\N	\N	638
6539	MBK	http://mbk-cykler.dk/	\N	\N	\N	\N	\N	\N	1301
6540	MEC (Mountain Equipment Co-op)	http://www.mec.ca/	\N	\N	\N	\N	\N	\N	1157
6541	MKS		\N	\N	\N	\N	\N	\N	655
6542	MMR	http://www.mmrbikes.com/	\N	\N	\N	\N	\N	\N	1264
6543	MRP		\N	\N	\N	\N	\N	\N	661
6544	MSR		\N	\N	\N	\N	\N	\N	662
6545	MTI Adventurewear		\N	\N	\N	\N	\N	\N	663
6546	Madsen	http://www.madsencycles.com/	\N	\N	\N	\N	\N	\N	1117
6547	Madwagon		\N	\N	\N	\N	\N	\N	1151
6548	Magellan		\N	\N	\N	\N	\N	\N	639
6549	Magna	http://www.magnabike.com/	\N	\N	\N	\N	\N	\N	122
6550	Malvern Star	http://www.malvernstar.com.au/	\N	\N	\N	\N	\N	\N	218
6551	ManKind	http://mankindbmx.com/	\N	\N	\N	\N	\N	\N	1092
6552	Mango	http://www.mangobikes.co.uk/	\N	\N	\N	\N	\N	\N	1195
6553	Manhattan	http://www.manhattancruisers.com/	\N	\N	\N	\N	\N	\N	969
6554	Manitou		\N	\N	\N	\N	\N	\N	640
6555	Map Bicycles	http://www.mapbicycles.com/	\N	\N	\N	\N	\N	\N	1290
6556	Maraton	http://www.bikemaraton.com/	\N	\N	\N	\N	\N	\N	993
6557	Marin Bikes	http://www.marinbikes.com/2013/	\N	\N	\N	\N	B	\N	219
6558	TriSlide		\N	\N	\N	\N	\N	\N	862
6559	TriSwim		\N	\N	\N	\N	\N	\N	863
6560	Tribe Bicycle Co	http://tribebicycles.com/	\N	\N	\N	\N	\N	\N	1393
6561	Trigger Point		\N	\N	\N	\N	\N	\N	860
6562	Trik Topz		\N	\N	\N	\N	\N	\N	861
6563	Trinx	http://www.trinx.com/	\N	\N	\N	\N	\N	\N	1287
6564	Triumph Cycle		\N	\N	\N	\N	\N	\N	326
6565	TruVativ		\N	\N	\N	\N	\N	\N	865
6566	Tubasti		\N	\N	\N	\N	\N	\N	866
6567	Tubus	http://www.tubus.com/	\N	\N	\N	\N	\N	\N	1494
6568	Tufo		\N	\N	\N	\N	\N	\N	867
6569	Tunturi		\N	\N	\N	\N	\N	\N	14
6570	Turin	http://www.turinbicycle.com/	\N	\N	\N	\N	\N	\N	1341
6571	Turner Bicycles	http://www.turnerbikes.com/	\N	\N	\N	\N	\N	\N	328
6572	Twin Six	https://www.twinsix.com/	\N	\N	\N	\N	\N	\N	868
6573	TwoFish		\N	\N	\N	\N	\N	\N	869
6574	UCLEAR		\N	\N	\N	\N	\N	\N	871
6575	UCO		\N	\N	\N	\N	\N	\N	872
6576	Uline		\N	\N	\N	\N	\N	\N	873
6577	Ultimate Survival Technologies		\N	\N	\N	\N	\N	\N	874
6578	UltraPaws		\N	\N	\N	\N	\N	\N	875
6579	Umberto Dei	http://umbertodei.it/index.htm	\N	\N	\N	\N	\N	\N	1004
6580	Unior		\N	\N	\N	\N	\N	\N	876
6581	Univega		\N	\N	\N	\N	\N	\N	329
6582	Unknown		\N	\N	\N	\N	\N	\N	877
6583	Upland	http://www.uplandbicycles.com/	\N	\N	\N	\N	\N	\N	1198
6584	Urago		\N	\N	\N	\N	\N	\N	330
6585	Utopia		\N	\N	\N	\N	\N	\N	331
6586	VP Components		\N	\N	\N	\N	\N	\N	891
6587	VSF Fahrradmanufaktur	http://www.fahrradmanufaktur.de	\N	\N	\N	\N	\N	\N	1248
6588	Valdora		\N	\N	\N	\N	\N	\N	332
6589	Van Dessel	http://www.vandesselsports.com/	\N	\N	\N	\N	\N	\N	1272
6590	Van Herwerden	http://www.vanherwerden.nl/	\N	\N	\N	\N	\N	\N	1047
6591	Vanilla	http://www.thevanillaworkshop.com/	\N	\N	\N	\N	\N	\N	1251
6592	Vanmoof	http://vanmoof.com/	\N	\N	\N	\N	\N	\N	1231
6593	Vargo		\N	\N	\N	\N	\N	\N	878
6594	Vassago	http://www.vassagocycles.com/	\N	\N	\N	\N	\N	\N	1055
6595	Vee Rubber		\N	\N	\N	\N	\N	\N	880
6596	Velo		\N	\N	\N	\N	\N	\N	881
6597	Velo Orange	http://www.velo-orange.com/	\N	\N	\N	\N	\N	\N	882
6598	Velo Press		\N	\N	\N	\N	\N	\N	883
6599	Velo Vie		\N	\N	\N	\N	\N	\N	335
6600	Velocity		\N	\N	\N	\N	\N	\N	884
6601	Velomotors		\N	\N	\N	\N	\N	\N	333
6602	Velorbis	http://www.velorbis.com/velorbis-collections/velorbis-bicycles	\N	\N	\N	\N	\N	\N	982
6603	Velox		\N	\N	\N	\N	\N	\N	885
6604	Verde	http://verdebmx.com/2013completes/	\N	\N	\N	\N	\N	\N	968
6605	Versa		\N	\N	\N	\N	\N	\N	886
6606	Vicini	http://www.vicini.it	\N	\N	\N	\N	\N	\N	1481
6607	Vilano	http://www.vilanobikes.com	\N	\N	\N	\N	\N	\N	981
6608	Villy Customs		\N	\N	\N	\N	\N	\N	337
6609	Vincero Design		\N	\N	\N	\N	\N	\N	887
6610	Vindec High Riser		\N	\N	\N	\N	\N	\N	338
6611	Viner		\N	\N	\N	\N	\N	\N	1514
6612	Virtue	http://www.virtuebike.com	\N	\N	\N	\N	\N	\N	956
6613	Viscount		\N	\N	\N	\N	\N	\N	1082
6614	Vision	http://www.visiontechusa.com/	\N	\N	\N	\N	\N	\N	888
6615	Vittoria		\N	\N	\N	\N	\N	\N	889
6616	Vitus		\N	\N	\N	\N	\N	\N	339
6617	Viva	http://www.vivabikes.com/	\N	\N	\N	\N	\N	\N	1188
6618	Vivente	http://www.viventebikes.com/	\N	\N	\N	\N	\N	\N	1192
6619	Volae		\N	\N	\N	\N	\N	\N	1249
6620	Volagi	http://www.volagi.com/	\N	\N	\N	\N	\N	\N	1106
6621	Volume		\N	\N	\N	\N	\N	\N	890
6622	Voodoo	http://voodoocycles.net/	\N	\N	\N	\N	B	\N	1089
6623	Vortrieb	http://www.vortrieb.com/	\N	\N	\N	\N	\N	\N	1075
6624	VéloSoleX		\N	\N	\N	\N	\N	\N	334
6625	WD-40 Bike		\N	\N	\N	\N	\N	\N	895
6626	WTB		\N	\N	\N	\N	\N	\N	913
6627	Wabi Cycles	http://www.wabicycles.com/index.html	\N	\N	\N	\N	\N	\N	996
6628	Wahoo Fitness		\N	\N	\N	\N	\N	\N	892
6629	Wald		\N	\N	\N	\N	\N	\N	893
6630	Walking Bird		\N	\N	\N	\N	\N	\N	894
6631	Waterford	http://waterfordbikes.com/w/	\N	\N	\N	\N	\N	\N	341
6632	WeThePeople		\N	\N	\N	\N	\N	\N	342
6633	WeeRide	http://www.weeride.com/	\N	\N	\N	\N	\N	\N	1039
6634	Weehoo	http://rideweehoo.com/	\N	\N	\N	\N	\N	\N	1118
6635	Wellgo		\N	\N	\N	\N	\N	\N	896
6636	Wheels Manufacturing		\N	\N	\N	\N	\N	\N	897
6637	Wheelsmith		\N	\N	\N	\N	\N	\N	898
6638	Where to Bike		\N	\N	\N	\N	\N	\N	899
6639	Whisky Parts Co		\N	\N	\N	\N	\N	\N	900
6640	Whispbar		\N	\N	\N	\N	\N	\N	901
6641	White Bros		\N	\N	\N	\N	\N	\N	902
6642	White Lightning		\N	\N	\N	\N	\N	\N	903
6643	Wigwam		\N	\N	\N	\N	\N	\N	904
6644	Wilderness Trail Bikes		\N	\N	\N	\N	\N	\N	343
6645	Wilier Triestina	http://www.wilier.com/	\N	\N	\N	\N	\N	\N	344
6646	Williams		\N	\N	\N	\N	\N	\N	905
6647	Willworx		\N	\N	\N	\N	\N	\N	906
6648	Win		\N	\N	\N	\N	\N	\N	907
6649	Windsor	http://www.windsorbicycles.com/	\N	\N	\N	\N	\N	\N	946
6650	Winora	http://www.winora.de/	\N	\N	\N	\N	\N	\N	932
6651	Winter Bicycles	http://www.winterbicycles.com/	\N	\N	\N	\N	\N	\N	1052
6652	Wippermann		\N	\N	\N	\N	\N	\N	908
6653	Witcomb Cycles		\N	\N	\N	\N	\N	\N	345
6654	Witz		\N	\N	\N	\N	\N	\N	909
6655	Wooden Bike Coffee		\N	\N	\N	\N	\N	\N	910
6656	WordLock	http://wordlock.com/	\N	\N	\N	\N	\N	\N	1254
6657	WorkCycles	http://www.workcycles.com/	\N	\N	\N	\N	\N	\N	987
6658	Adler	\N	\N	\N	t	https://en.wikipedia.org/wiki/Adler_(automobile)	\N	\N	\N
6659	AIST	\N	\N	\N	f	https://en.wikipedia.org/wiki/Aist_Bicycles	\N	\N	\N
6660	Aprilia	\N	\N	\N	f	https://en.wikipedia.org/wiki/Aprilia	\N	\N	\N
6661	Ariel	\N	\N	\N	t	https://en.wikipedia.org/wiki/Ariel_(vehicle)	\N	\N	\N
6662	Baltik vairas	\N	\N	\N	f	https://en.wikipedia.org/wiki/Baltik_vairas	\N	\N	\N
6663	Barnes Cycle Company	\N	\N	\N	t	https://en.wikipedia.org/wiki/History_of_cycling_in_Syracuse,_New_York#Barnes_Cycle_Company	\N	\N	\N
6664	Battaglin	\N	\N	\N	f	https://en.wikipedia.org/wiki/Giovanni_Battaglin#Retirement	\N	\N	\N
6665	Berlin &amp; Racycle Manufacturing Company	\N	\N	\N	t	https://en.wikipedia.org/wiki/The_Arthur_Pequegnat_Clock_Company	\N	\N	\N
6666	Bontrager	\N	\N	\N	f	https://en.wikipedia.org/wiki/Keith_Bontrager#Bicycles	\N	\N	\N
6667	Bootie	\N	\N	\N	f	https://en.wikipedia.org/wiki/Bootie_(bicycle)	\N	\N	\N
6668	Bradbury	\N	\N	\N	t	https://en.wikipedia.org/wiki/Bradbury_Motor_Cycles	\N	\N	\N
6669	BSA	\N	\N	\N	f	https://en.wikipedia.org/wiki/Birmingham_Small_Arms_Company	\N	\N	\N
6670	B’Twin	\N	\N	\N	f	https://en.wikipedia.org/wiki/Decathlon_Group	\N	\N	\N
6671	Clément	\N	\N	\N	t	https://en.wikipedia.org/wiki/Adolphe_Cl%C3%A9ment#C.C3.A9ment_cycles	\N	\N	\N
6672	Coventry-Eagle	\N	\N	\N	f	https://en.wikipedia.org/wiki/Coventry-Eagle	\N	\N	\N
6673	Cycleuropa Group	\N	\N	\N	f	https://en.wikipedia.org/wiki/Cycleuropa_Group	\N	\N	\N
6674	Defiance Cycle Company	\N	\N	\N	f	https://en.wikipedia.org/wiki/Defiance_Cycle_Company	\N	\N	\N
6675	Demorest	\N	\N	\N	f	https://en.wikipedia.org/wiki/Lycoming_Engines#Sewing_machines.2C_bicycles_and_fashion	\N	\N	\N
6676	Dunelt	\N	\N	\N	t	https://en.wikipedia.org/wiki/Dunelt_Motorcycles	\N	\N	\N
6677	Ērenpreiss Bicycles	\N	\N	\N	f	https://en.wikipedia.org/wiki/%C4%92renpreiss_Bicycles	\N	\N	\N
6678	Excelsior	\N	\N	\N	t	https://en.wikipedia.org/wiki/Excelsior_Motor_Company	\N	\N	\N
6679	Gimson	\N	\N	\N	t	https://en.wikipedia.org/wiki/Gimson_(cycles)	\N	\N	\N
6680	Gräf &amp; Stift	\N	\N	\N	t	https://en.wikipedia.org/wiki/Gr%C3%A4f_%26_Stift	\N	\N	\N
6681	Gustavs Ērenpreis Bicycle Factory	\N	\N	\N	t	https://en.wikipedia.org/wiki/Gustavs_%C4%92renpreis_Bicycle_Factory	\N	\N	\N
6682	Harley-Davidson	\N	\N	\N	f	https://en.wikipedia.org/wiki/Harley-Davidson#Bicycles	\N	\N	\N
6683	Henley Bicycle Works	\N	\N	\N	t	https://en.wikipedia.org/wiki/Micajah_C._Henley	\N	\N	\N
6684	Hoffmann	\N	\N	\N	t	https://en.wikipedia.org/wiki/Hoffmann_(motorcycle)	\N	\N	\N
6685	Husqvarna	\N	\N	\N	f	https://en.wikipedia.org/wiki/Husqvarna_Motorcycles#Bicycle_manufacturing	\N	\N	\N
6686	Indian	\N	\N	\N	f	https://en.wikipedia.org/wiki/Indian_(motorcycle)#Bicycles	\N	\N	\N
6687	IFA	\N	\N	\N	t	https://en.wikipedia.org/wiki/Industrieverband_Fahrzeugbau	\N	\N	\N
6688	Ivel Cycle Works	\N	\N	\N	t	https://en.wikipedia.org/wiki/Dan_Albone	\N	\N	\N
6689	Kangaroo	\N	\N	\N	f	https://en.wikipedia.org/wiki/Kangaroo_bicycle	\N	\N	\N
6690	Karbon Kinetics Limited	\N	\N	\N	f	https://en.wikipedia.org/wiki/Karbon_Kinetics_Limited	\N	\N	\N
6691	Kia	\N	\N	\N	f	https://en.wikipedia.org/wiki/Kia_Motors	\N	\N	\N
6692	Merckx	\N	\N	\N	f	https://en.wikipedia.org/wiki/Eddy_Merckx	\N	\N	\N
6693	Minerva	\N	\N	\N	t	https://en.wikipedia.org/wiki/Minerva_(automobile)#Bicycles_and_motorcycles	\N	\N	\N
6694	Mochet	\N	\N	\N	t	https://en.wikipedia.org/wiki/Mochet	\N	\N	\N
6695	Motobécane	\N	\N	\N	f	https://en.wikipedia.org/wiki/Motob%C3%A9cane	\N	\N	\N
6696	Nagasawa	\N	\N	\N	f	https://en.wikipedia.org/wiki/Yoshiaki_Nagasawa	\N	\N	\N
6697	NEXT	\N	\N	\N	f	https://en.wikipedia.org/wiki/NEXT_(bicycle_company)	\N	\N	\N
6698	NSU	\N	\N	\N	f	https://en.wikipedia.org/wiki/NSU_Motorenwerke#NSU_bicycles	\N	\N	\N
6699	Olive Wheel Company	\N	\N	\N	t	https://en.wikipedia.org/wiki/History_of_cycling_in_Syracuse,_New_York#Olive_Wheel_Company	\N	\N	\N
6700	Órbita	\N	\N	\N	f	https://en.wikipedia.org/wiki/%C3%93rbita_bicycles	\N	\N	\N
6701	Overman Wheel Company	\N	\N	\N	t	https://en.wikipedia.org/wiki/Overman_Wheel_Company	\N	\N	\N
6702	Premier	\N	\N	\N	t	https://en.wikipedia.org/wiki/Premier_Motorcycles	\N	\N	\N
6703	Quality Bicycle Products	\N	\N	\N	f	https://en.wikipedia.org/wiki/Quality_Bicycle_Products	\N	\N	\N
6704	R+E Cycles	\N	\N	\N	f	https://en.wikipedia.org/wiki/R%2BE_Cycles	\N	\N	\N
6705	Rabasa Cycles	\N	\N	\N	f	https://en.wikipedia.org/wiki/Rabasa_Cycles	\N	\N	\N
6706	Rhoades Car	\N	\N	\N	f	https://en.wikipedia.org/wiki/Rhoades_Car	\N	\N	\N
6707	Riley Cycle Company	\N	\N	\N	t	https://en.wikipedia.org/wiki/Riley_(motor-car)#Riley_Cycle_Company	\N	\N	\N
6708	ROSE Bikes	\N	\N	\N	f	https://en.wikipedia.org/wiki/ROSE_Bikes	\N	\N	\N
6709	Salcano (bicycle)	\N	\N	\N	f	https://en.wikipedia.org/wiki/Salcano_(bicycle)	\N	\N	\N
6710	Maskinfabriks-aktiebolaget Scania	\N	\N	\N	f	https://en.wikipedia.org/wiki/Maskinfabriks-aktiebolaget_Scania	\N	\N	\N
6711	Simpel	\N	\N	\N	f	https://en.wikipedia.org/wiki/Simpel	\N	\N	\N
6712	Singer	\N	\N	\N	t	https://en.wikipedia.org/wiki/Singer_(car)#Bicycles	\N	\N	\N
6713	Softride	\N	\N	\N	f	https://en.wikipedia.org/wiki/Softride	\N	\N	\N
6714	Solifer	\N	\N	\N	f	https://en.wikipedia.org/wiki/Solifer	\N	\N	\N
6715	SOMA Fabrications	\N	\N	\N	f	https://en.wikipedia.org/wiki/SOMA_Fabrications	\N	\N	\N
6716	Star Cycle Company	\N	\N	\N	f	https://en.wikipedia.org/wiki/Star_Motor_Company#Bicycles	\N	\N	\N
6717	Stearns	\N	\N	\N	t	https://en.wikipedia.org/wiki/E._C._Stearns_Bicycle_Agency	\N	\N	\N
6718	Steyr	\N	\N	\N	t	https://en.wikipedia.org/wiki/Steyr-Daimler-Puch	\N	\N	\N
6719	Sunbeam	\N	\N	\N	t	https://en.wikipedia.org/wiki/Sunbeam_Cycles#Sunbeam_bicycles	\N	\N	\N
6720	Swift Folder	\N	\N	\N	f	https://en.wikipedia.org/wiki/Swift_Folder	\N	\N	\N
6721	Syracuse Cycle Company	\N	\N	\N	t	https://en.wikipedia.org/wiki/History_of_cycling_in_Syracuse,_New_York#Syracuse_Cycle_Company	\N	\N	\N
6722	Thomas	\N	\N	\N	t	https://en.wikipedia.org/wiki/Thomas_Motor_Company	\N	\N	\N
6723	Tube Investments	\N	\N	\N	f	https://en.wikipedia.org/wiki/Tube_Investments	\N	\N	\N
6724	Velocite Bikes	\N	\N	\N	f	https://en.wikipedia.org/wiki/Velocite_Bikes	\N	\N	\N
6725	Victoria	\N	\N	\N	f	https://en.wikipedia.org/wiki/Victoria_(motorcycle)	\N	\N	\N
6726	Wanderer	\N	\N	\N	t	https://en.wikipedia.org/wiki/Wanderer_(car)	\N	\N	\N
6727	Westfield Maufacturing	\N	\N	\N	t	https://en.wikipedia.org/wiki/History_of_cycling_in_Syracuse,_New_York#Westfield_Manufacturing	\N	\N	\N
6728	Whippet	\N	\N	\N	f	https://en.wikipedia.org/wiki/Whippet_(bicycle)	\N	\N	\N
6729	Wittson Custom Ti Cycles	\N	\N	\N	f	https://en.wikipedia.org/wiki/Wittson_Custom_Ti_Cycles	\N	\N	\N
6730	Worden Bicycles	\N	\N	\N	t	https://en.wikipedia.org/wiki/History_of_cycling_in_Syracuse,_New_York#Worden_Bicycles	\N	\N	\N
6731	Whyte	\N	\N	\N	f	https://en.wikipedia.org/wiki/Whyte_(bicycles)	\N	\N	\N
6732	Zündapp	\N	\N	\N	f	https://en.wikipedia.org/wiki/Z%C3%BCndapp	\N	\N	\N
\.


--
-- Name: manufacturer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: arobson
--

SELECT pg_catalog.setval('manufacturer_id_seq', 6868, true);


--
-- Data for Name: model; Type: TABLE DATA; Schema: public; Owner: arobson
--

COPY model (id, manufacturer_id, name, year_introduced, year_discontinued, notes, web_url, source, style_id, created_at, type_ids) FROM stdin;
\.


--
-- Name: model_id_seq; Type: SEQUENCE SET; Schema: public; Owner: arobson
--

SELECT pg_catalog.setval('model_id_seq', 1, false);


--
-- Data for Name: photo; Type: TABLE DATA; Schema: public; Owner: arobson
--

COPY photo (id, original_file, file_path, bike_id, user_id, metadata, created_at, updated_at) FROM stdin;
246		/dev/2017-03/1-148982040_{*}.jpg	1	1	\N	2017-03-18 12:57:19.724755-07	\N
247		/dev/2017-03/1-148982040_{*}.jpg	1	1	\N	2017-03-18 13:03:13.924765-07	\N
248		/dev/2017-03/1-148982040_{*}.jpg	1	1	\N	2017-03-18 13:14:22.755495-07	\N
249	ellen-rutt-detroit-art-bike.jpg	/dev/2017-03/1-148982040_{*}.jpg	1	1	\N	2017-03-18 13:14:31.919351-07	\N
250	fuji_cambridge_iii.jpg	/dev/2017-03/1-148982040_{*}.jpg	1	1	\N	2017-03-18 14:31:47.779407-07	\N
251	287769357_d9bf7ba0da.jpg	/dev/2017-03/1-148982040_{*}.jpg	1	1	\N	2017-03-18 14:37:49.295141-07	\N
252	287769684_d8ae73e674.jpg	/dev/2017-03/1-148982040_{*}.jpg	1	1	\N	2017-03-18 14:53:15.467752-07	\N
253	00I0I_dklyr2uOCiH_1200x900.jpg	/dev/2017-03/1-148982040_{*}.jpg	1	1	\N	2017-03-18 14:54:14.813719-07	\N
254	00l0l_3qMEYlr9NAr_1200x900.jpg	/dev/2017-03/1-148982040_{*}.jpg	1	1	\N	2017-03-18 15:35:16.020839-07	\N
255	Screen Shot 2017-03-08 at 6.51.24 PM.png	/dev/2017-03/1-148982040_{*}.jpg	1	1	{"width": 1251, "height": 939, "filesize": "2.674MB", "number_pixels": "1.175M"}	2017-03-18 15:51:29.259189-07	\N
256	Screen Shot 2017-02-09 at 1.35.40 PM.png	/dev/2017-03/1-148999320_{*}.jpg	1	1	{"width": 864, "height": 648, "filesize": "1.123MB", "number_pixels": "560K"}	2017-03-20 11:56:38.947078-07	\N
\.


--
-- Name: photo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: arobson
--

SELECT pg_catalog.setval('photo_id_seq', 256, true);


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
-- Data for Name: session; Type: TABLE DATA; Schema: public; Owner: arobson
--

COPY session (sid, sess, expire) FROM stdin;
wmaLtyqnZt5hNbEy-TJG_PnJNiiGObgs	{"cookie":{"originalMaxAge":2592000000,"expires":"2017-03-30T02:59:09.638Z","httpOnly":true,"path":"/"}}	2017-03-29 19:59:10
u79eVtlGh7mONkCtfjJZ2hzb3ALG0RjQ	{"cookie":{"originalMaxAge":2592000000,"expires":"2017-03-27T23:27:17.759Z","httpOnly":true,"path":"/"}}	2017-03-27 16:27:18
0XEuurkq985EnMgu2fOuvbFw_WApiN5N	{"cookie":{"originalMaxAge":2592000000,"expires":"2017-03-30T02:59:09.650Z","httpOnly":true,"path":"/"}}	2017-03-29 19:59:10
_0IWn5h0SVBuVz4EDrKiqGjLmOJR79Yc	{"cookie":{"originalMaxAge":2592000000,"expires":"2017-03-30T22:16:21.577Z","httpOnly":true,"path":"/"},"passport":{"user":5}}	2017-03-30 15:17:10
V1_myJsHMrGRunIliKv8A94ntbz67RrJ	{"cookie":{"originalMaxAge":2592000000,"expires":"2017-03-27T23:27:17.757Z","httpOnly":true,"path":"/"}}	2017-03-27 16:27:18
j-J8Rp_Xs9SFkBiExaoGX9oIrZbfAzON	{"cookie":{"originalMaxAge":2591999999,"expires":"2017-04-19T18:53:34.266Z","httpOnly":true,"path":"/"},"passport":{"user":1}}	2017-04-19 11:56:44
gskHgbu2wpw2qbBKgr776Czunt53V-_5	{"cookie":{"originalMaxAge":2592000000,"expires":"2017-03-30T02:59:09.621Z","httpOnly":true,"path":"/"}}	2017-03-29 19:59:10
2cywolBc5FvvCd_cBu5-6ZCoIbEbMijK	{"cookie":{"originalMaxAge":2592000000,"expires":"2017-03-27T23:27:17.756Z","httpOnly":true,"path":"/"}}	2017-03-27 16:27:18
LtPxp5MxYqpHijUvkuqMN5xW9bTmBqI-	{"cookie":{"originalMaxAge":2592000000,"expires":"2017-03-30T03:16:01.930Z","httpOnly":true,"path":"/"}}	2017-03-30 15:11:14
EcL-Tw3Vw-bL1YhgD384KVLkr0v2tuMe	{"cookie":{"originalMaxAge":2592000000,"expires":"2017-03-27T23:27:17.758Z","httpOnly":true,"path":"/"}}	2017-03-27 16:27:18
Fe3VpVxuAmhb3P56mJL2rS8jTRZAFTYs	{"cookie":{"originalMaxAge":2591999999,"expires":"2017-03-27T23:27:17.754Z","httpOnly":true,"path":"/"}}	2017-03-27 16:27:18
4z9e9GdlXez4l8eGajYc6trfrK3s_MJO	{"cookie":{"originalMaxAge":2592000000,"expires":"2017-03-30T02:59:09.644Z","httpOnly":true,"path":"/"}}	2017-03-29 19:59:10
gdzoTodDKuUust53dWKJ7DMpqfVZXI3y	{"cookie":{"originalMaxAge":2592000000,"expires":"2017-03-30T02:59:09.563Z","httpOnly":true,"path":"/"}}	2017-03-29 19:59:10
\.


--
-- Data for Name: story; Type: TABLE DATA; Schema: public; Owner: arobson
--

COPY story (id, created_at, text, user_id) FROM stdin;
\.


--
-- Name: story_id_seq; Type: SEQUENCE SET; Schema: public; Owner: arobson
--

SELECT pg_catalog.setval('story_id_seq', 1, false);


--
-- Data for Name: theft; Type: TABLE DATA; Schema: public; Owner: arobson
--

COPY theft (id, reported_at, description, bike_id, owner_id, recovered_at) FROM stdin;
\.


--
-- Name: theft_id_seq; Type: SEQUENCE SET; Schema: public; Owner: arobson
--

SELECT pg_catalog.setval('theft_id_seq', 1, false);


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
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: arobson
--

SELECT pg_catalog.setval('user_id_seq', 3, true);


--
-- Data for Name: user_photo; Type: TABLE DATA; Schema: public; Owner: arobson
--

COPY user_photo (id, user_id, web_url, source, created_at) FROM stdin;
22	\N	https://scontent.xx.fbcdn.net/v/t1.0-1/p50x50/12295504_10207924651948031_1540028450570342820_n.jpg?oh=141a54fe9311be8d1068fd3df0fa80ff&oe=596EE342	'facebook'	2017-03-16 22:12:43.68154-07
25	1	https://scontent.xx.fbcdn.net/v/t1.0-1/p50x50/12295504_10207924651948031_1540028450570342820_n.jpg?oh=141a54fe9311be8d1068fd3df0fa80ff&oe=596EE342	'facebook'	2017-03-18 10:55:48.168753-07
\.


--
-- Name: user_photo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: arobson
--

SELECT pg_catalog.setval('user_photo_id_seq', 27, true);


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
-- Name: bike bike_main_photo_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: arobson
--

ALTER TABLE ONLY bike
    ADD CONSTRAINT bike_main_photo_id_fkey FOREIGN KEY (main_photo_id) REFERENCES photo(id) ON DELETE CASCADE;


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

