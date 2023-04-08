--
-- PostgreSQL database dump
--

-- Dumped from database version 15.1
-- Dumped by pg_dump version 15.1

-- Started on 2023-03-22 18:57:29

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 230 (class 1259 OID 25119)
-- Name: carro; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.carro (
    id integer NOT NULL,
    status boolean DEFAULT false NOT NULL
);


ALTER TABLE public.carro OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 25118)
-- Name: carro_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.carro_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.carro_id_seq OWNER TO postgres;

--
-- TOC entry 3424 (class 0 OID 0)
-- Dependencies: 229
-- Name: carro_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.carro_id_seq OWNED BY public.carro.id;


--
-- TOC entry 221 (class 1259 OID 25019)
-- Name: categorias; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categorias (
    id integer NOT NULL,
    categoria character varying(100) NOT NULL,
    descripcion character varying(255)
);


ALTER TABLE public.categorias OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 25018)
-- Name: categorias_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.categorias_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.categorias_id_seq OWNER TO postgres;

--
-- TOC entry 3425 (class 0 OID 0)
-- Dependencies: 220
-- Name: categorias_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categorias_id_seq OWNED BY public.categorias.id;


--
-- TOC entry 232 (class 1259 OID 25127)
-- Name: detalleorden; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.detalleorden (
    id integer NOT NULL,
    publicacion_id integer NOT NULL,
    cantidad integer NOT NULL,
    precio numeric NOT NULL,
    item integer NOT NULL,
    orden_id character varying(12) NOT NULL
);


ALTER TABLE public.detalleorden OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 25126)
-- Name: detalleOrden_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."detalleOrden_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."detalleOrden_id_seq" OWNER TO postgres;

--
-- TOC entry 3426 (class 0 OID 0)
-- Dependencies: 231
-- Name: detalleOrden_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."detalleOrden_id_seq" OWNED BY public.detalleorden.id;


--
-- TOC entry 225 (class 1259 OID 25035)
-- Name: estadoorden; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.estadoorden (
    id integer NOT NULL,
    estado character varying(100) NOT NULL,
    descripcion character varying(255)
);


ALTER TABLE public.estadoorden OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 25034)
-- Name: estadoOrden_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."estadoOrden_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."estadoOrden_id_seq" OWNER TO postgres;

--
-- TOC entry 3427 (class 0 OID 0)
-- Dependencies: 224
-- Name: estadoOrden_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."estadoOrden_id_seq" OWNED BY public.estadoorden.id;


--
-- TOC entry 227 (class 1259 OID 25042)
-- Name: estadopublicacion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.estadopublicacion (
    id integer NOT NULL,
    estado character varying(50) NOT NULL,
    descripcion character varying(150)
);


ALTER TABLE public.estadopublicacion OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 25041)
-- Name: estadoPublicacion_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."estadoPublicacion_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."estadoPublicacion_id_seq" OWNER TO postgres;

--
-- TOC entry 3428 (class 0 OID 0)
-- Dependencies: 226
-- Name: estadoPublicacion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."estadoPublicacion_id_seq" OWNED BY public.estadopublicacion.id;


--
-- TOC entry 228 (class 1259 OID 25057)
-- Name: favoritos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.favoritos (
    usuario_id integer NOT NULL,
    publicacion_id integer NOT NULL
);


ALTER TABLE public.favoritos OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 25026)
-- Name: ordenes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ordenes (
    id integer NOT NULL,
    usuario_id integer NOT NULL,
    total numeric NOT NULL,
    estado_id integer DEFAULT 1 NOT NULL,
    observacion character varying(255),
    fecha timestamp with time zone DEFAULT now() NOT NULL,
    orden_id character varying(12) NOT NULL
);


ALTER TABLE public.ordenes OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 25025)
-- Name: ordenes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ordenes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ordenes_id_seq OWNER TO postgres;

--
-- TOC entry 3429 (class 0 OID 0)
-- Dependencies: 222
-- Name: ordenes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ordenes_id_seq OWNED BY public.ordenes.id;


--
-- TOC entry 217 (class 1259 OID 25003)
-- Name: perfiles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.perfiles (
    id integer NOT NULL,
    nombre character varying(50) NOT NULL,
    descripcion character varying(255)
);


ALTER TABLE public.perfiles OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 25002)
-- Name: perfiles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.perfiles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.perfiles_id_seq OWNER TO postgres;

