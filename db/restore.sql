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
    original_filename text,
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
-- Name: user; Type: TABLE; Schema: public; Owner: arobson
--

CREATE TABLE "user" (
    id integer NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    last_login timestamp with time zone,
    username text,
    facebook_id integer,
    name text,
    first_name text,
    last_name text,
    facebook_link text,
    gender text,
    locale text
);


ALTER TABLE "user" OWNER TO arobson;

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

ALTER SEQUENCE user_id_seq OWNED BY "user".id;


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
-- Name: user id; Type: DEFAULT; Schema: public; Owner: arobson
--

ALTER TABLE ONLY "user" ALTER COLUMN id SET DEFAULT nextval('user_id_seq'::regclass);


--
-- Data for Name: bike; Type: TABLE DATA; Schema: public; Owner: arobson
--

COPY bike (id, brand_unlinked, model_unlinked, created_at, updated_at, user_id, description, notes, nickname, manufacturer_id, model_id, serial_number, main_photo_path, type_ids, reason_ids, status) FROM stdin;
\.


--
-- Name: bike_id_seq; Type: SEQUENCE SET; Schema: public; Owner: arobson
--

SELECT pg_catalog.setval('bike_id_seq', 115, true);


--
-- Data for Name: bike_info; Type: TABLE DATA; Schema: public; Owner: arobson
--

