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
-- Name: manufacturer id; Type: DEFAULT; Schema: public; Owner: arobson
--

ALTER TABLE ONLY manufacturer ALTER COLUMN id SET DEFAULT nextval('manufacturer_id_seq'::regclass);


--
-- Data for Name: manufacturer; Type: TABLE DATA; Schema: public; Owner: arobson
--

COPY manufacturer (id, name, company_web_url, year_established, notes, discontinued, wikipedia_url, market_size, country, bike_index_id) FROM stdin;
1	Batavus	http://www.batavus.com/	\N	\N	\N	\N	\N	\N	18
2	Bazooka	http://www.bazookasports.com/	\N	\N	\N	\N	\N	\N	1223
3	BeOne	http://www.beone-bikes.com/	\N	\N	\N	\N	\N	\N	1044
4	Beater Bikes	http://beaterbikes.net/	\N	\N	\N	\N	\N	\N	1024
5	Bell		\N	\N	\N	\N	\N	\N	1235
6	Bellwether		\N	\N	\N	\N	\N	\N	411
7	Benotto		\N	\N	\N	\N	\N	\N	1110
8	Bergamont	http://www.bergamont.de/	\N	\N	\N	\N	\N	\N	1031
9	Bertoni		\N	\N	\N	\N	\N	\N	1383
10	Bertucci		\N	\N	\N	\N	\N	\N	412
11	Bianchi	http://www.bianchi.com/	\N	\N	\N	\N	A	\N	129
12	Bickerton		\N	\N	\N	\N	\N	\N	39
13	Bicycle Research		\N	\N	\N	\N	\N	\N	413
14	Big Agnes Inc		\N	\N	\N	\N	\N	\N	414
15	Big Cat Bikes	http://www.bigcatbikes.com/	\N	\N	\N	\N	\N	\N	1501
16	Big Shot	http://www.bigshotbikes.com/	\N	\N	\N	\N	\N	\N	1152
17	Bike Fit Systems		\N	\N	\N	\N	\N	\N	415
18	Bike Friday	http://bikefriday.com/	\N	\N	\N	\N	\N	\N	40
19	Bike Mielec	http://www.bikemielec.com/	\N	\N	\N	\N	\N	\N	1017
20	Bike Ribbon		\N	\N	\N	\N	\N	\N	416
21	Bike-Aid		\N	\N	\N	\N	\N	\N	417
22	Bike-Eye		\N	\N	\N	\N	\N	\N	418
23	Bike-O-Vision		\N	\N	\N	\N	\N	\N	419
24	Bike4Life		\N	\N	\N	\N	\N	\N	1148
25	BikeE recumbents		\N	\N	\N	\N	\N	\N	1100
26	Bikes Belong		\N	\N	\N	\N	\N	\N	420
27	Bikeverywhere		\N	\N	\N	\N	\N	\N	421
28	Bilenky Cycle Works	http://www.bilenky.com/Home.html	\N	\N	\N	\N	\N	\N	41
29	Biomega	http://biomega.dk/biomega.aspx	\N	\N	\N	\N	\N	\N	42
30	BionX		\N	\N	\N	\N	\N	\N	422
31	Birdy	http://www.birdybike.com/	\N	\N	\N	\N	\N	\N	255
32	Biria	http://www.biria.com/	\N	\N	\N	\N	\N	\N	944
33	Birmingham Small Arms Company		\N	\N	\N	\N	\N	\N	43
34	Bishop	http://bishopbikes.com/	\N	\N	\N	\N	\N	\N	1350
35	Black Diamond		\N	\N	\N	\N	\N	\N	423
36	Black Market	http://www.blackmarketbikes.com	\N	\N	\N	\N	\N	\N	109
37	Black Mountain Cycles	http://www.blackmtncycles.com/	\N	\N	\N	\N	\N	\N	1178
38	Black Sheep Bikes	http://blacksheepbikes.com/	\N	\N	\N	\N	\N	\N	1034
39	Blix	http://blixbike.com/	\N	\N	\N	\N	\N	\N	1512
40	Blue (Blue Competition Cycles)	http://www.rideblue.com/	\N	\N	\N	\N	\N	\N	1167
41	Blue Sky Cycle Carts	http://blueskycyclecarts.com/	\N	\N	\N	\N	\N	\N	1506
42	Boardman Bikes	http://www.boardmanbikes.com/	\N	\N	\N	\N	\N	\N	44
43	Bobbin	http://www.bobbinbikes.co.uk/	\N	\N	\N	\N	\N	\N	1032
44	BodyGlide		\N	\N	\N	\N	\N	\N	425
45	Boeshield		\N	\N	\N	\N	\N	\N	426
46	Bohemian Bicycles	http://www.bohemianbicycles.com/	\N	\N	\N	\N	\N	\N	45
47	Bondhus		\N	\N	\N	\N	\N	\N	427
48	Bonk Breaker		\N	\N	\N	\N	\N	\N	428
49	Boo Bicycles	http://boobicycles.com/	\N	\N	\N	\N	\N	\N	1286
50	Boreal	http://borealbikes.com/	\N	\N	\N	\N	\N	\N	1304
51	Borealis (fat bikes)	http://www.fatbike.com/	\N	\N	\N	\N	\N	\N	1305
52	Boreas Gear		\N	\N	\N	\N	\N	\N	430
53	Borile	http://www.borile.it/gb_chi.html	\N	\N	\N	\N	\N	\N	48
54	Bottecchia	http://www.bottecchia.co.uk/	\N	\N	\N	\N	\N	\N	49
55	Boulder Bicycles	http://www.renehersebicycles.com/Randonneur%20bikes.htm	\N	\N	\N	\N	\N	\N	1016
56	Box Bike Collective	http://www.boxbikecollective.com/	\N	\N	\N	\N	\N	\N	1485
57	Brannock Device Co.		\N	\N	\N	\N	\N	\N	432
58	Brasil & Movimento	http://www.brasilemovimento.com.br	\N	\N	\N	\N	\N	\N	51
59	Brave Soldier		\N	\N	\N	\N	\N	\N	433
60	Breadwinner	http://breadwinnercycles.com/	\N	\N	\N	\N	\N	\N	1354
61	Breakbrake17 Bicycle Co.	http://breakbrake17.com/	\N	\N	\N	\N	\N	\N	1363
62	Breezer	http://www.breezerbikes.com/	\N	\N	\N	\N	B	\N	941
63	Brennabor	http://brennabor.pl/	\N	\N	\N	\N	\N	\N	52
64	Bridgestone	http://www.bridgestone.com/	\N	\N	\N	\N	B	\N	53
65	Brilliant Bicycle	http://brilliant.co/	\N	\N	\N	\N	\N	\N	1381
66	British Eagle		\N	\N	\N	\N	\N	\N	54
67	Broakland	http://www.broakland.com/	\N	\N	\N	\N	\N	\N	1483
68	Brodie	http://www.brodiebikes.com/2014/	\N	\N	\N	\N	\N	\N	1128
69	Broke Bikes	https://brokebik.es/	\N	\N	\N	\N	\N	\N	1246
70	Brompton Bicycle	http://www.brompton.co.uk/	\N	\N	\N	\N	\N	\N	55
71	Brooklyn Bicycle Co.	http://www.brooklynbicycleco.com/	\N	\N	\N	\N	\N	\N	1098
72	Brooks England LTD.	http://www.brooksengland.com/	\N	\N	\N	\N	\N	\N	435
73	Browning		\N	\N	\N	\N	\N	\N	1239
74	Brunswick Corporation	http://www.brunswick.com/	\N	\N	\N	\N	\N	\N	56
75	Brush Research		\N	\N	\N	\N	\N	\N	436
76	Budnitz	http://budnitzbicycles.com/	\N	\N	\N	\N	\N	\N	1265
77	Buff		\N	\N	\N	\N	\N	\N	438
78	Burley		\N	\N	\N	\N	\N	\N	439
79	Burley Design	http://www.burley.com/	\N	\N	\N	\N	\N	\N	57
80	Bushnell		\N	\N	\N	\N	\N	\N	440
81	Buzzy's		\N	\N	\N	\N	\N	\N	441
82	CCM		\N	\N	\N	\N	\N	\N	271
83	CDI Torque Products		\N	\N	\N	\N	\N	\N	450
84	CETMA Cargo	http://cetmacargo.com/	\N	\N	\N	\N	\N	\N	1369
85	CHUMBA Racing	http://chumbabikes.com/	\N	\N	\N	\N	\N	\N	72
86	CRUD		\N	\N	\N	\N	\N	\N	468
87	CST		\N	\N	\N	\N	\N	\N	469
88	CVLN (Civilian)	http://www.ridecvln.com/	\N	\N	\N	\N	\N	\N	1093
89	CX Tape		\N	\N	\N	\N	\N	\N	471
90	Caffelatex		\N	\N	\N	\N	\N	\N	442
91	Calcott Brothers		\N	\N	\N	\N	\N	\N	58
92	Calfee Design	http://www.calfeedesign.com/	\N	\N	\N	\N	\N	\N	59
93	California Springs		\N	\N	\N	\N	\N	\N	443
94	Caloi	http://www.caloi.com/home/	\N	\N	\N	\N	\N	\N	60
95	Camelbak	http://www.camelbak.com/	\N	\N	\N	\N	\N	\N	444
96	Camillus		\N	\N	\N	\N	\N	\N	445
97	Campagnolo	http://www.campagnolo.com/	\N	\N	\N	\N	\N	\N	446
98	Campion Cycle Company		\N	\N	\N	\N	\N	\N	61
99	Cane Creek	http://www.canecreek.com/	\N	\N	\N	\N	\N	\N	447
100	Canfield Brothers	http://canfieldbrothers.com/	\N	\N	\N	\N	\N	\N	1183
101	Dawes Cycles	http://www.dawescycles.com/	\N	\N	\N	\N	\N	\N	93
102	De Rosa	http://www.derosanews.com/	\N	\N	\N	\N	\N	\N	96
103	DeBernardi	http://www.zarbikes.com/zar/about-debernardi.html	\N	\N	\N	\N	\N	\N	1087
104	DeFeet		\N	\N	\N	\N	\N	\N	483
105	DeSalvo Cycles	http://www.desalvocycles.com/	\N	\N	\N	\N	\N	\N	1244
106	Decathlon	http://www.decathlon.fr	\N	\N	\N	\N	\N	\N	1300
107	Deco		\N	\N	\N	\N	\N	\N	481
108	Deda Elementi		\N	\N	\N	\N	\N	\N	482
109	Deity	http://www.deitycomponents.com/	\N	\N	\N	\N	\N	\N	1008
110	Del Sol	http://www.ridedelsol.com/bikes	\N	\N	\N	\N	\N	\N	1131
111	Della Santa	http://dellasanta.com/	\N	\N	\N	\N	\N	\N	1346
112	Delta		\N	\N	\N	\N	\N	\N	484
113	Deluxe		\N	\N	\N	\N	\N	\N	485
114	Demolition		\N	\N	\N	\N	\N	\N	486
115	Den Beste Sykkel	http://www.dbs.no/	\N	\N	\N	\N	\N	\N	95
116	Dengfu	http://dengfubikes.com/	\N	\N	\N	\N	\N	\N	1242
117	Derby Cycle	http://www.derby-cycle.com/en.html	\N	\N	\N	\N	\N	\N	5
118	Dermatone		\N	\N	\N	\N	\N	\N	487
119	Dero		\N	\N	\N	\N	\N	\N	488
120	Detroit Bikes	http://detroitbikes.com/	\N	\N	\N	\N	\N	\N	1206
121	Deuter		\N	\N	\N	\N	\N	\N	489
122	Devinci	http://www.devinci.com/home.html	\N	\N	\N	\N	\N	\N	97
123	Di Blasi Industriale	http://www.diblasi.it/?lng=en	\N	\N	\N	\N	\N	\N	98
124	Dia-Compe		\N	\N	\N	\N	\N	\N	490
125	DiaTech		\N	\N	\N	\N	\N	\N	491
126	Diadora	http://www.diadoraamerica.com/	\N	\N	\N	\N	\N	\N	1237
127	Diamant	http://www.diamantrad.com/home/	\N	\N	\N	\N	\N	\N	99
128	Diamondback	http://www.diamondback.com/	\N	\N	\N	\N	A	\N	199
129	Dicta		\N	\N	\N	\N	\N	\N	492
130	Dillenger	http://dillengerelectricbikes.com/	\N	\N	\N	\N	\N	\N	1513
131	Dimension		\N	\N	\N	\N	\N	\N	494
132	Discwing		\N	\N	\N	\N	\N	\N	495
133	Doberman	http://dobermannbikes.blogspot.com	\N	\N	\N	\N	\N	\N	1
134	Dodici Milano	http://www.dodicicicli.com/	\N	\N	\N	\N	\N	\N	967
135	Dolan	http://www.dolan-bikes.com/	\N	\N	\N	\N	\N	\N	1057
136	Dorel Industries	http://www.dorel.com/	\N	\N	\N	\N	\N	\N	6
137	Downtube	http://www.downtube.com	\N	\N	\N	\N	\N	\N	1395
138	Dual Eyewear		\N	\N	\N	\N	\N	\N	499
139	Dualco		\N	\N	\N	\N	\N	\N	500
140	Dynacraft	http://www.dynacraftbike.com/	\N	\N	\N	\N	\N	\N	121
141	Dynamic Bicycles	http://www.dynamicbicycles.com/	\N	\N	\N	\N	\N	\N	1208
142	Dyno		\N	\N	\N	\N	\N	\N	927
143	E-Case		\N	\N	\N	\N	\N	\N	503
144	E. C. Stearns Bicycle Agency		\N	\N	\N	\N	\N	\N	310
145	EAI (Euro Asia Imports)	http://www.euroasiaimports.com/aboutus.asp	\N	\N	\N	\N	\N	\N	356
146	EBC		\N	\N	\N	\N	\N	\N	506
147	EG Bikes (Metronome)	http://www.egbike.com/	\N	\N	\N	\N	\N	\N	1277
148	EK USA		\N	\N	\N	\N	\N	\N	508
149	EMC Bikes	http://www.emcbikes.com/	\N	\N	\N	\N	\N	\N	1200
150	ENVE Composites		\N	\N	\N	\N	\N	\N	516
151	ESI		\N	\N	\N	\N	\N	\N	521
152	EVS Sports		\N	\N	\N	\N	\N	\N	523
153	EZ Pedaler (EZ Pedaler electric bikes)	http://www.ezpedaler.com/	\N	\N	\N	\N	\N	\N	1356
154	Eagle Bicycle Manufacturing Company		\N	\N	\N	\N	\N	\N	124
155	Eagles Nest Outfitters		\N	\N	\N	\N	\N	\N	504
156	East Germany	http://www.easternbikes.com/dealers/	\N	\N	\N	\N	\N	\N	183
157	Eastern	http://easternbikes.com/	\N	\N	\N	\N	\N	\N	505
158	Easton	https://www.eastoncycling.com/	\N	\N	\N	\N	\N	\N	1508
159	Easy Motion	http://www.emotionbikesusa.com/	\N	\N	\N	\N	\N	\N	1196
160	Ebisu	http://www.jitensha.com/eng/aboutframes_e.html	\N	\N	\N	\N	\N	\N	973
161	Eddy Merckx	http://www.eddymerckx.be/	\N	\N	\N	\N	\N	\N	225
162	Edinburgh Bicycle Co-operative	http://www.edinburghbicycle.com/	\N	\N	\N	\N	\N	\N	1028
163	EighthInch	http://www.eighthinch.com	\N	\N	\N	\N	\N	\N	1090
164	Electra	http://www.electrabike.com/	\N	\N	\N	\N	B	\N	125
165	Elevn Technologies		\N	\N	\N	\N	\N	\N	510
166	Elite SRL		\N	\N	\N	\N	\N	\N	511
167	Elliptigo	http://www.elliptigo.com/	\N	\N	\N	\N	\N	\N	1233
168	Ellis	http://www.elliscycles.com/	\N	\N	\N	\N	\N	\N	1236
169	Ellis Briggs	http://www.ellisbriggscycles.co.uk/	\N	\N	\N	\N	\N	\N	126
170	Ellsworth	http://www.ellsworthride.com	\N	\N	\N	\N	A	\N	127
171	Emilio Bozzi		\N	\N	\N	\N	\N	\N	128
172	Endurance Films		\N	\N	\N	\N	\N	\N	512
173	Enduro		\N	\N	\N	\N	\N	\N	513
174	Endurox		\N	\N	\N	\N	\N	\N	514
175	Energizer		\N	\N	\N	\N	\N	\N	515
176	Engin Cycles	http://www.engincycles.com/	\N	\N	\N	\N	\N	\N	1365
177	Enigma Titanium	http://www.enigmabikes.com/	\N	\N	\N	\N	\N	\N	130
178	Epic		\N	\N	\N	\N	\N	\N	517
179	Ergon		\N	\N	\N	\N	\N	\N	519
180	Erickson Bikes	http://www.ericksonbikes.com/	\N	\N	\N	\N	\N	\N	1498
181	Esbit		\N	\N	\N	\N	\N	\N	520
182	Europa	http://www.europacycles.com.au/	\N	\N	\N	\N	\N	\N	1103
183	Evelo	http://www.evelo.com/	\N	\N	\N	\N	\N	\N	1281
184	Eveready		\N	\N	\N	\N	\N	\N	522
185	Evil	http://www.evil-bikes.com	\N	\N	\N	\N	\N	\N	1048
186	Evo	http://evobicycle.com/	\N	\N	\N	\N	\N	\N	1389
187	Excess Components		\N	\N	\N	\N	\N	\N	524
188	Exustar		\N	\N	\N	\N	\N	\N	525
189	Ezee	http://ezeebike.com/	\N	\N	\N	\N	\N	\N	1407
190	FBM	http://fbmbmx.com	\N	\N	\N	\N	\N	\N	529
191	FRAMED	http://www.framedbikes.com/	\N	\N	\N	\N	\N	\N	1269
192	FSA (Full Speed Ahead)		\N	\N	\N	\N	\N	\N	543
193	Faggin	http://www.fagginbikes.com/en	\N	\N	\N	\N	\N	\N	1259
194	Failure	http://www.failurebikes.com/	\N	\N	\N	\N	\N	\N	1009
195	Fairdale	http://fairdalebikes.com/	\N	\N	\N	\N	\N	\N	526
196	Falco Bikes	http://www.falcobike.com/	\N	\N	\N	\N	\N	\N	1358
197	Falcon	http://www.falconcycles.co.uk/CORP/aboutFalcon.html	\N	\N	\N	\N	\N	\N	132
198	Faraday	http://www.faradaybikes.com/	\N	\N	\N	\N	\N	\N	1256
199	Fast Wax		\N	\N	\N	\N	\N	\N	528
200	Fat City Cycles		\N	\N	\N	\N	\N	\N	134
201	Fatback	http://fatbackbikes.com/	\N	\N	\N	\N	\N	\N	1056
202	Fausto Coppi		\N	\N	\N	\N	\N	\N	1217
203	Federal	http://www.federalbikes.com	\N	\N	\N	\N	\N	\N	113
204	Felt	http://www.feltbicycles.com/	\N	\N	\N	\N	B	\N	136
205	Fetish	https://www.facebook.com/FetishCycles	\N	\N	\N	\N	\N	\N	1168
206	Fezzari	http://www.fezzari.com/	\N	\N	\N	\N	\N	\N	1169
207	FiberFix		\N	\N	\N	\N	\N	\N	530
208	Fiction		\N	\N	\N	\N	\N	\N	531
209	Field	http://www.fieldcycles.com/	\N	\N	\N	\N	\N	\N	140
210	Finish Line		\N	\N	\N	\N	\N	\N	532
211	Finite		\N	\N	\N	\N	\N	\N	533
212	Firefly Bicycles	http://fireflybicycles.com/	\N	\N	\N	\N	\N	\N	1376
213	Firefox	http://www.firefoxbikes.com/	\N	\N	\N	\N	\N	\N	1153
214	Firenze		\N	\N	\N	\N	\N	\N	1064
215	Firmstrong	http://www.firmstrong.com/	\N	\N	\N	\N	\N	\N	1065
216	First Endurance		\N	\N	\N	\N	\N	\N	534
217	Fit bike Co.		\N	\N	\N	\N	\N	\N	353
218	Fizik		\N	\N	\N	\N	\N	\N	535
219	Fleet Velo	http://fleetvelo.com/fv/	\N	\N	\N	\N	\N	\N	370
220	Fleetwing		\N	\N	\N	\N	\N	\N	138
221	Flybikes		\N	\N	\N	\N	\N	\N	536
222	Flying Pigeon	http://flyingpigeon-la.com/	\N	\N	\N	\N	\N	\N	141
223	Flying Scot	http://www.flying-scot.com/core/welcome.html	\N	\N	\N	\N	\N	\N	142
224	Flyxii	http://www.flyxii.com/	\N	\N	\N	\N	\N	\N	1378
225	Focale44	http://www.focale44bikes.com/	\N	\N	\N	\N	\N	\N	966
226	Focus	http://www.focus-bikes.com/int/en/home.html	\N	\N	\N	\N	\N	\N	143
227	Foggle		\N	\N	\N	\N	\N	\N	537
228	Fokhan		\N	\N	\N	\N	\N	\N	1049
229	Folmer & Schwing		\N	\N	\N	\N	\N	\N	158
230	Fondriest	http://www.fondriestbici.com	\N	\N	\N	\N	\N	\N	1094
231	Forge Bikes	http://forgebikes.com/	\N	\N	\N	\N	\N	\N	1079
232	Formula		\N	\N	\N	\N	\N	\N	538
233	Fortified (lights)	http://fortifiedbike.com/	\N	\N	\N	\N	\N	\N	1359
234	Foundry Cycles	http://foundrycycles.com/	\N	\N	\N	\N	\N	\N	539
235	Fox		\N	\N	\N	\N	\N	\N	540
236	Fram	http://wsid9d3eg.homepage.t-online.de	\N	\N	\N	\N	\N	\N	146
237	Frances	http://francescycles.com/	\N	\N	\N	\N	\N	\N	1345
238	Francesco Moser (F. Moser)	http://www.mosercycles.com/	\N	\N	\N	\N	\N	\N	1221
239	Freddie Grubb		\N	\N	\N	\N	\N	\N	147
240	Free Agent	http://www.freeagentbmx.com/	\N	\N	\N	\N	\N	\N	1102
241	Free Spirit		\N	\N	\N	\N	\N	\N	1172
242	Freedom		\N	\N	\N	\N	\N	\N	541
243	Freeload		\N	\N	\N	\N	\N	\N	542
244	FuelBelt		\N	\N	\N	\N	\N	\N	544
245	Fuji	http://www.fujibikes.com/	\N	\N	\N	\N	A	\N	101
246	Fulcrum		\N	\N	\N	\N	\N	\N	545
247	Fyxation	http://www.fyxation.com/	\N	\N	\N	\N	\N	\N	546
248	G Sport		\N	\N	\N	\N	\N	\N	547
249	G-Form		\N	\N	\N	\N	\N	\N	548
250	GMC		\N	\N	\N	\N	\N	\N	1138
251	GT Bicycles	http://www.gtbicycles.com/	\N	\N	\N	\N	A	\N	119
252	GU		\N	\N	\N	\N	\N	\N	568
253	Gamut		\N	\N	\N	\N	\N	\N	549
254	Gardin		\N	\N	\N	\N	\N	\N	1014
255	Garmin		\N	\N	\N	\N	\N	\N	550
256	Gary Fisher	http://www.trekbikes.com/us/en/collections/gary_fisher/	\N	\N	\N	\N	A	\N	149
257	Gates Carbon Drive		\N	\N	\N	\N	\N	\N	551
258	Gateway		\N	\N	\N	\N	\N	\N	552
259	Gavin	http://www.gavinbikes.com/	\N	\N	\N	\N	\N	\N	1171
260	Gazelle	http://www.gazelle.us.com/	\N	\N	\N	\N	\N	\N	150
261	Gear Aid		\N	\N	\N	\N	\N	\N	553
262	Gear Clamp		\N	\N	\N	\N	\N	\N	554
263	Gear Up		\N	\N	\N	\N	\N	\N	555
264	Geax		\N	\N	\N	\N	\N	\N	556
265	GenZe	http://www.genze.com	\N	\N	\N	\N	\N	\N	1510
266	Gendron Bicycles	http://www.gendron-bicycles.ca/	\N	\N	\N	\N	\N	\N	151
267	Genesis	http://www.genesisbikes.co.uk/	\N	\N	\N	\N	\N	\N	1137
268	Genuine Innovations		\N	\N	\N	\N	\N	\N	557
269	Geotech	http://www.geotechbikes.com	\N	\N	\N	\N	\N	\N	1303
270	Gepida	http://www.gepida.eu/	\N	\N	\N	\N	\N	\N	152
271	Ghost	http://www.ghost-bikes.com	\N	\N	\N	\N	\N	\N	1245
272	Giant (and LIV)	http://www.giant-bicycles.com/	\N	\N	\N	\N	\N	\N	153
273	Gibbon Slacklines		\N	\N	\N	\N	\N	\N	558
274	Gilmour	http://www.gilmourbicycles.us/	\N	\N	\N	\N	\N	\N	1185
275	Gineyea	http://www.gineyea.com/	\N	\N	\N	\N	\N	\N	1499
276	Giordano	http://giordanobicycles.com/	\N	\N	\N	\N	\N	\N	1174
277	Gitane	http://www.gitaneusa.com/	\N	\N	\N	\N	B	\N	86
278	Glacier Glove		\N	\N	\N	\N	\N	\N	559
279	Gladiator Cycle Company	http://www.cyclesgladiator.com/	\N	\N	\N	\N	\N	\N	154
280	Globe	http://www.specialized.com/us/en/bikes/globe	\N	\N	\N	\N	\N	\N	943
281	Gnome et Rhône		\N	\N	\N	\N	\N	\N	155
282	GoGirl		\N	\N	\N	\N	\N	\N	560
283	Gocycle	http://gocycle.com/	\N	\N	\N	\N	\N	\N	1396
284	Gomier		\N	\N	\N	\N	\N	\N	1288
285	Gore		\N	\N	\N	\N	\N	\N	561
286	Gormully & Jeffery		\N	\N	\N	\N	\N	\N	156
287	Grab On		\N	\N	\N	\N	\N	\N	562
288	Grabber		\N	\N	\N	\N	\N	\N	563
289	Graber		\N	\N	\N	\N	\N	\N	564
290	Graflex	http://graflex.org/	\N	\N	\N	\N	\N	\N	157
291	Granite Gear		\N	\N	\N	\N	\N	\N	565
292	Gravity	http://www.bikesdirect.com/	\N	\N	\N	\N	\N	\N	566
293	Greenfield		\N	\N	\N	\N	\N	\N	567
294	Greenspeed	http://www.greenspeed.com.au/	\N	\N	\N	\N	\N	\N	1083
295	Gudereit	http://www.gudereit.de	\N	\N	\N	\N	\N	\N	1266
296	Guerciotti	http://www.guerciotti.it/	\N	\N	\N	\N	\N	\N	159
297	Gunnar	http://gunnarbikes.com/site/	\N	\N	\N	\N	\N	\N	986
298	Guru	http://www.gurucycles.com/en	\N	\N	\N	\N	\N	\N	1193
299	Guyot Designs		\N	\N	\N	\N	\N	\N	569
300	H Plus Son		\N	\N	\N	\N	\N	\N	570
301	Marinoni	http://www.marinoni.qc.ca/indexEN.html	\N	\N	\N	\N	\N	\N	1158
302	Mars Cycles	http://www.marscycles.com/	\N	\N	\N	\N	\N	\N	1484
303	Marson		\N	\N	\N	\N	\N	\N	641
304	Maruishi	http://en.maruishi-bike.com.cn/	\N	\N	\N	\N	\N	\N	1036
305	Marukin	http://www.marukin-bicycles.com/	\N	\N	\N	\N	\N	\N	1175
306	Marzocchi		\N	\N	\N	\N	\N	\N	642
307	Masi	http://www.masibikes.com	\N	\N	\N	\N	B	\N	104
308	Master Lock	http://www.masterlockbike.com	\N	\N	\N	\N	\N	\N	108
309	Matchless		\N	\N	\N	\N	\N	\N	220
310	Matra	http://matra.com/pre-home/?___SID=U	\N	\N	\N	\N	\N	\N	221
311	Maverick	http://www.maverickbike.com/	\N	\N	\N	\N	\N	\N	1159
312	Mavic		\N	\N	\N	\N	\N	\N	643
313	Maxcom	http://maxcombike.com/	\N	\N	\N	\N	\N	\N	1497
314	Maxit		\N	\N	\N	\N	\N	\N	644
315	Maxxis		\N	\N	\N	\N	\N	\N	645
316	Mechanical Threads		\N	\N	\N	\N	\N	\N	646
317	Meiser		\N	\N	\N	\N	\N	\N	647
318	Melon Bicycles	http://www.melonbicycles.com/	\N	\N	\N	\N	\N	\N	222
319	Mercian Cycles	http://www.merciancycles.co.uk/	\N	\N	\N	\N	\N	\N	223
320	Mercier	http://www.cyclesmercier.com	\N	\N	\N	\N	\N	\N	931
321	Merida Bikes	http://www.merida.com	\N	\N	\N	\N	\N	\N	65
322	Merlin	http://www.merlinbike.com/	\N	\N	\N	\N	\N	\N	224
323	Merrell		\N	\N	\N	\N	\N	\N	648
324	MetaBikes	http://meta-bikes.com/	\N	\N	\N	\N	\N	\N	988
325	Metric Hardware		\N	\N	\N	\N	\N	\N	649
326	Metrofiets	https://metrofiets.com	\N	\N	\N	\N	\N	\N	1364
327	Micajah C. Henley		\N	\N	\N	\N	\N	\N	167
328	Micargi	http://micargibicycles.com/	\N	\N	\N	\N	\N	\N	1165
329	Miche		\N	\N	\N	\N	\N	\N	650
330	Michelin		\N	\N	\N	\N	\N	\N	651
331	MicroShift		\N	\N	\N	\N	\N	\N	652
332	Miele bicycles	http://www.mielebicycles.com/home.html	\N	\N	\N	\N	\N	\N	226
333	Mikkelsen	http://www.mikkelsenframes.com/	\N	\N	\N	\N	B	\N	1187
334	Milwaukee Bicycle Co.	http://www.benscycle.net/	\N	\N	\N	\N	\N	\N	227
335	Minoura		\N	\N	\N	\N	\N	\N	653
336	MirraCo 	http://mirrabikeco.com/	\N	\N	\N	\N	\N	\N	1012
337	Mirrycle		\N	\N	\N	\N	\N	\N	654
338	Mission Bicycles	https://www.missionbicycle.com/	\N	\N	\N	\N	B	\N	990
339	Miyata	http://www.miyatabicycles.com/	\N	\N	\N	\N	\N	\N	229
340	Mizutani		\N	\N	\N	\N	\N	\N	1166
341	Modolo	http://www.modolo.eu/	\N	\N	\N	\N	\N	\N	1398
342	Momentum	http://www.pedalmomentum.com/	\N	\N	\N	\N	\N	\N	1387
343	Monark	http://www.monarkexercise.se/	\N	\N	\N	\N	\N	\N	87
344	Mondia	http://en.wikipedia.org/wiki/Mondia	\N	\N	\N	\N	\N	\N	230
345	Mondraker	http://www.mondraker.com/	\N	\N	\N	\N	\N	\N	1263
346	Mongoose	http://www.mongoose.com/	\N	\N	\N	\N	A	\N	118
347	Montague	http://www.montaguebikes.com/	\N	\N	\N	\N	\N	\N	656
348	Moots Cycles	http://moots.com/	\N	\N	\N	\N	B	\N	232
349	Mophie		\N	\N	\N	\N	\N	\N	658
350	Mosaic	http://mosaiccycles.com/	\N	\N	\N	\N	\N	\N	1351
351	Moser Cicli	http://www.ciclimoser.com/	\N	\N	\N	\N	\N	\N	233
352	Mosh		\N	\N	\N	\N	\N	\N	1284
353	Mosso	http://www.mosso.com.tw/	\N	\N	\N	\N	\N	\N	1302
354	Moth Attack	http://mothattack.com/	\N	\N	\N	\N	\N	\N	1349
355	Motiv	http://www.motivelectricbikes.com	\N	\N	\N	\N	\N	\N	984
356	Motobecane	http://www.motobecane.com/	\N	\N	\N	\N	B	\N	234
357	Moulden		\N	\N	\N	\N	\N	\N	1050
358	Moulton Bicycle	http://www.moultonbicycles.co.uk/	\N	\N	\N	\N	\N	\N	235
359	Mountain Cycles		\N	\N	\N	\N	\N	\N	1283
360	Mountainsmith		\N	\N	\N	\N	\N	\N	659
361	Mr. Tuffy		\N	\N	\N	\N	\N	\N	660
362	Mucky Nutz 	http://muckynutz.com/	\N	\N	\N	\N	\N	\N	1509
363	Muddy Fox	http://www.muddyfoxusa.com/	\N	\N	\N	\N	\N	\N	237
364	Murray		\N	\N	\N	\N	\N	\N	236
365	Mutant Bikes		\N	\N	\N	\N	\N	\N	664
366	Mutiny	http://www.mutinybikes.com/	\N	\N	\N	\N	\N	\N	1067
367	Müsing (Musing)	http://www.muesing-bikes.de/	\N	\N	\N	\N	\N	\N	1361
368	N Gear		\N	\N	\N	\N	\N	\N	665
369	NEMO		\N	\N	\N	\N	\N	\N	671
370	NS Bikes	http://www.ns-bikes.com/	\N	\N	\N	\N	\N	\N	1011
371	Nakamura	http://www.nakamura.no/	\N	\N	\N	\N	\N	\N	1285
372	Naked	http://timetogetnaked.com/	\N	\N	\N	\N	\N	\N	1250
373	Nalgene		\N	\N	\N	\N	\N	\N	666
374	Nantucket Bike Basket Company		\N	\N	\N	\N	\N	\N	667
375	Nashbar	http://Nashbar.com	\N	\N	\N	\N	\N	\N	957
376	Nathan		\N	\N	\N	\N	\N	\N	668
377	National	http://nationalmoto.com/	\N	\N	\N	\N	\N	\N	238
378	Native		\N	\N	\N	\N	\N	\N	669
379	Neil Pryde	http://www.neilprydebikes.com/	\N	\N	\N	\N	\N	\N	240
380	Nema		\N	\N	\N	\N	\N	\N	670
381	Neobike	http://www.allproducts.com/bike/neobike/	\N	\N	\N	\N	\N	\N	241
382	New Albion	http://newalbioncycles.com/	\N	\N	\N	\N	\N	\N	1071
383	New Balance		\N	\N	\N	\N	\N	\N	672
384	Next	http://next-bike.com/	\N	\N	\N	\N	\N	\N	123
385	Niner	http://www.ninerbikes.com/	\N	\N	\N	\N	\N	\N	1022
386	Nirve	http://www.nirve.com/	\N	\N	\N	\N	\N	\N	1176
387	Nishiki	http://nishiki.com/	\N	\N	\N	\N	\N	\N	243
388	Nite Ize		\N	\N	\N	\N	\N	\N	673
389	NiteRider		\N	\N	\N	\N	\N	\N	674
390	Nitto		\N	\N	\N	\N	\N	\N	675
391	Nokon		\N	\N	\N	\N	\N	\N	676
392	Nomad Cargo	https://www.facebook.com/NomadCargo	\N	\N	\N	\N	\N	\N	1408
393	Norco Bikes	http://www.norco.com/	\N	\N	\N	\N	\N	\N	244
394	Norman Cycles	http://www.normanmotorcycles.org.uk/	\N	\N	\N	\N	\N	\N	245
395	North Shore Billet		\N	\N	\N	\N	\N	\N	677
396	Northrock	http://www.northrockbikes.com/	\N	\N	\N	\N	\N	\N	1021
397	Novara		\N	\N	\N	\N	\N	\N	246
398	NuVinci		\N	\N	\N	\N	\N	\N	679
399	Nukeproof	http://nukeproof.com/	\N	\N	\N	\N	\N	\N	1282
400	Nymanbolagen		\N	\N	\N	\N	\N	\N	248
401	Worksman Cycles	http://www.worksmancycles.com/	\N	\N	\N	\N	\N	\N	346
402	World Jerseys		\N	\N	\N	\N	\N	\N	912
403	Wright Cycle Company		\N	\N	\N	\N	\N	\N	347
404	X-Fusion		\N	\N	\N	\N	\N	\N	914
405	X-Lab		\N	\N	\N	\N	\N	\N	915
406	X-Treme	http://www.x-tremescooters.com	\N	\N	\N	\N	\N	\N	1077
407	Xds	http://www.xdsbicycles.com/	\N	\N	\N	\N	\N	\N	1343
408	Xootr		\N	\N	\N	\N	\N	\N	348
409	Xpedo		\N	\N	\N	\N	\N	\N	916
410	Xtracycle	http://www.xtracycle.com/	\N	\N	\N	\N	\N	\N	1007
411	YST		\N	\N	\N	\N	\N	\N	920
412	Yakima		\N	\N	\N	\N	\N	\N	917
413	Yaktrax		\N	\N	\N	\N	\N	\N	918
414	Yamaguchi Bicycles	http://www.yamaguchibike.com/content/Index	\N	\N	\N	\N	\N	\N	349
415	Yamaha		\N	\N	\N	\N	\N	\N	350
416	Yankz		\N	\N	\N	\N	\N	\N	919
417	Yeti	http://www.yeticycles.com	\N	\N	\N	\N	B	\N	1091
418	Yuba	http://yubabikes.com/	\N	\N	\N	\N	\N	\N	1003
419	Yurbuds		\N	\N	\N	\N	\N	\N	921
420	Zensah		\N	\N	\N	\N	\N	\N	922
421	Zigo		\N	\N	\N	\N	\N	\N	351
422	Zinn Cycles	http://zinncycles.com	\N	\N	\N	\N	\N	\N	1215
423	Zipp Speed Weaponry		\N	\N	\N	\N	\N	\N	923
424	Zoic		\N	\N	\N	\N	\N	\N	924
425	Zoom		\N	\N	\N	\N	\N	\N	925
426	Zoot		\N	\N	\N	\N	\N	\N	926
427	Zycle Fix	http://zyclefix.com/	\N	\N	\N	\N	\N	\N	1182
428	b'Twin	http://www.btwin.com/en/home	\N	\N	\N	\N	\N	\N	1073
429	beixo	http://www.beixo.com/	\N	\N	\N	\N	\N	\N	1368
430	de Fietsfabriek 	http://www.defietsfabriek.nl/	\N	\N	\N	\N	\N	\N	1122
431	di Florino		\N	\N	\N	\N	\N	\N	1119
432	e*thirteen		\N	\N	\N	\N	\N	\N	502
433	eGear		\N	\N	\N	\N	\N	\N	507
434	eZip	http://www.currietech.com/	\N	\N	\N	\N	\N	\N	1170
435	eflow (Currietech)	http://www.currietech.com/	\N	\N	\N	\N	\N	\N	1280
436	elete		\N	\N	\N	\N	\N	\N	509
437	epicRIDES		\N	\N	\N	\N	\N	\N	518
438	k.bedford customs	http://www.kbedfordcustoms.com/	\N	\N	\N	\N	\N	\N	1445
439	liteloc	http://litelok.com/	\N	\N	\N	\N	\N	\N	1401
440	nuun		\N	\N	\N	\N	\N	\N	678
441	silverback	http://www.silverbacklab.com/	\N	\N	\N	\N	\N	\N	1479
442	sixthreezero	http://www.sixthreezero.com/	\N	\N	\N	\N	\N	\N	1006
443	van Andel/Bakfiets	http://www.bakfiets.nl/	\N	\N	\N	\N	\N	\N	1121
444	O-Stand		\N	\N	\N	\N	\N	\N	680
445	O2		\N	\N	\N	\N	\N	\N	681
446	ODI		\N	\N	\N	\N	\N	\N	682
447	OHM	http://ohmcycles.com/	\N	\N	\N	\N	\N	\N	1262
448	Odyssey		\N	\N	\N	\N	\N	\N	683
449	Ohio Travel Bag		\N	\N	\N	\N	\N	\N	684
450	Olmo	http://www.olmobikes.com/	\N	\N	\N	\N	\N	\N	1211
451	Omnium	http://omniumcargo.dk/	\N	\N	\N	\N	\N	\N	1384
452	On-One (On One)	http://www.on-one.co.uk/	\N	\N	\N	\N	\N	\N	1226
453	OnGuard		\N	\N	\N	\N	\N	\N	686
454	One Way		\N	\N	\N	\N	\N	\N	685
455	Opel	http://opelbikes.com/	\N	\N	\N	\N	\N	\N	249
456	Optic Nerve		\N	\N	\N	\N	\N	\N	687
457	Optimus		\N	\N	\N	\N	\N	\N	688
458	Opus	http://opusbike.com/en/	\N	\N	\N	\N	\N	\N	1074
459	Orange Seal		\N	\N	\N	\N	\N	\N	689
460	Orange mountain bikes	http://www.orangebikes.co.uk/	\N	\N	\N	\N	\N	\N	250
461	Orbea	http://www.orbea.com/us-en/	\N	\N	\N	\N	\N	\N	251
462	Orbit	http://www.orbit-cycles.co.uk/	\N	\N	\N	\N	\N	\N	980
463	Orient Bikes	http://www.orient-bikes.gr/en	\N	\N	\N	\N	\N	\N	252
464	Origin8 (Origin-8)	http://www.origin-8.com/	\N	\N	\N	\N	\N	\N	948
465	Ortlieb		\N	\N	\N	\N	\N	\N	690
466	Other		\N	\N	\N	\N	\N	\N	100
467	Otis Guy	http://www.otisguycycles.com/	\N	\N	\N	\N	\N	\N	1347
468	Oury		\N	\N	\N	\N	\N	\N	691
469	OutGo		\N	\N	\N	\N	\N	\N	692
470	Owl 360		\N	\N	\N	\N	\N	\N	693
471	Oyama	http://www.oyama.eu/	\N	\N	\N	\N	\N	\N	1033
472	Ozone		\N	\N	\N	\N	\N	\N	694
473	PDW		\N	\N	\N	\N	\N	\N	702
474	POC		\N	\N	\N	\N	\N	\N	715
475	PUBLIC bikes	http://publicbikes.com/	\N	\N	\N	\N	B	\N	974
476	Pace Sportswear		\N	\N	\N	\N	\N	\N	695
477	Paceline Products		\N	\N	\N	\N	\N	\N	696
478	Pacific Cycle	http://www.pacific-cycles.com/	\N	\N	\N	\N	\N	\N	115
479	PackTowl		\N	\N	\N	\N	\N	\N	697
480	Pake	http://www.pakebikes.com	\N	\N	\N	\N	\N	\N	365
481	Panaracer		\N	\N	\N	\N	\N	\N	698
482	Panasonic		\N	\N	\N	\N	B	\N	239
483	Paper Bicycle	http://www.paper-bicycle.com/	\N	\N	\N	\N	\N	\N	1147
484	Park		\N	\N	\N	\N	\N	\N	699
485	Parkpre	http://www.parkpre.com/	\N	\N	\N	\N	\N	\N	1023
486	Parlee	http://www.parleecycles.com	\N	\N	\N	\N	B	\N	700
487	Pasculli	http://www.pasculli.de	\N	\N	\N	\N	\N	\N	1444
488	Pashley Cycles	http://www.pashley.co.uk/	\N	\N	\N	\N	\N	\N	256
489	Patria	http://www.patria.net/en/bicycles/	\N	\N	\N	\N	\N	\N	257
490	Paul	http://www.paulcomp.com/	\N	\N	\N	\N	\N	\N	701
491	Pearl Izumi		\N	\N	\N	\N	\N	\N	703
492	Pedco		\N	\N	\N	\N	\N	\N	704
493	Pedego	http://www.pedegoelectricbikes.com/	\N	\N	\N	\N	\N	\N	1114
494	Pedersen bicycle	http://www.pedersenbicycles.com/	\N	\N	\N	\N	\N	\N	258
495	Pedro's		\N	\N	\N	\N	\N	\N	705
496	Pegasus	http://www.pegasus-bikes.de/startseite/	\N	\N	\N	\N	\N	\N	1404
497	Pegoretti	http://www.gitabike.com/cgi-bin/shop/pegoretti_loadhome.cgi?file=pegoretti.html	\N	\N	\N	\N	\N	\N	1142
498	Penguin Brands		\N	\N	\N	\N	\N	\N	706
499	Pereira	http://www.pereiracycles.com/	\N	\N	\N	\N	\N	\N	1189
500	Performance	http://www.performancebike.com/bikes	\N	\N	\N	\N	\N	\N	1061
501	Peugeot	http://www.peugeot.com/en/products-services/cycles	\N	\N	\N	\N	B	\N	102
502	Phat Cycles	http://www.phatcycles.com/	\N	\N	\N	\N	\N	\N	1062
503	Phil Wood		\N	\N	\N	\N	\N	\N	707
504	Philips		\N	\N	\N	\N	\N	\N	708
505	Phillips Cycles	http://www.phillipscycles.co.uk/	\N	\N	\N	\N	\N	\N	260
506	Phoenix	http://www.cccme.org.cn/	\N	\N	\N	\N	\N	\N	261
507	Phorm		\N	\N	\N	\N	\N	\N	709
508	Pierce-Arrow	http://www.pierce-arrow.org	\N	\N	\N	\N	\N	\N	262
509	Pilen	http://www.pilencykel.se/site/en/home	\N	\N	\N	\N	\N	\N	1202
510	Pinarello	http://www.racycles.com/	\N	\N	\N	\N	\N	\N	263
511	Pinhead	http://www.pinheadcomponents.com/	\N	\N	\N	\N	\N	\N	710
512	Pinnacle (Evans Cycles)	https://www.evanscycles.com/pinnacle_b	\N	\N	\N	\N	\N	\N	1511
513	Pitlock	http://www.pitlock.com/	\N	\N	\N	\N	\N	\N	992
514	Pivot	http://www.pivotcycles.com/	\N	\N	\N	\N	\N	\N	1105
515	Planet Bike		\N	\N	\N	\N	\N	\N	711
516	Planet X	http://www.planet-x-bikes.co.uk/	\N	\N	\N	\N	\N	\N	264
517	Platypus		\N	\N	\N	\N	\N	\N	712
518	Pletscher		\N	\N	\N	\N	\N	\N	713
519	Po Campo		\N	\N	\N	\N	\N	\N	714
520	Pocket Bicycles		\N	\N	\N	\N	\N	\N	265
521	Pogliaghi	http://en.wikipedia.org/wiki/Pogliaghi	\N	\N	\N	\N	\N	\N	266
522	Polar		\N	\N	\N	\N	\N	\N	716
523	Polar Bottles		\N	\N	\N	\N	\N	\N	717
524	Polygon	http://www.polygonbikes.com/	\N	\N	\N	\N	\N	\N	1104
525	Pope Manufacturing Company		\N	\N	\N	\N	\N	\N	267
526	Power Grips		\N	\N	\N	\N	\N	\N	718
527	PowerBar		\N	\N	\N	\N	\N	\N	719
528	PowerTap		\N	\N	\N	\N	\N	\N	720
529	Premium	http://www.premiumbmx.com/	\N	\N	\N	\N	\N	\N	1141
530	Price	http://www.price-bikes.ch/	\N	\N	\N	\N	\N	\N	1375
531	Primal Wear		\N	\N	\N	\N	\N	\N	721
532	Primo		\N	\N	\N	\N	\N	\N	722
533	Primus Mootry (PM Cycle Fabrication)	http://www.primusmootry.com/	\N	\N	\N	\N	\N	\N	1340
534	Princeton Tec		\N	\N	\N	\N	\N	\N	723
535	Principia	http://www.principia.dk/gb/	\N	\N	\N	\N	\N	\N	975
536	Priority Bicycles	http://www.prioritybicycles.com/	\N	\N	\N	\N	\N	\N	1390
537	Private label		\N	\N	\N	\N	\N	\N	211
538	Pro-tec		\N	\N	\N	\N	\N	\N	724
539	ProBar		\N	\N	\N	\N	\N	\N	725
540	ProGold		\N	\N	\N	\N	\N	\N	729
541	Problem Solvers		\N	\N	\N	\N	\N	\N	726
542	Procycle Group	http://www.procycle.com/en/default.asp	\N	\N	\N	\N	\N	\N	269
543	Prodeco	http://prodecotech.com/	\N	\N	\N	\N	\N	\N	1160
544	24seven	http://www.leisurelakesbikes.com/bikes/bmx-bikes/b/24seven	\N	\N	\N	\N	\N	\N	7
545	333Fab	http://www.333fab.com/	\N	\N	\N	\N	\N	\N	1410
546	3G	http://www.3gbikes.com/	\N	\N	\N	\N	\N	\N	1125
547	3T		\N	\N	\N	\N	B	\N	375
548	3rd Eye		\N	\N	\N	\N	\N	\N	374
549	3rensho		\N	\N	\N	\N	\N	\N	1112
550	45North		\N	\N	\N	\N	\N	\N	376
551	4ZA		\N	\N	\N	\N	\N	\N	377
552	6KU	http://6kubikes.com	\N	\N	\N	\N	\N	\N	1274
553	9 zero 7	https://www.facebook.com/9Zero7Bikes	\N	\N	\N	\N	\N	\N	1113
554	A-Class		\N	\N	\N	\N	\N	\N	378
555	A-bike	http://www.a-bike.co.uk/	\N	\N	\N	\N	\N	\N	8
556	A2B e-bikes	http://www.wearea2b.com/us/	\N	\N	\N	\N	\N	\N	1212
557	ABI		\N	\N	\N	\N	\N	\N	380
558	ACS		\N	\N	\N	\N	\N	\N	384
559	AGang	http://www.agang.eu	\N	\N	\N	\N	\N	\N	1255
560	ALAN	http://www.alanbike.it/	\N	\N	\N	\N	\N	\N	24
561	AMF		\N	\N	\N	\N	\N	\N	29
562	AXA	http://www.axa-stenman.com/en/bicycle-components/locks/frame-locks/defender/	\N	\N	\N	\N	\N	\N	1268
563	Aardvark		\N	\N	\N	\N	\N	\N	379
564	Abici	http://www.abici-italia.it/en/index.html	\N	\N	\N	\N	\N	\N	9
565	Abus	http://www.abus.com/eng/Mobile-Security/Bike-safety-and-security/Locks	\N	\N	\N	\N	\N	\N	107
566	Accelerade		\N	\N	\N	\N	\N	\N	382
567	Accell	http://www.accell-group.com/uk/accell-group.asp	\N	\N	\N	\N	\N	\N	10
568	Access	https://www.performancebike.com/	\N	\N	\N	\N	\N	\N	1042
569	Acros		\N	\N	\N	\N	\N	\N	383
570	Acstar	http://www.acstar.cz/	\N	\N	\N	\N	\N	\N	1293
571	Adams (Trail a bike)	http://www.trail-a-bike.com/	\N	\N	\N	\N	\N	\N	1258
572	Adolphe Clément		\N	\N	\N	\N	\N	\N	77
573	Adventure Medical Kits		\N	\N	\N	\N	\N	\N	385
574	Advocate	http://advocatecycles.com/	\N	\N	\N	\N	\N	\N	1480
575	Aegis	http://www.aegisbicycles.com/home.html	\N	\N	\N	\N	B	\N	1260
576	Aerofix Cycles	http://www.aerofixcycles.com/	\N	\N	\N	\N	\N	\N	1002
577	Affinity Cycles	http://affinitycycles.com/	\N	\N	\N	\N	\N	\N	1199
578	AheadSet		\N	\N	\N	\N	\N	\N	386
579	Airborne	http://www.airbornebicycles.com/	\N	\N	\N	\N	\N	\N	1133
580	Aist Bicycles	http://aist-bike.com/	\N	\N	\N	\N	\N	\N	23
581	Aladdin		\N	\N	\N	\N	\N	\N	387
582	Alcyon		\N	\N	\N	\N	\N	\N	25
583	Alex		\N	\N	\N	\N	\N	\N	388
584	Alexander Leutner & Co.		\N	\N	\N	\N	\N	\N	214
585	Alien Bikes	http://alienbikes.com/	\N	\N	\N	\N	\N	\N	1013
586	Alienation		\N	\N	\N	\N	\N	\N	389
587	Alite Designs		\N	\N	\N	\N	\N	\N	390
588	All City	http://allcitycycles.com	\N	\N	\N	\N	B	\N	371
589	Alldays & Onions		\N	\N	\N	\N	\N	\N	26
590	Alliance	http://alliancebicycles.com/	\N	\N	\N	\N	\N	\N	1257
591	Alton	http://altonus.com/	\N	\N	\N	\N	\N	\N	1366
592	American Bicycle Company		\N	\N	\N	\N	\N	\N	27
593	American Classic		\N	\N	\N	\N	\N	\N	391
594	American Machine and Foundry		\N	\N	\N	\N	\N	\N	28
595	American Star Bicycle		\N	\N	\N	\N	\N	\N	31
596	Amoeba	http://www.amoebaparts.com/	\N	\N	\N	\N	\N	\N	1355
597	And		\N	\N	\N	\N	\N	\N	392
598	Andiamo		\N	\N	\N	\N	\N	\N	393
599	Answer BMX		\N	\N	\N	\N	\N	\N	394
600	Apollo	http://www.apollobikes.com/	\N	\N	\N	\N	\N	\N	1099
601	Aqua Sphere		\N	\N	\N	\N	\N	\N	396
602	Aquamira		\N	\N	\N	\N	\N	\N	397
603	Arai		\N	\N	\N	\N	\N	\N	398
604	Ares	http://www.aresbikes.com/	\N	\N	\N	\N	\N	\N	1379
605	Argon 18	http://www.argon18bike.com/velo.html	\N	\N	\N	\N	\N	\N	32
606	Asama	http://www.asamabicycles.com/	\N	\N	\N	\N	\N	\N	1081
607	Assos		\N	\N	\N	\N	\N	\N	399
608	Atala		\N	\N	\N	\N	\N	\N	17
609	Atomlab	http://www.atomlab.com/	\N	\N	\N	\N	\N	\N	400
610	Author	http://www.author.eu/	\N	\N	\N	\N	\N	\N	33
611	Avalon	http://www.walmart.com/	\N	\N	\N	\N	\N	\N	1126
612	Avanti	http://www.avantibikes.com/nz/	\N	\N	\N	\N	\N	\N	34
613	Aventón	http://aventonbikes.com/	\N	\N	\N	\N	\N	\N	1059
614	Avid		\N	\N	\N	\N	\N	\N	401
615	Axiom		\N	\N	\N	\N	\N	\N	402
616	Axle Release		\N	\N	\N	\N	\N	\N	403
617	Azonic	http://www.oneal.com/index.php/home/azonic-prime	\N	\N	\N	\N	\N	\N	1156
618	Azor	http://www.azor.nl/	\N	\N	\N	\N	\N	\N	1120
619	Aztec		\N	\N	\N	\N	\N	\N	404
620	Azzuri	http://www.azzurribikes.com/	\N	\N	\N	\N	\N	\N	1101
621	BCA		\N	\N	\N	\N	\N	\N	410
622	BH Bikes (Beistegui Hermanos)	http://bhbikes-us.com	\N	\N	\N	\N	\N	\N	36
623	BMC	http://www.bmc-racing.com	\N	\N	\N	\N	\N	\N	359
624	BOB	http://www.bobgear.com/bike-trailers	\N	\N	\N	\N	\N	\N	424
625	BONT		\N	\N	\N	\N	\N	\N	429
626	BOX		\N	\N	\N	\N	\N	\N	431
627	BSD		\N	\N	\N	\N	\N	\N	437
628	BSP	http://www.bsp-fietsen.nl/	\N	\N	\N	\N	\N	\N	1491
629	BULLS Bikes	http://www.bullsbikesusa.com/	\N	\N	\N	\N	\N	\N	1402
630	Bacchetta	http://www.bacchettabikes.com/	\N	\N	\N	\N	\N	\N	989
631	Backpacker's Pantry		\N	\N	\N	\N	\N	\N	405
632	Backward Circle	http://www.backwardcircle.com/	\N	\N	\N	\N	\N	\N	1025
633	Badger Bikes	http://www.badgerbikes.com/	\N	\N	\N	\N	\N	\N	1486
634	Bahco		\N	\N	\N	\N	\N	\N	406
635	Bailey	http://www.bailey-bikes.com	\N	\N	\N	\N	\N	\N	958
636	Baladeo		\N	\N	\N	\N	\N	\N	407
637	Bamboocycles	http://bamboocycles.com/	\N	\N	\N	\N	\N	\N	1307
638	Banjo Brothers		\N	\N	\N	\N	\N	\N	408
639	Banshee Bikes	http://www.bansheebikes.com	\N	\N	\N	\N	\N	\N	1066
640	Bantam (Bantam Bicycle Works)	http://www.bantambicycles.com/	\N	\N	\N	\N	\N	\N	1362
641	Bar Mitts		\N	\N	\N	\N	\N	\N	409
642	Barracuda	http://www.barracudabikes.co.uk/	\N	\N	\N	\N	\N	\N	1134
643	Basso	http://www.bassobikes.com/	\N	\N	\N	\N	\N	\N	35
644	Stevens	http://www.stevensbikes.de/2014/index.php	\N	\N	\N	\N	\N	\N	1108
645	Stevenson Custom Bicycles	http://stevensoncustombikes.com/	\N	\N	\N	\N	\N	\N	1229
646	Stinner	http://www.stinnerframeworks.com/	\N	\N	\N	\N	\N	\N	1482
647	Stoemper	http://stoemper.com/	\N	\N	\N	\N	\N	\N	960
648	Stolen Bicycle Co.		\N	\N	\N	\N	\N	\N	352
649	Stop Flats 2		\N	\N	\N	\N	\N	\N	817
650	Strada Customs	http://www.stradacustoms.com	\N	\N	\N	\N	\N	\N	939
651	Stradalli Cycles	http://www.carbonroadbikebicyclecycling.com/	\N	\N	\N	\N	\N	\N	1210
652	Straitline		\N	\N	\N	\N	\N	\N	818
653	Strawberry Bicycle	http://www.strawberrybicycle.com/	\N	\N	\N	\N	\N	\N	1382
654	Strida		\N	\N	\N	\N	\N	\N	314
655	Strider	http://www.striderbikes.com/	\N	\N	\N	\N	\N	\N	819
768	RaceFace		\N	\N	\N	\N	\N	\N	739
656	Stromer	http://www.stromerbike.com/en/us	\N	\N	\N	\N	\N	\N	1243
657	Strong Frames	http://www.strongframes.com/	\N	\N	\N	\N	\N	\N	1177
658	Sturmey-Archer		\N	\N	\N	\N	\N	\N	820
659	Stålhästen	http://www.stalhasten.eu/st%C3%A5lh%C3%A4sten	\N	\N	\N	\N	\N	\N	1072
660	Subrosa	http://subrosabrand.com/	\N	\N	\N	\N	\N	\N	821
661	Suelo		\N	\N	\N	\N	\N	\N	822
662	Sugino		\N	\N	\N	\N	\N	\N	823
663	Sun		\N	\N	\N	\N	\N	\N	315
664	Sun Ringle		\N	\N	\N	\N	\N	\N	824
665	SunRace	http://www.sunrace.com/	\N	\N	\N	\N	\N	\N	825
666	Sunday	http://www.sundaybikes.com	\N	\N	\N	\N	\N	\N	355
667	Sunn	https://www.facebook.com/sunn.bicycle	\N	\N	\N	\N	\N	\N	1086
668	Suomi		\N	\N	\N	\N	\N	\N	826
669	Supercross	http://www.supercrossbmx.com/	\N	\N	\N	\N	\N	\N	1496
670	Superfeet		\N	\N	\N	\N	\N	\N	827
671	Supernova		\N	\N	\N	\N	\N	\N	828
672	Surly	http://surlybikes.com	\N	\N	\N	\N	\N	\N	112
673	Surrey	http://www.internationalsurreyco.com	\N	\N	\N	\N	\N	\N	1191
674	Sutherlands		\N	\N	\N	\N	\N	\N	829
675	Suunto		\N	\N	\N	\N	\N	\N	830
676	Suzuki		\N	\N	\N	\N	\N	\N	318
677	Sweetpea Bicycles	http://www.sweetpeabicycles.com/	\N	\N	\N	\N	\N	\N	1252
678	Swingset	http://www.swingsetbicycles.com/	\N	\N	\N	\N	\N	\N	1275
679	Swix		\N	\N	\N	\N	\N	\N	832
680	Swobo	http://shop.swobo.com/	\N	\N	\N	\N	\N	\N	963
681	SyCip	http://sycip.com/	\N	\N	\N	\N	\N	\N	1234
682	Syncros	http://www.syncros.com/syncros/us/en/	\N	\N	\N	\N	\N	\N	1504
683	Syntace		\N	\N	\N	\N	\N	\N	833
684	T Mat Pro		\N	\N	\N	\N	\N	\N	834
685	TET Cycles (Tom Teesdale Bikes)	http://tetcycles.com/	\N	\N	\N	\N	\N	\N	1232
686	TH Industries		\N	\N	\N	\N	\N	\N	842
687	TI Cycles of India		\N	\N	\N	\N	\N	\N	323
688	TRP		\N	\N	\N	\N	\N	\N	864
689	TYR		\N	\N	\N	\N	\N	\N	870
690	Tacx	https://www.tacx.com/	\N	\N	\N	\N	\N	\N	835
691	Takara	http://takarabikes.com/	\N	\N	\N	\N	\N	\N	949
692	Talisman		\N	\N	\N	\N	\N	\N	1037
693	Tallac	http://tallachouse.com/	\N	\N	\N	\N	\N	\N	1370
694	Tamer		\N	\N	\N	\N	\N	\N	836
695	Tange-Seiki		\N	\N	\N	\N	\N	\N	837
696	Tangent Products		\N	\N	\N	\N	\N	\N	838
697	Tati Cycles	http://taticycles.com/	\N	\N	\N	\N	\N	\N	1209
698	Taylor Bicycles (Paul Taylor)	http://taylorbicycles.blogspot.com/	\N	\N	\N	\N	\N	\N	1294
699	Tec Labs		\N	\N	\N	\N	\N	\N	839
700	Tektro		\N	\N	\N	\N	\N	\N	840
701	Tern	http://www.ternbicycles.com/us/	\N	\N	\N	\N	\N	\N	976
702	Terra Trike	http://www.terratrike.com/	\N	\N	\N	\N	\N	\N	1306
703	Terrible One	http://www.terribleone.com	\N	\N	\N	\N	\N	\N	1299
704	Terrot		\N	\N	\N	\N	\N	\N	319
705	Terry	http://www.terrybicycles.com/	\N	\N	\N	\N	\N	\N	841
706	The Arthur Pequegnat Clock Company		\N	\N	\N	\N	\N	\N	37
707	The Bicycle Forge	http://www.bicycleforge.com/	\N	\N	\N	\N	\N	\N	1080
708	The Hive		\N	\N	\N	\N	\N	\N	844
709	Thinksport		\N	\N	\N	\N	\N	\N	846
710	Thomson		\N	\N	\N	\N	\N	\N	847
711	Thorn Cycles		\N	\N	\N	\N	\N	\N	321
712	Throne Cycles	http://thronecycles.com/	\N	\N	\N	\N	\N	\N	1386
713	Thruster	http://walmart.com	\N	\N	\N	\N	\N	\N	1161
714	Thule	http://www.thule.com	\N	\N	\N	\N	\N	\N	848
715	Ti Cycles	http://ticycles.com/	\N	\N	\N	\N	\N	\N	985
716	Tigr	http://tigrlock.com	\N	\N	\N	\N	\N	\N	111
717	Timbuk2		\N	\N	\N	\N	\N	\N	849
718	Time	http://www.time-sport.com/	\N	\N	\N	\N	\N	\N	850
719	Timex		\N	\N	\N	\N	\N	\N	851
720	Tioga		\N	\N	\N	\N	\N	\N	852
721	Titan	http://www.titanracingbikes.com/	\N	\N	\N	\N	\N	\N	991
722	Titus	http://www.titusti.com	\N	\N	\N	\N	\N	\N	1043
723	Toko		\N	\N	\N	\N	\N	\N	853
724	Tomac	http://www.tomac.com.au/	\N	\N	\N	\N	\N	\N	1380
725	Tommasini	http://tommasinibicycle.com/	\N	\N	\N	\N	\N	\N	1162
726	Tommaso	http://tommasobikes.com/	\N	\N	\N	\N	\N	\N	970
727	Tony Hawk	http://www.toysrus.com/	\N	\N	\N	\N	\N	\N	1164
728	Topeak		\N	\N	\N	\N	\N	\N	854
729	TorHans		\N	\N	\N	\N	\N	\N	855
730	Torelli	http://www.torelli.com/	\N	\N	\N	\N	\N	\N	1145
731	Torker		\N	\N	\N	\N	\N	\N	324
732	Tour de France	http://cyclefg.com/	\N	\N	\N	\N	\N	\N	1163
733	Tout Terrain	http://www.en.tout-terrain.de/	\N	\N	\N	\N	\N	\N	1505
734	Toyo	http://toyoframe.com/	\N	\N	\N	\N	\N	\N	1342
735	Traitor	http://www.traitorcycles.com	\N	\N	\N	\N	\N	\N	1271
736	Transit	http://www.performancebike.com/bikes/CategoryDisplay?catalogId=10551&storeId=10052&categoryId=400763&langId=-1&parent_category_rn=400345&top_category=400345&pageView=	\N	\N	\N	\N	\N	\N	1273
737	Transition Bikes	http://www.transitionbikes.com/	\N	\N	\N	\N	\N	\N	1019
738	Tranz-X		\N	\N	\N	\N	\N	\N	856
739	Trayl	http://traylcycling.com/	\N	\N	\N	\N	\N	\N	1400
740	Tree		\N	\N	\N	\N	\N	\N	857
741	Trek	http://www.trekbikes.com/us/en/	\N	\N	\N	\N	A	\N	47
742	Tressostar		\N	\N	\N	\N	\N	\N	858
743	TriFlow		\N	\N	\N	\N	\N	\N	859
744	Profile Design		\N	\N	\N	\N	\N	\N	727
745	Profile Racing		\N	\N	\N	\N	\N	\N	728
746	Prologo		\N	\N	\N	\N	\N	\N	730
747	Promax		\N	\N	\N	\N	\N	\N	731
748	Propain	https://www.propain-bikes.com/	\N	\N	\N	\N	\N	\N	1503
749	Prophete	http://www.prophete.de/	\N	\N	\N	\N	\N	\N	272
750	Puch	http://www.puch.at/	\N	\N	\N	\N	\N	\N	88
751	Pure City	http://purecitycycles.com/	\N	\N	\N	\N	\N	\N	1394
752	Pure Fix	http://purefixcycles.com/	\N	\N	\N	\N	\N	\N	947
753	Python	http://www.pythonbikes.com/	\N	\N	\N	\N	\N	\N	1045
754	Python Pro	http://pythonpro.dk/	\N	\N	\N	\N	\N	\N	1298
755	Q-Outdoor		\N	\N	\N	\N	\N	\N	732
756	Q-Tubes		\N	\N	\N	\N	\N	\N	733
757	QBP		\N	\N	\N	\N	\N	\N	734
758	Quadrant Cycle Company		\N	\N	\N	\N	\N	\N	273
759	Quest		\N	\N	\N	\N	\N	\N	736
760	Quik Stik		\N	\N	\N	\N	\N	\N	737
761	Quintana Roo	http://www.quintanarootri.com/	\N	\N	\N	\N	\N	\N	275
762	R12		\N	\N	\N	\N	\N	\N	738
763	RIH	http://www.rih.nl	\N	\N	\N	\N	\N	\N	1001
764	RPM		\N	\N	\N	\N	\N	\N	760
765	RRB (Rat Rod Bikes)	https://www.facebook.com/ratrodbikescom	\N	\N	\N	\N	\N	\N	945
766	RST		\N	\N	\N	\N	\N	\N	761
767	Rabeneick	http://www.rabeneick.de/bikes/	\N	\N	\N	\N	\N	\N	1296
769	Racktime		\N	\N	\N	\N	\N	\N	740
770	Radio Bike Co	http://www.radiobikes.com/	\N	\N	\N	\N	\N	\N	1388
771	Radio Flyer	http://www.radioflyer.com/trikes.html	\N	\N	\N	\N	\N	\N	276
772	Raleigh	http://www.raleighusa.com/	\N	\N	\N	\N	A	\N	277
773	Ram	http://www.ram-bikes.com/eng/	\N	\N	\N	\N	\N	\N	997
774	Rambler	http://en.wikipedia.org/wiki/Rambler_(bicycle)	\N	\N	\N	\N	\N	\N	278
775	Rans Designs	http://www.rans.com/	\N	\N	\N	\N	\N	\N	279
776	RavX	http://ravx.com/	\N	\N	\N	\N	\N	\N	1409
777	Rawland Cycles	https://www.rawlandcycles.com/	\N	\N	\N	\N	\N	\N	1078
778	Razor	http://www.razor.com/	\N	\N	\N	\N	\N	\N	280
779	ReTale		\N	\N	\N	\N	\N	\N	745
780	Redline	http://www.redlinebicycles.com	\N	\N	\N	\N	\N	\N	955
781	Redlof		\N	\N	\N	\N	\N	\N	1041
782	Reflect Sports		\N	\N	\N	\N	\N	\N	741
783	Regina	http://www.reginabikes.it/	\N	\N	\N	\N	\N	\N	1076
784	Rema		\N	\N	\N	\N	\N	\N	742
785	Renthal		\N	\N	\N	\N	\N	\N	743
786	René Herse	http://www.renehersebicycles.com/	\N	\N	\N	\N	\N	\N	170
787	Republic	http://www.republicbike.com/	\N	\N	\N	\N	\N	\N	971
788	Republic of China		\N	\N	\N	\N	\N	\N	254
789	Resist		\N	\N	\N	\N	\N	\N	744
790	Retrospec	http://www.retrospecbicycles.com/	\N	\N	\N	\N	\N	\N	1180
791	Revelate Designs		\N	\N	\N	\N	\N	\N	746
792	Revolights	http://revolights.com/	\N	\N	\N	\N	\N	\N	1227
793	Rhythm		\N	\N	\N	\N	\N	\N	747
794	Ribble	http://www.ribblecycles.co.uk/	\N	\N	\N	\N	\N	\N	1046
795	Ride2		\N	\N	\N	\N	\N	\N	748
796	Ridgeback	http://www.ridgeback.co.uk/	\N	\N	\N	\N	\N	\N	281
797	Ridley	http://www.ridley-bikes.com/be/nl/intro	\N	\N	\N	\N	\N	\N	749
798	Riese und Müller	http://www.en.r-m.de/	\N	\N	\N	\N	\N	\N	283
799	Ritchey	http://ritcheylogic.com/	\N	\N	\N	\N	\N	\N	750
800	Ritte	http://rittecycles.com/	\N	\N	\N	\N	\N	\N	1051
801	Rivendell Bicycle Works	http://www.rivbike.com/	\N	\N	\N	\N	\N	\N	285
802	Roadmaster		\N	\N	\N	\N	\N	\N	30
803	Roberts Cycles	http://www.robertscycles.com/	\N	\N	\N	\N	\N	\N	286
804	Robin Hood	http://www.robinhoodcycles.com/	\N	\N	\N	\N	\N	\N	287
805	Rock Lobster	http://www.rocklobstercycles.com/	\N	\N	\N	\N	\N	\N	1135
806	Rock-N-Roll		\N	\N	\N	\N	\N	\N	751
807	RockShox		\N	\N	\N	\N	\N	\N	752
808	Rocky Mountain Bicycles		\N	\N	\N	\N	A	\N	270
809	Rocky Mounts		\N	\N	\N	\N	\N	\N	753
810	Rodriguez	http://www.rodbikes.com/	\N	\N	\N	\N	\N	\N	1124
811	Rohloff		\N	\N	\N	\N	\N	\N	754
812	Rokform		\N	\N	\N	\N	\N	\N	755
813	Rola		\N	\N	\N	\N	\N	\N	756
814	Rosko	http://rosko.cc	\N	\N	\N	\N	\N	\N	1478
815	Ross	http://www.randyrrross.com/	\N	\N	\N	\N	\N	\N	288
816	Rossignol		\N	\N	\N	\N	\N	\N	757
817	Rossin	http://rossinbikes.it/	\N	\N	\N	\N	\N	\N	1069
818	Rover Company	http://www.randyrrross.com/	\N	\N	\N	\N	\N	\N	289
819	Rowbike	http://www.rowbike.com/	\N	\N	\N	\N	\N	\N	290
820	Rox		\N	\N	\N	\N	\N	\N	758
821	Royal		\N	\N	\N	\N	\N	\N	759
822	Royce Union 	http://royceunionbikes.com/	\N	\N	\N	\N	\N	\N	1000
823	Rudge-Whitworth		\N	\N	\N	\N	\N	\N	291
824	Ryde	http://www.ryde.nl/	\N	\N	\N	\N	\N	\N	1493
825	S and M (S&M)	http://www.sandmbikes.com	\N	\N	\N	\N	\N	\N	361
826	S and S		\N	\N	\N	\N	\N	\N	762
827	SCOTT	http://www.scott-sports.com/global/en/	\N	\N	\N	\N	A	\N	296
828	SDG		\N	\N	\N	\N	\N	\N	770
829	SE Bikes (SE Racing)	http://www.sebikes.com	\N	\N	\N	\N	\N	\N	363
830	SKS		\N	\N	\N	\N	\N	\N	788
831	SLS3		\N	\N	\N	\N	\N	\N	790
832	SR Suntour		\N	\N	\N	\N	\N	\N	806
833	SRAM	http://www.sram.com	\N	\N	\N	\N	\N	\N	807
834	SST		\N	\N	\N	\N	\N	\N	808
835	START		\N	\N	\N	\N	\N	\N	811
836	SWEAT GUTR		\N	\N	\N	\N	\N	\N	831
837	Salomon		\N	\N	\N	\N	\N	\N	763
838	Salsa	http://salsacycles.com/	\N	\N	\N	\N	B	\N	764
839	Salt (BMX)	http://saltbmx.com	\N	\N	\N	\N	\N	\N	1502
840	SaltStick		\N	\N	\N	\N	\N	\N	766
841	Samchuly	http://www.samchuly.co.kr/main/main.html	\N	\N	\N	\N	\N	\N	292
842	Sancineto		\N	\N	\N	\N	\N	\N	1186
843	Sanderson	http://sanderson-cycles.com	\N	\N	\N	\N	\N	\N	1038
844	Santa Cruz	http://www.santacruzbicycles.com/en	\N	\N	\N	\N	B	\N	965
845	Santana Cycles	http://www.santanatandem.com/	\N	\N	\N	\N	\N	\N	293
846	Saracen Cycles	http://www.saracen.co.uk/	\N	\N	\N	\N	\N	\N	294
847	Saris		\N	\N	\N	\N	\N	\N	767
848	Satori	http://www.satoribike.com/	\N	\N	\N	\N	\N	\N	1489
849	Scania AB	http://scania.com/	\N	\N	\N	\N	\N	\N	295
850	Scattante	http://www.performancebike.com/webapp/wcs/stores/servlet/SubCategory_10052_10551_400759_-1_400345_400345	\N	\N	\N	\N	\N	\N	942
851	Schindelhauer	http://www.schindelhauerbikes.com/	\N	\N	\N	\N	\N	\N	1228
852	Schmidt (Wilfried Schmidt Maschinenbau)	http://www.nabendynamo.de/	\N	\N	\N	\N	\N	\N	1495
853	Schwalbe		\N	\N	\N	\N	\N	\N	768
854	Schwinn	http://www.schwinnbikes.com/	\N	\N	\N	\N	A	\N	117
855	Scotty		\N	\N	\N	\N	\N	\N	769
856	Seal Line		\N	\N	\N	\N	\N	\N	771
857	Sears Roebuck		\N	\N	\N	\N	\N	\N	1027
858	Season	http://seasonbikesbmx.com/	\N	\N	\N	\N	\N	\N	1020
859	Seattle Sports Company		\N	\N	\N	\N	\N	\N	772
860	Sekai		\N	\N	\N	\N	\N	\N	1143
861	Sekine		\N	\N	\N	\N	\N	\N	1058
862	Selle Anatomica	http://selleanatomica.com	\N	\N	\N	\N	\N	\N	1289
863	Selle Italia		\N	\N	\N	\N	\N	\N	773
864	Selle Royal		\N	\N	\N	\N	\N	\N	774
865	Selle San Marco		\N	\N	\N	\N	\N	\N	775
866	Serfas	https://www.serfas.com/	\N	\N	\N	\N	\N	\N	1399
867	Serotta	http://serotta.com/	\N	\N	\N	\N	\N	\N	297
868	Sette	http://www.settebikes.com/	\N	\N	\N	\N	\N	\N	1297
869	Seven Cycles	http://www.sevencycles.com/	\N	\N	\N	\N	\N	\N	298
870	Shadow Conspiracy	http://www.theshadowconspiracy.com/	\N	\N	\N	\N	\N	\N	845
871	Shelby Cycle Company		\N	\N	\N	\N	\N	\N	299
872	Sherpani		\N	\N	\N	\N	\N	\N	776
873	Shimano	http://bike.shimano.com	\N	\N	\N	\N	A	\N	366
874	Shinola	http://www.shinola.com/	\N	\N	\N	\N	B	\N	1096
875	Shogun		\N	\N	\N	\N	\N	\N	962
876	Shredder	http://lilshredder.com/	\N	\N	\N	\N	\N	\N	1010
877	Sidi		\N	\N	\N	\N	\N	\N	777
878	Sierra Designs		\N	\N	\N	\N	\N	\N	778
879	Sigma		\N	\N	\N	\N	\N	\N	779
880	Silca		\N	\N	\N	\N	\N	\N	780
881	Simcoe	http://simcoebicycles.com/	\N	\N	\N	\N	\N	\N	1392
882	Simple Green		\N	\N	\N	\N	\N	\N	781
883	Simplon	http://www.simplon.com	\N	\N	\N	\N	\N	\N	1270
884	Simson		\N	\N	\N	\N	\N	\N	300
885	Sinclair Research	http://www.sinclairzx.com/	\N	\N	\N	\N	\N	\N	301
886	Singletrack Solutions		\N	\N	\N	\N	\N	\N	782
887	Sinz		\N	\N	\N	\N	\N	\N	783
888	Six-Eleven	http://sixelevenbicycleco.com/	\N	\N	\N	\N	\N	\N	1353
889	SixSixOne		\N	\N	\N	\N	\N	\N	784
890	Skadi		\N	\N	\N	\N	\N	\N	785
891	Skinz		\N	\N	\N	\N	\N	\N	786
892	Skratch Labs		\N	\N	\N	\N	\N	\N	787
893	Skyway 		\N	\N	\N	\N	\N	\N	999
894	Slime		\N	\N	\N	\N	\N	\N	789
895	Smartwool		\N	\N	\N	\N	\N	\N	791
896	SockGuy		\N	\N	\N	\N	\N	\N	792
897	Sohrab Cycles	http://www.sohrab-cycles.com/index.php	\N	\N	\N	\N	\N	\N	303
898	Solex	http://www.solexworld.com/en/	\N	\N	\N	\N	\N	\N	305
899	Solio		\N	\N	\N	\N	\N	\N	794
900	Solé (Sole bicycles)	http://www.solebicycles.com/	\N	\N	\N	\N	\N	\N	304
901	Soma	http://www.somafab.com	\N	\N	\N	\N	B	\N	368
902	Somec	http://www.somec.com/	\N	\N	\N	\N	\N	\N	306
903	Sondors	http://gosondors.com/	\N	\N	\N	\N	\N	\N	1411
904	Sonoma	http://sonomabike.com/	\N	\N	\N	\N	\N	\N	1197
905	Soulcraft	http://www.soulcraftbikes.com	\N	\N	\N	\N	\N	\N	1267
906	Source		\N	\N	\N	\N	\N	\N	795
907	Spalding Bicycles		\N	\N	\N	\N	\N	\N	364
908	Sparta B.V.		\N	\N	\N	\N	\N	\N	21
909	Specialized	http://www.specialized.com/us/en/home/	\N	\N	\N	\N	A	\N	307
910	Spectrum	http://www.spectrum-cycles.com/	\N	\N	\N	\N	\N	\N	1276
911	Speedfil		\N	\N	\N	\N	\N	\N	797
912	Speedwell bicycles		\N	\N	\N	\N	\N	\N	308
913	Spenco		\N	\N	\N	\N	\N	\N	798
914	Spicer	http://www.spicercycles.com/	\N	\N	\N	\N	\N	\N	1207
915	SpiderTech		\N	\N	\N	\N	\N	\N	799
916	Spike	http://spikeparts.com/	\N	\N	\N	\N	\N	\N	1030
917	Spinskins		\N	\N	\N	\N	\N	\N	800
918	Splendid Cycles	http://www.splendidcycles.com/	\N	\N	\N	\N	\N	\N	1500
919	Spooky	http://www.spookybikes.com	\N	\N	\N	\N	\N	\N	953
920	SportRack		\N	\N	\N	\N	\N	\N	803
921	Sportlegs		\N	\N	\N	\N	\N	\N	801
922	Sportourer		\N	\N	\N	\N	\N	\N	802
923	Spot	http://spotbrand.com/	\N	\N	\N	\N	\N	\N	1053
924	Sprintech		\N	\N	\N	\N	\N	\N	804
925	Squeal Out		\N	\N	\N	\N	\N	\N	805
926	Squire	http://www.squirelocks.co.uk/security_advice/secure_your_bicycle.html	\N	\N	\N	\N	\N	\N	110
927	St. Tropez		\N	\N	\N	\N	\N	\N	1018
928	Stages cycling (Power meters)	http://www.stagescycling.com/stagespower	\N	\N	\N	\N	\N	\N	1360
929	Staiger	http://www.staiger-fahrrad.de/	\N	\N	\N	\N	\N	\N	12
930	Stan's No Tubes		\N	\N	\N	\N	\N	\N	809
931	Standard Byke	http://www.standardbyke.com/	\N	\N	\N	\N	\N	\N	1144
932	Stanley		\N	\N	\N	\N	\N	\N	810
933	Stanridge Speed	http://www.stanridgespeed.com/	\N	\N	\N	\N	\N	\N	1154
934	State Bicycle Co.	http://www.statebicycle.com/	\N	\N	\N	\N	\N	\N	961
935	Steadyrack		\N	\N	\N	\N	\N	\N	812
936	Steelman Cycles	http://www.steelmancycles.com/	\N	\N	\N	\N	\N	\N	1357
937	Stein		\N	\N	\N	\N	\N	\N	813
938	Stein Trikes	http://www.steintrikes.com/index.php	\N	\N	\N	\N	\N	\N	979
939	Stelber Cycle Corp		\N	\N	\N	\N	\N	\N	311
940	Stella		\N	\N	\N	\N	\N	\N	312
941	Stem CAPtain		\N	\N	\N	\N	\N	\N	814
942	Sterling Bicycle Co.		\N	\N	\N	\N	\N	\N	313
943	Steve Potts	http://www.stevepottsbicycles.com	\N	\N	\N	\N	\N	\N	983
944	HBBC (Huntington Beach Bicycle, Co)	http://hbbcinc.com/	\N	\N	\N	\N	\N	\N	1214
945	HED		\N	\N	\N	\N	\N	\N	576
946	HP Velotechnik	http://www.hpvelotechnik.com	\N	\N	\N	\N	\N	\N	1204
947	Haibike (Currietech)	http://www.currietech.com/	\N	\N	\N	\N	\N	\N	1279
948	Hallstrom	http://www.hallstrom.no/	\N	\N	\N	\N	\N	\N	1373
949	Halo		\N	\N	\N	\N	\N	\N	571
950	Hammer Nutrition		\N	\N	\N	\N	\N	\N	572
951	Hampsten Cycles	http://www.hampsten.com/	\N	\N	\N	\N	\N	\N	1371
952	Handsome Cycles	http://www.handsomecycles.com	\N	\N	\N	\N	B	\N	934
953	Handspun		\N	\N	\N	\N	\N	\N	573
954	Hanford	https://www.facebook.com/pages/Hanford-Cycles/230458813647205	\N	\N	\N	\N	\N	\N	1238
955	Haro	http://www.harobikes.com	\N	\N	\N	\N	A	\N	105
956	Harry Quinn		\N	\N	\N	\N	\N	\N	162
957	Harvey Cycle Works	http://harveykevin65.wix.com/harveycycleworks	\N	\N	\N	\N	\N	\N	1097
958	Hasa	http://www.hasa.com.tw/	\N	\N	\N	\N	\N	\N	1181
959	Hase bikes	http://hasebikes.com/	\N	\N	\N	\N	\N	\N	163
960	Hayes		\N	\N	\N	\N	\N	\N	574
961	Head		\N	\N	\N	\N	\N	\N	164
962	Headsweats		\N	\N	\N	\N	\N	\N	575
963	Heinkel	http://www.heinkeltourist.com/	\N	\N	\N	\N	\N	\N	166
964	Helkama	http://www.helkamavelox.fi/en/	\N	\N	\N	\N	\N	\N	165
965	Hercules Fahrrad GmbH & Co		\N	\N	\N	\N	\N	\N	11
966	Heritage	http://www.heritagebicycles.com/	\N	\N	\N	\N	\N	\N	995
967	Herkelmann	http://www.herkelmannbikes.com/	\N	\N	\N	\N	\N	\N	1216
968	Hero Cycles Ltd	http://www.herocycles.com/	\N	\N	\N	\N	\N	\N	169
969	Heron	http://www.heronbicycles.com/	\N	\N	\N	\N	\N	\N	1201
970	Hetchins	http://www.hetchins.org/	\N	\N	\N	\N	\N	\N	171
971	High Gear		\N	\N	\N	\N	\N	\N	577
972	Highland		\N	\N	\N	\N	\N	\N	578
973	Hija de la Coneja	https://www.facebook.com/hijadelaconeja	\N	\N	\N	\N	\N	\N	1155
974	Hillman	http://hillmancycles.com.au	\N	\N	\N	\N	\N	\N	172
975	Hinton Cycles	http://www.hintoncycles.com/	\N	\N	\N	\N	\N	\N	1377
976	Hirschfeld		\N	\N	\N	\N	\N	\N	1149
977	Hirzl		\N	\N	\N	\N	\N	\N	579
978	Hobson		\N	\N	\N	\N	\N	\N	580
979	Hoffman	http://hoffmanbikes.com/	\N	\N	\N	\N	\N	\N	951
980	Holdsworth	http://www.holdsworthbikes.co.uk/	\N	\N	\N	\N	\N	\N	174
981	Honey Stinger		\N	\N	\N	\N	\N	\N	581
982	Hope		\N	\N	\N	\N	\N	\N	582
983	House of Talents		\N	\N	\N	\N	\N	\N	583
984	Hozan		\N	\N	\N	\N	\N	\N	584
985	HubBub		\N	\N	\N	\N	\N	\N	585
986	Hudz		\N	\N	\N	\N	\N	\N	586
987	Huffy	http://www.huffybikes.com	\N	\N	\N	\N	A	\N	175
988	Hufnagel	http://www.hufnagelcycles.com/	\N	\N	\N	\N	\N	\N	1173
989	Humangear		\N	\N	\N	\N	\N	\N	587
990	Humber	http://en.wikipedia.org/wiki/Humber_(bicycle)	\N	\N	\N	\N	\N	\N	176
991	Humble Frameworks	http://www.humbleframeworks.cc	\N	\N	\N	\N	\N	\N	954
992	Hunter	http://www.huntercycles.com/	\N	\N	\N	\N	\N	\N	972
993	Hurricane Components		\N	\N	\N	\N	\N	\N	588
994	Hurtu	http://en.wikipedia.org/wiki/Hurtu	\N	\N	\N	\N	\N	\N	177
995	Hutchinson		\N	\N	\N	\N	\N	\N	589
996	Hyalite Equipment		\N	\N	\N	\N	\N	\N	590
997	Hydrapak		\N	\N	\N	\N	\N	\N	591
998	Hyper	http://www.hyperbicycles.com/	\N	\N	\N	\N	\N	\N	1136
999	IBEX	http://ibexbikes.com/	\N	\N	\N	\N	\N	\N	592
1000	ICE Trikes (Inspired Cycle Engineering )	http://www.icetrikes.co/	\N	\N	\N	\N	\N	\N	1109
1001	IMBA		\N	\N	\N	\N	\N	\N	595
1002	IRD (Interloc Racing Design)	http://www.interlocracing.com/	\N	\N	\N	\N	\N	\N	1492
1003	IRO Cycles	http://www.irocycle.com	\N	\N	\N	\N	\N	\N	938
1004	ISM		\N	\N	\N	\N	\N	\N	601
1005	IZIP (Currietech)	http://www.currietech.com/	\N	\N	\N	\N	\N	\N	1278
1006	Ibis	http://www.ibiscycles.com/bikes/	\N	\N	\N	\N	\N	\N	179
1007	Ice Trekkers		\N	\N	\N	\N	\N	\N	593
1008	IceToolz		\N	\N	\N	\N	\N	\N	594
1009	Ideal Bikes	http://www.idealbikes.net/	\N	\N	\N	\N	\N	\N	180
1010	Identiti	http://www.identitibikes.com/	\N	\N	\N	\N	\N	\N	1070
1011	Incredibell		\N	\N	\N	\N	\N	\N	596
1012	Independent Fabrication	http://www.ifbikes.com/	\N	\N	\N	\N	\N	\N	184
1013	Industrieverband Fahrzeugbau		\N	\N	\N	\N	\N	\N	182
1014	Industry Nine		\N	\N	\N	\N	\N	\N	597
1015	Infini		\N	\N	\N	\N	\N	\N	598
1016	Inglis (Retrotec)	http://ingliscycles.com/	\N	\N	\N	\N	\N	\N	1352
1017	Innerlight Cycles	http://www.innerlightcycles.com/	\N	\N	\N	\N	\N	\N	1184
1018	Innova		\N	\N	\N	\N	\N	\N	599
1019	Inspired	http://www.inspiredbicycles.com/	\N	\N	\N	\N	\N	\N	1405
1020	Intense	http://intensecycles.com/	\N	\N	\N	\N	\N	\N	600
1021	Iride Bicycles	http://www.irideusa.com/	\N	\N	\N	\N	\N	\N	185
1022	Iron Horse Bicycles	http://www.ironhorsebikes.com/	\N	\N	\N	\N	\N	\N	116
1023	Islabikes	http://www.islabikes.com/	\N	\N	\N	\N	\N	\N	1063
1024	Issimo Designs		\N	\N	\N	\N	\N	\N	602
1025	Italvega	http://en.wikipedia.org/wiki/Italvega	\N	\N	\N	\N	\N	\N	186
1026	Itera plastic bicycle		\N	\N	\N	\N	\N	\N	187
1027	Iver Johnson		\N	\N	\N	\N	\N	\N	188
1028	Iverson		\N	\N	\N	\N	\N	\N	189
1029	JMC Bicycles	http://www.jmccycles.com/	\N	\N	\N	\N	\N	\N	190
1030	JP Weigle's		\N	\N	\N	\N	\N	\N	608
1031	Jagwire		\N	\N	\N	\N	\N	\N	603
1032	Jamis	http://www.jamisbikes.com/usa/index.html	\N	\N	\N	\N	A	\N	201
1033	Jan Jansen	http://www.janjanssen.nl/index.php	\N	\N	\N	\N	\N	\N	1123
1034	Jandd		\N	\N	\N	\N	\N	\N	604
1035	Javelin	http://www.javbike.com/	\N	\N	\N	\N	\N	\N	1194
1036	Jelly Belly		\N	\N	\N	\N	\N	\N	605
1037	JetBoil		\N	\N	\N	\N	\N	\N	606
1038	Jittery Joe's		\N	\N	\N	\N	\N	\N	607
1039	John Cherry bicycles	http://www.sandsmachine.com/bp_chery.htm	\N	\N	\N	\N	\N	\N	1085
1040	John Deere 		\N	\N	\N	\N	\N	\N	998
1041	Jorg & Olif	http://jorgandolif.com	\N	\N	\N	\N	\N	\N	1222
1042	Juiced Riders	http://www.juicedriders.com/	\N	\N	\N	\N	\N	\N	1406
1043	Juliana Bicycles	http://www.julianabicycles.com/en/us	\N	\N	\N	\N	\N	\N	1241
1044	Cannondale	http://www.cannondale.com/	\N	\N	\N	\N	A	\N	62
1045	Canyon bicycles	http://www.canyon.com/	\N	\N	\N	\N	\N	\N	63
1046	Cardiff	http://www.cardiffltd.com/	\N	\N	\N	\N	\N	\N	1490
1047	Carmichael Training Systems		\N	\N	\N	\N	\N	\N	448
1048	Carrera bicycles	http://www.carrera-podium.it/	\N	\N	\N	\N	\N	\N	64
1049	CatEye		\N	\N	\N	\N	\N	\N	449
1050	Catrike	http://www.catrike.com/	\N	\N	\N	\N	\N	\N	66
1051	Cayne	http://www.sun.bike/	\N	\N	\N	\N	\N	\N	1179
1052	Centurion	http://www.centurion.de/en_int	\N	\N	\N	\N	\N	\N	68
1053	CeramicSpeed		\N	\N	\N	\N	\N	\N	451
1054	Cervélo	http://www.cervelo.com/en/	\N	\N	\N	\N	B	\N	69
1055	Chadwick		\N	\N	\N	\N	\N	\N	452
1056	Challenge		\N	\N	\N	\N	\N	\N	453
1057	Charge	http://www.chargebikes.com/	\N	\N	\N	\N	\N	\N	940
1058	Chariot	http://www.thule.com/en-us/us/products/active-with-kids	\N	\N	\N	\N	\N	\N	1129
1059	Chase		\N	\N	\N	\N	\N	\N	454
1060	Chater-Lea		\N	\N	\N	\N	\N	\N	70
1061	Chicago Bicycle Company		\N	\N	\N	\N	\N	\N	71
1062	Chris King		\N	\N	\N	\N	\N	\N	455
1063	Christiania Bikes	http://christianiabikes.com/en/	\N	\N	\N	\N	\N	\N	1247
1064	Chromag	http://www.chromagbikes.com	\N	\N	\N	\N	\N	\N	456
1065	Cielo	http://cielo.chrisking.com/	\N	\N	\N	\N	\N	\N	1218
1066	Cignal		\N	\N	\N	\N	\N	\N	1084
1067	Cilo		\N	\N	\N	\N	\N	\N	73
1068	Cinelli	http://www.cinelli-usa.com/	\N	\N	\N	\N	\N	\N	74
1069	Ciocc	http://www.ciocc.it/	\N	\N	\N	\N	\N	\N	1130
1070	Citizen Bike	http://www.citizenbike.com/	\N	\N	\N	\N	\N	\N	1068
1071	City Bicycles Company	http://citybicycleco.com	\N	\N	\N	\N	\N	\N	937
1072	Civia	http://www.civiacycles.com	\N	\N	\N	\N	\N	\N	372
1073	Clark-Kent		\N	\N	\N	\N	\N	\N	75
1074	Claud Butler	http://claudbutler.co.uk/	\N	\N	\N	\N	\N	\N	76
1075	Clean Bottle		\N	\N	\N	\N	\N	\N	457
1076	Clement		\N	\N	\N	\N	\N	\N	458
1077	Cloud Nine		\N	\N	\N	\N	\N	\N	459
1078	Club Roost		\N	\N	\N	\N	\N	\N	460
1079	Co-Motion	http://www.co-motion.com/	\N	\N	\N	\N	\N	\N	78
1080	Coker Tire	http://www.cokertire.com/	\N	\N	\N	\N	\N	\N	79
1081	Colnago	http://www.colnago.com/bicycles/	\N	\N	\N	\N	B	\N	80
1082	Colony	http://www.colonybmx.com	\N	\N	\N	\N	\N	\N	1225
1083	Colossi	http://www.colossicycling.com/	\N	\N	\N	\N	\N	\N	1374
1084	Columbia		\N	\N	\N	\N	\N	\N	1146
1085	Columbus Tubing	http://www.columbustubi.com/	\N	\N	\N	\N	\N	\N	1295
1086	Competition Cycles Services		\N	\N	\N	\N	\N	\N	461
1087	Condor	http://www.condorcycles.com/	\N	\N	\N	\N	\N	\N	959
1088	Conor	http://www.conorbikes.com/	\N	\N	\N	\N	\N	\N	978
1089	Continental		\N	\N	\N	\N	\N	\N	462
1090	Contour Sport		\N	\N	\N	\N	\N	\N	463
1091	Cook Bros. Racing		\N	\N	\N	\N	\N	\N	1060
1092	Cooper Bikes	http://www.cooperbikes.com	\N	\N	\N	\N	\N	\N	936
1093	Corima	http://www.corima.com/	\N	\N	\N	\N	\N	\N	81
1094	Corratec	http://www.corratec.com/	\N	\N	\N	\N	\N	\N	1205
1095	Cortina Cycles	http://www.cortinacycles.com/	\N	\N	\N	\N	\N	\N	82
1096	Cove	http://covebike.com/	\N	\N	\N	\N	\N	\N	1139
1097	Craft		\N	\N	\N	\N	\N	\N	464
1098	Crank Brothers		\N	\N	\N	\N	\N	\N	465
1099	Crank2	http://www.crank-2.com	\N	\N	\N	\N	\N	\N	1220
1100	Crazy Creek		\N	\N	\N	\N	\N	\N	466
1101	Create	http://www.createbikes.com/	\N	\N	\N	\N	\N	\N	1095
1102	Creme Cycles	http://cremecycles.com	\N	\N	\N	\N	\N	\N	1224
1103	Crescent Moon		\N	\N	\N	\N	\N	\N	467
1104	Crew	http://crewbikeco.com/	\N	\N	\N	\N	\N	\N	1253
1105	Critical Cycles	http://www.criticalcycles.com/	\N	\N	\N	\N	\N	\N	935
1106	Crumpton	http://www.crumptoncycles.com/	\N	\N	\N	\N	\N	\N	1348
1107	Cruzbike	http://cruzbike.com/	\N	\N	\N	\N	\N	\N	1391
1108	Cube	http://www.cube.eu/en/cube-bikes/	\N	\N	\N	\N	\N	\N	83
1109	CueClip		\N	\N	\N	\N	\N	\N	470
1110	Cuevas	https://www.facebook.com/CUEVAS-BIKES-209970107454/	\N	\N	\N	\N	\N	\N	1488
1111	Cult	http://www.cultcrew.com	\N	\N	\N	\N	\N	\N	362
1112	Currie Technology (Currietech)	http://www.currietech.com/	\N	\N	\N	\N	\N	\N	1115
1113	Currys	http://www.currys.co.uk/gbuk/index.html	\N	\N	\N	\N	\N	\N	84
1114	Curtlo	http://www.curtlo.com/	\N	\N	\N	\N	\N	\N	1397
1115	Cyclamatic		\N	\N	\N	\N	\N	\N	1367
1116	Cycle Dog		\N	\N	\N	\N	\N	\N	472
1117	Cycle Force Group	http://www.cyclefg.com/	\N	\N	\N	\N	\N	\N	89
1118	Cycle Stuff		\N	\N	\N	\N	\N	\N	473
1119	CycleAware		\N	\N	\N	\N	\N	\N	474
1120	CycleOps		\N	\N	\N	\N	\N	\N	475
1121	CyclePro		\N	\N	\N	\N	\N	\N	964
1122	Cycles Fanatic	http://www.cyclesfanatic.com/	\N	\N	\N	\N	\N	\N	1291
1123	Cycles Follis		\N	\N	\N	\N	\N	\N	145
1124	Cycles Toussaint	http://www.cyclestoussaint.com/	\N	\N	\N	\N	\N	\N	1385
1125	Cycleurope	http://www.cycleurope.com	\N	\N	\N	\N	\N	\N	4
1126	Cyclo		\N	\N	\N	\N	\N	\N	476
1127	Cycloc		\N	\N	\N	\N	\N	\N	477
1128	Cyfac	http://www.cyfac.fr/index.aspx	\N	\N	\N	\N	\N	\N	90
1129	CygoLite		\N	\N	\N	\N	\N	\N	478
1130	Cytosport		\N	\N	\N	\N	\N	\N	479
1131	DAJO		\N	\N	\N	\N	\N	\N	480
1132	DEAN	http://www.deanbikes.com	\N	\N	\N	\N	\N	\N	1203
1133	DHS	http://www.dhsbike.hu/	\N	\N	\N	\N	\N	\N	1127
1134	DIG BMX		\N	\N	\N	\N	\N	\N	493
1135	DK Bikes	http://www.dkbicycles.com/	\N	\N	\N	\N	\N	\N	1132
1136	DMR Bikes	http://www.dmrbikes.com/	\N	\N	\N	\N	\N	\N	496
1137	DNP		\N	\N	\N	\N	\N	\N	497
1138	DT Swiss		\N	\N	\N	\N	\N	\N	498
1139	DZ Nuts		\N	\N	\N	\N	\N	\N	501
1140	Da Bomb Bikes	http://www.dabombbike.com/	\N	\N	\N	\N	\N	\N	91
1141	Daccordi	http://www.daccordicicli.com/	\N	\N	\N	\N	\N	\N	1292
1142	Dahon	http://www.dahon.com/	\N	\N	\N	\N	B	\N	92
1143	Davidson	http://davidsonbicycles.com/	\N	\N	\N	\N	\N	\N	1219
1144	K-Edge		\N	\N	\N	\N	\N	\N	609
1145	K2	http://www.k2bike.com/	\N	\N	\N	\N	\N	\N	192
1146	KBC		\N	\N	\N	\N	\N	\N	613
1147	KHS Bicycles	http://khsbicycles.com/	\N	\N	\N	\N	\N	\N	196
1148	KMC		\N	\N	\N	\N	\N	\N	621
1149	KS		\N	\N	\N	\N	\N	\N	626
1150	KT Tape		\N	\N	\N	\N	\N	\N	627
1151	KTM	http://www.ktm.com/us/ready-to-race.html	\N	\N	\N	\N	\N	\N	208
1152	KW Bicycle	http://www.kwcycles.com/	\N	\N	\N	\N	\N	\N	1107
1153	Kalkhoff	http://www.kalkhoff-bikes.com/	\N	\N	\N	\N	\N	\N	977
1154	Kalloy		\N	\N	\N	\N	\N	\N	610
1155	Katadyn		\N	\N	\N	\N	\N	\N	611
1156	Kazam		\N	\N	\N	\N	\N	\N	612
1157	Keith Bontrager	http://bontrager.com/history	\N	\N	\N	\N	\N	\N	46
1158	Kelly	http://www.kellybike.com/index.html	\N	\N	\N	\N	\N	\N	1487
1159	Kellys Bicycles	http://www.kellysbike.com/	\N	\N	\N	\N	\N	\N	1116
1160	Kenda		\N	\N	\N	\N	\N	\N	614
1161	Kent	http://www.kentbicycles.com/	\N	\N	\N	\N	\N	\N	193
1162	Kestrel	http://www.kestrelbicycles.com/	\N	\N	\N	\N	\N	\N	194
1163	Kettler	http://www.kettler.co.uk/	\N	\N	\N	\N	\N	\N	195
1164	Kind Bar		\N	\N	\N	\N	\N	\N	615
1165	Kinesis	http://www.kinesisbikes.co.uk/	\N	\N	\N	\N	\N	\N	616
1166	Kinesis Industry	http://www.kinesis.com.tw/	\N	\N	\N	\N	\N	\N	198
1167	Kinetic		\N	\N	\N	\N	\N	\N	617
1168	Kinetic Koffee		\N	\N	\N	\N	\N	\N	618
1169	Kink	http://www.kinkbmx.com	\N	\N	\N	\N	\N	\N	358
1170	Kinn	http://www.kinnbikes.com/	\N	\N	\N	\N	\N	\N	1403
1171	Kirk	http://www.kirkframeworks.com/	\N	\N	\N	\N	\N	\N	1150
1172	Kish Fabrication	http://www.kishbike.com/	\N	\N	\N	\N	\N	\N	1029
1173	Kiss My Face		\N	\N	\N	\N	\N	\N	619
1174	Klean Kanteen		\N	\N	\N	\N	\N	\N	620
1175	Klein Bikes		\N	\N	\N	\N	A	\N	325
1176	Knog		\N	\N	\N	\N	\N	\N	622
1177	Knolly	http://knollybikes.com/	\N	\N	\N	\N	\N	\N	1213
1178	Koga-Miyata	http://www.koga.com/koga_uk/	\N	\N	\N	\N	\N	\N	20
1179	Kogel	http://http://www.kogel.cc/	\N	\N	\N	\N	\N	\N	1507
1180	Kogswell Cycles		\N	\N	\N	\N	\N	\N	205
1181	Kona	http://www.konaworld.com/	\N	\N	\N	\N	B	\N	203
1182	Kool Kovers		\N	\N	\N	\N	\N	\N	623
1183	Kool-Stop		\N	\N	\N	\N	\N	\N	624
1184	Kreitler		\N	\N	\N	\N	\N	\N	625
1185	Kron	http://kronbikes.com/	\N	\N	\N	\N	\N	\N	1190
1186	Kronan	http://www.kronan.com/en/cykel	\N	\N	\N	\N	\N	\N	206
1187	Kross SA	http://www.kross.pl/	\N	\N	\N	\N	\N	\N	207
1188	Kryptonite	http://www.kryptonitelock.com/Pages/Home.aspx	\N	\N	\N	\N	\N	\N	106
1189	Kuat		\N	\N	\N	\N	\N	\N	628
1190	Kuota	http://www.kuota.it/index.php	\N	\N	\N	\N	\N	\N	209
1191	Kustom Kruiser		\N	\N	\N	\N	\N	\N	1140
1192	Kuwahara	http://kuwahara-bike.com/	\N	\N	\N	\N	\N	\N	210
1193	LDG (Livery Design Gruppe)	http://liverydesigngruppe.com/	\N	\N	\N	\N	\N	\N	1230
1194	LOW//	http://lowbicycles.com/	\N	\N	\N	\N	\N	\N	1026
1195	Land Shark	http://landsharkbicycles.com/	\N	\N	\N	\N	\N	\N	1344
1196	Lapierre	http://www.lapierre-bikes.co.uk/	\N	\N	\N	\N	\N	\N	929
1197	Larry Vs Harry	http://www.larryvsharry.com/english/	\N	\N	\N	\N	\N	\N	1015
1198	Laurin & Klement		\N	\N	\N	\N	\N	\N	212
1199	Lazer		\N	\N	\N	\N	\N	\N	629
1200	LeMond Racing Cycles	https://en.wikipedia.org/wiki/LeMond_Racing_Cycles	\N	\N	\N	\N	\N	\N	213
1201	Leader Bikes	http://www.leaderbikeusa.com	\N	\N	\N	\N	\N	\N	933
1202	Leg Lube		\N	\N	\N	\N	\N	\N	630
1203	Legacy Frameworks	http://legacyframeworks.com/	\N	\N	\N	\N	\N	\N	952
1204	Leopard	http://www.leopardcycles.com/	\N	\N	\N	\N	\N	\N	1372
1205	Lezyne		\N	\N	\N	\N	\N	\N	631
1206	Light My Fire		\N	\N	\N	\N	\N	\N	633
1207	Light and Motion		\N	\N	\N	\N	\N	\N	632
1208	Lightning Cycle Dynamics	http://www.lightningbikes.com/	\N	\N	\N	\N	\N	\N	1035
1209	Lightspeed	http://www.litespeed.com/	\N	\N	\N	\N	\N	\N	1111
1210	Linus	http://www.linusbike.com/	\N	\N	\N	\N	B	\N	950
1211	Liotto (Cicli Liotto Gino & Figli)	http://www.liotto.com/	\N	\N	\N	\N	\N	\N	1261
1212	Litespeed	http://www.litespeed.com/	\N	\N	\N	\N	\N	\N	215
1213	Liteville	http://www.liteville.de/	\N	\N	\N	\N	\N	\N	1240
1214	Lizard Skins		\N	\N	\N	\N	\N	\N	634
1215	Loctite		\N	\N	\N	\N	\N	\N	635
1216	Loekie	http://www.loekie.nl/	\N	\N	\N	\N	\N	\N	19
1217	Lonely Planet		\N	\N	\N	\N	\N	\N	636
1218	Look	http://www.lookcycle.com/	\N	\N	\N	\N	\N	\N	369
1219	Lotus		\N	\N	\N	\N	\N	\N	217
1220	Louis Garneau	http://www.louisgarneau.com	\N	\N	\N	\N	\N	\N	637
1221	Louison Bobet		\N	\N	\N	\N	\N	\N	216
1222	Lycoming Engines	http://www.lycoming.textron.com/	\N	\N	\N	\N	\N	\N	94
1223	Lynskey	http://www.lynskeyperformance.com/	\N	\N	\N	\N	\N	\N	1088
1224	M Essentials		\N	\N	\N	\N	\N	\N	638
1225	MBK	http://mbk-cykler.dk/	\N	\N	\N	\N	\N	\N	1301
1226	MEC (Mountain Equipment Co-op)	http://www.mec.ca/	\N	\N	\N	\N	\N	\N	1157
1227	MKS		\N	\N	\N	\N	\N	\N	655
1228	MMR	http://www.mmrbikes.com/	\N	\N	\N	\N	\N	\N	1264
1229	MRP		\N	\N	\N	\N	\N	\N	661
1230	MSR		\N	\N	\N	\N	\N	\N	662
1231	MTI Adventurewear		\N	\N	\N	\N	\N	\N	663
1232	Madsen	http://www.madsencycles.com/	\N	\N	\N	\N	\N	\N	1117
1233	Madwagon		\N	\N	\N	\N	\N	\N	1151
1234	Magellan		\N	\N	\N	\N	\N	\N	639
1235	Magna	http://www.magnabike.com/	\N	\N	\N	\N	\N	\N	122
1236	Malvern Star	http://www.malvernstar.com.au/	\N	\N	\N	\N	\N	\N	218
1237	ManKind	http://mankindbmx.com/	\N	\N	\N	\N	\N	\N	1092
1238	Mango	http://www.mangobikes.co.uk/	\N	\N	\N	\N	\N	\N	1195
1239	Manhattan	http://www.manhattancruisers.com/	\N	\N	\N	\N	\N	\N	969
1240	Manitou		\N	\N	\N	\N	\N	\N	640
1241	Map Bicycles	http://www.mapbicycles.com/	\N	\N	\N	\N	\N	\N	1290
1242	Maraton	http://www.bikemaraton.com/	\N	\N	\N	\N	\N	\N	993
1243	Marin Bikes	http://www.marinbikes.com/2013/	\N	\N	\N	\N	B	\N	219
1244	TriSlide		\N	\N	\N	\N	\N	\N	862
1245	TriSwim		\N	\N	\N	\N	\N	\N	863
1246	Tribe Bicycle Co	http://tribebicycles.com/	\N	\N	\N	\N	\N	\N	1393
1247	Trigger Point		\N	\N	\N	\N	\N	\N	860
1248	Trik Topz		\N	\N	\N	\N	\N	\N	861
1249	Trinx	http://www.trinx.com/	\N	\N	\N	\N	\N	\N	1287
1250	Triumph Cycle		\N	\N	\N	\N	\N	\N	326
1251	TruVativ		\N	\N	\N	\N	\N	\N	865
1252	Tubasti		\N	\N	\N	\N	\N	\N	866
1253	Tubus	http://www.tubus.com/	\N	\N	\N	\N	\N	\N	1494
1254	Tufo		\N	\N	\N	\N	\N	\N	867
1255	Tunturi		\N	\N	\N	\N	\N	\N	14
1256	Turin	http://www.turinbicycle.com/	\N	\N	\N	\N	\N	\N	1341
1257	Turner Bicycles	http://www.turnerbikes.com/	\N	\N	\N	\N	\N	\N	328
1258	Twin Six	https://www.twinsix.com/	\N	\N	\N	\N	\N	\N	868
1259	TwoFish		\N	\N	\N	\N	\N	\N	869
1260	UCLEAR		\N	\N	\N	\N	\N	\N	871
1261	UCO		\N	\N	\N	\N	\N	\N	872
1262	Uline		\N	\N	\N	\N	\N	\N	873
1263	Ultimate Survival Technologies		\N	\N	\N	\N	\N	\N	874
1264	UltraPaws		\N	\N	\N	\N	\N	\N	875
1265	Umberto Dei	http://umbertodei.it/index.htm	\N	\N	\N	\N	\N	\N	1004
1266	Unior		\N	\N	\N	\N	\N	\N	876
1267	Univega		\N	\N	\N	\N	\N	\N	329
1268	Unknown		\N	\N	\N	\N	\N	\N	877
1269	Upland	http://www.uplandbicycles.com/	\N	\N	\N	\N	\N	\N	1198
1270	Urago		\N	\N	\N	\N	\N	\N	330
1271	Utopia		\N	\N	\N	\N	\N	\N	331
1272	VP Components		\N	\N	\N	\N	\N	\N	891
1273	VSF Fahrradmanufaktur	http://www.fahrradmanufaktur.de	\N	\N	\N	\N	\N	\N	1248
1274	Valdora		\N	\N	\N	\N	\N	\N	332
1275	Van Dessel	http://www.vandesselsports.com/	\N	\N	\N	\N	\N	\N	1272
1276	Van Herwerden	http://www.vanherwerden.nl/	\N	\N	\N	\N	\N	\N	1047
1277	Vanilla	http://www.thevanillaworkshop.com/	\N	\N	\N	\N	\N	\N	1251
1278	Vanmoof	http://vanmoof.com/	\N	\N	\N	\N	\N	\N	1231
1279	Vargo		\N	\N	\N	\N	\N	\N	878
1280	Vassago	http://www.vassagocycles.com/	\N	\N	\N	\N	\N	\N	1055
1281	Vee Rubber		\N	\N	\N	\N	\N	\N	880
1282	Velo		\N	\N	\N	\N	\N	\N	881
1283	Velo Orange	http://www.velo-orange.com/	\N	\N	\N	\N	\N	\N	882
1284	Velo Press		\N	\N	\N	\N	\N	\N	883
1285	Velo Vie		\N	\N	\N	\N	\N	\N	335
1286	Velocity		\N	\N	\N	\N	\N	\N	884
1287	Velomotors		\N	\N	\N	\N	\N	\N	333
1288	Velorbis	http://www.velorbis.com/velorbis-collections/velorbis-bicycles	\N	\N	\N	\N	\N	\N	982
1289	Velox		\N	\N	\N	\N	\N	\N	885
1290	Verde	http://verdebmx.com/2013completes/	\N	\N	\N	\N	\N	\N	968
1291	Versa		\N	\N	\N	\N	\N	\N	886
1292	Vicini	http://www.vicini.it	\N	\N	\N	\N	\N	\N	1481
1293	Vilano	http://www.vilanobikes.com	\N	\N	\N	\N	\N	\N	981
1294	Villy Customs		\N	\N	\N	\N	\N	\N	337
1295	Vincero Design		\N	\N	\N	\N	\N	\N	887
1296	Vindec High Riser		\N	\N	\N	\N	\N	\N	338
1297	Viner		\N	\N	\N	\N	\N	\N	1514
1298	Virtue	http://www.virtuebike.com	\N	\N	\N	\N	\N	\N	956
1299	Viscount		\N	\N	\N	\N	\N	\N	1082
1300	Vision	http://www.visiontechusa.com/	\N	\N	\N	\N	\N	\N	888
1301	Vittoria		\N	\N	\N	\N	\N	\N	889
1302	Vitus		\N	\N	\N	\N	\N	\N	339
1303	Viva	http://www.vivabikes.com/	\N	\N	\N	\N	\N	\N	1188
1304	Vivente	http://www.viventebikes.com/	\N	\N	\N	\N	\N	\N	1192
1305	Volae		\N	\N	\N	\N	\N	\N	1249
1306	Volagi	http://www.volagi.com/	\N	\N	\N	\N	\N	\N	1106
1307	Volume		\N	\N	\N	\N	\N	\N	890
1308	Voodoo	http://voodoocycles.net/	\N	\N	\N	\N	B	\N	1089
1309	Vortrieb	http://www.vortrieb.com/	\N	\N	\N	\N	\N	\N	1075
1310	VéloSoleX		\N	\N	\N	\N	\N	\N	334
1311	WD-40 Bike		\N	\N	\N	\N	\N	\N	895
1312	WTB		\N	\N	\N	\N	\N	\N	913
1313	Wabi Cycles	http://www.wabicycles.com/index.html	\N	\N	\N	\N	\N	\N	996
1314	Wahoo Fitness		\N	\N	\N	\N	\N	\N	892
1315	Wald		\N	\N	\N	\N	\N	\N	893
1316	Walking Bird		\N	\N	\N	\N	\N	\N	894
1317	Waterford	http://waterfordbikes.com/w/	\N	\N	\N	\N	\N	\N	341
1318	WeThePeople		\N	\N	\N	\N	\N	\N	342
1319	WeeRide	http://www.weeride.com/	\N	\N	\N	\N	\N	\N	1039
1320	Weehoo	http://rideweehoo.com/	\N	\N	\N	\N	\N	\N	1118
1321	Wellgo		\N	\N	\N	\N	\N	\N	896
1322	Wheels Manufacturing		\N	\N	\N	\N	\N	\N	897
1323	Wheelsmith		\N	\N	\N	\N	\N	\N	898
1324	Where to Bike		\N	\N	\N	\N	\N	\N	899
1325	Whisky Parts Co		\N	\N	\N	\N	\N	\N	900
1326	Whispbar		\N	\N	\N	\N	\N	\N	901
1327	White Bros		\N	\N	\N	\N	\N	\N	902
1328	White Lightning		\N	\N	\N	\N	\N	\N	903
1329	Wigwam		\N	\N	\N	\N	\N	\N	904
1330	Wilderness Trail Bikes		\N	\N	\N	\N	\N	\N	343
1331	Wilier Triestina	http://www.wilier.com/	\N	\N	\N	\N	\N	\N	344
1332	Williams		\N	\N	\N	\N	\N	\N	905
1333	Willworx		\N	\N	\N	\N	\N	\N	906
1334	Win		\N	\N	\N	\N	\N	\N	907
1335	Windsor	http://www.windsorbicycles.com/	\N	\N	\N	\N	\N	\N	946
1336	Winora	http://www.winora.de/	\N	\N	\N	\N	\N	\N	932
1337	Winter Bicycles	http://www.winterbicycles.com/	\N	\N	\N	\N	\N	\N	1052
1338	Wippermann		\N	\N	\N	\N	\N	\N	908
1339	Witcomb Cycles		\N	\N	\N	\N	\N	\N	345
1340	Witz		\N	\N	\N	\N	\N	\N	909
1341	Wooden Bike Coffee		\N	\N	\N	\N	\N	\N	910
1342	WordLock	http://wordlock.com/	\N	\N	\N	\N	\N	\N	1254
1343	WorkCycles	http://www.workcycles.com/	\N	\N	\N	\N	\N	\N	987
1344	Adler	\N	\N	\N	t	https://en.wikipedia.org/wiki/Adler_(automobile)	\N	\N	\N
1345	AIST	\N	\N	\N	f	https://en.wikipedia.org/wiki/Aist_Bicycles	\N	\N	\N
1346	Aprilia	\N	\N	\N	f	https://en.wikipedia.org/wiki/Aprilia	\N	\N	\N
1347	Ariel	\N	\N	\N	t	https://en.wikipedia.org/wiki/Ariel_(vehicle)	\N	\N	\N
1348	Baltik vairas	\N	\N	\N	f	https://en.wikipedia.org/wiki/Baltik_vairas	\N	\N	\N
1349	Barnes Cycle Company	\N	\N	\N	t	https://en.wikipedia.org/wiki/History_of_cycling_in_Syracuse,_New_York#Barnes_Cycle_Company	\N	\N	\N
1350	Battaglin	\N	\N	\N	f	https://en.wikipedia.org/wiki/Giovanni_Battaglin#Retirement	\N	\N	\N
1351	Berlin &amp; Racycle Manufacturing Company	\N	\N	\N	t	https://en.wikipedia.org/wiki/The_Arthur_Pequegnat_Clock_Company	\N	\N	\N
1352	Bontrager	\N	\N	\N	f	https://en.wikipedia.org/wiki/Keith_Bontrager#Bicycles	\N	\N	\N
1353	Bootie	\N	\N	\N	f	https://en.wikipedia.org/wiki/Bootie_(bicycle)	\N	\N	\N
1354	Bradbury	\N	\N	\N	t	https://en.wikipedia.org/wiki/Bradbury_Motor_Cycles	\N	\N	\N
1355	BSA	\N	\N	\N	f	https://en.wikipedia.org/wiki/Birmingham_Small_Arms_Company	\N	\N	\N
1356	B’Twin	\N	\N	\N	f	https://en.wikipedia.org/wiki/Decathlon_Group	\N	\N	\N
1357	Clément	\N	\N	\N	t	https://en.wikipedia.org/wiki/Adolphe_Cl%C3%A9ment#C.C3.A9ment_cycles	\N	\N	\N
1358	Coventry-Eagle	\N	\N	\N	f	https://en.wikipedia.org/wiki/Coventry-Eagle	\N	\N	\N
1359	Cycleuropa Group	\N	\N	\N	f	https://en.wikipedia.org/wiki/Cycleuropa_Group	\N	\N	\N
1360	Defiance Cycle Company	\N	\N	\N	f	https://en.wikipedia.org/wiki/Defiance_Cycle_Company	\N	\N	\N
1361	Demorest	\N	\N	\N	f	https://en.wikipedia.org/wiki/Lycoming_Engines#Sewing_machines.2C_bicycles_and_fashion	\N	\N	\N
1362	Dunelt	\N	\N	\N	t	https://en.wikipedia.org/wiki/Dunelt_Motorcycles	\N	\N	\N
1363	Ērenpreiss Bicycles	\N	\N	\N	f	https://en.wikipedia.org/wiki/%C4%92renpreiss_Bicycles	\N	\N	\N
1364	Excelsior	\N	\N	\N	t	https://en.wikipedia.org/wiki/Excelsior_Motor_Company	\N	\N	\N
1365	Gimson	\N	\N	\N	t	https://en.wikipedia.org/wiki/Gimson_(cycles)	\N	\N	\N
1366	Gräf &amp; Stift	\N	\N	\N	t	https://en.wikipedia.org/wiki/Gr%C3%A4f_%26_Stift	\N	\N	\N
1367	Gustavs Ērenpreis Bicycle Factory	\N	\N	\N	t	https://en.wikipedia.org/wiki/Gustavs_%C4%92renpreis_Bicycle_Factory	\N	\N	\N
1368	Harley-Davidson	\N	\N	\N	f	https://en.wikipedia.org/wiki/Harley-Davidson#Bicycles	\N	\N	\N
1369	Henley Bicycle Works	\N	\N	\N	t	https://en.wikipedia.org/wiki/Micajah_C._Henley	\N	\N	\N
1370	Hoffmann	\N	\N	\N	t	https://en.wikipedia.org/wiki/Hoffmann_(motorcycle)	\N	\N	\N
1371	Husqvarna	\N	\N	\N	f	https://en.wikipedia.org/wiki/Husqvarna_Motorcycles#Bicycle_manufacturing	\N	\N	\N
1372	Indian	\N	\N	\N	f	https://en.wikipedia.org/wiki/Indian_(motorcycle)#Bicycles	\N	\N	\N
1373	IFA	\N	\N	\N	t	https://en.wikipedia.org/wiki/Industrieverband_Fahrzeugbau	\N	\N	\N
1374	Ivel Cycle Works	\N	\N	\N	t	https://en.wikipedia.org/wiki/Dan_Albone	\N	\N	\N
1375	Kangaroo	\N	\N	\N	f	https://en.wikipedia.org/wiki/Kangaroo_bicycle	\N	\N	\N
1376	Karbon Kinetics Limited	\N	\N	\N	f	https://en.wikipedia.org/wiki/Karbon_Kinetics_Limited	\N	\N	\N
1377	Kia	\N	\N	\N	f	https://en.wikipedia.org/wiki/Kia_Motors	\N	\N	\N
1378	Merckx	\N	\N	\N	f	https://en.wikipedia.org/wiki/Eddy_Merckx	\N	\N	\N
1379	Minerva	\N	\N	\N	t	https://en.wikipedia.org/wiki/Minerva_(automobile)#Bicycles_and_motorcycles	\N	\N	\N
1380	Mochet	\N	\N	\N	t	https://en.wikipedia.org/wiki/Mochet	\N	\N	\N
1381	Motobécane	\N	\N	\N	f	https://en.wikipedia.org/wiki/Motob%C3%A9cane	\N	\N	\N
1382	Nagasawa	\N	\N	\N	f	https://en.wikipedia.org/wiki/Yoshiaki_Nagasawa	\N	\N	\N
1383	NEXT	\N	\N	\N	f	https://en.wikipedia.org/wiki/NEXT_(bicycle_company)	\N	\N	\N
1384	NSU	\N	\N	\N	f	https://en.wikipedia.org/wiki/NSU_Motorenwerke#NSU_bicycles	\N	\N	\N
1385	Olive Wheel Company	\N	\N	\N	t	https://en.wikipedia.org/wiki/History_of_cycling_in_Syracuse,_New_York#Olive_Wheel_Company	\N	\N	\N
1386	Órbita	\N	\N	\N	f	https://en.wikipedia.org/wiki/%C3%93rbita_bicycles	\N	\N	\N
1387	Overman Wheel Company	\N	\N	\N	t	https://en.wikipedia.org/wiki/Overman_Wheel_Company	\N	\N	\N
1388	Premier	\N	\N	\N	t	https://en.wikipedia.org/wiki/Premier_Motorcycles	\N	\N	\N
1389	Quality Bicycle Products	\N	\N	\N	f	https://en.wikipedia.org/wiki/Quality_Bicycle_Products	\N	\N	\N
1390	R+E Cycles	\N	\N	\N	f	https://en.wikipedia.org/wiki/R%2BE_Cycles	\N	\N	\N
1391	Rabasa Cycles	\N	\N	\N	f	https://en.wikipedia.org/wiki/Rabasa_Cycles	\N	\N	\N
1392	Rhoades Car	\N	\N	\N	f	https://en.wikipedia.org/wiki/Rhoades_Car	\N	\N	\N
1393	Riley Cycle Company	\N	\N	\N	t	https://en.wikipedia.org/wiki/Riley_(motor-car)#Riley_Cycle_Company	\N	\N	\N
1394	ROSE Bikes	\N	\N	\N	f	https://en.wikipedia.org/wiki/ROSE_Bikes	\N	\N	\N
1395	Salcano (bicycle)	\N	\N	\N	f	https://en.wikipedia.org/wiki/Salcano_(bicycle)	\N	\N	\N
1396	Maskinfabriks-aktiebolaget Scania	\N	\N	\N	f	https://en.wikipedia.org/wiki/Maskinfabriks-aktiebolaget_Scania	\N	\N	\N
1397	Simpel	\N	\N	\N	f	https://en.wikipedia.org/wiki/Simpel	\N	\N	\N
1398	Singer	\N	\N	\N	t	https://en.wikipedia.org/wiki/Singer_(car)#Bicycles	\N	\N	\N
1399	Softride	\N	\N	\N	f	https://en.wikipedia.org/wiki/Softride	\N	\N	\N
1400	Solifer	\N	\N	\N	f	https://en.wikipedia.org/wiki/Solifer	\N	\N	\N
1401	SOMA Fabrications	\N	\N	\N	f	https://en.wikipedia.org/wiki/SOMA_Fabrications	\N	\N	\N
1402	Star Cycle Company	\N	\N	\N	f	https://en.wikipedia.org/wiki/Star_Motor_Company#Bicycles	\N	\N	\N
1403	Stearns	\N	\N	\N	t	https://en.wikipedia.org/wiki/E._C._Stearns_Bicycle_Agency	\N	\N	\N
1404	Steyr	\N	\N	\N	t	https://en.wikipedia.org/wiki/Steyr-Daimler-Puch	\N	\N	\N
1405	Sunbeam	\N	\N	\N	t	https://en.wikipedia.org/wiki/Sunbeam_Cycles#Sunbeam_bicycles	\N	\N	\N
1406	Swift Folder	\N	\N	\N	f	https://en.wikipedia.org/wiki/Swift_Folder	\N	\N	\N
1407	Syracuse Cycle Company	\N	\N	\N	t	https://en.wikipedia.org/wiki/History_of_cycling_in_Syracuse,_New_York#Syracuse_Cycle_Company	\N	\N	\N
1408	Thomas	\N	\N	\N	t	https://en.wikipedia.org/wiki/Thomas_Motor_Company	\N	\N	\N
1409	Tube Investments	\N	\N	\N	f	https://en.wikipedia.org/wiki/Tube_Investments	\N	\N	\N
1410	Velocite Bikes	\N	\N	\N	f	https://en.wikipedia.org/wiki/Velocite_Bikes	\N	\N	\N
1411	Victoria	\N	\N	\N	f	https://en.wikipedia.org/wiki/Victoria_(motorcycle)	\N	\N	\N
1412	Wanderer	\N	\N	\N	t	https://en.wikipedia.org/wiki/Wanderer_(car)	\N	\N	\N
1413	Westfield Maufacturing	\N	\N	\N	t	https://en.wikipedia.org/wiki/History_of_cycling_in_Syracuse,_New_York#Westfield_Manufacturing	\N	\N	\N
1414	Whippet	\N	\N	\N	f	https://en.wikipedia.org/wiki/Whippet_(bicycle)	\N	\N	\N
1415	Wittson Custom Ti Cycles	\N	\N	\N	f	https://en.wikipedia.org/wiki/Wittson_Custom_Ti_Cycles	\N	\N	\N
1416	Worden Bicycles	\N	\N	\N	t	https://en.wikipedia.org/wiki/History_of_cycling_in_Syracuse,_New_York#Worden_Bicycles	\N	\N	\N
1417	Whyte	\N	\N	\N	f	https://en.wikipedia.org/wiki/Whyte_(bicycles)	\N	\N	\N
1418	Zündapp	\N	\N	\N	f	https://en.wikipedia.org/wiki/Z%C3%BCndapp	\N	\N	\N
1419	Alps	\N	\N	\N	f	\N	\N	\N	\N
1420	Amanda (Tokyo)	\N	\N	\N	f	\N	\N	\N	\N
1421	Amuna (written "AMVNA", manufactured by Matsumoto Cycle, Sendai)	\N	\N	\N	f	\N	\N	\N	\N
1422	A.N. Design Works (Core Japan, Tokyo)	\N	\N	\N	f	\N	\N	\N	\N
1423	Araya	\N	\N	\N	f	\N	\N	\N	\N
1424	ARES	\N	\N	\N	f	\N	\N	\N	\N
1425	Asuka (Nara)	\N	\N	\N	f	\N	\N	\N	\N
1426	Baramon (Kurume)	\N	\N	\N	f	\N	\N	\N	\N
1427	Cateye	\N	\N	\N	f	\N	\N	\N	\N
1428	Cherubim (Machida, Tokyo)	\N	\N	\N	f	\N	\N	\N	\N
1429	Crafted (Fukui)	\N	\N	\N	f	\N	\N	\N	\N
1430	Deki	\N	\N	\N	f	\N	\N	\N	\N
1431	Elan	\N	\N	\N	f	\N	\N	\N	\N
1432	Emme Akko (Miyako)	\N	\N	\N	f	\N	\N	\N	\N
1433	Fury	\N	\N	\N	f	\N	\N	\N	\N
1434	Ganwell (Kyoto)	\N	\N	\N	f	\N	\N	\N	\N
1435	Hirose (Kodaira, Tokyo)	\N	\N	\N	f	\N	\N	\N	\N
1436	Holks	\N	\N	\N	f	\N	\N	\N	\N
1437	Honjo (Tottori)	\N	\N	\N	f	\N	\N	\N	\N
1438	Ikesho	\N	\N	\N	f	\N	\N	\N	\N
1439	Iribe (Nara)	\N	\N	\N	f	\N	\N	\N	\N
1440	Kalavinka (made by Tsukumo, Tokyo)	\N	\N	\N	f	\N	\N	\N	\N
1441	Kusano Engineering (Tokyo)	\N	\N	\N	f	\N	\N	\N	\N
1442	Mikado	\N	\N	\N	f	\N	\N	\N	\N
1443	Kiyo Miyazawa (Tokyo)	\N	\N	\N	f	\N	\N	\N	\N
1444	Miyuki (Tokyo)	\N	\N	\N	f	\N	\N	\N	\N
1446	Nakagawa (Osaka)	\N	\N	\N	f	\N	\N	\N	\N
1447	Nakamichi	\N	\N	\N	f	\N	\N	\N	\N
1448	Ono	\N	\N	\N	f	\N	\N	\N	\N
1449	Polaris	\N	\N	\N	f	\N	\N	\N	\N
1450	Project M (Tsukuba, Ibaraki)	\N	\N	\N	f	\N	\N	\N	\N
1451	Raizin (Kiryu, Gunma)	\N	\N	\N	f	\N	\N	\N	\N
1452	Ravanello (made by Takamura, Tokyo)	\N	\N	\N	f	\N	\N	\N	\N
1453	Reminton	\N	\N	\N	f	\N	\N	\N	\N
1454	Sannow	\N	\N	\N	f	\N	\N	\N	\N
1455	Shimazaki (Tokyo)	\N	\N	\N	f	\N	\N	\N	\N
1456	Silk	\N	\N	\N	f	\N	\N	\N	\N
1457	Smith	\N	\N	\N	f	\N	\N	\N	\N
1458	Suntour	\N	\N	\N	f	\N	\N	\N	\N
1459	Tano	\N	\N	\N	f	\N	\N	\N	\N
1460	Toei (Kawaguchi, Saitama)	\N	\N	\N	f	\N	\N	\N	\N
1461	Tokyobike	\N	\N	\N	f	\N	\N	\N	\N
1462	Tsunoda (Nagoya, Japan — also manufactured Lotus brand)	\N	\N	\N	f	\N	\N	\N	\N
1463	Tubagra	\N	\N	\N	f	\N	\N	\N	\N
1464	Vigore (Kyoto)	\N	\N	\N	f	\N	\N	\N	\N
1465	Vlaams	\N	\N	\N	f	\N	\N	\N	\N
1466	Vogue (made by Orient, Kamakura)	\N	\N	\N	f	\N	\N	\N	\N
1467	Zebrakenko	\N	\N	\N	f	\N	\N	\N	\N
1468	Zunow (Osaka)	\N	\N	\N	f	\N	\N	\N	\N
\.


--
-- Name: manufacturer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: arobson
--

SELECT pg_catalog.setval('manufacturer_id_seq', 1468, true);


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
-- Name: manufacturer country_code; Type: FK CONSTRAINT; Schema: public; Owner: arobson
--

ALTER TABLE ONLY manufacturer
    ADD CONSTRAINT country_code FOREIGN KEY (country) REFERENCES country(code);


--
-- PostgreSQL database dump complete
--