--
-- TOC entry 3430 (class 0 OID 0)
-- Dependencies: 216
-- Name: perfiles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.perfiles_id_seq OWNED BY public.perfiles.id;


--
-- TOC entry 219 (class 1259 OID 25010)
-- Name: publicaciones; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.publicaciones (
    id integer NOT NULL,
    usuario_id integer NOT NULL,
    titulo character varying(100) NOT NULL,
    precio numeric NOT NULL,
    descripcion character varying(255) NOT NULL,
    stock integer NOT NULL,
    categoria_id integer NOT NULL,
    imagen1 character varying(255),
    imagen2 character varying(255),
    imagen3 character varying(255),
    estado_id integer NOT NULL,
    date_creacion timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.publicaciones OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 25009)
-- Name: publicaciones_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.publicaciones_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.publicaciones_id_seq OWNER TO postgres;

--
-- TOC entry 3431 (class 0 OID 0)
-- Dependencies: 218
-- Name: publicaciones_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.publicaciones_id_seq OWNED BY public.publicaciones.id;


--
-- TOC entry 215 (class 1259 OID 24994)
-- Name: usuarios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuarios (
    id integer NOT NULL,
    perfil_id integer NOT NULL,
    rut character varying(11) NOT NULL,
    email character varying(100) NOT NULL,
    nombre character varying(150) NOT NULL,
    password character varying(255) NOT NULL,
    direccion character varying(255),
    telefono character(12),
    img character varying(255),
    status boolean NOT NULL,
    date_creacion timestamp with time zone DEFAULT now()
);


ALTER TABLE public.usuarios OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 24993)
-- Name: usuarios_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.usuarios_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.usuarios_id_seq OWNER TO postgres;

--
-- TOC entry 3432 (class 0 OID 0)
-- Dependencies: 214
-- Name: usuarios_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.usuarios_id_seq OWNED BY public.usuarios.id;


--
-- TOC entry 3228 (class 2604 OID 25122)
-- Name: carro id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carro ALTER COLUMN id SET DEFAULT nextval('public.carro_id_seq'::regclass);


--
-- TOC entry 3222 (class 2604 OID 25022)
-- Name: categorias id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categorias ALTER COLUMN id SET DEFAULT nextval('public.categorias_id_seq'::regclass);


--
-- TOC entry 3230 (class 2604 OID 25130)
-- Name: detalleorden id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalleorden ALTER COLUMN id SET DEFAULT nextval('public."detalleOrden_id_seq"'::regclass);


--
-- TOC entry 3226 (class 2604 OID 25038)
-- Name: estadoorden id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estadoorden ALTER COLUMN id SET DEFAULT nextval('public."estadoOrden_id_seq"'::regclass);


--
-- TOC entry 3227 (class 2604 OID 25045)
-- Name: estadopublicacion id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estadopublicacion ALTER COLUMN id SET DEFAULT nextval('public."estadoPublicacion_id_seq"'::regclass);


--
-- TOC entry 3223 (class 2604 OID 25029)
-- Name: ordenes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ordenes ALTER COLUMN id SET DEFAULT nextval('public.ordenes_id_seq'::regclass);


--
-- TOC entry 3219 (class 2604 OID 25006)
-- Name: perfiles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.perfiles ALTER COLUMN id SET DEFAULT nextval('public.perfiles_id_seq'::regclass);


--
-- TOC entry 3220 (class 2604 OID 25013)
-- Name: publicaciones id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.publicaciones ALTER COLUMN id SET DEFAULT nextval('public.publicaciones_id_seq'::regclass);


--
-- TOC entry 3217 (class 2604 OID 24997)
-- Name: usuarios id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios ALTER COLUMN id SET DEFAULT nextval('public.usuarios_id_seq'::regclass);


--
-- TOC entry 3416 (class 0 OID 25119)
-- Dependencies: 230
-- Data for Name: carro; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.carro (id, status) FROM stdin;
\.


--
-- TOC entry 3407 (class 0 OID 25019)
-- Dependencies: 221
-- Data for Name: categorias; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categorias (id, categoria, descripcion) FROM stdin;
1	plantas	Plantas de jardin
\.