COPY bike_info (bike_id, year, era, speeds, handlebars, brakes, color, details) FROM stdin;
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
5023	5914	Galaxy 5	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5024	5914	Giro	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5025	5914	Raceline Record	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5026	5914	Capri about	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5027	5914	Gran Tour	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5028	5914	Imperial	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5029	5918	Flatland	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5030	5919	Alistair	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5031	5919	E112	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5032	5919	Electron	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5033	5919	Electron HED3s	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5034	5921	Di Fiori	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5035	5922	Campagnolo	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5036	5922	Campagnolo Veloce	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5037	5922	Corsa	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5038	5922	Grand Prix	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5039	5922	Reparto Corse	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5040	5922	Rizzato	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5041	5922	Steel road	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5042	5922	Albatross	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5043	5922	Air road7	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5044	5922	Veloculture Mag	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5045	5922	Professional Record	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5046	5922	Record	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5498	6086	Dash	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5499	6086	DYNATECH	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5500	6086	Elkhorn	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5501	6086	Flipflop	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5502	6086	Flyer	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5503	6086	Giro	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5504	6086	GOD	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5505	6086	Golden Arrow c1937	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5506	6086	Gran Sport	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5507	6086	Grand Prix	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5508	6086	Grand Prix Nates	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5509	6086	Grand Sport	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5510	6086	GrandPrix Winter	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5511	6086	High Life	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5512	6086	International cross	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5513	6086	Kennith	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5514	6086	M60	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5515	6086	M80	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5516	6086	M800	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5517	6086	Macaframa	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5518	6086	Machine	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5519	6086	Marathon	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5520	6086	Mercury	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5521	6086	Modern	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5522	6086	Nova Sport	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5523	6086	Olympian	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5524	6086	One	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5525	6086	One Way	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5526	6086	OneWay	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5527	6086	Overhaul	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5528	6086	Professional	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5529	6086	Professional Mk V	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5530	6086	Proline 200	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5531	6086	Pursuit	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5532	6086	R700	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5533	6086	Rambler MX	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5534	6086	Rampar Rapide	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5535	6086	Rapide	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5536	6086	Record DL130	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5537	6086	Record Sprint	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5538	6086	Rider	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5539	6086	Road Ace	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5540	6086	Rush Hour 09	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5541	6086	Rush Hour Pro RHP	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5542	6086	Rushour 06	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5543	6086	Scirroco	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5544	6086	Shoppaphenia	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5545	6086	Sirocco	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5546	6086	Snow Plow	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5547	6086	Sojourn	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5548	6086	Something or other	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5549	6086	Sport	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5550	6086	Sport Winter	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5551	6086	Sportif	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5552	6086	Sports original	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5553	6086	Sprint	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5554	6086	Sprite Townie	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5555	6086	Styler Mag	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5556	6086	Summit	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5557	6086	Super Course	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5558	6086	Super Course dads	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5559	6086	Super Course MK II	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5560	6086	Super Course MKII	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5561	6086	Super Grand Prix	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5562	6086	Super ReCourse	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5563	6086	Super Record	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5564	6086	Super Tourer	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5565	6086	Supercourse	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5566	6086	Supercourse 72	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5567	6086	SuperCourse TeamUSA	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5568	6086	Talus 29er 29	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5569	6086	Tarantula Winter	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5570	6086	Team	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5571	6086	Team Aero 753	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5572	6086	Team Heritage	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5573	6086	Team Professional	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5574	6086	Team USA	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5575	6086	Technium 440	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5576	6086	Technium 450	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5577	6086	Technium Aluminum	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5578	6086	The Troopz	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5579	6086	TI maybe LAST setup	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5580	6086	TI Tour De France	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5581	6086	Tourist	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5582	6086	Townie	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5583	6086	Trek	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5584	6086	TriLite 87	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5047	5922	Pista Campagnolo	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5048	5922	Sky	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5049	5922	Dedacciai prototype	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5050	5924	Vision	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5051	5926	Blade	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5052	5926	Giro Pro	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5053	5926	Pista Pro	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5054	5926	Pista Team rig	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5055	5926	Giro Pro Series	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5585	6086	USA Competition	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5586	6086	VOLANT	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5587	6086	Winter	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5588	6086	XXIX 29er	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5589	6086	Blukka	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5590	6086	Clubman Path Racer	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5591	6086	Grand Prix ala 68	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5592	6086	Rampar R1	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5593	6086	Rush Hour ever	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5594	6086	SB 1114	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5595	6086	Eclipse	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5148	6019	Dolan	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5596	6086	M20 Ever XC Rocket	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5597	6086	Road Reynolds 531	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5598	6086	Lenton Sports	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5599	6086	Sports C Tourist	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5600	6086	Sports Vangaurd	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5601	6086	Lancer	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5602	6086	Lenton Grand Prix	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5603	6086	Triumph my wifes	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5604	6086	Sports 3 speed	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5605	6086	SuperCourse Kelly	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5606	6086	Sprite Cyril	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5607	6086	Twenty Folding	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5608	6086	LTDSC	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5609	6086	Twenty Marshmallow	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5610	6086	Competition Compo	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5611	6086	RRA full Campy NRSR	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5612	6086	Super Course Single	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5613	6086	Tourist DL1	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5614	6086	Ti team professiona	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5615	6086	Folder	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5616	6086	Grand Prix SS	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5617	6086	Sports 3spd	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5618	6086	Tourist rodbrake	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5619	6086	Folder Twenty	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5620	6086	Professional Nigel	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5621	6086	Record LTD	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5622	6086	Sprite 27 Tiki	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5623	6086	Grand Prix Porteur	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5624	6086	Stowaway	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5625	6086	Team colors	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5626	6086	Competiton GS	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5627	6086	Pro team colors	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5628	6086	DL1 Roadster	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5629	6086	Grocery Getter	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5630	6086	Criterium	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5631	6086	Gran Sport 12	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5632	6086	Gran Course	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5633	6086	Marathon tourer	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5634	6086	Alyeska	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5635	6086	Marinoni	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5636	6086	Grand Prix 650b	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5637	6086	Technium TriLite	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5638	6086	Mojave 80	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5639	6086	One Way CROSS STYLE	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5640	6086	Rush HourDay One	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5641	6086	Prestige	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5642	6086	Revenio 20	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5643	6086	RX 10	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5644	6086	Tourer	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5645	6086	TI Pro Racer	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5646	6086	Record Hornet	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5647	6086	Rampar ROne	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5648	6086	Technium 420	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5649	6086	USA	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5650	6091	Nordavinden	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5651	6094	Micro Mini	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5652	6094	Micro Mini Pro	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5653	6094	Conquest Porteur	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5654	6094	925 Carla	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5655	6094	925	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5656	6094	925 randonneur	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5657	6094	9to5	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5658	6094	Conquest Disc R	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5659	6094	D440	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5660	6094	Flight 29er	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5661	6094	Monocog	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5662	6094	Monocog Back to	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5663	6094	Monocog 26r	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5664	6094	PL24	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5665	6094	R510	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5666	6094	Ridonkulous	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5667	6094	TampT MX24	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5668	6094	Conquest Pro	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5669	6094	Monocog 29er	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5670	6094	925 Daily Driver	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5671	6094	Conquest Team	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5672	6094	D660 1x9 29er	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5673	6097	Sask	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5674	6101	NJS	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5675	5315	Champion	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5676	5315	Competition	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5677	5315	Course	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5678	5315	Criterium	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5679	5315	Criterium early	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5680	5315	Hennes Junkermann	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5681	5315	Professional	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5682	5315	Proteam	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5234	6040	SLX	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5683	5319	Restore NOS	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5684	5319	Paint	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5685	5321	Triathlon	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5686	5321	500 Lady	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5687	5321	800	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5688	5321	Basement Find	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5689	5321	MEGA THRUST	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5690	5321	Mod	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5691	5321	Modello	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5692	5321	Modelo Campy Record	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5693	5321	Modelo 1700	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5694	5321	Modelo 1800	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5695	5321	Modelo 24 Ragazzino	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5056	5929	Ti Hill Climber	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5057	5931	DS1	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5058	5937	Machine TRC01	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5059	5937	Time Machine TT02	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5060	5937	CrossMachine CX01	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5061	5937	Goldsprint	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5696	5321	Modelo 3000	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5697	5321	Modelo 600	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5698	5321	Modelo 800	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5699	5321	Modelo Rigato	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5700	5321	Modolo 3000	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5701	5321	Pista	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5702	5321	Pista Take 2	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5703	5321	San remo	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5704	5321	Sprint	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5705	5321	Timetrial	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5706	5321	Modelo 800 c85	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5707	5321	Pursuit funny	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5708	5321	1700	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5709	5321	Triathlon Edition	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5710	5323	Corsa Mondiale	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5711	5323	Italamerica	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5712	5323	W Joe Bell Paint	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5713	5323	Professionale	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5714	5323	Nouvitalia	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5715	5325	Pista Concept	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5716	5325	Pista	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5717	5325	SUPER PISTA CELESTE	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5718	5325	928 Carbon	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5719	5325	TSX	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5720	5325	Vinto	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5721	5325	87 Brava	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5722	5325	Old campagnolo	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5723	5325	06 pista	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5724	5325	1885 ALU REBORN	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5725	5325	1885 Italia	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5726	5325	Tange B	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5727	5325	SUPER PISTA	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5728	5325	603 Vento	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5729	5325	88 Eco Pista	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5730	5325	928	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5731	5325	928 Carbon C2C	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5732	5325	928 L Carbon	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5733	5325	928 MonoQ	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5734	5325	Alfana	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5735	5325	Alfana the evolving	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5736	5325	Alloro	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5737	5325	Aspelozen3	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5738	5325	Axis	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5739	5325	Axis Bianca	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5740	5325	BASS KAWASAKIGREEN	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5741	5325	B4P 1885 Alu	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5742	5325	BASS	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5743	5325	Blacked	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5744	5325	Board Walk	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5745	5325	Bomber	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5746	5325	Boy	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5747	5325	Brava	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5748	5325	BUSS	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5749	5325	C2C	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5750	5325	C2C 928 CARBON	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5751	5325	Campione	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5752	5325	Campione dItalia	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5753	5325	Campione de Italia	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5754	5325	Campione del mondo	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5755	5325	Caurus	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5309	6055	400T	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5756	5325	CAURUS 837 Hamburg	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5757	5325	CAURUS 840 Hamburg	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5758	5325	Caurus 840 A szamr	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5759	5325	Centenario	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5760	5325	Champione del Mondo	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5761	5325	City	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5762	5325	Commutercity	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5763	5325	Concept	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5764	5325	Concept deuce	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5765	5325	Converted roadbike	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5766	5325	CUSS	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5767	5325	D2 Pista	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5768	5325	D2 Pista 100	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5769	5325	D2 Pista Alu	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5770	5325	D2 Pista Scandium	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5771	5325	D2 Pista Super	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5772	5325	D2 SUPER PISTA	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5773	5325	D2 Super Pista hed3	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5774	5325	ELOS	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5775	5325	ELOS 96	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5776	5325	Eros	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5777	5325	Ev3 alucarbon	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5778	5325	EV4	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5779	5325	Ev4 reparto corse	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5780	5325	Faxed	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5781	5325	FixedGear	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5782	5325	Folding	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5783	5325	For the Office	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5784	5325	Freemont	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5785	5325	Fremont	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5786	5325	Genius	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5787	5325	Giro	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5788	5325	Got bullmoosed	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5789	5325	Infinito Ultegra	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5790	5325	Italian Champion	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5791	5325	Krono	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5792	5325	Krono 5716	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5793	5325	Krono TT	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5794	5325	Limited SE	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5795	5325	Luna	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5796	5325	Mega Alu	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5797	5325	Mega Pro	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5365	6055	Y11	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5798	5325	Mega Pro L 7005	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5799	5325	Mega Pro XL	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5800	5325	Mega X Pro AL	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5801	5325	MegaPro SL	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5802	5325	Meta Trick	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5803	5325	Milano	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5804	5325	Minimax Rare Find	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5805	5325	Nero	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5806	5325	Nirone 7 08	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5807	5325	Nuevo	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5808	5325	Nuova Alloro	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5809	5325	Nuova Racing 12v	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5810	5325	Nuova Racing 81	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5376	6055	600	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5811	5325	Nuovo Racer 12v	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5812	5325	Oldschool pista	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5813	5325	Pasta Concept	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5062	5937	Racemaster	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5063	5937	RaceMaster SLX 01	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5064	5937	Racemaster SLX01	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5065	5937	RM01	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5066	5937	Road Racer SL01	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5067	5937	SLC01	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5068	5937	SLC01 Pro	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5069	5937	SLC01 Pro Machine	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5070	5937	SLR01 Team Machine	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5814	5325	Pista PPP	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5815	5325	PISTA 03	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5816	5325	Pista 05	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5817	5325	Pista 06	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5818	5325	Pista 08 w Hed3c	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5819	5325	Pista silent night	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5820	5325	Pista TARCKED OUT	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5821	5325	Pista Navy	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5822	5325	Pista 08	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5389	6055	1420	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5823	5325	Pista 08 Justine	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5824	5325	Pista 09	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5825	5325	Pista or 86	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5826	5325	Pista342crew	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5827	5325	Pista 53	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5828	5325	Pista Version	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5829	5325	Pista 909	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5830	5325	Pista chrome	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5831	5325	Pista Coastie	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5832	5325	Pista Concept 05	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5833	5325	Pista Concept Lucy	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5834	5325	Pista concept 04	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5835	5325	Pista Concept 06	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5836	5325	Pista concept 420	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5837	5325	Pista Concept 51	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5838	5325	Pista Concept 57	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5839	5325	Pista Concept lbc	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5840	5325	Pista del Burque	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5841	5325	Pista Gang Greenie	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5842	5325	Pista se giorni	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5843	5325	Pista Sei Giorni	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5844	5325	Pista Steal	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5845	5325	Pista Steel	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5846	5325	Pista steel broken	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5847	5325	Pista via condotti	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5848	5325	Pista Vondash	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5849	5325	Pista w aerospoke	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5850	5325	Pista Noble	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5851	5325	Pistarip	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5852	5325	Pistacrap	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5853	5325	Pistola	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5854	5325	Police	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5855	5325	Project3	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5856	5325	Quattro	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5857	5325	Racer	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5858	5325	Randonneur	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5859	5325	Raw	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5860	5325	Recod 920	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5861	5325	Rekord 746	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5862	5325	Rekord 748	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5863	5325	Rekord 841d	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5864	5325	Rekord 845	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5865	5325	Reparto Corsa	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5866	5325	Reparto Corse	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5867	5325	Reparto Corse Pista	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5868	5325	Resto pista	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5869	5325	RoadtoFixed	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5870	5325	Roadbike	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5871	5325	Roadie	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5872	5325	Roger SS	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5873	5325	Roger SS CX	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5874	5325	SASS	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5875	5325	San Jose	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5876	5325	San Jose Geared	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5877	5325	San Remo	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5878	5325	Sempre Ultegra Di2	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5879	5325	Sika	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5880	5325	Single X	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5881	5325	SLX	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5882	5325	Space Violet	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5883	5325	Specialissima	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5884	5325	Sport	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5885	5325	Sport SS	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5886	5325	Sport sx	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5887	5325	Strada	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5888	5325	Strada LX	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5889	5325	Super Corsa	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5890	5325	Super GL	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5891	5325	Super Overhauled	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5892	5325	Super Pisa	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5893	5325	Super Pista Retro	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5894	5325	SUPER PISTA1986	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5895	5325	Super Pista D2	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5896	5325	Super Pista LTD	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5897	5325	Super Turismo	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5898	5325	Superleggera	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5899	5325	Team Veloce 04	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5900	5325	Trofeo	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5901	5325	Trofeo87	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8636	6346	Sputnik updated	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8637	6346	Sputnik 06	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8638	6346	Ventura	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8639	6346	Ventura Comp	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8640	6346	Xenith Team	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8641	6346	Later	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8642	6346	Eclipse 853 STEEL	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8643	6346	Dakar XLT	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8644	6346	Ranger XR	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8645	6346	Dakota Comp	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8646	6349	Garda	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8647	6349	Vigorelli	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8648	6354	Varsity	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8649	6358	SR300	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8650	6358	Campagnolo Athena	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8651	6358	Criterium	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8652	6358	One	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8653	6358	Capo	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8654	6358	TownieCity	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8655	6358	Pepsi baby	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8656	6358	28 series Road	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8657	6358	28 Ultegra R900	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8658	6358	30 RAW	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8659	6358	30 Road Race	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8660	6358	30 SR800	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8661	6358	600 SIS	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8662	6358	Barloworld	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8663	6358	Bulldog	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8664	6358	Caad 3	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8665	6358	CAAD 5	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8666	6358	CAAD 5 Machine	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8667	6358	CAAD 9	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8668	6358	Caad 9 hand painted	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8669	6358	Caad10	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8670	6358	Caad10 RAW	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8671	6358	CAAD2	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8672	6358	CAAD3 Road	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8673	6358	Caad3 Saeco	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8674	6358	CAAD4	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8675	6358	CAAD4 The Crusher	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8676	6358	CAAD4 R1000 Aero	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8677	6358	CAAD4 R400	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8678	6358	Caad4 R800	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8679	6358	CAAD4 Saeco	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8680	6358	CAAD5	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8681	6358	CAAD5 FixedSingle	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8682	6358	Caad7 Saeco	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8683	6358	CAAD8 Optimo 1	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8684	6358	CAAD9	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8685	6358	CAAD9 Dura Ace	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8686	6358	Caad94	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8687	6358	Caadx	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8688	6358	Capo Cherry	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8689	6358	Capo 07	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8690	6358	Capo 08	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8691	6358	Capo 09	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8692	6358	Capo 1	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8693	6358	Capo 2	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8694	6358	Capo Blacked out	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8695	6358	Capo WHOW RIDER	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8696	6358	Capo spinergy	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8841	6358	Six136	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9100	6395	Celtic	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9230	6401	Lavoro	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9894	6664	SLX	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9895	6666	Hardtail 24 wheels	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9896	6666	Carbon X lite	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5902	5325	TSX Dura Ace	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5903	5325	Veloce	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5904	5325	Veloce Stella	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5905	5325	Vento 527 Celeste	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5906	5325	Vento 602	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5907	5325	Via Nirone	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5908	5325	Via Nirone 7	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5909	5325	Vigorelli	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5910	5325	Virata carbon	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5911	5325	Volpe	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5912	5325	Volpe flat bars	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5913	5325	Vs F150	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5914	5325	Campys	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5915	5325	X4 Specialissima	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5916	5325	YELLA	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5917	5325	BBSS	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5918	5325	Pis o shit	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5919	5325	Classica	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5920	5325	CityCross	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5921	5325	Piaggio	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5922	5325	Steel Sweeeet Ride	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5923	5325	Eco Pista Yay	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5924	5325	Marys Illini 4000	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5071	5937	Slx01	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5072	5937	SLX01 Unassembled	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5073	5937	SSX Streetfire	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5074	5937	Streetfire	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5075	5937	Streetfire SSX	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5076	5937	Streetracer SR02	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5077	5937	Team Machine SLT 01	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5925	5325	Pista Concept V2	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5926	5325	Brainy smurf	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5927	5325	Record 841 Celeste	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5928	5325	Triathlon Baby	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5929	5325	LeMond Specialized	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5930	5325	Mtn	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5931	5325	Pista flip flop	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5932	5325	Roger	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5933	5325	Stelvio	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5934	5325	CELESTE	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5935	5325	Pista Concept Tarck	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5936	5325	Stable all elements	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5937	5325	ATB	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5938	5325	Pursuit 80s	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5939	5325	Super Leggera	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5940	5325	Eco pista	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5941	5325	Piaggio Pista	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5942	5325	Nuova	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5943	5325	Rekord 748 Restored	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5944	5325	Nuovo Gran Sport	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5945	5325	Piaggio Super Pista	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5946	5325	Piaggio sport	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5947	5325	Limited PackMule	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5948	5325	Squadra	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5949	5325	Grizzly	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5950	5325	Limited	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5951	5325	Volpe w Campagnolo	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5952	5325	Pista Priceless	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5953	5325	Virata	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5954	5325	Veloce Celeste	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5955	5325	Premio	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5956	5325	Pista Destroyer	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5957	5325	SL Lite Alloy	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5958	5325	Eros Celeste	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5959	5325	Pista Concept sjk	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5960	5325	Pista redux	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5961	5325	Pista No decals	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5962	5325	928 Ultegra	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5963	5325	Castro Valley	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5964	5325	Concept 61cn	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5965	5325	Cross Concept	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5966	5325	Pista soma	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5967	5325	D2 Crono Carbon	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5968	5325	Pista for trade for	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5969	5325	Pista Miche Grupos	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5970	5325	Pista Nero	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5971	5325	Super pista uti	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5972	5325	Sempre	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5973	5325	Polo steed	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5974	5325	Pista RARE	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5975	5325	Nuovo Racing	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5976	5325	Polo	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5977	5325	Shimano 600	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5978	5325	Advantage	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5979	5325	Tsx ultralight	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5980	5343	Copenhagen	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5981	5343	Copenhagen Cologne	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5982	5343	MN 03	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5983	5352	Speedster	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5984	5352	Cx Titanium	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5985	5352	LOLLOBRIGIDA RR	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5986	5356	Team C Baseman Biff	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5987	5356	Team Carbon	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5988	5363	Leader 735TR	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5989	5368	Campagnolo	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5990	5368	89 Randy	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5991	5368	989	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5992	5368	Ashes 2 Ashes	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5993	5368	Campione del mondo	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5994	5368	Champione Del Mondo	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5995	5368	Extra Leggeri	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5996	5368	SL Chorus	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5997	5368	Sprint	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5998	5368	Squadra Columbus SL	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5999	5368	Team ADR	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6000	5368	Team SPAGO	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6001	5368	Winter Beast	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6002	5368	Giro D Italia	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6003	5368	Professional	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6004	5368	SLX	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6005	5368	Strada	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6006	5368	Professional SL	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6007	5369	Pista	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6008	5369	Brevet	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6009	5376	Jet Stream XTR 900	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6010	5376	Cloud 9	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6011	5376	Lightning	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6012	5376	Lightning xtr	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6013	5376	Thunder	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6014	5376	Venturi	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6015	5378	NJS Keirin	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6016	5378	NYC	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6017	5378	XO 3	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6018	5378	Altair	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6019	5378	TRON	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6020	5378	Take 2	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6021	5378	1x1MB3	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6022	5378	300 Mixtie	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6023	5378	400	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6024	5378	440 87	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6025	5378	450	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6026	5378	500 articulation	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6027	5378	515	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6028	5378	600	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6029	5378	Anchor	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6030	5378	ANCHOR ARCP	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6031	5378	Anchor Keirin	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6032	5378	Anchor NJS	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6033	5378	Anchor NJS 535 cm	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6034	5378	ANCHOR PHM9	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6035	5378	ANCHOR PHR7	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6036	5378	Beauty	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6037	5378	CB2	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6038	5378	Coaster brake	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6039	5378	Road to	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5078	5937	Time machine TT03	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5079	5937	Timemachine TM01	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5080	5937	Machine	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5081	5937	TrailFox 02	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5082	5937	TT02 Team Astana	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6040	5378	Diamond Sports	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6041	5378	Galaxie	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6042	5378	Golden rainbow	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6043	5378	Grand Velo	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6044	5378	Grand Vlo	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6045	5378	Kabuki	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6046	5378	Kabuki 19__	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6047	5378	Kabuki s	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6048	5378	Keirin	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6049	5378	Keirin Machine	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6050	5378	MB3	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6051	5378	MB6	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6052	5378	MB4	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6053	5378	Mile 112	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6054	5378	NJS	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6055	5378	NJS DEAD	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6056	5378	NJS Anchor	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6057	5378	NJS Crimson	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6058	5378	Radac	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6059	5378	RB 5 Synergy Sport	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6060	5378	RB1	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6061	5378	RB1 synergy	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6062	5378	RB2	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6063	5378	RB3	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6064	5378	RBT	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6065	5378	City	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6066	5378	Steel	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6067	5378	SUPER DIAMOND ROAD	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6068	5378	T700 Warhorse	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6069	5378	Repaint	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6070	5378	Velo Cult	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6071	5378	X03	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6072	5378	X01	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6073	5378	XO 2	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6074	5378	XO1	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6075	5378	XO1 SRAM Rival	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6076	5378	XO2	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6077	5378	YELLOWNESS	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6078	5378	Night Wing	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6079	5378	ANCHORGRAND MIGHTY	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6080	5378	Bomber	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6081	5378	XO5	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6082	5378	500	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6083	5378	Daily ride murdered	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6084	5378	515cm	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6085	5378	NJS updated setup	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6086	5378	Atlantis ARR 550	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6087	5378	MB5	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6088	5378	NJS Ishiwata 017	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6089	5378	Beast	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6090	5378	Eurasia	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6091	5378	T700	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6092	5378	450 Japan	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6093	5378	300	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6094	5378	550	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6095	5378	MB2 Comp	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6096	5378	CB1	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6097	5381	Pipebomb	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6098	5381	Pipe Bomb	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6099	5381	Street Fighter	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6100	5381	StreetFighter	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6101	5381	CritFighter	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6102	5382	Sovereign	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6103	5392	Duet	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6104	5396	Galaxy 3spd	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6105	5396	Pursuit	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6106	5408	FS3	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6107	5408	Team edition RARE	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6108	5411	Super Record	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6109	5411	Nuovo Record	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6110	5411	Mix	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6111	5411	Veloce	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6112	5411	Athena	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6113	5411	Chorus Group	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6114	5411	50th groupset	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6115	5411	CRecord	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6116	5411	Strada	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6117	5411	Record 10	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6118	5411	Diskwheel	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6119	5411	NJS KEIRIN	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6120	5411	Pista Schauff Final	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6121	5411	Record SAMSON	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6122	5411	Chorus 10	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6123	5411	TEAM vento	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6124	5411	Parts	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6125	5411	Sheriff Star	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6126	5411	C Record	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6127	5411	Mavic	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6128	5411	NuovoSuper Record	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6129	5411	CRECORD COBALTO	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6130	5411	CRECORD COBALTO 54	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6131	5411	C Record delta	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6132	5411	Record	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6133	5411	Chorus group 90S	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6134	5411	Record Group Road	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6135	5411	SRNR	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6136	5411	Record Carbon	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6137	5411	Group	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6138	5411	Parts mix	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6139	5411	SR FOR SELL	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6140	5411	Record 010	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6141	5411	Gran Sport	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6142	5411	Shamal	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6143	5411	EASTON	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6144	5411	Crecord Croce dAune	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6145	5411	Croce daune deltas	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6146	5411	Record Group	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6147	5411	Record components	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6148	5411	Zonda 16R wheels	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6149	5411	Pista	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6150	5411	Roma Mexico 1969	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6151	5411	Club Racer	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6152	5411	CRecords	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6153	5411	Record Vento 3ttt	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6154	5411	Ends Columbus SL	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6155	5411	Stratos Group	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6156	5411	Record Pista	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6157	5411	Componetry	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6158	5411	Century	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6159	5411	Super Record 77	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6160	5411	Super Record gruppo	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6161	5411	Gipiemme	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6162	5411	Dropouts	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5083	5937	ProMachine SLC01	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5084	5940	Dog Pelican 700c	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5085	5943	600 Ultegra	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5086	5943	Bushmaster 2	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5087	5944	Corsa	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5088	5944	Bella ATT	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5089	5951	Cross	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5090	5953	Scirocco	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5091	5953	SCREAM	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5092	5957	Coral	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5093	5957	Trackbike	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5094	5957	Baby	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5095	5957	BRANDED ALAN	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5096	5957	Coral Road	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5097	5957	Gap	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5098	5957	Gap pista 81	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5099	5957	GAP TI	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5100	5957	Hissho SS	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6163	5411	Super Record NJS	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6164	5411	CRecord Gruppo	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6165	5411	Victory	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6166	5411	Chorus	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6167	5411	Athena group	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6168	5411	Veloce Road	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6169	5412	Del Mondo	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6170	5413	Volos	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6171	5415	SST	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6172	5415	Galaxy	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6173	5415	Lightning SST	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6174	5415	Revolver	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6175	5415	SST AL 2	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6176	5415	SST Aluminum	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6177	5415	SST STi	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6178	5415	Super Galaxy	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6179	5415	Tartan	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6180	5415	SST AL	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6181	5415	Polo No Sympathy	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6182	5416	Endurace	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6183	5416	King	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6184	5416	Kron Rock Racing	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6185	5416	Macro	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6186	5416	Merak	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6187	5416	Neo Primato	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6188	5416	NeoPrimato	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6189	5416	Pista	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6190	5416	Pista steel lugged	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6191	5416	Planet	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6192	5416	PRIMATO	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6193	5416	Professional Pista	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6194	5416	Professional Road	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6195	5416	PRX	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6196	5416	Resurrected	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6197	5416	San Remo	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6198	5416	SLX	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6199	5416	Super Prestige	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6200	5416	Titanio	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6201	5416	Titanium Beograd	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6202	5416	Professional	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6203	5416	Professional SLX	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6204	5417	Thron	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6205	5417	Columbus Cromor	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6206	5417	Zonal	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6207	5417	Zonal Pista	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6208	5420	Prestige	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6209	5421	Competition	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6210	5425	Allrounder	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6211	5425	Corsa Speciale	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6212	5426	Brakes	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6213	5426	Pursuit	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6214	5426	Force	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6215	5426	Paint	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6216	5426	V1000	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6217	5426	V 1000	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6218	5427	Ross	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6219	5427	Chrome	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6220	5427	Shopper	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6221	5427	2nd Edition	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6222	5427	VTG Steel	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6223	5427	Racer	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6224	5427	StingRay	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6225	5434	Company	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6226	5434	Townie	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6227	5436	Full sus XC	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6228	5436	Amsterdam winter	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6229	5436	Chicane	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6230	5436	Leo 1	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6231	5441	Belgium	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6232	5441	SSP	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6233	5441	75 Jahre	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6234	5441	Belgian	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6235	5441	Cicli	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6236	5441	East Germany DDR	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6237	5441	GDR	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6238	5441	Trackframe	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6239	5441	Numero Uno	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6240	5442	Axis	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6241	5442	DBR Axis Ti	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6242	5442	Expert TG road	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6243	5442	Interval TG	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6244	5442	Overdrive	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6245	5442	Overdrive 29er	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6246	5442	PrevialTG	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6247	5442	SorentoSEMountain	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6248	5442	DBR WCF 61	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6249	5442	Podium 2	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6250	5442	Senior pro MINT	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6251	5442	DB expert tg	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6252	5449	Arc	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6253	5449	GB Team	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6254	5449	DF3	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6255	5449	Forza	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6256	5449	Forza Irish Edit	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6257	5449	Kadet	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6258	5449	Pre Cursa	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6259	5449	Pre Cursa SF	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6260	5449	PreCursa	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6261	5449	Prototype	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6262	5449	Seta	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5101	5957	Loto reload	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5102	5957	Loto Columbus SLX	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5103	5957	Paris Robaix	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5104	5957	Paris Roubaix	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5105	5957	Pista	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5106	5957	Cyclcross	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5107	5957	TRICOLORE	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5108	5957	TTFunny 81	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5109	5957	Viper	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5110	5957	ZerK	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5111	5957	Matic	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5112	5957	TT Funny	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5113	5957	TT ELIZA	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5114	5957	Pista Redux SOLDDD	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5115	5957	Gap UPDATED	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5116	5957	Loto	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6263	5449	Seta team Ireland	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6264	5449	Tarck	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6265	5449	Champ	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6266	5449	Champ 58	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6267	5449	Champ goes SNAP	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6268	5449	Champion	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6269	5449	Champion Veronica	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6270	5449	Yvonne McGregor	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6271	5455	Shaft Drive	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6272	5456	Roadster	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6273	5456	Slammer	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6274	5456	VFR	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6275	5456	Air	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6276	5470	DDR	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6277	5471	Jane	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6278	5471	NIGHT TRAIN	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6279	5471	Euro	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6280	5471	Germany Diamant	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6281	5471	Slash 5	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6282	5471	Block Commie	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6283	5475	Corsa FAEMA	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6284	5475	97 Edition	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6285	5475	Crescent	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6286	5475	Crescent TT	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6287	5475	Elite	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6288	5475	7Eleven Pista	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6289	5475	Tempo TT Mixed gear	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6290	5475	Alu Cross	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6291	5475	AMX2	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6292	5475	Century Team Kelme	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6293	5475	Columbus	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6294	5475	Corsa	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6295	5475	Corsa 8687	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6296	5475	Corsa Extra	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6297	5475	Corsa Extra Pista	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6298	5475	Corsa Extra SLX	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6299	5475	Corsa Extra TT	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6300	5475	Corsa Extra TT NOS	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6301	5475	Corsa ZeroUno	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6302	5475	Cromor Pista	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6303	5475	Extra Corsa 711	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6304	5475	Faema x SRAM Rival	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6305	5475	Gara	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6306	5475	Gara Pista	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6307	5475	Hour record replica	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6308	5475	ML Leader	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6309	5475	Molteni replica	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6310	5475	MX Leader	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6311	5475	MXLeader	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6312	5475	MXLeader Pro Team	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6313	5475	Pista	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6314	5475	Pista P Punt	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6315	5475	Professional	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6316	5475	Pursuit	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6317	5475	SLX Corsa Extra	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6318	5475	SLX Pista	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6319	5475	Strada 9293	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6320	5475	Strada OS Brain	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6321	5475	Team 711 Reissue	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6322	5475	Team SC	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6323	5475	Team SC SRAM Force	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6324	5475	Titanium Road	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6325	5475	Alu	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6326	5475	Campagnolo group	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6327	5475	Premium	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6328	5475	TSX	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6329	5475	Strada OS	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6330	5475	Pista Priest 3	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6331	5475	Mutisport	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6332	5475	Professional Road	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6333	5475	Corsa Pista	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6334	5475	Grand Prix	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6335	5475	Crescent slx	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6336	5475	Corsa Molteni	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6337	5475	EMX3	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6338	5477	Scrambler	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6339	5477	Scrambler V2	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6340	5477	Scrambler V3	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6341	5478	Rosie	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6342	5478	Rally Sport	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6343	5478	Rat Fink	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6344	5478	Townie	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6345	5478	Townie 21	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6346	5484	Isis	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6347	5484	Joker	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6348	5484	Truth	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6349	5484	Witness	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6350	5487	SX fsr	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6351	5492	Velo	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6352	5492	Fail Cinelli Mash	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6353	5492	Disc 05	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6354	5492	Carbon 56	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6355	5492	FSR	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6356	5492	Lugged carbon	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6357	5492	Carbon Fiber	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6358	5492	Carbon Fiber Road	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6359	5496	Pista	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6360	5496	Sport	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6361	5496	MODELL	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6362	5496	Shimano 105	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6363	5499	Imperial	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6364	5499	Lizard	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5117	5958	512 Sport	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5118	5958	852	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5119	5958	Chrono	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5120	5958	Cross	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5121	5958	Strada Blacktop 800	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5122	5968	50 Folding	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5123	5974	Malum	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5124	5980	Driver	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5125	5980	Funday	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5126	5980	Ian	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5127	5980	Roller	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5128	5990	Kouki	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5129	5994	Sanchez	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5130	5994	Sanchaz	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5131	5994	Updated	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5132	5994	Del Norte	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5133	5994	Dirty sanchez	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5134	5994	Folsom	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5135	5994	Otis	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5136	5994	Polo	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5137	5994	Scanchez	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5138	6005	Horizon	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5139	6005	Mhmm	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6365	5499	Twin	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6366	5499	Beast 20	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6367	5500	29er	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6368	5500	29er Hardtail	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6369	5504	Capone	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6370	5504	Howler	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6371	5504	PWMOTO	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6372	5504	Sword	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6373	5504	SWORD CLEAR METAL	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6374	5504	Sword Disco	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6375	5507	Ready for Polo	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6376	5507	Campion del Mondo	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6377	5507	Campione del Mondo	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6378	5507	Columbus Air	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6379	5507	Fenice	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6380	5507	Mattia 090710	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6381	5507	Onda pursuit	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6382	5507	Padova Oria Mirage	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6383	5507	Pista	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6384	5507	Pursuit	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6385	5507	Crossbike	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6386	5507	Pursuit 2828	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6387	5509	Weekender	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6388	5511	MASH 58	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6389	5511	Vigorelli	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6390	5511	Or 80	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6391	5511	Circa	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6392	5511	Ernie Clements	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6393	5511	Majorca	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6394	5511	San Remo	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6395	5511	Tourer	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6396	5511	Reynolds 531C	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6397	5511	Eddy Merckx	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6398	5511	Giro de italia	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6399	5514	Cycles Yo Eddy SS	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6400	5514	Cycles Yo Eddy	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6401	5516	Pista	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6402	5516	Aluminium K	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6403	5516	Aluminium K3	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6404	5516	Barocco	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6405	5516	Campagnolo	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6406	5516	JUNIOR	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6407	5516	KCN2	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6408	5516	Neuron	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6409	5516	Reparto Corse	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6410	5517	Hamilton	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6411	5518	Teca dos TK2	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6412	5518	S22	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6413	5518	TK2	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6414	5518	Brougham	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6415	5518	09 TK2	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6416	5518	Nine Solo	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6417	5518	Yii	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6418	5518	AC1	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6419	5518	Breed	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6420	5518	BRO	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6421	5518	Brougham RAW	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6422	5518	Claire	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6423	5518	Curbside	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6424	5518	Curbside 08	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6425	5518	Deep six	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6426	5518	F1C	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6427	5518	F5 Braindead	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6428	5518	F50	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6429	5518	F55	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6430	5518	F65	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6431	5518	F75	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6432	5518	F80	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6433	5518	F85	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6434	5518	FX1	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6435	5518	SC1	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6436	5518	T23	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6437	5518	TK1	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6438	5518	TK2 06	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6439	5518	TK2 09	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6440	5518	TK2 HED 3	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6441	5518	Tk2 342	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6442	5518	Tk2bur	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6443	5518	Tk3	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6444	5518	TK3 HED3	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6445	5518	Tk3 hed 3	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6446	5518	Virtue 1	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6447	5518	Z35	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6448	5518	Z6 Carbonish	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6449	5518	Dispatch	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6450	5518	Flyer	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6451	5518	Curbside demo	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6452	5518	F5C	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6453	5518	F1 Road	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6454	5518	B2 TT	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6455	5518	F1X	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6456	5518	TK2 byah	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6457	5518	S32	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6458	5518	TK2 SIMPLISTIC	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6459	5518	F4SL	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5140	6005	Medallion	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5141	6005	Olympian	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5142	6005	Prestige	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5143	6005	Tribute	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5144	6017	MoodyHickerson	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5145	6017	Ruben	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5146	6017	GB Barcode	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5147	6018	Racer	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6460	5518	Gridloc	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6461	5518	F15X	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6462	5519	Cycles attack	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6463	5519	Attack	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6464	5519	Attack RZA	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6465	5519	Series	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6466	5519	Fixation	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6467	5519	Inzio Road	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6468	5519	Position	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6469	5519	Cycles Inizio	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6470	5519	105	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6471	5523	Commander Lemond	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6472	5523	Cycles	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6473	5526	TITANIUM	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6474	5528	Rebuild	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6475	5528	Amie	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6476	5535	Ultegra	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6477	5535	Mosca 2	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6478	5535	Diablo	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6479	5535	Pantera	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6480	5535	Team Super Fly	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6481	5540	Izalco 05	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6482	5540	Izalco Team	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6483	5540	Izalco Team Milram	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6484	5540	Izalco	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6485	5540	RT 550 Suntour	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6486	5540	Cayo Ultegra	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6487	5540	Izalco Pro 10 22g	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6488	5544	Alu Campagnolo	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6489	5544	Cromor	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6490	5544	Magister	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6491	5544	Pursuit	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6492	5544	Top Level	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6493	5544	Genises	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6494	5546	Bici Cinelli	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6495	5546	One REDUX	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6496	5546	Reynolds 525	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6497	5549	Hound	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6498	5551	BreakAway	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6499	5554	Expert	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6500	5555	Dunelt 3spd	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6501	5555	Aimees	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6502	5555	Sunbird	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6503	5555	Ladys	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6504	5555	ScorcherHauler	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6505	5555	3 WheelerTricycle	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6506	5555	FS12	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6507	5556	One	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6508	5559	Pro 09	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6509	5559	06 illest	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6510	5559	Savannah	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6511	5559	FRacing	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6512	5559	Pro Madness	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6513	5559	The Original Curl	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6514	5559	Comp	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6515	5559	World	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6516	5559	Obey	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6517	5559	Pro 08	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6518	5559	Intermediate	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6519	5559	Pro 07	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6520	5559	Gran Tourer SE	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6521	5559	Torture Horse	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6522	5559	Late	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6523	5559	Team SL A6 Aluminum	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6524	5559	Absolute	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6525	5559	Absolute SX	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6526	5559	Allegro	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6527	5559	Aloha	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6528	5559	Altamira	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6529	5559	Arcadia	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6530	5559	Bar	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6531	5559	Berkeley	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6532	5559	Cambridge VI	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6533	5559	Chromo	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6534	5559	Crack	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6535	5559	Crack Ho	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6536	5559	Cross Comp	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6537	5559	Cross Pro	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6538	5559	Declaration	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6539	5559	Del Rey	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6540	5559	Elios	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6541	5559	Espree	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6542	5559	Faxed	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6543	5559	Feather	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6544	5559	Feather Work	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6545	5559	Feather 58	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6546	5559	Feather bird rock	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6547	5559	Finest II	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6548	5559	Finest Mark II	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6549	5559	Flair	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6550	5559	Gran Tourer	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6551	5559	GRAND CANYON	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6552	5559	Grand Tourer SE	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6553	5559	League	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6554	5559	Monterey	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6555	5559	Newest	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6556	5559	Newest 30	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6557	5559	Newest 40	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6558	5559	Newst 10	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6559	5559	OBEY mal fini	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6560	5559	Obey Coaster Brake	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6561	5559	OBEY Hawaii	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6562	5559	Obey Proper	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6563	5559	Obeyerr Oghey	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6564	5559	Panic 10	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6565	5559	Professional	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6566	5559	Pursuit	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6567	5559	RACER NJSs	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6568	5559	Roubaix	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6569	5559	Roubaix SL Centaur	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6570	5559	Royale	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6571	5559	S12S	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6572	5559	Sagres	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6573	5559	Sagres runabout	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6574	5559	Sagres SP	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6575	5559	Sand Blaster	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6576	5559	SL1 Comp	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5149	6019	Style	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5150	6812	Criterium rex	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5151	6812	Roadbike	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5152	6812	Super Aero	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5153	6813	Flatland	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5154	6820	Roadbike	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5155	6823	Rocket	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5156	6844	NJS	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6577	5559	Road Racer	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6578	5559	Sports 10	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6579	5559	Sports 12	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6580	5559	Sports circa	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6581	5559	Sprint	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6582	5559	Steel	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6583	5559	Stratos	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6584	5559	Team Pro	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6585	5559	Tiara	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6586	5559	08 JPN	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6587	5559	Not pro	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6588	5559	Polo	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6589	5559	Darkie	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6590	5559	06 26 to the 700c	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6591	5559	09 Brownie	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6592	5559	200000009	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6593	5559	305	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6594	5559	52 sons	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6595	5559	Comp 10	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6596	5559	Comp City Edition	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6597	5559	Comp 09	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6598	5559	Elite	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6599	5559	Naoko	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6600	5559	Pr0	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6601	5559	Pro BUTTERCUP	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6602	5559	Pro 2	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6603	5559	Pro 04	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6604	5559	Pro flt blk	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6605	5559	Pro 06	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6606	5559	Pro Track Only	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6607	5559	Pro berlin	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6608	5559	Pro polished	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6609	5559	Pro deuce	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6610	5559	Pro Paris	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6611	5559	Pro w American 420s	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6612	5559	ProHo	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6613	5559	Promson	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6614	5559	Road Trainer	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6615	5559	Spaghetti Monster	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6616	5559	Year Something	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6617	5559	TrackPro	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6618	5559	Whatever	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6619	5559	Ujiuji	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6620	5559	FG 2 brakes	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6621	5559	Roubaix SL	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6622	5559	Cross RC	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6623	5559	Ace	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6624	5559	Team SL	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6625	5559	Party	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6626	5559	FUNBIKE	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6627	5559	Newest 20	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6628	5559	SL1 Frameset	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6629	5559	Roubaix Pro	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6630	5559	Grime scene	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6631	5559	Miami	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6632	5559	Hemi	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6633	5559	That could	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6634	5559	Apple	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6635	5559	Finest	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6636	5559	Tourer	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6637	5559	S10	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6638	5559	Finest MkII	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6639	5559	America	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6640	5559	Gran Tourer Road	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6641	5559	Regis	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6642	5559	Royal QWEST	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6643	5559	Supreme	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6644	5559	Edition	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6645	5559	Del Ray Super Clean	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6646	5559	450 SE Terry Style	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6647	5559	Del Ray	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6648	5559	Opus IV	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6649	5559	Sandblaster	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6650	5559	Cross	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6651	5559	Finest ChrMo	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6652	5559	Is dead	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6653	5559	Crosstown	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6654	5559	Team RC	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6655	5559	Roubaix LTD	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6656	5559	Originally	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6657	5559	Obey VEGAS	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6658	5559	Team	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6659	5559	Mack attack	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6660	5559	Pro murdered out	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6661	5559	Tarck	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6662	5559	Comp powdercoat	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6663	5559	Pro Philadelphia	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6664	5559	Pro ftp paint	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6665	5559	Kids 650	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6666	5559	Betsy	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6667	5559	Tahoe	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6668	5559	Matching Trailer	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6669	5564	Denali	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6670	5565	Pulse	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6671	5565	Arrowhead	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6672	5565	GTB	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6673	5565	Duncan the thief	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6674	5565	Team Delta Force	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6675	5565	Aggressor 10	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6676	5565	All Terra Tempest	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6677	5565	Avalanche 30	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6678	5565	Avalanche LE	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6679	5565	Avalaunche 20 06	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6680	5565	Bump Traded	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6681	5565	Edge	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6682	5565	Edge Reynolds 853	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6683	5565	Edge titanium	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6684	5565	EDGE AERO	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6685	5565	Edge Aluminium	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6686	5565	Edge frameset	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6687	5565	Edge risers	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6688	5565	Force	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6689	5565	Generic	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6690	5565	GTB WHITELIGHTING	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6691	5565	GTB Praxidike	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5157	6844	NJS wahwah	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5158	6844	Pursuit	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5159	6847	WOODEN RIMS	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5160	6847	Road 500	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5161	6847	Katakura	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5162	6847	Path	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5163	6849	Superbe Pro	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5164	6849	Nitto	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5165	6849	Cyclone 7000	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5166	6849	Superbe race	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5167	6849	Sprint 9000	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5168	6858	Wind	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5169	6858	SUN	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5170	6867	Superbe Pro	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5171	6867	Nitto	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5172	6867	Cyclone 7000	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5173	6867	Superbe race	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5174	6867	Sprint 9000	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5175	6025	Audax	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5176	6025	Audax Mk 3	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5177	6026	Tracklord	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5178	6032	Trial	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5179	6032	Machine TT02	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5180	6032	Machine TT03	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6692	5565	GTB Generic	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6693	5565	GTB Sheila	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6694	5565	GTB POLISHED	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6695	5565	Gtb my second	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6696	5565	GTBfirst preview	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6697	5565	Gutterball	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6698	5565	HEART THROB PULSE	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6699	5565	IDrive 40	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6700	5565	KARAKORAM	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6701	5565	Kinesis	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6702	5565	Legato 40	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6703	5565	Mach One	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6704	5565	Mini	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6705	5565	National Team Road	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6706	5565	Outpost	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6707	5565	Pantera	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6708	5565	Peace	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6709	5565	Pockyclipse	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6710	5565	POLO	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6711	5565	Pulse Triange	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6712	5565	Pulse 98	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6713	5565	Pulse Kinesis	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6714	5565	Pulse ReIssue	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6715	5565	PULSE Cinelli Pista	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6716	5565	Pulse Bietch	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6717	5565	Pulse Jammer	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6718	5565	Pulse Mavic	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6719	5565	Pulse Dura Ace	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6720	5565	Pursuit	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6721	5565	RICOCHET	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6722	5565	Tequesta	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6723	5565	Strike	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6724	5565	Team Race 56	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6725	5565	TEAM USA tiemeyer	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6726	5565	Timberline	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6727	5565	Ultra	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6728	5565	Xtracycle	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6729	5565	Zaskar	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6730	5565	Zaskar Expert 9er	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6731	5565	ZASKAR TEAM	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6732	5565	ZR 50	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6733	5565	ZR Dura Ace	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6734	5565	Zr30 Dura tegra	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6735	5565	Continuum	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6736	5565	Tachyon	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6737	5565	Super phoebe	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6738	5565	Single speeder	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6739	5565	Daily	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6740	5565	Kilo	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6741	5565	Olympic Pursuit	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6742	5565	US National Team	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6743	5565	Folding restoration	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6744	5565	Pro Performer	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6745	5565	Performer	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6746	5565	Interceptor	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6747	5565	Pro Freestyle Tour	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6748	5565	Tequesta Zubaz	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6749	5565	Interceptor VEGAS	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6750	5565	Avalanche	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6751	5565	Backwoods	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6752	5565	ZR1000 1x9	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6753	5565	Palomar	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6754	5565	ZRX	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6755	5565	Ruckus 20	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6756	5565	Series 1	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6757	5565	Fueler	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6758	5565	853	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6759	5565	Edge Zap Anodized	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6760	5566	Typhoon	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6761	5568	June Trigger	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6762	5568	Lanterne	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6763	5568	Persuit	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6764	5568	Pursuit	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6765	5568	TeamCRecord	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6766	5568	TNT	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6767	5568	Ultima	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6768	5568	Triathlon	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6769	5568	400	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6770	5568	Team Cambio Rino	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6771	5570	Big sur	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6772	5570	HiFi Plus 29	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6773	5570	Kai Tai	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6774	5570	Mako	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6775	5570	Napa	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6776	5570	Paragon	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6777	5570	Snow monster	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6778	5570	Tasajara	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6779	5570	Tassajara	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6780	5570	Utopia	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5181	6032	Trial NOS	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5182	6032	Trial Rig	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5183	6032	Trial 650c	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5184	6032	TrialFunny	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5185	6032	Traveller	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5186	6032	Trial Fake trial	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5187	6032	Trial Funny	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5188	6032	Traveler	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5189	6032	Trial 753	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5190	6032	Machine	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5191	6032	Trial pursuit	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5192	6032	Trial 100km road	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5193	6032	Bomb	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5194	6032	Edge Pulse	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6781	5570	Mullet John	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6782	5570	Sugar	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6783	5570	Marlin	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6784	5570	Montare	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6785	5570	Sugar 4	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6786	5570	Cake 2 DLX	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6787	5570	Zebrano	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6788	5570	Wahoo	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6789	5570	Sawyer	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6790	5573	Fisso	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6791	5574	Tour de Lavenir	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6792	5574	AA Team DAF Trucks	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6793	5574	Champion mondial	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6794	5574	Champion Mondial AA	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6795	5574	Champion Mondial AB	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6796	5574	Jeugd race 24	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6797	5574	Super Mondiale	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6798	5574	Team	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6799	5574	Titan Team Golff	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6800	5574	Pearl	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6801	5574	Triathlon Trophy	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6802	5574	Trim Trophy	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6803	5574	Vuelta	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6804	5574	Champion	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6805	5574	Fiets	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6806	5574	Factory	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6807	5574	AA Champion Mondial	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6808	5581	Day One Disc	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6809	5581	Flyer	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6810	5581	Latitude 16	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6811	5584	Asgard Pro	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6812	5585	V 2	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6813	5585	EBS Race	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6814	5585	Race	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6815	5588	Pursuit	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6816	5588	Pursuit Netherlands	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6817	5591	650bTourer	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6818	5591	Purplepink	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6819	5591	City	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6820	5591	FRENCH	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6821	5591	Grand Sport DeLuxe	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6822	5591	Hosteler	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6823	5591	Interclub	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6824	5591	Kilo	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6825	5591	Mach 320 TT	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6826	5591	Mexico Pista	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6827	5591	Olympic Record II	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6828	5591	Pista	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6829	5591	Professional 531c	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6830	5591	Racing Team	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6831	5591	Super Olympic	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6832	5591	TDF 531 ca	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6833	5591	Tour dAvenir	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6834	5591	Tour De France	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6835	5591	Mexico	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6836	5591	WOMAN	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6837	5591	Le Conard	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6838	5591	Kilo loaded	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6839	5591	Workhorse	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6840	5591	Superbe Elite	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6841	5591	Handmade de luxe	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6842	5591	Super Corsa	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6843	5591	Sprint	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6844	5591	Performance	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6845	5591	Gran Sport de Lux	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6846	5594	Roll 1	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6847	5594	Roll 1 HI	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6848	5594	Roll 2	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6849	5594	Roll	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6850	5594	Sport womans	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6851	5594	Centrum Sport	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6852	5594	Sport	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6853	5606	29point5 29er	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6854	5606	Liberty 1	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6855	5610	Pista All Italian	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6856	5610	SL Competition	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6857	5610	51 Road	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6858	5610	Brain	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6859	5610	Cross	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6860	5610	Pista	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6861	5610	RecordUltegra SL	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6862	5610	Roadie	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6863	5610	Shadow	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6864	5610	SLX	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6865	5610	Panto	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6866	5610	Vega Dura Ace	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6867	5610	Specialissima	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6868	5610	SUPER RECORD BITS	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6869	5610	Super Record	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6870	5610	Pista Full Campy	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6871	5611	Crosshairs	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6872	5611	Fastlane	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6873	5611	Roadie	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6874	5611	Rockhound	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6875	5611	Sport	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6876	5611	Tirebiter	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6877	5611	Ruffian	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6878	5612	Strada	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6879	5615	De Defrag	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6880	5615	Piuma	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6881	5615	Campagnolo Pista	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6882	5615	Ciclo	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6883	5615	Corsa pista	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6884	5615	Megatube Alu Road	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5195	6032	For a Real	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5196	6032	Shark attack	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5197	6032	Speeder S 58	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5198	6032	Trial Specialized	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5199	6032	VX Edge	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5200	6032	VX Pro	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5201	6032	Trialer	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5202	6035	Team Golff	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5203	6035	Composite	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5204	6035	Teamline	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5205	6035	Exclusiv	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5206	6035	WinterWheels	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5207	6036	Racer X	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5208	6038	Medium	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5209	6039	SUPER PRESTIGE	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6885	5615	Pista	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6886	5615	Pista Coaster Brake	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6887	5615	Roadie	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6888	5615	Mavic groupset	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6889	5615	Junior size racing	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6890	5615	Sportivo	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6891	5615	Strada	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6892	5615	Tretubi	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6893	5615	Turismo	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6894	5615	VR2	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6895	5616	MASH x CINELLI	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6896	5618	Mutt RoadAce 404	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6897	5618	Road Ace 505	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6898	5618	Road Ace 606	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6899	5618	Roadace	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6900	5618	Roadace 707	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6901	5618	Roadace RX7	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6902	5619	M410	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6903	5621	Prestige	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6904	5621	Il diavolo	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6905	5621	3V Pista	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6906	5621	3v Volumetrica	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6907	5621	Alare	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6908	5621	Aspelozen1	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6909	5621	California pursuit	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6910	5621	Coltello	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6911	5621	Coltello v2	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6912	5621	COLTELLO AEROSPOKE	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6913	5621	CX Uno	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6914	5621	Evol Sakzilla	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6915	5621	Fixd	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6916	5621	Gran Corsa	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6917	5621	Gran Crit	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6918	5621	Gran Criterium	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6919	5621	LTD	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6920	5621	Nuova Strada	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6921	5621	Pista	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6922	5621	Pursuit	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6923	5621	Speciale	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6924	5621	SPECIALE aerospoke	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6925	5621	Speciale CX	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6926	5621	Speciale ltd	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6927	5621	Speciale Pista	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6928	5621	Speciale Sprint	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6929	5621	Sprint	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6930	5621	Team V3	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6931	5621	Coltello destroyer	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6932	5621	Coltello 59	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6933	5621	3V Volumetrica CCCP	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6934	5621	Nova Strada	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6935	5621	Coltello aluminum	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6936	5621	Alare bellissima	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6937	5621	War Pony Randonneur	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6938	5621	Barcelona	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6939	5626	SSC Group17lbs	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6940	5626	Ellipse	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6941	5626	Groupset	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6942	5626	Comete	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6943	5626	Crank	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6944	5626	Group	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6945	5626	3ttt components	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6946	5633	Vincitore	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6947	5633	PROFESSIONAL	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6948	5633	653 ProLugless	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6949	5633	Pista	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6950	5633	Pro lugless	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6951	5633	Strada Speciale80s	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6952	5633	Super Vigorelli	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6953	5633	Path	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6954	5633	Wildwood	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6955	5633	Easter egg style	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6956	5633	Restoration	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6957	5633	Time Trialer	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6958	5633	Tourer	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6959	5633	Olympic	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6960	5634	Kilo TT	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6961	5634	Killer	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6962	5634	Kilo	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6963	5634	SS 001	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6964	5634	Kilo tt pro	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6965	5634	300  Reynolds 531	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6966	5634	Polo	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6967	5634	Killa TT	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6968	5634	Killo TT	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6969	5634	Kilo TEAM	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6970	5634	Kilo tt nothing	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6971	5634	Kilo TT Creamcycle	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6972	5634	Kilo TT Grape Soda	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6973	5634	Kilo TT taste	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6974	5634	Kilo TT Deluxe	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6975	5634	Kilo TT Raw	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6976	5634	Kilo TT REdone LA	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6977	5634	Kilo TT Stripper	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6978	5634	Kilo TT Cetma	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6979	5634	Kilo TT x Norcal	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6980	5634	Kilo TTBlank	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6981	5634	Kilo TT RIDICULOUS	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6982	5634	Kilo TTStripper	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6983	5634	Kilo TTT	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6984	5634	Kilo TTuxedo	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6985	5634	Kilo WheaTT	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6986	5634	Kilo WT	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5210	6039	Tecno Extra	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5211	6039	W Dura Ace 7402	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5212	6039	Prestige	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5213	6039	AERO PURSUIT	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5214	6039	Air CX	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5215	6039	Air CX pursuit	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5216	6039	Air CX TT	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5217	6039	Air Prestige	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5218	6039	CX Comp TT	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5219	6039	Prestige Pista	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5220	6039	Prestige Restomod	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5221	6039	Prestige SL	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5222	6039	Pursuit	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5223	6039	Pursuit Restoration	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5224	6039	Pusuit	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5225	6039	Road Campy	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5226	6039	Tecno	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5227	6039	Velosita	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5228	6039	Techno	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5229	6040	Augusta	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5230	6040	12 spd	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5231	6040	Augusta Ninja	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5232	6040	Augusta Frankenbike	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6987	5634	Kilo WT AeroPhatty	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6988	5634	KiloTT	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6989	5634	KiloTT Pro	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6990	5634	Orion	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6991	5634	Piste	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6992	5634	Rain Runner	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6993	5634	Replica team Gan	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6994	5634	Sport 26	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6995	5634	Tour de France	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6996	5634	StripperKilo TT	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6997	5634	Urbanismo	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6998	5634	Stripper	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
6999	5634	LA TT	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7000	5634	GipiemmeSimplex SLJ	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7001	5634	Deluxe 2nd Edition	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7002	5634	Franken	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7003	5634	Kilo tt Island	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7004	5634	Galaxy	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7005	5634	Kilo TT Thurston	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7006	5634	Kilo Stripper	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7007	5635	HFS	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7008	5635	Road 901	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7009	5635	Albon Tech DX	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7010	5636	THe window breaker	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7011	5636	Extralight	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7012	5636	Agilis	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7013	5636	Cielo	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7014	5636	CR Works	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7015	5636	Cyrene	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7016	5636	Extra extra light	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7017	5636	Fortius	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7018	5636	Lunaris	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7019	5636	Magia	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7020	5636	Martian	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7021	5636	Works 40	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7022	5636	Agilis Stage 2	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7023	5636	Titanium	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7024	5636	Titanium Road	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7025	5636	Extralight Titanium	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7026	5638	Trick	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7027	5638	6 VIP	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7028	5643	Superbe	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7029	5643	707 NITTO RB021	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7030	5643	Grupos	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7031	5646	Gara Road Issue	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7032	5646	Full Campy	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7033	5646	RoadCondor	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7034	5646	Gara	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7035	5646	Vanielli	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7036	5646	Lupa	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7037	5647	Kamkikaze	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7038	5647	Dura Ace 7700	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7039	5647	Hardtail	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7040	5647	Lugged Pista	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7041	5650	20Forty	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7042	5652	Tightie Whitie	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7043	5653	Omnium Aluminum	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7044	5653	Sports	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7045	5653	Flyer	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7046	5653	Prologue	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7047	5653	Flyer Hamburg	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7048	5653	Fully	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7049	5653	Gents LuxeS	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7050	5653	Gents racer	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7051	5653	Gentsracer	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7052	5653	Gentsracer Aeroluxe	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7053	5653	Granracer	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7054	5653	GranWinner	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7055	5653	Roadchamp	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7056	5653	Roadrunner	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7057	5653	Runner	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7058	5653	SSP	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7059	5653	Tt Pursuit	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7060	5653	FullPro	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7061	5653	RecordPro	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7062	5653	SWEETNESS	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7063	5653	Terrarunner	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7064	5653	Ninety	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7065	5653	100 Rei	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7066	5653	110	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7067	5653	310	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7068	5653	512	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7069	5653	710	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7070	5653	912	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7071	5653	912 road	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7072	5653	CarbonTech 3000	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7073	5653	CT 3000	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7074	5653	Death Sled	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5233	6040	Monza Budget 070410	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5235	6040	Slx columbus	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5236	6040	Team	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5237	6040	TLX	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5238	6040	Chrono TT	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5239	6044	20th Anniversary	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5240	6044	Corsa Pista	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5241	6044	Corsa Strada	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5242	6044	Tipo Uno	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5243	6044	Super Strada	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5244	6045	280X	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5245	6045	KB2 Slate	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5246	6045	UDistrict	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5247	6045	LX unicycle	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7075	5653	Footie	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7076	5653	Nine16	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7077	5653	Ninja	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7078	5653	OnOff Roadrunner	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7079	5653	One Hundred	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7080	5653	One Ten	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7081	5653	One Thousand	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7082	5653	OneHundred	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7083	5653	Path Thunder	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7084	5653	ProMiyata	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7085	5653	SevenTen	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7086	5653	Shredder	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7087	5653	Sportster	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7088	5653	Team Pista	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7089	5653	Team Titanium	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7090	5653	Team	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7091	5653	Three Ten	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7092	5653	Threeten	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7093	5653	TI6000	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7094	5653	For the early	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7095	5653	TwoTen	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7096	5653	Team Pista DA10	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7097	5653	7677	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7098	5653	OneTen	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7099	5653	Funny	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7100	5653	914	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7101	5653	WDuraAce 7200	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7102	5653	1000	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7103	5653	SixTen	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7104	5653	210	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7105	5653	NineTwelve	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7106	5653	Pista	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7107	5653	512 Competition	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7108	5653	Alumitech 6500	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7109	5653	Nimbus	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7110	5653	Triton	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7111	5653	1400AlumiTech	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7112	5653	721A UPDATED	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7113	5653	TeamMiyata	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7114	5653	Sportcross	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7115	5653	TripleCross	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7116	5653	914 Road	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7117	5653	Elevation	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7118	5653	Sidewinder	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7119	5653	Twisted spokes	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7120	5653	100	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7121	5653	Makeover	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7122	5653	One Ten Facelift	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7123	5653	Carbontech 7000	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7124	5655	3000	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7125	5657	Americana	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7126	5657	Ultra lyx	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7127	5657	Flygstlscykel	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7128	5658	Criterium	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7129	5658	Aspelozen7	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7130	5658	Super	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7131	5660	Amasa Comp	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7132	5660	Crossway 425	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7133	5660	Hard Luck	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7134	5660	Iboc Comp	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7135	5660	Supergoose	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7136	5660	XR100	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7137	5660	XR250 the Goose	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7138	5660	Mangusta	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7139	5660	Californian	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7140	5660	Moto SuperGoose	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7141	5660	IBOC ZeroG	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7142	5660	Dolomite	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7143	5660	Competition	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7144	5661	Folding	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7145	5661	M1000 BiFrame	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7146	5662	Compact	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7147	5662	PsychloX	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7148	5662	Vamoots	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7149	5662	Vamoots CR	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7150	5662	Vamoots SL	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7151	5662	YBB	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7152	5662	Vamoots Road	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7153	5662	CompactSL	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7154	5666	Brass 4 Star	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7155	5666	Racing	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7156	5670	Jury	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7157	5670	Grand Record	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7158	5670	Le Champion	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7159	5670	Grand Sport	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7160	5670	Netherlands	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7161	5670	Stupid	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7162	5670	Messenger	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7163	5670	Super Mirage	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7164	5670	Grand Jubilee	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7165	5670	C5 NOS	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7166	5670	Cafe Latte	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7167	5670	Citybike	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7168	5670	Roadbike	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7169	5670	Fantom Cross uno	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7170	5670	Fanton 29er	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7171	5670	Fly Team Super Fly	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7172	5670	For 2	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7173	5670	Grand Jubile	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7174	5670	Grand Jubilee 83	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7175	5670	Grand Jublie	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7176	5670	Jubilee Sport	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7177	5670	Jublie Sport	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7178	5670	Jury 53	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5248	6046	Resurection	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5249	6046	Super	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5250	6047	Sikroad	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5251	6048	Godzilla	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5252	6048	Godzilla 30	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5253	6048	Godzilla finished	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5254	6048	Godzilla nhannguy3n	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5255	6049	Ringleader	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5256	6049	Ruben	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5257	6049	Cycles Ringleader	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5258	6051	TRI	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5259	6054	People	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7179	5670	Le Champion SL	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7180	5670	Mirage	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7181	5670	Mirage s	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7182	5670	Mongoose Mangusta	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7183	5670	Mystery	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7184	5670	Nomade	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7185	5670	Nomade II	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7186	5670	Phantom Pro 29	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7187	5670	Pista	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7188	5670	Profil 2	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7189	5670	Retrostyle	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7190	5670	S3X	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7191	5670	Super Champion NOS	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7192	5670	Team	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7193	5670	Beast	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7194	5670	Vent Noir	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7195	5670	Nomade Sprint	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7196	5670	DODICI RIMS	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7197	5670	Grand Sprint	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7198	5670	Uno	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7199	5670	Shimano 600	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7200	5670	TR3 training	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7201	5670	Messenger brakeless	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7202	5670	Messenger Cassie	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7203	5670	LeChampion Ti	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7204	5670	Fantom Cross	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7205	5670	Sprint	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7206	5673	European	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7207	5673	Racer	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7208	5673	For Polo	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7209	5673	Unicycle Muni	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7210	5673	CommuterTouring	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7211	5673	Tour Grand Mesa	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7212	5673	ALTITUDE SE 29er	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7213	5673	BOROUGHS	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7214	5673	Reaper	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7215	5673	RM7dh	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7216	5673	Slayer50	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7217	5673	Solo 30	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7218	5673	TEAM ISSUE ROAD	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7219	5673	Whistler DB 1	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7220	5673	Flyer	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7221	5674	Traverse	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7222	5678	Burns	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7223	5678	Klunker	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7224	5678	Monterey Kats	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7225	5678	Nassau	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7226	5678	Prostyle trick	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7227	5678	Spaceliner Lowrider	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7228	5678	Stingray	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7229	5678	Sportcrest	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7230	5684	Analog	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7231	5684	Suburban	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7232	5686	Vivalo	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7233	5686	Cannondale Capo	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7234	5686	Chrome Pista	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7235	5689	Aero Sprint funny	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7236	5689	Aluminum roadie	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7237	5689	Crit	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7238	5689	NX01	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7239	5689	Pursuit	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7240	5689	Pursuit TT	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7241	5689	Road alpha 5000	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7242	5689	Road LP	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7243	5689	Toure XC	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7244	5691	Team	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7245	5691	Team Road	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7246	5691	NJS	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7247	5691	Sensor	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7248	5691	Panasonic	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7249	5691	Team Lutz Haueisen	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7250	5691	Team GT kilo	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7251	5693	Alize	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7252	5698	Spark GS Baller	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7253	5698	Generation	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7254	5699	Brass Knuckle	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7255	5699	Air 9	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7256	5699	EMD9	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7257	5699	One 9	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7258	5699	SIR	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7259	5699	Jet 9 RDO	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7260	5699	Air9	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7261	5701	Modulus	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7262	5701	Competition	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7263	5701	NFS Alfa	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7264	5701	1x8	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7265	5701	Alien RetroDirect	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7266	5701	Altron NFS	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7267	5701	Sscx	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7268	5701	Basket	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7269	5701	Bushwacker	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7270	5701	Century	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7271	5701	Century yee	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7272	5701	Comp III	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7273	5701	Sport	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7274	5701	International	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7275	5701	International 83	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7276	5701	International Road	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7277	5701	Kokusai	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7278	5701	Linear	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7279	5701	Linear TT	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7280	5701	Medalist	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7281	5701	NFS	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7282	5701	Olympic	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7283	5701	Olympic Royal	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7284	5701	Olympic Royale	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7285	5701	Olympic SF	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7286	5701	Olympic SS	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7287	5701	Olympic Super	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5260	6055	1200 Aluminum	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5261	6055	OCLV	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5262	6055	Madone 47 WSD	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5263	6055	510	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5264	6055	TX900	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5265	6055	YFoil Y66	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5266	6055	660	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5267	6055	2100	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5268	6055	610	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5269	6055	Madone 52 Pro	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5270	6055	820	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5271	6055	520	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5272	6055	1000	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5273	6055	2300 de Defrag	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5274	6055	4300	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5275	6055	USPS	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5276	6055	Madone	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5277	6055	1100 Commuting Rig	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5278	6055	2200	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5279	6055	T1 S3X	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5280	6055	700 Multi	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5281	6055	1200	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5282	6055	400	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5283	6055	300	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5284	6055	950 w ends	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7288	5701	Polo	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7289	5701	Prestige	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7290	5701	Pro road fixiefree	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7291	5701	Riviera	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7292	5701	Sebring	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7293	5701	Convert	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7294	5701	WMavic Crank	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7295	5701	SS climber	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7296	5701	TriA	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7297	5701	Trim Master	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7298	5701	1st convert	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7299	5701	Juwel	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7300	5701	Olympic EVER	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7301	5701	Rally	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7302	5701	Marina 12	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7303	5701	Comp 2	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7304	5701	Cresta	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7305	5701	Seral Rando	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7306	5701	TriA Recycle find	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7307	5701	Linear funny V2	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7308	5701	TriA Equip	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7309	5701	ALTRON 7000	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7310	5701	Olympic 12	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7311	5701	Restoration	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7312	5701	TTPursuit	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7313	5704	RB021	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7314	5704	TSUBASA HANDLEBARS	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7315	5704	Njs	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7316	5707	Cherokee	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7317	5707	Reactor	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7318	5707	604 Street	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7319	5707	Bush Pilot	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7320	5707	CCX 1	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7321	5707	Fat tour	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7322	5707	JAVA	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7323	5707	Judan belt drive	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7324	5707	Kokanee	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7325	5707	Monterey	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7326	5707	Monterey Road	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7327	5707	Monterey SL	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7328	5707	Moustache SS	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7329	5707	SIX	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7330	5707	Vesta Belt	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7331	5711	Buzz	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7332	5711	Safari	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7333	5711	Team	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7334	5711	Viaggio	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7335	5711	Divano	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7336	5711	Strada	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7337	5722	Swift	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7338	5724	Salsa Ala Carte	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7339	5728	US Team	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7340	5728	School Criterium	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7341	5728	Aero Road	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7342	5728	Aero	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7343	5728	AeroHOME	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7344	5728	Criterium	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7345	5728	Funny	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7346	5728	GT Olympic Pursuit	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7347	5728	GT US National Team	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7348	5728	Kilo	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7349	5728	School Handmade	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7350	5728	Team USA	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7351	5728	TEAM USA II ROAD	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7352	5728	Pursuit	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7353	5728	Triple triangle	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7354	5728	Kilo pursuit	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7355	5731	ARC	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7356	5731	575	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7357	5731	ARC My Dream XC	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7358	5731	ASX	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7359	5731	DJ 4X	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7360	5731	ULTIMATE	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7361	5755	Gorilla	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7362	5764	Olympic C	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7363	5764	Betty	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7364	5764	San Remo	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7365	5764	Original OG Florida	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7366	5764	Competition	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7367	5764	Competition Pista	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7368	5764	Gara Pista	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7369	5764	Gentleman Z	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7370	5764	Giro	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7371	5764	Lady	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7372	5764	Mexico	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7373	5764	Pista	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7374	5764	Pista Supertype	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7375	5764	Pursuit	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7376	5764	Road Need Help	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7377	5764	Vitalicio	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5285	6055	420 Convert	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5286	6055	560	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5287	6055	Wan	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5288	6055	Flying Couch	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5289	6055	Sheriff 3700	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5290	6055	1000 My Roadie	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5291	6055	1000 convertion	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5292	6055	1100	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5293	6055	1200 Full 105 group	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5294	6055	1500 05	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7378	5764	En Venta	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7379	5764	Campy	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7380	5764	Corsica	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7381	5765	Aluminum	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7382	5765	Slut	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7383	5768	CROSS STYLE	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7384	5771	Primer	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7385	5772	Fidelio	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7386	5772	Spark	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7387	5772	Triton	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7388	5775	Sherpa	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7389	5775	Orca	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7390	5775	Altec Pista	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7391	5775	Aqua T105	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7392	5775	Aspin	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7393	5775	BMD concept	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7394	5775	Carpe Diem	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7395	5775	Dude A10	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7396	5775	Kronos	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7397	5775	Lobster	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7398	5775	Lobular Pista	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7399	5775	Lobular	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7400	5775	Onixxx	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7401	5775	Opal	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7402	5775	Pista	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7403	5775	Trackie	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7404	5775	Euskaltel	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7405	5776	UK Racing	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7406	5780	Boyfriend	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7407	5780	Stuff	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7408	5780	Car	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7409	5780	Skateboard is a	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7410	5780	Carlton	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7411	5780	Detail	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7412	5780	Picture	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7413	5794	Rum Runner	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7414	5794	FixE	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7415	5794	BasketGrocery	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7416	5794	BlackFix	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7417	5794	Bombin PARTED OUT	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7418	5794	Bumblebee	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7419	5794	Cmute	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7420	5794	CMuter	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7421	5794	Fantastic	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7422	5794	French 75	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7423	5794	Hawaii	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7424	5794	PAKE PAKE	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7425	5794	Reloaded	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7426	5794	Rumrunner	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7427	5794	SS beatercommuter	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7428	5794	KATANA	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7429	5794	Team Beerd Edition	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7430	5794	Ver 70 Updated	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7431	5794	Zipper	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7432	5794	Chicago	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7433	5794	Bareknuckle	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7434	5794	Whip	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7435	5794	Pacquao Couch	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7436	5794	CMYK Colour Scheme	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7437	5796	Pos	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7438	5796	Zipp Track wheels	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7439	5796	08 Keirin	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7440	5796	Aero	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7441	5796	For a GREAT Man	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7442	5796	DX 4000	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7443	5796	DX 0L11097	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7444	5796	Dx4000	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7445	5796	DX5000 restomod	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7446	5796	Dx1000	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7447	5796	DX3000 Hamburg	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7448	5796	Keirin	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7449	5796	NJS	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7450	5796	NJS 515	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7451	5796	PR4000	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7452	5796	ProTouring	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7453	5796	PT3500 Tourer	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7454	5796	Pursuit	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7455	5796	Sport 1000	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7456	5796	Sport 500	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7457	5796	Sport Deluxe	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7458	5796	Sport LX	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7459	5796	1000	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7460	5796	4000	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7461	5796	KEIRIN fromOSAKA	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7462	5796	Waves	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7463	5796	Is FINISHED	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7464	5796	AR6000 Aero	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7465	5796	DX3000	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7466	5796	DX5000 Dura Ace	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7467	5796	Team	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7468	5796	Livery	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7469	5796	Team America	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7470	5796	Team Japan	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7471	5796	Team Japan MOD	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7472	5796	DX5000	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7473	5796	DX6000	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7474	5796	MC6500	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7475	5796	MC5500	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7476	5796	MC7500	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7477	5796	PICS Titanium	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7478	5796	PICS Team	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7479	5796	PICS Team MC 800	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7480	5796	PR6000	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7481	5796	Keirin NJS Pumpkin	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7482	5796	Clown	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7483	5796	Sport Road	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7484	5798	Brooklyn NY	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7485	5799	Hammer	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7486	5800	Z3c	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7487	5800	Z5 paint	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7488	5804	Barkley Road	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7489	5804	Milnes CX	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7490	5804	Younger	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7491	5810	City SlickerII	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5295	6055	1500 Aluminum 53cms	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5296	6055	20 Pilot	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5297	6055	2100 Pro	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5298	6055	2100ZR	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5299	6055	2300 Alpha SL	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5300	6055	2300 Rework	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5301	6055	2500 pro	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5302	6055	2nd District	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5303	6055	360	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5304	6055	370 Sport	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5305	6055	400 FixedGear	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5306	6055	400 circa	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5307	6055	400 convert	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5308	6055	400 Elance	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7492	5810	Swing LX	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7493	5811	Fina Estampa	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7494	5811	Duende	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7495	5814	Lbc	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7496	5814	Strada	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7497	5814	Vitesse	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7498	5814	R203 circa	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7499	5815	Grapecycle	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7500	5815	PX10	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7501	5815	650B Randonneuse	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7502	5815	PY10	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7503	5815	Pa10	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7504	5815	OLD SCHOOL	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7505	5815	PG10	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7506	5815	PKN10E	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7507	5815	CFX10	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7508	5815	City	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7509	5815	Est tres beau	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7510	5815	Triathlon	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7511	5815	UO8	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7512	5815	GALIBIER HAMBURG	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7513	5815	Folding	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7514	5815	Ventoux PE 300	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7515	5815	Portapanini	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7516	5815	Putain	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7517	5815	Skittles	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7518	5815	79 super comp px10	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7519	5815	Seventies	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7520	5815	103_fixed gear_1979	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7521	5815	1920ies half racer	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7522	5815	Juliette	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7523	5815	PH 10LE Steel	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7524	5815	PH501	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7525	5815	2K COMP	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7526	5815	531	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7527	5815	531 pro	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7528	5815	531 Racing	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7529	5815	Aneto	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7530	5815	C Titan Teamline	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7531	5815	Cab	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7532	5815	Carbolite 103	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7533	5815	Catania	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7534	5815	Cologne	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7535	5815	Country	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7536	5815	Course	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7537	5815	CP 20	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7538	5815	DA 40 E	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7539	5815	DIY	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7540	5815	Europa	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7541	5815	Fibre de Carbone	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7542	5815	Galaxie	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7543	5815	Galibier	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7544	5815	Hot Streak	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7545	5815	Iseran	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7546	5815	Izoard	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7547	5815	Kid Equipe Z Days	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7548	5815	Kid Festina	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7549	5815	Lorange	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7550	5815	Nice	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7551	5815	P10 Competition	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7552	5815	PA 10LE	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7553	5815	PA10 Winter trainer	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7554	5815	PB14	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7555	5815	PH 10 L	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7556	5815	PH 12	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7557	5815	PH 8	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7558	5815	PH10 ls 50	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7559	5815	PH10C	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7560	5815	PH10LE reanimated	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7561	5815	PH11 FootieCoaster	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7562	5815	PK 10E Competition	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7563	5815	PL 8	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7564	5815	PL8 M 10 V	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7565	5815	Polo	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7566	5815	PR 10	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7567	5815	PR10	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7568	5815	Princeton	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7569	5815	PSV10S	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7570	5815	PX10 The Legend	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7571	5815	PX10 Racing	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7572	5815	PX10 LE	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7573	5815	PX10E	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7574	5815	PX10L	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7575	5815	PX8	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7576	5815	PY 10	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7577	5815	Py10 Reynolds 753r	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7578	5815	PY10 77	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7579	5815	Rainbow Rain	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7580	5815	Rando	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7581	5815	Record Du Monde	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7582	5815	Reynolds 531	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7583	5815	Sante	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7584	5815	Something or other	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7585	5815	Spectre	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7586	5815	SSFixed	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7587	5815	Super Sport	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7588	5815	Super Vitus 980	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7589	5815	Taco	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7590	5815	Team	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7591	5815	The Elder	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7592	5815	Touraine	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7593	5815	Tourmalet	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7594	5815	Townie	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7595	5815	Townie Snow	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7596	5815	Transformed	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7597	5815	U08	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7598	5815	U08 restoration	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5310	6055	412	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5311	6055	414	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5312	6055	420	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5313	6055	430	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5314	6055	500 TREK 1000	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5315	6055	5000 TCT	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5316	6055	5200	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5317	6055	5200 CarbonioRetro	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5318	6055	5200 USPS	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5319	6055	5500	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5320	6055	5500 OCLV	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5321	6055	69 Madone	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5322	6055	610 83	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5323	6055	610 84	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5324	6055	613	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5325	6055	620	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5326	6055	72 fx	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5327	6055	710	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5328	6055	7100 29er	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5329	6055	7200 hybrininer	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5330	6055	736	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7599	5815	UE8 reborn	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7600	5815	UO 9	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7601	5815	UO 9 Super Sport	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7602	5815	UO18	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7603	5815	UO10	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7604	5815	Ventoux	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7605	5815	Ventoux 87	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7606	5815	Vitus 979	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7607	5815	Weekend Rider	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7608	5815	XCountry	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7609	5815	Chrome	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7610	5815	Help me	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7611	5815	APOCALYPSE	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7612	5815	PH 10LE	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7613	5815	PKN10	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7614	5815	Helium Ladys	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7615	5815	PX10 Coastie	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7616	5815	YOUOHATE	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7617	5815	NS22 Folding	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7618	5815	UE8	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7619	5815	P10	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7620	5815	PX 10E French Road	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7621	5815	J 8	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7622	5815	PX10 Bella	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7623	5815	Monaco	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7624	5815	PFN10	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7625	5815	PKN10 Competition	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7626	5815	PF60	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7627	5815	PH10S	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7628	5815	PH10S 2nd Gen	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7629	5815	City Express	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7630	5815	PSV 10	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7631	5815	PSV10	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7632	5815	PX 8 M	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7633	5815	P6 Carbolite 103	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7634	5815	PSV10N	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7635	5815	PX10 DU	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7636	5815	Avoriaz	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7637	5815	Cosmic	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7638	5815	P6 Iseran	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7639	5815	P8 Avoriaz	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7640	5815	Versailles	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7641	5815	The Fury	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7642	5815	PX10 Race	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7643	5815	PXSB Sante	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7644	5815	Triathalon	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7645	5815	Dune Racing ISS 500	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7646	5815	Competition 60	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7647	5815	UO 8	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7648	5815	Ventoux reborn	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7649	5815	Dolomites	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7650	5817	Felt Brougham	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7651	5817	9kg	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7652	5819	Frankenbanger	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7653	5820	Titanium Road	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7654	5824	Montello SLX	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7655	5824	Montello	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7656	5824	Treviso	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7657	5824	Lucinda	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7658	5824	Banesto Replica	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7659	5824	Steel	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7660	5824	Olympic	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7661	5824	Amatore	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7662	5824	Amatore pista	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7663	5824	Asolo	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7664	5824	Bassano Pista	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7665	5824	Cadore	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7666	5824	Columbus max	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7667	5824	CRONO	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7668	5824	Cross	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7669	5824	Dogma	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7670	5824	Donna	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7671	5824	Dyna	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7672	5824	F313	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7673	5824	FP Quattro	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7674	5824	GAVIA	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7675	5824	Italia Treviso	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7676	5824	Jan Ullrich Team	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7677	5824	Maxim	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7678	5824	Mon Viso	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7679	5824	Montello repainted	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7680	5824	Montello SL Chrome	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7681	5824	Opera	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7682	5824	PLogO	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7683	5824	Paris	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7684	5824	Paris Pista	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7685	5824	Paris SS	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7686	5824	Paris Team Sky	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7687	5824	Pista	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7688	5824	Pista AL	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7689	5824	Prologo	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7690	5824	Prologo TT	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7691	5824	Pursuit FUNNY	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7692	5824	Radius	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7693	5824	ROKH	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5331	6055	750	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5332	6055	800	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5333	6055	800 Sport Buildup	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5334	6055	8000ZX	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5335	6055	8500	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5336	6055	850shx	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5337	6055	920 Rides again	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5338	6055	930 Singletrack	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5339	6055	950 Singletack	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5340	6055	Antelope	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5341	6055	Double	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5342	6055	Earl	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5343	6055	Elance 310	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5344	6055	Elance 400D	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5345	6055	F400 attic find	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5346	6055	Flying YGuitar	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7694	5824	SS roadie	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7695	5824	Stelvio	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7696	5824	Stelvio Road	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7697	5824	Super Record	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7698	5824	Suprise 57 campy	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7699	5824	Surprise	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7700	5824	Surprise pista	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7701	5824	Sutterlin winter	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7702	5824	Idk the	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7703	5824	Trevisio	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7704	5824	TSX	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7705	5824	Tsx colombus	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7706	5824	TT for Team Telekom	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7707	5824	Veneto	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7708	5824	Campy Record	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7709	5824	Dura Ace	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7710	5824	Xtrack Sprint	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7711	5824	Treviso Road	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7712	5824	Prince dolan	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7713	5824	Amatore trainer	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7714	5824	Catena Lusso	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7715	5824	Lusso Catena	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7716	5824	Campagnolo Victory	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7717	5824	Asolo Steel Road	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7718	5824	FP5	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7719	5824	Prince	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7720	5824	Paris Carbon 501K	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7721	5824	Pursuit	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7722	5830	Ec90 Speedneedle	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7723	5830	Alibongo	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7724	5830	Carbon 72 kg	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7725	5830	Carbon SL Pro	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7726	5830	Pro Carbon	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7727	5830	PRO CARBONSTREET	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7728	5830	Stealth	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7729	5830	Superlight Team	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7730	5830	Zebdi trials	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7731	5830	VS 53 BUICK	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7732	5830	Stealth Pro Carbon	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7733	5834	Rocket Pro	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7734	5835	Italcorse Pista	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7735	5835	Pista Pursuit	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7736	5835	TT Prototype	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7737	5835	Italcorsa	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7738	5835	Italcorse	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7739	5843	Brew	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7740	5843	Brew Hawaii	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7741	5843	Ale	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7742	5844	Race	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7743	5849	Alu	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7744	5849	Rex Pro	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7745	5849	Rex Road	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7746	5849	RexE	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7747	5849	RSL	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7748	5860	Major	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7749	5861	Ventus	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7750	5861	7800 808	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7751	5863	Original	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7752	5863	Super Record Export	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7753	5863	Coasterbrake	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7754	5863	Super Record60	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7755	5863	Katana	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7756	5863	Okashii	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7757	5863	555 beast	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7758	5863	Aero PURSUIT	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7759	5863	Aerodynamics	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7760	5863	Athlete	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7761	5863	Cello X 3rensho	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7762	5863	Katana road	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7763	5863	Pseudocross	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7764	5863	Pursue	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7765	5863	Pursuit	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7766	5863	Specialized	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7767	5863	SR Export	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7768	5863	Super record	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7769	5863	Super Record Aero	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7770	5863	SuperRecord Export	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7771	5863	Yamazaki	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7772	5863	Chromoly	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7773	5874	Aluminum SS	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7774	5874	Team Fanini	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7775	5874	Aluminium cross	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7776	5874	Aspelozen8	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7777	5874	Carbon Plus	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7778	5874	Roadbike	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7779	5874	CORSA SUPER	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7780	5874	Record Carbino	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7781	5874	Record Carbonio	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7782	5874	Sprint Record	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7783	5874	SR pantographed	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7784	5874	Super Record	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7785	5874	Super record pista	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7786	5874	Super Record SPRINT	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7787	5874	Ultegra Road	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7788	5874	Competizione	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7789	5874	SR Carbonio	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7790	5874	Cross Carbon X33	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7791	5875	Roadmaster	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7792	5875	Skylark	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7793	5875	Hercules Path Racer	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7794	5878	Speed	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7795	5889	Stealth Bomber	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5347	6055	Fuel 80	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5348	6055	Fuel EX 8	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5349	6055	FX 72	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5350	6055	Madone 45 WSD	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5351	6055	Madone 59	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7796	5889	Victory	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7797	5891	Marta	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7798	5891	Gtgt	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7799	5891	212	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7800	5891	Chro Pro	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7801	5891	Cyclone	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7802	5891	Cyclone FGFS	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7803	5891	Kissena	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7804	5891	Kissina	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7805	5891	Lo Pro	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7806	5891	Lo Pro Smile	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7807	5891	Lo Pro JAKARTA	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7808	5891	Lo Pro Part II	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7809	5891	Lo Pro ss	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7810	5891	Lo Pro Miss Berry	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7811	5891	Lo Probur	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7812	5891	Lo rookie	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7813	5891	Low Pro	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7814	5891	Low Pro Icarus	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7815	5891	Low pro large	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7816	5891	Marta Numero Dos	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7817	5891	Pursuit	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7818	5891	YellowPro	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7819	5891	Yuko	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7820	5893	Liberator	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7821	5893	Ti Hag	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7822	5899	Ankle FAIL	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7823	5899	ALIEN ALIEN	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7824	5899	Carbon V3	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7825	5899	Complete	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7826	5899	Ghost v 2	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7827	5899	RetroDirect	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7828	5902	Nature Boy	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7829	5902	Big Block	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7830	5902	Defwish	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7831	5902	Dropout Iffed Out	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7832	5902	Macho Man	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7833	5902	Dropout Limited	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7834	5902	Nature Boy School	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7835	5907	420s	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7836	6108	Lo pro	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7837	6108	R872	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7838	6111	XNight Flipper	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7839	6111	Aedon Campy	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7840	6111	Boreas	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7841	6111	Compact	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7842	6111	Crossbow	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7843	6111	Crossbow NA08	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7844	6111	Damocles	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7845	6111	Icarus	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7846	6111	Noah Pro ISP	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7847	6111	Orion	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7848	6111	Oval	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7849	6111	Oval 7D61	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7850	6111	Oval BlakkAttakk	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7851	6111	Pegasus	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7852	6111	Workhorse	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7853	6111	XRide	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7854	6111	XBow Version 20	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7855	6111	Crosswind	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7856	6111	Noah	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7857	6113	Swiss Cross	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7858	6113	SwissCross 20	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7859	6113	Ascent	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7860	6113	Chicane	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7861	6113	NiTi	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7862	6113	P29er	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7863	6113	PTeam	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7864	6113	Plexus	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7865	6113	Road Logic 13	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7866	6113	Road Logic	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7867	6113	Swiss Cross 12	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7868	6113	Swiss Cross Gen1	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7869	6113	Timberwolf	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7870	6113	Timber Comp	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7871	6116	Voyager large size	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7872	6116	Low Rider	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7873	6116	Milano Coltrane	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7874	6117	C Retro	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7875	6117	Bluey	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7876	6117	Pursuit ready soon	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7877	6117	Handbuilt	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7878	6117	Charles criterium	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7879	6117	Life	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7880	6118	Lenton Sport	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7881	6119	Team tig 853	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7882	6122	ALTITUDE SE 29er	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7883	6122	BOROUGHS	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7884	6122	Reaper	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7885	6122	RM7dh	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7886	6122	Slayer50	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7887	6122	Solo 30	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7888	6122	TEAM ISSUE ROAD	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7889	6122	Whistler DB 1	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7890	6125	Expedition	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7891	6125	Supercommuter	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7892	6125	Travel	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7893	6125	29er	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7894	6129	Rat Finked Apollo	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7895	6129	Revise	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7896	6129	Mt MCKINLEY	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7897	6129	AUBERGINE	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7898	6129	Eurosport	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7899	6129	Gran Tour	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7900	6129	Mt St Helens	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7901	6129	Mt Bear frankenbike	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7902	6129	Riviera	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7903	6129	Signature	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7904	6129	Signature series	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7905	6129	Gran Tour II	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7906	6129	Shopping Cart	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7907	6129	Signature 290S	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7908	6131	ADRENALINE BLU	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7909	6131	Columbus slx road	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7910	6131	Aerodynamics	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7911	6131	Coaster	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7912	6131	Finished	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7913	6131	Funny	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7914	6131	Fxd	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7915	6131	Ghibli	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7916	6131	Ginestra	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7917	6131	Infinity	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5352	6055	Multitrack 730 Polo	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5353	6055	OCLV 5000 Junkyard	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5354	6055	Portland	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5355	6055	Pro Series	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5356	6055	Rusty Steel	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5357	6055	Session 88 downhill	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5358	6055	Soho S	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5359	6055	STP 200	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5360	6055	T1 Demon	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5361	6055	T1 Remix	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5362	6055	T200	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5363	6055	UtilityCross	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5364	6055	Wsd fuel ex 7 05	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7918	6131	Pista	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7919	6131	Pista sprint	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7920	6131	Prestige	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7921	6131	Pursuit	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7922	6131	Pursuit olympic	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7923	6131	Record	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7924	6131	Sprint monster	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7925	6131	Tt pista	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7926	6131	WinterRain Street	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7927	6131	Crono bike	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7928	6131	Pista Record	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7929	6131	Pista Super Record	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7930	6131	Team 711	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7931	6131	RLX Road	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7932	6135	Force	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7933	6135	Blackness	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7934	6135	Enfield Zephyr	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7935	6135	ENGLAND	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7936	6135	H Cycles 11	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7937	6135	Scot	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7938	6135	24inch	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7939	6135	QWEST	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7940	6136	Dumpster grab	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7941	6136	Hollands Hope	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7942	6136	Find	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7943	6141	PEAK	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7944	6141	Expert	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7945	6141	Speedster	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7946	6141	Scale 29er	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7947	6141	Speedster s3	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7948	6141	Addict Ltd	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7949	6141	ADDICT R2	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7950	6141	Addict R3 678kg	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7951	6141	Aspect 650	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7952	6141	CR1 PRO	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7953	6141	CR1 TEAM	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7954	6141	Foil Team Issue	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7955	6141	Rigid	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7956	6141	S40	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7957	6141	S60 Sram Rival	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7958	6141	Scale 10	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7959	6141	Scale 20 CarbonGONE	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7960	6141	Speedster S40	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7961	6141	Speedster S50	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7962	6141	SUB10	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7963	6141	Ironman	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7964	6141	Ironman Expert	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7965	6141	Expert Funny	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7966	6141	Ironman Carbon	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7967	6141	Master	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7968	6141	TINLEY TRILITE	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7969	6141	Ironman Expert  24	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7970	6141	Comp Racing	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7971	6141	CR1	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7972	6141	Scale 30	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7973	6141	Scale 60 Patrol	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7974	6141	Spark 30	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7975	6141	Scale elite 29er	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7976	6141	Sportster 10	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7977	6147	Rival	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7978	6147	Apex road	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7979	6147	Force	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7980	6147	REDForce Group	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7981	6147	Omnium	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7982	6147	S80 Wheelset	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7983	6147	Rival Group	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7984	6147	Components	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7985	6147	RivalRed	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7986	6148	AL 2	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7987	6148	Aluminum	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7988	6148	STi	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7989	6149	Schosse	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7990	6149	Osse CTAPT	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7991	6149	Osse XB3 CTAPT	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7992	6152	Pistola	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7993	6152	Trixie w Disc Cog	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7994	6152	Campeon	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7995	6152	Casseroll Single	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7996	6152	Ala Carte	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7997	6152	Ala Carte 1x9	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7998	6152	Casseroll	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
7999	6152	Casseroll Triple	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8000	6152	Chilie Con Crosso	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8001	6152	Juan Solo Supermoto	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8002	6152	La Raza	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8003	6152	Las Cruces	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8004	6152	Podio	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8005	6152	Casserol	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8006	6152	Vaya	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8007	6152	Verde	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8008	6152	Warbird 2	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8009	6156	Steelmachine	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8010	6158	TallBoy LT Carbon	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8011	6158	Blur XC	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8012	6158	Nomad	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8013	6158	Tallboy	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8014	6158	Blur 4X	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8015	6158	Bullit	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8016	6158	Blur LT	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8017	6158	Chameleon	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8018	6158	Juliana	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8019	6159	Moda	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8020	6164	Americano	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8021	6164	R660	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8022	6164	SSR	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8023	6164	XRL	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5366	6055	Transplant	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5367	6055	700	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5368	6055	GIRLFRIEND	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5369	6055	930	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5370	6055	614	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5371	6055	720	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5372	6055	400 Revamp	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5373	6055	460	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5374	6055	500 Ratrod	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8024	6164	R330 Triple Road	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8025	6164	XRL Cross	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8026	6168	564	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8027	6168	Paramount	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8028	6168	PROLOGUE TT	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8029	6168	World Sport	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8030	6168	Varsity	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8031	6168	Varsity Parts	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8032	6168	Tempo	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8033	6168	Caliente	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8034	6168	Varsity 510	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8035	6168	Le Tour IV	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8036	6168	Collegiate	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8037	6168	Cutter	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8038	6168	Paramount p14	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8039	6168	Le Tour	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8040	6168	Traveler	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8041	6168	Traveler III	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8042	6168	Super Stock	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8043	6168	Sprint FixieSS	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8044	6168	World	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8045	6168	Madison	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8046	6168	Lil Tiger	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8047	6168	Sierra	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8048	6168	Sprint	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8049	6168	Varisty	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8050	6168	Breeze	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8051	6168	Voyageur	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8052	6168	Le Tour III	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8053	6168	Spoiler	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8054	6168	Continental II	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8055	6168	Twinn Deluxe	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8056	6168	S9five 2	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8057	6168	World Tourist	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8058	6168	Voyageur 118	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8059	6168	Waterford Paramount	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8060	6168	434	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8061	6168	Aluminum modernized	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8062	6168	American Deluxe	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8063	6168	Apple Krate	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8064	6168	Armstrong	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8065	6168	Baby	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8066	6168	Bomber	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8067	6168	Caliente raw	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8068	6168	Chicago Prelude	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8069	6168	Cimarron	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8070	6168	Circuit	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8071	6168	Collegiate Sport	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8072	6168	Continental	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8073	6168	Fairlady Chopper	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8074	6168	Fastback	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8075	6168	Fastback Comp	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8076	6168	Fastback Pro	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8077	6168	Graf	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8078	6168	High Sierra	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8079	6168	Homegrown	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8080	6168	Hurricane	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8081	6168	Jester	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8082	6168	Le tour 122	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8083	6168	Le Tour 2	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8084	6168	Le Tour chromoly	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8085	6168	Le Tour II	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8086	6168	Le Tour Luxe	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8087	6168	Le Tour SS	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8088	6168	Le Tour Road	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8089	6168	Le Tour Fred	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8090	6168	LeTour	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8091	6168	LeTour II	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8092	6168	Little 500	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8093	6168	Maddie	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8094	6168	Maddie Frankenstein	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8095	6168	Maddy Ohhh 9	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8096	6168	Madison 08	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8097	6168	Madison chrome	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8098	6168	Madison Eyesore	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8099	6168	Madison Reissue	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8100	6168	Mercier Franken	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8101	6168	Mesa	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8102	6168	Paramount chrome	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8103	6168	PARAMOUNT OS	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8104	6168	Passage reborn	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8105	6168	Path racer	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8106	6168	PELETON	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8107	6168	Peloton Pro	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8108	6168	Peloton Pro circa	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8109	6168	Polska	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8110	6168	Prelude	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8111	6168	Premis	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8112	6168	Prologue	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8113	6168	Prologue TT funny	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8114	6168	Racer	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8115	6168	Rat	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8116	6168	Raw	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8117	6168	Rebirth	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8118	6168	Sierra Tourer	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8119	6168	Sierra Pro Comp	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8120	6168	Sports Tourer	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8121	6168	Steelchromeshadow	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8122	6168	Suburban	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8123	6168	Super Le Tour	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8124	6168	SUPER LE TOUR BLOO	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8125	6168	Super Le Tour 122	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8126	6168	Super le tour sacto	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8127	6168	Super Sport	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8128	6168	Super Sport SP	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8129	6168	Superior	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8130	6168	Tempo Tiagra	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8131	6168	Time Machine	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8132	6168	To Win	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8133	6168	Tornado	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8134	6168	Traveler Tasty	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8135	6168	Travler III	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8136	6168	Typhoon	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5375	6055	410 Single	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5377	6055	660 Pro Series	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5378	6055	760	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5379	6055	310 Elance	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5380	6055	460 sw8 roadie	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5381	6055	500 tri series	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5382	6055	Elance 400	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5383	6055	Tri Series 700	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5384	6055	1500	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5385	6055	330 Elance	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5386	6055	400D Elance	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5387	6055	400T Elance	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5388	6055	400 Tighty Whitey	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8137	6168	Wannabee Stingray	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8138	6168	Whipp	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8139	6168	World circa	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8140	6168	World Sports	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8141	6168	World Sport SS	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8142	6168	World SS Coaster	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8143	6168	XR8	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8144	6168	Paramounts	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8145	6168	Twinn	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8146	6168	Lil Chik Stingray	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8147	6168	PARAMOUNT ser 123	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8148	6168	DX Bare Naked	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8149	6168	Spitfire	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8150	6168	Paramount P12	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8151	6168	Skipper	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8152	6168	Jaguar	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8153	6168	American	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8154	6168	FLEET	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8155	6168	J33 Stingray	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8156	6168	Hollywood Deluxe	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8157	6168	Sting Ray	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8158	6168	Breeze Charlene	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8159	6168	Paramount P13	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8160	6168	Paramount P139	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8161	6168	Paramount P15	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8162	6168	Deluxe StingRay	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8163	6168	SS Continental	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8164	6168	Stingray	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8165	6168	Paramount TRADED	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8166	6168	VOYAGEUR II	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8167	6168	Hollywood	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8168	6168	Pixie II	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8169	6168	Varsity Camelback	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8170	6168	Volare	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8171	6168	Voyageur SP	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8172	6168	WorldSport	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8173	6168	TempoGone	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8174	6168	Madison NOS	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8175	6168	Peloton	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8176	6168	Circuit stock	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8177	6168	Paramount Waterford	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8178	6168	Predator	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8179	6168	564 Aluminum	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8180	6168	594	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8181	6168	World Sport Road	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8182	6168	Moab3	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8183	6168	Super Sport June	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8184	6168	Panther	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8185	6168	Manta Ray	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8186	6168	Madison St Louis	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8187	6168	Madison The Mad Son	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8188	6168	Cutter Murdered	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8189	6168	Sprint FGSS	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8190	6168	Mirada	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8191	6168	So Cal	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8192	6168	Rat Rod	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8193	6168	Super lite	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8194	6168	Approved Le Tour	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8195	6168	LeTour Quicksilver	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8196	6168	Sierra revisited	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8197	6168	Woodlands	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8198	6168	Le Tour SS WIP	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8199	6168	Traveler Road	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8200	6168	Passage	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8201	6169	Torker	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8202	6174	1000	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8203	6174	1000 Birthday	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8204	6174	2400	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8205	6174	Hanzo Steel	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8206	6174	Magic	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8207	6174	Free Wheel	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8208	6174	500 Sport	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8209	6175	OLD SCHOOL	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8210	6175	Roadie	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8211	6175	Medallion	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8212	6175	SHC	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8213	6175	Single	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8214	6175	Medialle	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8215	6175	SHB or SHC	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8216	6181	Pursuit AERO	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8217	6181	84 US olympic team	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8218	6181	Dead	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8219	6181	Atlanta	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8220	6181	Baby	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8221	6181	Coeur dAcier	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8222	6181	Colorado II	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8223	6181	Colorado III OS	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8224	6181	Colorado III	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8225	6181	Colorado Ti	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8226	6181	Coors Light	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8227	6181	Corsa Pista	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8228	6181	CRL Legend	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8229	6181	Csi	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8230	6181	Pursuit	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8231	6181	Davis phinney	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8232	6181	Legend Ti	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8233	6181	Nova	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8234	6181	Nova X	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8235	6181	Ottrott	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8236	6181	Ti road	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8237	6181	RIP2011	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8238	6181	Mavic Group	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8239	6181	Colorado	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8240	6181	Colorado TG	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8241	6181	Classique	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5390	6055	1420 DEAD	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5391	6055	790 Multi	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5392	6055	790	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5393	6055	1100 Aluminum	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5394	6055	2300	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5395	6055	1220	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5396	6055	Y22	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5397	6055	SubVert 20	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5398	6055	Pilot 21	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5399	6055	2100 ZR	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5400	6055	5000	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5401	6055	Madone SL 52	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5402	6055	6000	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5403	6055	Madone 52	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5404	6055	T1 15lbs PIMP	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5405	6055	FX 72 WSD	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5406	6055	Madone 51	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5407	6055	15 Alpha Compact	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5408	6055	Madone 5	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5409	6055	Crossrip	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5410	6055	400 porteur	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5411	6055	500	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5412	6055	1500 old skewl	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8242	6181	Attack	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8243	6181	Singolo	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8244	6181	Colorado CRL	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8245	6181	Colorado Road	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8246	6182	Reken SS	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8247	6183	Redo	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8248	6183	Hundred	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8249	6183	Aerios	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8250	6183	Axiom	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8251	6183	Axiom Ti	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8252	6183	Bella	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8253	6183	Duo 29er	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8254	6183	Twenty five TR	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8255	6187	600	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8256	6187	Dura Ace	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8257	6187	Dura Ace 8V	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8258	6187	Dura Ace 7800	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8259	6187	600 Ultegra	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8260	6187	600 ex	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8261	6187	DuraAce 2x9 Ultegra	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8262	6187	Aero tubeset600 AX	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8263	6187	105	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8264	6187	600 Arabesque	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8265	6187	600EX group	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8266	6187	RX100	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8267	6187	Dura Ace740	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8268	6187	Sante	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8269	6187	Team Show	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8270	6187	Team colours	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8271	6187	Rainbow machine	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8272	6187	Aero 83	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8273	6187	10 pitch	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8274	6187	Sirrus	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8275	6187	Pursuit	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8276	6187	Nagasawa	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8277	6187	Deore XT group	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8278	6187	Ultegra 6700 Group	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8279	6187	Dura Ace 7900 Group	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8280	6189	My first road	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8281	6189	The King Snake	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8282	6189	100	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8283	6189	1000	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8284	6189	300	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8285	6189	400	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8286	6189	500 the Snake King	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8287	6189	600	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8288	6189	Ice	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8289	6189	Kaze 105 pursuit	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8290	6189	Kaze TTFunny	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8291	6189	KAZIE	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8292	6189	Metro SE	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8293	6189	Polo	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8294	6189	Roadster	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8295	6189	Sport	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8296	6189	Triple Triangle	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8297	6189	400 Maroon	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8298	6189	MTB1	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8299	6189	Randonneur	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8300	6189	TouringRando	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8301	6189	Samurai Tange 2	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8302	6197	Pavo 615kg	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8303	6207	Tuff Wheels	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8304	6207	Street Beat	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8305	6207	Street Shredder	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8306	6215	Rush	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8307	6215	Smoothie	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8308	6215	4one5	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8309	6215	Buena Vista	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8310	6215	Buena Vista Mitxte	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8311	6215	Commute	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8312	6215	Cosmopolitan	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8313	6215	Cross	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8314	6215	Delancey	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8315	6215	Double Cross	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8316	6215	Double Cross Wayne	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8317	6215	Generation	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8318	6215	Grand randonneur	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8319	6215	Juice 29er	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8320	6215	Rush Mind The Gap	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8321	6215	Rush 08	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8322	6215	Rush 53	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8323	6215	Rush Niners	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8324	6215	Rushmore	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8325	6215	Smoothie 1x9	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8326	6215	Smoothie ES	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8327	6215	Smoothie ES extra	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8328	6215	Sport FixedFree	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8329	6215	Stanyan	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8330	6215	Double Cross DC	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5413	6055	1200 SS	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5414	6055	820 Miles	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5415	6055	2100 Zephyrus	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5416	6055	8000	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5417	6060	Funny	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5418	6064	Pacifica	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5419	6064	130 series	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5420	6064	Mistral	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5421	6064	Alpina 2500	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5422	6064	Bergmeister	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5423	6064	Brigadier	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5424	6064	Cavalier	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5425	6064	Cavalier SS	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5426	6064	Inter 10	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5427	6064	Mistral A	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8331	6216	Leader	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8332	6216	Lugo di Romagna	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8333	6216	Marble countertop	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8334	6216	Pista	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8335	6216	ProMax	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8336	6216	Super Air Pursuit	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8337	6216	Super Corsa	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8338	6221	Blade	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8339	6221	Blade RE	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8340	6221	SPX1000	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8341	6223	Epic	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8342	6223	Seattle langster	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8343	6223	Langster	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8344	6223	Expedition	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8345	6223	Langster Blaki	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8346	6223	Rockhopper SS 29er	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8347	6223	Allez Comp	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8348	6223	Stumpy	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8349	6223	Transition TRI	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8350	6223	Allez	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8351	6223	Langster customized	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8352	6223	Hardrock crmo	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8353	6223	Allez Triple	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8354	6223	Allez Sport	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8355	6223	Epic Disc 05	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8356	6223	Stumpjumper Pro	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8357	6223	STUMPY FSR 04	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8358	6223	Tarmac Pro	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8359	6223	Sirrus	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8360	6223	Tri spokes	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8361	6223	Rockhopper Comp	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8362	6223	Sworks langster	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8363	6223	04 Langster	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8364	6223	86 Allez	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8365	6223	Allez A1	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8366	6223	Allez C2	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8367	6223	Allez carbon fiber	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8368	6223	Allez CarbonAlu	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8369	6223	Allez comp04	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8370	6223	Allez CrMo	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8371	6223	Allez Double	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8372	6223	Allez Double Steel	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8373	6223	Allez Elite	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8374	6223	Allez Elite Double	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8375	6223	Allez Elite Triple	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8376	6223	Allez Epic	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8377	6223	Crux	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8378	6223	Demo 9	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8379	6223	Dolce	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8380	6223	E5 Aerotec	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8381	6223	Enduro	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8382	6223	Enduro Pro	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8383	6223	Epic Road	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8384	6223	Epic FSR	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8385	6223	Epic lugged carbon	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8386	6223	FatBoy 14	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8387	6223	FSR XC 04	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8388	6223	FSR XC Comp	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8389	6223	Globe Centrum Sport	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8390	6223	Globe Sport	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8391	6223	Hard Rock	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8392	6223	Hardrock	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8393	6223	Hardrock Comp	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8394	6223	Hardrock SS	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8395	6223	Langster Boston	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8396	6223	Langster Comp	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8397	6223	Langster London	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8398	6223	Langster Monaco	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8399	6223	Langster NYC	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8400	6223	Langster NYC 412	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8401	6223	Langster Pro	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8402	6223	Langster SWorks	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8403	6223	Langster Steel	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8404	6223	M2 team hardtail	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8405	6223	M4 CX	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8406	6223	Mutt	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8407	6223	Rock Combo	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8408	6223	RockHopper	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8409	6223	Rockhopper FS	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8410	6223	Rockhopper SS	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8411	6223	Roubaix	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8412	6223	Roubaix Comp	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8413	6223	Roubaix Comp triple	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8414	6223	S Works Tarmac SL	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8415	6223	Swork langster	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8416	6223	SWorks	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8417	6223	SWorks E5	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8418	6223	SWorks E5 Road	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8419	6223	SWorks Enduro	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8420	6223	SWorks roadie	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8421	6223	SWorks Tarmac SL	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8422	6223	SWorks Triathlon	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8423	6223	Sirrus Comp	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8424	6223	Stumpjumper	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8425	6223	Stumpjumper FSR	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8426	6223	Stumpjumper Pro HT	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8427	6223	Stumpy M2	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8428	6223	Stumpy M4	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8429	6223	Sworks hardtail	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8430	6223	Tarckster	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8431	6223	Tarmac	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5428	6064	Mistral Competition	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5429	6064	Mistral EL	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5430	6064	MIXTIE	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5431	6064	Royal Force	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5432	6064	Royal X	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5433	6064	Alpine	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5434	6064	Odyssey	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5435	6064	Luzern	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5436	6073	SampS couplers	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5437	6075	DeLuz	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5438	6075	Te Quilo	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5439	6075	Superform	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5440	6077	Bustraan	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8432	6223	Tarmac SWorks SL3	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8433	6223	Tarmac SL4 Pro	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8434	6223	Tarmak Sworks SL2	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8435	6223	Tokyo Langster	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8436	6223	Townie	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8437	6223	Tricross	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8438	6223	Tricross Comp	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8439	6223	Tricross SS	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8440	6223	Vienna Globe Sport	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8441	6223	Wangster Comp	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8442	6223	XCPro	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8443	6223	Crux Disc	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8444	6223	Stumpjumper Sport	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8445	6223	Allez SE	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8446	6223	Sequoia	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8447	6223	Allez Jim Merz	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8448	6223	Sirrus Triple	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8449	6223	StumpJumper FS	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8450	6223	Allez Pro	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8451	6223	Epic Pro	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8452	6223	M2 Road	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8453	6223	Rockhopper A1 FS	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8454	6223	Stumpjumper FSR XC	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8455	6223	Allez Comp Double	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8456	6223	Enduro SX fsr	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8457	6223	Langster Racer	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8458	6223	Demo 8	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8459	6223	Centrum Sport	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8460	6223	Langster Chicago	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8461	6223	Langster S Works	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8462	6223	S Works Transition	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8463	6223	Tarmac Pro SL	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8464	6223	Tri Cross	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8465	6223	Tarmac Pro SL DA	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8466	6223	Tricross Expert	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8467	6223	Camber Elite	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8468	6223	Lagster Steel	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8469	6223	SL2	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8470	6223	Stumpjumper FSR Evo	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8471	6223	Tarmac Comp	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8472	6223	Allez Compact	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8473	6223	Tarmac Expert	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8474	6223	Venge Pro	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8475	6223	Vita	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8476	6223	Tarmac Elite	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8477	6223	London edition	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8478	6224	1 lghtspd	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8479	6224	GHattons	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8480	6224	Criterium	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8481	6224	Titanium	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8482	6226	PATH RACER	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8483	6226	Mark III Titanium	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8484	6228	Cycles Pursuit	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8485	6228	Alluminum	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8486	6228	Pursuit	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8487	6228	Prototype	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8488	6228	Triple Triangle	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8489	6228	Aluminum	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8490	6233	Metalhead	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8491	6237	Brand	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8492	6237	Interbike display	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8493	6237	Brand 29 concept	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8494	6243	Trento	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8495	6243	VFR	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8496	6246	Park	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8497	6250	Pista Fillet Brazed	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8498	6250	LE10 Handmade	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8499	6269	Extreme X3	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8500	6269	Mary	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8501	6269	Mary 1x9	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8502	6269	Mary SS	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8503	6269	Mirra 540 Air	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8504	6269	Projekt	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8505	6269	MASTER Nos	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8506	6269	Master	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8507	6269	Shift R7	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8508	6269	Freestyler	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8509	6270	Pursuit	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8510	6278	Kulkuri 87	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8511	6278	Kuningaskulkuri	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8512	6278	Mail	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8513	6283	Randonnuer	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8514	6284	Tribute	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8515	6284	Super	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8516	6284	Vade mecum	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8517	6288	Columbus MAX	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8518	6288	SLX	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8519	6288	Rat rod	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8520	6293	Bama	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8521	6293	Rhythm	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8522	6294	Mix up rodentride	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8523	6294	Professional	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8524	6294	Team circa 68	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8525	6294	Unlikely Converted	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8526	6294	Zephyr path	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8527	6294	Stayer	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8528	6301	314 Road	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8529	6301	Aerowind	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8530	6301	Constellation	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8531	6301	Diesel	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8532	6301	Independence	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8533	6301	Omni10 donated	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8534	6301	Santa fe	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8535	6301	Stalker	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8536	6301	Terra Nova	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5441	6077	Bustraan Amsterdam	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5442	6077	Competition	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5443	6077	Elan Roadbike	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5444	6077	Luxe Bustraan	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5445	6077	Mistral	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5446	6077	Campagnolo	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5447	6077	Super Course	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5448	6077	Pista The cute one	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5449	6077	Sport	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5450	6077	Super	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5451	6077	Pista	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5452	6077	531	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5453	6081	Campagnolo	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5454	6086	Sprite	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5455	6086	Sports for Kerry	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5456	6086	Shopper	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5457	6086	Competition GS	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8537	6301	Sweet Style	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8538	6301	Rail	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8539	6306	Primo	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8540	6306	Corsa	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8541	6312	Highlight GPH	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8542	6317	Angus	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8543	6317	LC named Wesley	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8544	6317	Copy polobeater	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8545	6317	Mark V	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8546	6317	MarkV	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8547	6317	Mark V Pro	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8548	6317	GROUP BUY COMPLETE	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8549	6317	The Iro	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8550	6317	BFSSFG	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8551	6317	Angus Beef	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8552	6317	Butcher Bird	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8553	6317	Mary jane	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8554	6317	Rob Roy	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8555	6317	ANGUS Tangerine	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8556	6317	Angus daily rider	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8557	6317	BFSSFFLOLZOMGWTFBBQ	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8558	6317	Doom	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8559	6317	Group buy	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8560	6317	Groupbuy	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8561	6317	JRoy	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8562	6317	Jamie Roy	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8563	6317	Jamie Roy Ghost	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8564	6317	Jamie Roy RVA	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8565	6317	Limited Edition 59	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8566	6317	Limited Edition LC	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8567	6317	Mark v my baby	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8568	6317	Mark V 56	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8569	6317	Mark V complete	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8570	6317	Mark V BFSSFG	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8571	6317	MARK V FIFTYSIX CM	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8572	6317	Mark v illness	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8573	6317	Mark V Pro Alpha Q	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8574	6317	Mark V pro HD	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8575	6317	Mark V Pro San Jose	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8576	6317	Mark V Stealth	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8577	6317	Mark V Stripped	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8578	6317	Mark V Tank	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8579	6317	Mark V Work	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8580	6317	Mark V Oakland	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8581	6317	Mark5	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8582	6317	MarkV customized	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8583	6317	MarkV Pro	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8584	6317	Mia	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8585	6317	Murdered out	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8586	6317	Needs paint	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8587	6317	Nerdy angus	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8588	6317	Phoenix	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8589	6317	WORK	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8590	6317	WTF Phoenix	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8591	6317	Yall	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8592	6317	WTF	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8593	6317	De Vamp	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8594	6317	ANGUS PURSUIT STYLE	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8595	6317	Groupbuy Clone	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8596	6317	Angus duh	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8597	6317	Columbus OH AWS	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8598	6317	Sticker	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8599	6317	Jamie Roy 53	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8600	6317	Jesus Piece	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8601	6317	Rob Roy SSCX	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8602	6317	Ltd	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8603	6320	Kermit Tranny	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8604	6320	Hakkalgi	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8605	6320	Mojo	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8606	6320	Scorcher	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8607	6320	Spanky	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8608	6320	Mojo Carbon	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8609	6320	Hakkalugi	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8610	6320	Spanky Honey Badger	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8611	6326	Crown Jewel	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8612	6326	Smooth as silk	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8613	6326	Crown Jewel SEC	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8614	6326	Disc Club Racer	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8615	6326	Steel Deluxe	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8616	6326	Steel Deluxe SS	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8617	6326	Steel Planet X	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8618	6333	Jc Higgins	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8619	6333	Leader 721	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8620	6334	Uzzi Sl	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8621	6334	Spider XVP	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8622	6336	Maverick 55	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8623	6336	Trail	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8624	6346	Dragon 29er	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8625	6346	Sputnik	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8626	6346	Dragon One	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8627	6346	PinkOTron Supernova	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8628	6346	Aurora Elite	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8629	6346	Dakar	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8630	6346	Eclipse	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8631	6346	Quest	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8632	6346	Sonik	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8633	6346	SONIK 08	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8634	6346	Sonik w Zipp 404s	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8635	6346	Sputnik 09	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5458	6086	International	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5459	6086	Rampar R1097	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5460	6086	Record	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5461	6086	Roadster	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5462	6086	Camping	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5463	6086	555 SuperCourse	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5464	6086	Revenio 30	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5465	6086	Pros	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5466	6086	Marathon 502	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5467	6086	Sports	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5468	6086	Super Couse MKII	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5469	6086	Rush Hour	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5470	6086	Technium	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5471	6086	Professional from74	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5472	6086	Record Ace	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5473	6086	Twenty	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5474	6086	Rush Hour Pro	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5475	6086	Budget	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5476	6086	Seven Hundred	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5477	6086	77 Supercourse	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5478	6086	Circa	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5479	6086	SCORPIO Hamburg	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5480	6086	Campagnolo	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5481	6086	Carlton	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5482	6086	Team USA Olympic	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5483	6086	Sturmey Archer	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5484	6086	531c GRAN COURSE	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5485	6086	531c Luxe	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5486	6086	76 Gran Sport	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5487	6086	Airlite	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5488	6086	Cadent 20	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5489	6086	Camo coaster	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5490	6086	Capri	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5491	6086	Capri Radar	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5492	6086	Carlton Flyer	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5493	6086	Clubman	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5494	6086	Competition	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5495	6086	CompetitionSuperbe	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5496	6086	Condor	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
5497	6086	Crested Butte	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8703	6358	Conversiion	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8704	6358	Crit Converted	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8705	6358	Criterium 30	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8706	6358	Criterium 30 SR400	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8707	6358	Criterium SS	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8708	6358	Cruiserdale	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8709	6358	CX9	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8710	6358	EVO	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8711	6358	F2000SL	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8712	6358	F400	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8713	6358	F400 XC	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8714	6358	Flash Alloy	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8715	6358	Flash F2	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8716	6358	Ghetto	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8717	6358	Jekyll 1000	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8718	6358	Killer V900	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8719	6358	M300	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8720	6358	M300 1X9	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8721	6358	M400	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8722	6358	M500	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8723	6358	M900	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8724	6358	Mt proflex forks	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8725	6358	Oldie	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8726	6358	Optimo CAAD 05	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8727	6358	Optimo Disc	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8728	6358	Optimo	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8729	6358	Prophet	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8730	6358	R 400 58 Single	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8731	6358	R1000	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8732	6358	R1000 aero 58	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8733	6358	R2000	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8734	6358	R300	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8735	6358	R400	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8736	6358	R500	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8737	6358	R500 CAAD5	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8738	6358	R5000	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8739	6358	R600	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8740	6358	R600 Bumble Bee	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8741	6358	R700	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8742	6358	R800	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8743	6358	R800 28 Series	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8744	6358	R800 Cadd5	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8745	6358	R900 CAAD5	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8746	6358	R900 polished	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8747	6358	R900	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8748	6358	Racer	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8749	6358	Roadbike	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8750	6358	Rush 7	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8751	6358	RZ140	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8752	6358	Scalpel carbon 3	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8753	6358	Silk Road 500	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8754	6358	Sincycle Caad5	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8755	6358	Cross	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8756	6358	Six Crabon	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8757	6358	Six thirteen	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8758	6358	Six13	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8759	6358	Slice	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8760	6358	Sm600	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8761	6358	SM500	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8762	6358	SR600 87	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8763	6358	SR1000	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8764	6358	SR400	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8765	6358	SR400 Madison	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8766	6358	Sr500	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8767	6358	SR500 Team Crest	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8768	6358	SR800	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8769	6358	SSMOTO	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8770	6358	ST1000	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8771	6358	Super 6	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8772	6358	Super Six	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8773	6358	Super Six HiMod	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8774	6358	SuperSIX	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8775	6358	SuperSix Di2	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8776	6358	SuperSix Evo	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8777	6358	SuperSix HiMod	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8778	6358	Synapse My Tri	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8779	6358	Synapse Hi Mod	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8780	6358	T1000	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8781	6358	T700	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8782	6358	Mr magic	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8783	6358	Or Trade	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8784	6358	199 Polished	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8785	6358	30 polished	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8786	6358	Goodness	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8787	6358	Polished	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8788	6358	Team EDS	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8789	6358	Trail SL4 29er	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8790	6358	Transformer	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8791	6358	XR800	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8792	6358	Cannonball	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8793	6358	Cannonball 2	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8794	6358	H400	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8795	6358	CAAD8	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8796	6358	Rush Carbon 4 1400	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8797	6358	Moto2	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8798	6358	Racing	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8799	6358	CAAD96	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8800	6358	Major Taylor	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8801	6358	1000	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8802	6358	Boardwalk Bomber	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8803	6358	Caad5 saeco replica	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8804	6358	CAAD9 Team	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8805	6358	Criterium GFs	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8806	6358	SR 500	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8807	6358	SR900	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8808	6358	SM800	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8809	6358	SR600	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8810	6358	SR2000 Crit	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8811	6358	SR500 Criterium	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8812	6358	30 Criterium	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8813	6358	Criterion	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8814	6358	Criterium redo	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8815	6358	SR400 Criterium	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8816	6358	SR600 crit 30	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8817	6358	SR600 criterium	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8818	6358	R500 Road	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8819	6358	Clear pictures	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8820	6358	R400 ROSIE	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8821	6358	M800	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8822	6358	100 Original	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8823	6358	For Tree People	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8824	6358	Factory Polished	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8825	6358	NOS 100 Original	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8826	6358	M600 1x9	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8827	6358	SC 800	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8828	6358	Silk Path	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8829	6358	Delta V1000	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8830	6358	F900	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8831	6358	Raven	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8832	6358	CAAD7 R2000	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8833	6358	Jekyll 800	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8834	6358	CHASE	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8835	6358	Jekyll 600	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8836	6358	R5000si	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8837	6358	Optimo Cross	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8838	6358	Prophet 600	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8839	6358	SystemSix	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8840	6358	Prophet MX	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8842	6358	Synapse Alloy	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8843	6358	CAAD90	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8844	6358	Chase 3	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8845	6358	System Six	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8846	6358	CAAD 9 6800	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8847	6358	CAAD8 6	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8848	6358	CAAD9 4	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8849	6358	Super Sick Sick Six	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8850	6358	Trail SL5 29er	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8851	6358	CAAD 105	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8852	6358	CAAD10 4 Rival	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8853	6358	CAAD10 3	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8854	6358	Synapse Carbon	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8855	6358	Prestine condition	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8856	6358	Wannabe	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8857	6358	ST500	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8858	6358	Crit SR XXX	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8859	6358	R600 30	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8860	6358	St400	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8861	6358	Tourer	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8862	6358	SSP	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8863	6358	Roadie POLISHED	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8864	6358	R400 flat bar	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8865	6358	The Peppermint	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8866	6358	Get Yours	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8867	6358	Machine	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8868	6359	Aeroad CF 90 Pro	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8869	6359	Nerve XC	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8870	6359	Speedmax3 Triathlon	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8871	6359	Ultimate AL	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8872	6359	Ultimate CF 90	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8873	6359	VDrome	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8874	6359	Roadlite 60	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8875	6359	Ultimate CF EVO	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8876	6362	Adone	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8877	6362	Steel Road Campy	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8878	6362	Sport	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8879	6362	Race Pace	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8880	6365	Uno	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8881	6365	Uno work	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8882	6366	Sport DLX	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8883	6366	Firetruck Omega	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8884	6366	84 ELITE RS	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8885	6366	Accordo	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8886	6366	Accordo RS	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8887	6366	Works	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8888	6366	Comp TA	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8889	6366	ConversionFn huge	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8890	6366	Elite	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8891	6366	Elite 12	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8892	6366	Elite gt	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8893	6366	Elite RS	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8894	6366	Iron Man	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8895	6366	Iron Man Master	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8896	6366	Ironman	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8897	6366	Ironman chop job	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8898	6366	Ironman Expert	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8899	6366	Le Mans	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8900	6366	Le Mans Converted	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8901	6366	LeMans	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8902	6366	LeMans 12	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8903	6366	LeMans RS	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8904	6366	LeMans Tange 2	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8905	6366	Master Ironman	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8906	6366	ProTour	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8907	6366	Semi Pro	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8908	6366	Semi Professional	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8909	6366	Sport	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8910	6366	Super Elite	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8911	6366	Super Le Mans	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8912	6366	TRAC	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8913	6366	Turbo	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8914	6366	Cinelli Equipe	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8915	6366	Dave scott	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8916	6366	POS	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8917	6366	Street machine	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8918	6366	Le Mans RS	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8919	6366	W deep Vs	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8920	6366	Shit dlx	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8921	6366	Candidate	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8922	6366	Pro Tour	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8923	6366	Trac RARE	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8924	6366	Dave Scott Ironman	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8925	6366	Cavaletto	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8926	6366	Pro Tour 15	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8927	6366	Facet	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8928	6366	Ironman Dave Scott	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8929	6366	Iron Man Expert	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8930	6366	Ironman restomod	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8931	6366	LeMans RS Goodness	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8932	6366	Tange 1 Turbo	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8933	6366	Ironman Master	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8934	6366	Weinman wheels etc	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8935	6366	Turbo Tange1	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8936	6366	Super LeMans	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8937	6371	Cooker	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8938	6371	Cooker Fatbike	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8939	6371	Freestyler	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8940	6371	Plug	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8941	6371	Plug Freestyler	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8942	6371	Plug Reloaded	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8943	6371	Scissor	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8944	6371	Duster	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8945	6371	Plug Complete	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8946	6371	Scissor V2	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8947	6371	Plug Prestige	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8948	6373	Hawk V2	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8949	6377	Haulers	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8950	6381	Grn13	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8951	6381	SLX	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8952	6381	Sport 600	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8953	6381	Swiss	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8954	6382	Mash HAWAII	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8955	6382	Vigorelli 09	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8956	6382	Gazzetta	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8957	6382	Mash ismail	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8958	6382	Vigorelli	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8959	6382	MASH	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8960	6382	Equipe	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8961	6382	Super Corsa	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8962	6382	BootLeg 54	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8963	6382	55 Histogram	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8964	6382	Aliante	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8965	6382	Bolt	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8966	6382	Cafe racer remix	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8967	6382	Carbon Machine	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8968	6382	Estrada Pro	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8969	6382	Gazetta	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8970	6382	Gazzetta updated	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8971	6382	Gazzetta All Campy	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8972	6382	Gazzetta Bel Nero	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8973	6382	Gazzetta GR	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8974	6382	Gazzetta reborn	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8975	6382	Gazzetta SS	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8976	6382	Gazzetta n trick	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8977	6382	Gleris	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8978	6382	Hot Rats	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8979	6382	Laser	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8980	6382	LASER A	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8981	6382	Laser 85 NOS	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8982	6382	Laser pista	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8983	6382	LaZer pista	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8984	6382	Mash  stealth mode	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8985	6382	Mash 10	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8986	6382	Mash Histogram	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8987	6382	MASH grayorange	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8988	6382	Mash 1	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8989	6382	Mash 20	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8990	6382	Mash a CORIMA	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8991	6382	MASH DONE	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8992	6382	Mash 55	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8993	6382	Mash 58	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8994	6382	Mash Bolt	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8995	6382	Mash CLEAN D	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8996	6382	Mash HELLSTOGRAM	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8997	6382	MACHINE	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8998	6382	Mash Wolfbite	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8999	6382	MASH XL	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9000	6382	MAsH 1700	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9001	6382	MASHGrey	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9002	6382	Olympic	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9003	6382	Olympic pista	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9004	6382	Persuit KNWU	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9005	6382	Proxima	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9006	6382	Rampichino	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9007	6382	Rash	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9008	6382	Restored pista	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9009	6382	SC Pista	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9010	6382	Saetta	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9011	6382	SCs original road	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9012	6382	Soft Machine XC	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9013	6382	Starship	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9014	6382	Super Corsa Pista	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9015	6382	Super Pista	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9016	6382	Supercorsa	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9017	6382	Supercorsa Campy SR	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9018	6382	Supercorsa Pista	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9019	6382	Supercosa	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9020	6382	Unica	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9021	6382	Unica Shy Nelly	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9022	6382	Vigorelli 10	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9023	6382	Vigorelli 11	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9024	6382	Vigorelli FLYRS_FG	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9025	6382	Vigorelli BKKFIXED	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9026	6382	Vigorelli Pista	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9027	6382	Vigorelli PushPull	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9028	6382	Vigorilli	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9029	6382	Willin	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9030	6382	Xperience	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9031	6382	Mash Parallax	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9032	6382	SUICIDE DROP STEM	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9033	6382	Pista	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9034	6382	Pursuit	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9035	6382	Esque Road	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9036	6382	UPDATED	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9037	6382	Rollers	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9038	6382	Mash set up	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9039	6382	Supercorsa Campy 11	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9040	6382	Tape	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9041	6382	Mash thing	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9042	6382	There are many	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9043	6382	ASSASSIN pursuit	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9044	6382	Colombus	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9045	6382	Speciale Corsa	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9046	6382	Centurion	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9047	6382	Equipe Centurion	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9048	6382	Laser TT	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9049	6382	Ottomilauno	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9050	6382	Supercorsa road	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9051	6382	XLR8R2	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9052	6382	Super Pista Heaven	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9053	6382	VIGORELLI 56	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9054	6382	Vigo	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9055	6382	Estrada	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9056	6382	Vigorelli REPAINT	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9057	6382	Windsor AM4 Pro	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9058	6383	Poker Pista	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9059	6383	Coaster	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9060	6383	Colibri	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9061	6383	Designer 84	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9062	6383	Designer 84 Road	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9063	6383	Enemy	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9064	6383	Fade	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9065	6383	Gufo1990	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9066	6383	Mockba 80	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9067	6383	Mockba 80 restomod	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9068	6383	Pista	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9069	6383	San Cristobal	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9070	6383	SL Racing Team 83	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9071	6383	World 77 updated	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9072	6383	World 77 x Campy	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9073	6383	Astore	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9074	6383	Resurrection	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9075	6383	San Cristobal road	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9076	6383	AELLE road	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9077	6383	Mockba	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9078	6383	COM 125	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9079	6383	Carbon Dragster	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9080	6383	Designer	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9081	6383	World 77	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9082	6388	Competitor	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9083	6388	Coureur 57	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9084	6388	Daily	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9085	6388	Majestic	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9086	6388	Olympic Road	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9087	6388	Sierra	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9088	6393	PeriScope Scout 700	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9089	6393	Periscope Torpedo	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9090	6393	Ristretto	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9091	6395	B43	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9092	6395	Master	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9093	6395	Dream Pista	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9094	6395	Tecnos	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9095	6395	Super	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9096	6395	Full Campagnolo	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9097	6395	Altain Athena Group	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9098	6395	Super Singlespeeder	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9099	6395	2 Extreme Power	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9101	6395	Victory	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9102	6395	3 pantografata	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9103	6395	4 Gear	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9104	6395	Altain	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9105	6395	Arabesque	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9106	6395	Asso	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9107	6395	Bititan	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9108	6395	C40HP NuovoRetro	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9109	6395	C40	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9110	6395	C40 HP	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9111	6395	C40 MK II	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9112	6395	C40 PR10	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9113	6395	C40 Team Rabobank	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9114	6395	C50	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9115	6395	C50 Anniversary	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9116	6395	C50 Super Record 11	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9117	6395	C50 Spider	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9118	6395	Carbitubo	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9119	6395	Carbitubo 24 Front	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9120	6395	Carbiturbo	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9121	6395	CLX 30	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9122	6395	Columbus slx	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9123	6395	Crushed dropout	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9124	6395	Crystal	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9125	6395	Decor	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9126	6395	Dream	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9127	6395	Dream finally	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9128	6395	Dream bstay	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9129	6395	DREAM campagnolo	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9130	6395	Dream Lux	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9131	6395	Dream Pista DK	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9132	6395	Dream pista campy	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9133	6395	Elegant	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9134	6395	Elegant flat bar	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9135	6395	EPQ PR99	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9136	6395	EPS	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9137	6395	Esamexico pista	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9138	6395	International	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9139	6395	Lux Titanium	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9140	6395	Master   Neon	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9141	6395	Master89	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9142	6395	Master Bstay	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9143	6395	Master Bititan	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9144	6395	Master Carbon	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9145	6395	Master Crono	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9146	6395	Master Light	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9147	6395	Master LUX Pista	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9148	6395	Master MAPEI Pista	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9149	6395	MASTER OLYMPIC	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9150	6395	Master Pista	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9151	6395	Master Pista STASH	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9152	6395	Master Piu	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9153	6395	Master PIU C Record	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9154	6395	Master Plus	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9155	6395	Master pursuit	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9156	6395	Master Team Buckler	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9157	6395	Master tricolore	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9158	6395	Master TT	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9159	6395	Master X Light	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9160	6395	Master XLight	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9161	6395	Master XLight AD11	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9162	6395	Master XL	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9163	6395	Mexico	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9164	6395	Mexico ESA	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9165	6395	Mexico Pista	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9166	6395	Mexico Super	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9167	6395	NOS	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9168	6395	Nuovo Mexico	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9169	6395	Oval CX	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9170	6395	Panto Orig	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9171	6395	Pista	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9172	6395	Pista tt	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9173	6395	Pista Campy CRecord	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9174	6395	Pursuit	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9175	6395	PursuitHour Record	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9176	6395	Replica	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9177	6395	Rgal Arabesque lugs	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9178	6395	Saronni	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9179	6395	SingleFixed	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9180	6395	Spiral Conic	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9181	6395	Spiral Conic SLX	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9182	6395	Sprint	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9183	6395	Sprint Cromor	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9184	6395	Strada Scandium	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9185	6395	Super 85	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9186	6395	Super Colnago	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9187	6395	Super Mexico	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9188	6395	Super Pista	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9189	6395	Super Piu	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9190	6395	Super RestoMod	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9191	6395	Super rosso Saronni	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9192	6395	Super Sprint	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9193	6395	Super SS Sisterbike	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9194	6395	Super winter	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9195	6395	Superissimo	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9196	6395	Superissimo Super	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9197	6395	Super Pista ver1	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9198	6395	Technos	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9199	6395	TECNOS ART DECO	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9200	6395	Tecnos Competition	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9201	6395	Tecnos Pista	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9202	6395	Tecnos2000	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9203	6395	Titanium titanio	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9204	6395	Campagnolo	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9205	6395	VIP	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9206	6395	Jah provides	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9207	6395	Master XLite	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9208	6395	Export	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9209	6395	Master telaio	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9210	6395	Super pista molteni	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9211	6395	Arabesque Chrome	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9212	6395	Decor Road	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9213	6395	Mapie_Quickstep TT	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9214	6395	Tecnos Art Decor V2	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9215	6395	Mix Spider	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9216	6395	Geo Cross	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9217	6395	CLX w Ultegra 6700	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9218	6395	Cargostrange cat	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9219	6397	Mondial	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9220	6398	Rambler	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9221	6398	Adult Trike	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9222	6398	Muscle	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9223	6398	Twosome	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9224	6398	TwoSome SS	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9225	6398	Safety	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9226	6398	Sports Pacer V	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9227	6398	Trans Am	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9228	6398	Tourist Expert III	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9229	6399	Steel Steed	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9231	6401	Pista	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9232	6401	Squadra	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9233	6401	531	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9234	6401	Swiss Military MO5	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9235	6403	Lead Sled	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9236	6403	Circa	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9237	6403	Frankenstein	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9238	6406	Lo Pro	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9239	6407	Cougar	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9240	6407	Four Spokes	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9241	6407	COUGAR 2500	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9242	6408	IKO DESIGN	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9243	6415	5th	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9244	6415	Remake	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9245	6419	Mass DISASTER	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9246	6420	Ultralight	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9247	6422	Agree SL	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9248	6422	Attempt road	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9249	6422	Ltd	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9250	6422	Peloton race	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9251	6422	Reaction 18	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9252	6424	Barcelona	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9253	6425	DEATH ROW	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9254	6428	Mountaineer	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9255	6428	S3 Road	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9256	6437	072 faux Randonneur	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9257	6437	472	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9258	6437	Tour de France	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9259	6440	Cross Pro	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9260	6440	SSCX	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9261	6440	Touriste	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9262	6442	Albatros	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9263	6446	Scandium speedbike	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9264	6446	650c	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9265	6446	Trek	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9266	6446	Steel Road	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9267	6446	Castanza Titanium	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9268	6446	El Diente	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9269	6446	Rohloff 29er	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9270	6449	General Lee 24	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9271	6449	Octane Pro XL	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9272	6450	Sidekick	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9273	6450	Switchback	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9274	6452	KCNC	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9275	6455	50th Anniversary	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9276	6455	Pista	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9277	6455	Columbus EL Road	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9278	6455	Crono	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9279	6455	Crono TT	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9280	6455	Griffe	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9281	6455	La Migliore	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9282	6455	Megatube Alloy	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9283	6455	Mitico	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9284	6455	Profidea	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9285	6455	SLX Columbus	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9286	6455	Time TrialFunny	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9287	6455	TT Funny	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9288	6455	Turbo	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9289	6456	Mariner	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9290	6456	Ciao 8	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9291	6456	Folding	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9292	6456	Hack	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9293	6456	HELIOS SL	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9294	6456	MU P8	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9295	6456	Mu XL	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9296	6457	Work	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9297	6457	Impulse	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9298	6457	Lugged Steel Road	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9299	6457	Trackster	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9300	6457	Steel	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9301	6457	Signature	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9302	6459	Razorback	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9303	6459	Now gears	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9304	6459	Zed 30	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9305	6461	Flite 100	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9306	6461	Aero	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9307	6461	Comp	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9308	6461	Aeor	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9309	6461	Aero CHARLIE	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9310	6461	Aero naked	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9311	6461	Aero Pursuit	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9312	6461	Aero Aluminum	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9313	6461	Aero Turbo	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9314	6461	Aerotrack	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9315	6461	Aluminium pursuit	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9316	6461	BOMBer	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9317	6461	Competition	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9318	6461	Dj100 urbantrials	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9319	6461	Express SS	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9320	6461	Fixation	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9321	6461	FLIGHT 100	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9322	6461	Flite	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9323	6461	Flite 100 Aero	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9324	6461	Flite 100 Aerotrack	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9325	6461	Flite 100 paintjob	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9326	6461	Flite 100 so sick	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9327	6461	Flite 100 stealth	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9328	6461	Flite 100 Year	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9329	6461	Flite 800	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9330	6461	Flite raspberry	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9331	6461	Flite Aero	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9332	6461	Flite Ugly	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9333	6461	Flitey	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9334	6461	Pisser	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9335	6461	Professional	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9336	6461	Pursuit	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9337	6461	Ruffian	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9338	6461	Solo One SE	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9339	6461	Turbo	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9340	6461	Underdog	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9341	6461	Urban Uno	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9342	6461	XCT 555 Crusher	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9343	6461	ZH2B Work	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9344	6461	The Ice Cream	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9345	6461	So aero it hurts	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9346	6461	Front Freewheel	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9347	6461	Kalani	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9348	6461	John Howard Turbo	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9349	6461	Flite 100 Juice	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9350	6461	ALITE 800 17	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9351	6461	ST Comp	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9352	6461	Olympia	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9353	6465	Shimano 600	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9354	6465	Strada S	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9355	6472	PursuitGONE	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9356	6472	Pursuit	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9357	6472	Knobby X	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9358	6475	650c tritt	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9359	6475	Titanium 650c	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9360	6475	Lake	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9361	6475	Velodrome	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9362	6476	Spins	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9363	6476	200 SC	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9364	6476	200 SCi	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9365	6476	200 SCi parted out	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9366	6476	200SCi	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9367	6476	500 sci unicum	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9368	6476	500sci	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9369	6476	Airfoil PRO SE	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9370	6476	Evoke	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9371	6476	Flat bar	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9372	6476	KM40	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9373	6476	RT900	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9374	6476	RT900SL	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9375	6476	Rubicon	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9376	6476	Talon	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9377	6476	Talon 07	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9378	6476	Talon Carbon	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9379	6479	Pusle	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9380	6479	Decade Convert2	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9381	6483	Curb	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9382	6483	Gap	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9383	6485	Frameworks road	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9384	6489	Quantum Pro	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9385	6489	Adroit Race	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9386	6489	Attitude	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9387	6489	Attitude Nightstorm	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9388	6489	Family Truckster	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9389	6489	Fervor	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9390	6489	Mantra	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9391	6489	Performance	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9392	6489	Performance lbc	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9393	6489	Pinnacle	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9394	6489	Q Pro	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9395	6489	Q Pro XV	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9396	6489	QPro V	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9397	6489	Quantum	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9398	6489	QUANTUM CHAMELON	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9399	6489	Quantum Race	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9400	6489	Pulse II	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9401	6489	Attitude Comp	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9402	6489	Attitude Race	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9403	6489	Q Elite	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9404	6489	Pulse	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9405	6492	FullPro	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9406	6492	GranRacer	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9407	6492	RecordPro	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9408	6492	Roadchamp	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9409	6492	SWEETNESS	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9410	6492	Terrarunner	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9411	6494	G58	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9412	6494	Noah The Grape	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9413	6494	Porteur	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9414	6495	Kula Supreme	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9415	6495	AA v1	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9416	6495	Rat	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9417	6495	A Full Suspension	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9418	6495	Blast Pump	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9419	6495	Bonaaa	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9420	6495	Cadabra	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9421	6495	Coiler	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9422	6495	Cowan City rider	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9423	6495	Dew do it all	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9424	6495	Haole Athena 11s	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9425	6495	Honky Tonk	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9426	6495	Jake	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9427	6495	Jake Stock	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9428	6495	Jake the Snake	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9429	6495	Joe	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9430	6495	Kapu	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9431	6495	Kula	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9432	6495	Major One	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9433	6495	Minute	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9434	6495	Paddy wagon	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9435	6495	Paddywagon	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9436	6495	Paddywagon 08	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9437	6495	PHD	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9438	6495	Sutra	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9439	6495	Sutra 08	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9440	6495	Unit 17	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9441	6495	Unit 29er	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9442	6495	Unit fixedfree	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9443	6495	Zing Supreme race	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9444	6495	Explosif	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9445	6495	Unit	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9446	6495	Honk Tonk	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9447	6495	Unit rigid 29er	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9448	6495	Kikapu	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9449	6495	Roast	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9450	6495	Kula Deluxe	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9451	6495	Hardtail	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9452	6495	Zing Supreme	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9453	6495	King Zing	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9454	6495	Shred	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9455	6495	Lavadome	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9456	6499	Rock Racing	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9457	6499	Rock Racing TT	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9458	6504	Kalibur	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9459	6504	Kebel	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9460	6504	Kharma	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9461	6504	KOM	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9462	6504	Kom Evo	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9463	6504	Tri	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9464	6506	Carrera Sport	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9465	6506	KZ83 Laserlite	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9466	6506	UNICYCLE giraffe	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9467	6506	Count	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9468	6509	Shark	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9469	6509	Road Shark	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9470	6509	Jolly Roger	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9471	6509	Pursuit	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9472	6509	Shark Pursuit	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9473	6510	DH230	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9474	6510	DH920	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9475	6510	Titanium	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9476	6510	Xelius 900	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9477	6510	Xelius FDJ	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9478	6513	Pista	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9479	6515	725	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9480	6515	722TS ATX	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9481	6515	725tr	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9482	6515	725TR V2	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9483	6515	Vive Le Roy	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9484	6515	Dura Ace 7402	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9485	6515	722TS	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9486	6515	720tr	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9487	6515	722TS Raw Steel	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9488	6515	Ax Evolution	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9489	6515	Trick Star V1	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9490	6515	Oria GM00	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9491	6515	722RS	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9492	6515	720	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9493	6515	720trupdated	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9494	6515	720TT	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9495	6515	721	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9496	6515	721TR	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9497	6515	721TR Year	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9498	6515	721TR V25	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9499	6515	721Tr DODICI	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9500	6515	722 Steel Pista	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9501	6515	722 ts	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9502	6515	722TS updated	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9503	6515	722TS Dew Dude	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9504	6515	722TS RAW	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9505	6515	722ts RAWW	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9506	6515	725 w H Plus Sons	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9507	6515	725tr HURAY	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9508	6515	725tr The Panda	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9509	6515	725TrackRace RO	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9510	6515	727	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9511	6515	727 tr	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9512	6515	727tr raw	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9513	6515	727TR Aerospokes	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9514	6515	729trk Trickstar	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9515	6515	735	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9516	6515	735 09 Pinion	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9517	6515	735 TR	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9518	6515	735TR	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9519	6515	735tt	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9520	6515	737r	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9521	6515	780r	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9522	6515	785R Road	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9523	6515	LD 717	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9524	6515	LD 735TR WOOP WOOP	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9525	6515	LD720 TR	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9526	6515	LD721	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9527	6515	LD735 TT	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9528	6515	Ld735TR	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9529	6515	Lugged Steel	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9530	6515	Mordecai	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9531	6515	Pursuit	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9532	6515	Road Trainer	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9533	6515	Steal Pista	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9534	6515	Motorola colours	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9535	6515	Telekom	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9536	6515	AX Hour Record	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9537	6515	Pro Titanium	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9538	6515	722tr	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9539	6515	FixieFree	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9540	6515	Is finally finished	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9541	6515	725 v2	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9542	6515	LD715R	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9543	6515	725tr is my Works	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9544	6515	729TRK	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9545	6515	LD 735R	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9546	6515	LD 730R Road	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9547	6515	720tr whitegrey	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9548	6515	725 TR	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9549	6515	735TaRck	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9550	6515	LD 735TR	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9551	6515	725 TR lil cupcake	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9552	6515	725TR goldmember	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9553	6515	725TR V2 Tiffany	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9554	6515	V2 725TR	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9555	6515	725 Seafoam	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9556	6515	Kagero	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9557	6518	DC1 crashed	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9558	6523	Articulation	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9559	6523	Tuscany	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9560	6526	Pavia PedalForce RS	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9561	6526	Blade 700c	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9562	6526	Archon Ti	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9563	6526	Arenberg	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9564	6526	Firenze	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9565	6526	MGrecycling	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9566	6526	Ocoee	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9567	6526	Siena	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9568	6526	Solano	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9569	6526	Tuscany	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9570	6526	Ultimate	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9571	6526	Vela	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9572	6526	Polished Titanium	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9573	6526	Catalyst	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9574	6526	Unicoi	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9575	6526	Team	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9576	6526	Firenze Amie	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9577	6526	Obed	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9578	6526	Owlhollow	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9579	6532	555	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9580	6532	Mondriaan	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9581	6532	585 Super Campy	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9582	6532	KG396	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9583	6532	Fournales VTT	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9584	6532	KG461	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9585	6532	Carbon racer	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9586	6532	Kissena Velodrome	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9587	6532	233	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9588	6532	281	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9589	6532	464	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9590	6532	464 med	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9591	6532	464 AL P	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9592	6532	496	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9593	6532	496 carbon	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9594	6532	555 XL	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9595	6532	555 road race	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9596	6532	565	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9597	6532	565 Redux	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9598	6532	566	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9599	6532	585	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9600	6532	585 ultra	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9601	6532	586	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9602	6532	986	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9603	6532	AL 264	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9604	6532	AL 264 TEAM	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9605	6532	AL 464 P	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9606	6532	AL 464 Pista	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9607	6532	AL P 464	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9608	6532	Generation 4 KG56	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9609	6532	KG 171 carbon road	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9610	6532	KG 196 Mektronic	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9611	6532	KG 281	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9612	6532	KG 361 Campa Athena	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9613	6532	KG 381	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9614	6532	Kg 381i	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9615	6532	Kg 386	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9616	6532	KG 396 P	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9617	6532	KG 396 Pista	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9618	6532	KG 396 Sydney	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9619	6532	Kg 496	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9620	6532	KG 56 Generation	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9621	6532	KG171	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9622	6532	KG196	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9623	6532	KG231	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9624	6532	KG241	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9625	6532	KG253 Steel is Real	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9626	6532	Kg261	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9627	6532	KG282 Ti	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9628	6532	KG381 team	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9629	6532	Kg496	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9630	6532	KG96	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9631	6532	Kg96 Carbon Lo Pro	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9632	6532	KG96 Team Replica	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9633	6532	L96 LONDON olympics	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9634	6532	Team kg replika	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9635	6532	84 Schwinn Tempo	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9636	6532	986 Pro Team	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9637	6532	All NOS	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9638	6532	Once Replica KG 171	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9639	6532	595	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9640	6532	KG381 Lugged	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9641	6533	Unique	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9642	6533	Legend	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9643	6533	Otis Excelle	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9644	6533	Challenger SS	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9645	6533	Classique	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9646	6533	Roadster	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9647	6533	Sport 110	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9648	6533	Sprint	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9649	6533	Rainny day ride	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9650	6533	America	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9651	6533	Legend Compe	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9652	6533	Excelle	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9653	6533	Express ATB	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9654	6533	Super Pro Aero	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9655	6533	Eclair	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9656	6534	Pursuit 90	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9657	6537	Cooper	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9658	6537	Pro Cross	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9659	6537	R230	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9660	6537	R320	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9661	6539	Leader	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9662	6539	Trainer	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9663	6539	Super Leader	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9664	6548	Serpens	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9665	6550	Oppy T	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9666	6550	Wannabe	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9667	6550	5 star	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9668	6550	Oppy C5	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9669	6550	Oppy C7	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9670	6550	Reborn	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9671	6550	Sportif	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9672	6552	Double discs	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9673	6557	Verona	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9674	6557	Pursuit funny	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9675	6557	Argenta	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9676	6557	Bear Valley SE	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9677	6557	Mill Valley	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9678	6557	Northside trail	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9679	6557	Point Reyes	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9680	6557	Portofino	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9681	6557	RiftZone	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9682	6557	San Marino	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9683	6557	UnFairfax SC 2	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9684	6557	Muirwoods	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9685	6557	AXC Northside Trail	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9686	6557	PURSUIT	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9687	6557	Eldrige Grade SS	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9688	6557	TEAM MARIN	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9689	6557	Hamilton 29er	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9690	6569	Drumbrakes	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9691	6569	420GR Grass Racer	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9692	6569	Professional	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9693	6569	Retki Super	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9694	6571	DHR	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9695	6581	Gran Premio	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9696	6581	Nuovo Sport	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9697	6581	Supra Sport	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9698	6581	Activa Action	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9699	6581	Competizione	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9700	6581	Maxima	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9701	6581	Fx 20	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9702	6581	Gran Rally	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9703	6581	Gran Sport	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9704	6581	Gran Sprint	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9705	6581	Gran Turismo	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9706	6581	Gran Turismo SS	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9707	6581	Gran Turismos	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9708	6581	Grantech 88	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9709	6581	Modovivere	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9710	6581	Sport Tourer	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9711	6581	Super Ten	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9712	6581	Viva Sport	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9713	6581	Vivatech 1050	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9714	6581	Porteur	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9715	6581	Maxima Sport	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9716	6581	Superstrada	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9717	6581	Via de Oro	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9718	6581	Modo Vincere Ultima	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9719	6581	Arrowpace	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9720	6589	DragStrip Courage	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9721	6589	Country Road Bob	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9722	6589	Drag Strip Courage	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9723	6589	Flahute	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9724	6589	Full Tilt Boogie CX	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9725	6590	Criterium	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9726	6591	SpeedVagen Road	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9727	6591	SpeedVagen Lilac	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9728	6591	Mint Velo	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9729	6594	Jabberwocky	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9730	6596	Miscellany 5 images	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9731	6596	Cult	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9732	6596	CHARMANT	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9733	6596	De piste	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9734	6596	Hunter	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9735	6596	Sport	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9736	6596	Schauff pt 1	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9737	6596	Schauff pt 2	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9738	6596	Sport Coaster Brake	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9739	6596	Sport Classique	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9740	6596	Sport Pyrenees	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9741	6596	SportCourier 12	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9742	6596	Zephyr Carbon	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9743	6596	Team Issue	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9744	6600	Deep vs	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9745	6600	Rims	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9746	6604	Bandito	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9747	6604	Radia	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9748	6606	Club racer	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9749	6607	ZULU freestyle	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9750	6611	Pista	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9751	6611	Professional	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9752	6611	Comp Line Deda R1	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9753	6611	Corsa	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9754	6611	Modified Pursuit	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9755	6611	Pistoia	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9756	6611	RedWhite	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9757	6611	Course	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9758	6611	Course Pista	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9759	6611	Professional Pista	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9760	6611	Professional Lates	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9761	6613	Aerospace	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9762	6613	Aerospace 400	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9763	6613	Aerospace 600ex	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9764	6613	Aerospace Pro	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9765	6613	Age	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9766	6613	Lightweight	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9767	6614	R40 Recumbent	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9768	6614	Sprint TSG	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9769	6616	979	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9770	6616	788	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9771	6616	Paris Sport	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9772	6616	172	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9773	6616	THE WARRIOR	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9774	6616	980	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9775	6616	979 road	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9776	6616	979 Dural	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9777	6616	979 Duralinox	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9778	6616	979 Mavic	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9779	6616	979 Pursuit	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9780	6616	Carbone 9	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9781	6616	CL 1	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9782	6616	LOTTO MOBISTAR	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9783	6616	ZX1	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9784	6616	ZX1 Villager Eagle	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9785	6616	979Campagnolo SR	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9786	6616	992 Lotto Team	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9787	6616	Pursuit FUNNY	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9788	6617	Sport	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9789	6617	Wire Shaft	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9790	6621	Cutter	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9791	6621	Cutter V3	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9792	6621	Dinosaur	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9793	6621	Cutter V5	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9794	6621	Cutter Raw	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9795	6621	BIZ Biatch	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9796	6621	Creedence	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9797	6621	Cutter 32	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9798	6621	Cutter a temp	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9799	6621	Cutter 1st gen	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9800	6621	Cutter 56	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9801	6621	Cutter 700cmx	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9802	6621	Cutter freestyle	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9803	6621	Cutter GID	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9804	6621	Cutter Rat Ride	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9805	6621	CUTTER V 3	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9806	6621	Cutter V1	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9807	6621	Cutter V3 Glow	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9808	6621	Cutter V3 Raw	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9809	6621	Cutter V3 RedBlack	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9810	6621	Cutter v35	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9811	6621	Cutter V4	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9812	6621	Cutter V4 56	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9813	6621	Cutter V6	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9814	6621	Thrasher	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9815	6621	Thrasher Medium Raw	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9816	6621	THRASHER sz M	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9817	6621	Cutter Glow	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9818	6622	Zobop	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9819	6622	29er	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9820	6622	Bokor	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9821	6622	Hoodoo	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9822	6622	Wazoo	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9823	6622	Hoodoo The Alleycat	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9824	6627	808	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9825	6627	Lightning SE	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9826	6627	Lightning	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9827	6631	Paramount	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9828	6631	1700	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9829	6631	Fleetvelo	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9830	6631	Gnarl	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9831	6631	R33 Campy Record	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9832	6631	RS33	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9833	6631	X11	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9834	6632	185 tt	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9835	6632	Div	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9836	6632	Pony	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9837	6632	KH01	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9838	6642	ORBEA	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9839	6645	Alpe DHuez Pista	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9840	6645	Cromovelato	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9841	6645	Lavaredo Carbon	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9842	6645	Pista	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9843	6646	Trek Madone 47 WSD	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9844	6646	Metax stainless	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9845	6649	Hour	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9846	6649	PROFESSIONAL PISTA	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9847	6649	Professional	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9848	6649	The Hour	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9849	6649	National	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9850	6649	The Hour SF	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9851	6649	Cliff 29er Comp	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9852	6649	Clockwork	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9853	6649	Clockwork 52mm	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9854	6649	Hour V 20	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9855	6649	Profesional	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9856	6649	Shmindsor	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9857	6649	The Hour 08	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9858	6649	Trash hour	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9859	6649	Wellington 30	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9860	6649	Whateva	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9861	6649	The Hour rebuild	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9862	6649	Hour winter	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9863	6649	AM4 Pro	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9864	6649	Competition	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9865	6650	Nova	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9866	6651	BIZZIKE	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9867	6651	Beast	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9868	6651	Dew	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9869	6651	Configuration	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9870	6651	Setup	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9871	6651	Reincarnate	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9872	6651	Trainer	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9873	6651	Rain Street	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9874	6651	Whippp	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9875	6651	Wheels	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9876	6651	853	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9877	6651	Giant	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9878	6651	KHS	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9879	6651	Minty	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9880	6651	Porch	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9881	6651	ROSS	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9882	6651	Vainqueur	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9883	6651	Whip	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9884	6653	USA	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9885	6657	Horse	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9886	6657	InProgress	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9887	6657	Whip DESTRO v20	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9888	6657	Langster	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9889	6657	Baby work	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9890	6657	Vlo	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9891	6664	87 World Champion	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9892	6664	Fixedgear road	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9893	6664	Pursuit 87 NOS	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9897	6666	Privateer S	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9898	6669	Here to stay	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9899	6669	Single	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9900	6669	Sport	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9901	6669	Lugs	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9902	6669	Lugged steel	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9903	6676	3spd	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9904	6692	Pista	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9905	6692	Corsa FAEMA	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9906	6692	Needs some help	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9907	6692	MX Leader	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9908	6692	97 Edition	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9909	6692	Crescent	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9910	6692	Crescent TT	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8697	6358	Capo Hope	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8698	6358	Capo Pista	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8699	6358	Capo Trackie	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8700	6358	Capone 54	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8701	6358	Carbon Synapse	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
8702	6358	Club F Off	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9911	6692	Elite	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9912	6692	7Eleven Pista	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9913	6692	Tempo TT Mixed gear	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9914	6692	Alu Cross	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9915	6692	AMX2	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9916	6692	Century Team Kelme	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9917	6692	Columbus	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9918	6692	Corsa	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9919	6692	Corsa 8687	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9920	6692	Corsa Extra	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9921	6692	Corsa Extra Pista	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9922	6692	Corsa Extra SLX	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9923	6692	Corsa Extra TT	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9924	6692	Corsa Extra TT NOS	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9925	6692	Corsa ZeroUno	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9926	6692	Cromor Pista	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9927	6692	Extra Corsa 711	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9928	6692	Faema x SRAM Rival	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9929	6692	Gara	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9930	6692	Gara Pista	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9931	6692	Hour record replica	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9932	6692	ML Leader	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9933	6692	Molteni replica	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9934	6692	MXLeader	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9935	6692	MXLeader Pro Team	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9936	6692	Pista P Punt	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9937	6692	Professional	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9938	6692	Pursuit	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9939	6692	SLX Corsa Extra	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9940	6692	SLX Pista	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9941	6692	Strada 9293	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9942	6692	Strada OS Brain	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9943	6692	Team 711 Reissue	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9944	6692	Team SC	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9945	6692	Team SC SRAM Force	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9946	6692	Titanium Road	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9947	6692	Alu	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9948	6692	Campagnolo group	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9949	6692	Premium	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9950	6692	TSX	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9951	6692	Team Fiat	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9952	6692	110	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9953	6692	AXM	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9954	6692	FAEMA Pista	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9955	6692	MAX Telekom	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9956	6692	MX Leader Telekom	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9957	6692	MXL Pista	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9958	6692	MXL rescued	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9959	6692	Strada OS	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9960	6692	Pista Priest 3	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9961	6692	Super Record	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9962	6692	Mutisport	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9963	6692	Professional Road	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9964	6692	Corsa Pista	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9965	6692	Grand Prix	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9966	6692	Crescent slx	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9967	6692	711 Corsa Extra	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9968	6692	Corsa Molteni	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9969	6692	Alu Carbon	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9970	6692	EMX3	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9971	6695	Grand Record	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9972	6695	Coming soon	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9973	6695	Prestige	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9974	6695	Le Champion	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9975	6696	Forever	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9976	6696	Njs	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9977	6696	NJS KEIRIN Take 2	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9978	6697	Spark GS Baller	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9979	6697	Generation	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9980	6708	Hindu head	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9981	6713	Roadwing	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9982	6713	Allsop	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9983	6713	Fastt	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9984	6713	Norwester	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9985	6713	Qualifier Beam	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9986	6715	Rush	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9987	6715	Smoothie	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9988	6715	4one5	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9989	6715	Buena Vista	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9990	6715	Buena Vista Mitxte	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9991	6715	Commute	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9992	6715	Cosmopolitan	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9993	6715	Cross	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9994	6715	Delancey	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9995	6715	Double Cross	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9996	6715	Double Cross Wayne	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9997	6715	Generation	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9998	6715	Grand randonneur	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
9999	6715	Juice 29er	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
10000	6715	Rush Mind The Gap	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
10001	6715	Rush 08	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
10002	6715	Rush 53	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
10003	6715	Rush Niners	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
10004	6715	Rushmore	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
10005	6715	Smoothie 1x9	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
10006	6715	Smoothie ES	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
10007	6715	Smoothie ES extra	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
10008	6715	Sport FixedFree	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
10009	6715	Stanyan	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
10010	6715	Double Cross DC	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
10011	6716	Oppy T	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
10012	6716	Wannabe	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
10013	6716	5 star	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
10014	6716	Oppy C5	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
10015	6716	Oppy C7	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
10016	6716	Reborn	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
10017	6716	Sportif	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
10018	6716	Trek	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
10019	6716	Trophy	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
10020	6716	Super de Luxe	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
10021	6718	Clubman	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
10022	6718	Three speed	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
10023	6731	PRST1 Superbike	\N	\N		\N	first batch	\N	2017-02-08 12:10:43.477484-08	\N
\.