--
-- TOC entry 3411 (class 0 OID 25035)
-- Dependencies: 225
-- Data for Name: estadoorden; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.estadoorden (id, estado, descripcion) FROM stdin;
1	En Revision	Compra en proceso de revision
2	Aprobado	El pago fue corroborado
3	En Despacho	Se esta procesando el despacho de sus productos
4	Entregado	La compra fue entregada al cliente
5	En Reclamo	La compra presenta algun reclamo por parte del cliente
6	Finalizado	El proceso a finalizado con exito
\.


--
-- TOC entry 3413 (class 0 OID 25042)
-- Dependencies: 227
-- Data for Name: estadopublicacion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.estadopublicacion (id, estado, descripcion) FROM stdin;
1	Activo	Publicacion activa: Cumple con las politicas del sitio
2	Inactivo	Publicaion borrada por el Administrador
3	Finalizada	Publicacion borrada por el Propietario
4	Pausada	Publicacion Pausada por falta de stock
5	Suspendida	Publicacion en proceso de revision, por inclumplir las normas
6	En Espera	Publicacion en proceso de activacion
\.


--
-- TOC entry 3414 (class 0 OID 25057)
-- Dependencies: 228
-- Data for Name: favoritos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.favoritos (usuario_id, publicacion_id) FROM stdin;
\.



--
-- TOC entry 3403 (class 0 OID 25003)
-- Dependencies: 217
-- Data for Name: perfiles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.perfiles (id, nombre, descripcion) FROM stdin;
1	admin	administrador del sitio
2	Visitante	Perfil para personas no registradas
\.


--
-- TOC entry 3405 (class 0 OID 25010)
-- Dependencies: 219
-- Data for Name: publicaciones; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.publicaciones (id, usuario_id, titulo, precio, descripcion, stock, categoria_id, imagen1, imagen2, imagen3, estado_id, date_creacion) FROM stdin;
2	3	Planta carnivora	20000	planta come insectos de habitad humedo	4	1	\N	\N	\N	3	2023-03-16 20:32:07.371866-03
1	2	Nueva Publicacion	15980	Plantas de jardin	11	1	imagen	\N	\N	1	2023-03-15 23:10:20.834145-03
\.


--
-- TOC entry 3401 (class 0 OID 24994)
-- Dependencies: 215
-- Data for Name: usuarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.usuarios (id, perfil_id, rut, email, nombre, password, direccion, telefono, img, status, date_creacion) FROM stdin;
2	1	26312660-2	jose@email.com	jose caracas	123456	\N	\N	\N	t	2023-03-15 17:12:58.755428-03
3	1	26312660-2	correo@correo.cl	jose caracas	$2a$10$NSmt3l.cfJ9u20IDi5nT1Ot5uW0ZYB2UqfkS0GG2p8af2ZJWlmjHi	\N	\N	\N	t	2023-03-15 17:17:58.437837-03
4	1	121213-3	correo11@g.com	jjj	$2a$10$rZjSrg8I9rhv/G4/Dy9GWOcUXYyl/M17bESeqQTZGfgwX/XwPbfaq	\N	\N	\N	t	2023-03-21 15:13:28.671802-03
\.


--
-- TOC entry 3433 (class 0 OID 0)
-- Dependencies: 229
-- Name: carro_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.carro_id_seq', 1, false);


--
-- TOC entry 3434 (class 0 OID 0)
-- Dependencies: 220
-- Name: categorias_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categorias_id_seq', 1, false);


--
-- TOC entry 3435 (class 0 OID 0)
-- Dependencies: 231
-- Name: detalleOrden_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."detalleOrden_id_seq"', 19, true);


--
-- TOC entry 3436 (class 0 OID 0)
-- Dependencies: 224
-- Name: estadoOrden_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."estadoOrden_id_seq"', 1, false);


--
-- TOC entry 3437 (class 0 OID 0)
-- Dependencies: 226
-- Name: estadoPublicacion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."estadoPublicacion_id_seq"', 1, false);


--
-- TOC entry 3438 (class 0 OID 0)
-- Dependencies: 222
-- Name: ordenes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ordenes_id_seq', 7, true);


--
-- TOC entry 3439 (class 0 OID 0)
-- Dependencies: 216
-- Name: perfiles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.perfiles_id_seq', 1, true);


--
-- TOC entry 3440 (class 0 OID 0)
-- Dependencies: 218
-- Name: publicaciones_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.publicaciones_id_seq', 1, false);