--
-- Name: model_id_seq; Type: SEQUENCE SET; Schema: public; Owner: arobson
--

SELECT pg_catalog.setval('model_id_seq', 10023, true);


--
-- Data for Name: photo; Type: TABLE DATA; Schema: public; Owner: arobson
--

COPY photo (id, original_filename, file_path, bike_id, user_id, metadata, created_at) FROM stdin;
\.


--
-- Name: photo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: arobson
--

SELECT pg_catalog.setval('photo_id_seq', 53, true);


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
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: arobson
--

COPY "user" (id, created_at, last_login, username, facebook_id, name, first_name, last_name, facebook_link, gender, locale) FROM stdin;
1	2016-09-25 20:27:23.210233-07	\N	arobson	123	Ann Robson	Ann	Robson	https://www.facebook.com/aerobson	female	en-us
\.


--
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: arobson
--

SELECT pg_catalog.setval('user_id_seq', 1, false);


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
-- Name: user user_pkey; Type: CONSTRAINT; Schema: public; Owner: arobson
--

ALTER TABLE ONLY "user"
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
    ADD CONSTRAINT photo_user_id_fkey FOREIGN KEY (user_id) REFERENCES "user"(id) ON DELETE CASCADE;


--
-- Name: story story_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: arobson
--

ALTER TABLE ONLY story
    ADD CONSTRAINT story_user_id_fkey FOREIGN KEY (user_id) REFERENCES "user"(id) ON DELETE CASCADE;


--
-- Name: theft theft_bike_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: arobson
--

ALTER TABLE ONLY theft
    ADD CONSTRAINT theft_bike_id_fkey FOREIGN KEY (bike_id) REFERENCES bike(id) ON DELETE CASCADE;


--
-- Name: theft theft_owner_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: arobson
--

ALTER TABLE ONLY theft
    ADD CONSTRAINT theft_owner_id_fkey FOREIGN KEY (owner_id) REFERENCES "user"(id);


--
-- Name: bike user_id; Type: FK CONSTRAINT; Schema: public; Owner: arobson
--

ALTER TABLE ONLY bike
    ADD CONSTRAINT user_id FOREIGN KEY (user_id) REFERENCES "user"(id);


--
-- PostgreSQL database dump complete
--