--
-- TOC entry 3441 (class 0 OID 0)
-- Dependencies: 214
-- Name: usuarios_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.usuarios_id_seq', 4, true);


--
-- TOC entry 3246 (class 2606 OID 25125)
-- Name: carro carro_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carro
    ADD CONSTRAINT carro_pkey PRIMARY KEY (id);


--
-- TOC entry 3238 (class 2606 OID 25024)
-- Name: categorias categorias_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categorias
    ADD CONSTRAINT categorias_pkey PRIMARY KEY (id);


--
-- TOC entry 3248 (class 2606 OID 25134)
-- Name: detalleorden detalleOrden_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalleorden
    ADD CONSTRAINT "detalleOrden_pkey" PRIMARY KEY (id);


--
-- TOC entry 3242 (class 2606 OID 25040)
-- Name: estadoorden estadoOrden_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estadoorden
    ADD CONSTRAINT "estadoOrden_pkey" PRIMARY KEY (id);


--
-- TOC entry 3244 (class 2606 OID 25047)
-- Name: estadopublicacion estadoPublicacion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estadopublicacion
    ADD CONSTRAINT "estadoPublicacion_pkey" PRIMARY KEY (id);


--
-- TOC entry 3240 (class 2606 OID 25033)
-- Name: ordenes ordenes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ordenes
    ADD CONSTRAINT ordenes_pkey PRIMARY KEY (id);


--
-- TOC entry 3234 (class 2606 OID 25008)
-- Name: perfiles perfiles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.perfiles
    ADD CONSTRAINT perfiles_pkey PRIMARY KEY (id);


--
-- TOC entry 3236 (class 2606 OID 25017)
-- Name: publicaciones publicaciones_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.publicaciones
    ADD CONSTRAINT publicaciones_pkey PRIMARY KEY (id);


--
-- TOC entry 3232 (class 2606 OID 25001)
-- Name: usuarios usuarios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_pkey PRIMARY KEY (id);


--
-- TOC entry 3255 (class 2606 OID 25105)
-- Name: favoritos FK_pub; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.favoritos
    ADD CONSTRAINT "FK_pub" FOREIGN KEY (publicacion_id) REFERENCES public.publicaciones(id) ON DELETE CASCADE NOT VALID;


--
-- TOC entry 3256 (class 2606 OID 25100)
-- Name: favoritos FK_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.favoritos
    ADD CONSTRAINT "FK_user" FOREIGN KEY (usuario_id) REFERENCES public.usuarios(id) ON DELETE CASCADE NOT VALID;


--
-- TOC entry 3250 (class 2606 OID 25070)
-- Name: publicaciones fk_cat; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.publicaciones
    ADD CONSTRAINT fk_cat FOREIGN KEY (categoria_id) REFERENCES public.categorias(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- TOC entry 3251 (class 2606 OID 25075)
-- Name: publicaciones fk_estado; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.publicaciones
    ADD CONSTRAINT fk_estado FOREIGN KEY (estado_id) REFERENCES public.estadopublicacion(id) ON UPDATE CASCADE NOT VALID;


--
-- TOC entry 3257 (class 2606 OID 25135)
-- Name: detalleorden fk_pub; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalleorden
    ADD CONSTRAINT fk_pub FOREIGN KEY (publicacion_id) REFERENCES public.publicaciones(id);


--
-- TOC entry 3253 (class 2606 OID 25085)
-- Name: ordenes pk_estado; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ordenes
    ADD CONSTRAINT pk_estado FOREIGN KEY (estado_id) REFERENCES public.estadoorden(id) ON UPDATE CASCADE NOT VALID;


--
-- TOC entry 3249 (class 2606 OID 25060)
-- Name: usuarios pk_perfil; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT pk_perfil FOREIGN KEY (perfil_id) REFERENCES public.perfiles(id) NOT VALID;


--
-- TOC entry 3252 (class 2606 OID 25065)
-- Name: publicaciones pk_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.publicaciones
    ADD CONSTRAINT pk_user FOREIGN KEY (usuario_id) REFERENCES public.usuarios(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- TOC entry 3254 (class 2606 OID 25080)
-- Name: ordenes pk_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ordenes
    ADD CONSTRAINT pk_user FOREIGN KEY (usuario_id) REFERENCES public.usuarios(id) NOT VALID;


-- Completed on 2023-03-22 18:57:30

--
-- PostgreSQL database dump complete
--

