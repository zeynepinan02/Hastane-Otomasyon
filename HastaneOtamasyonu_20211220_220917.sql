--
-- PostgreSQL database dump
--

-- Dumped from database version 14.0
-- Dumped by pg_dump version 14.0

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

--
-- Name: hastaekle(bigint, character varying, character varying, character); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.hastaekle(tc bigint, ad character varying, soyad character varying, cinsiyet character) RETURNS integer
    LANGUAGE plpgsql
    AS $$ 
BEGIN
    INSERT into "Hasta"("TC","Hasta"."ad","Hasta"."soyad","Hasta"."cinsiyet")
    VALUES(tc,ad,soyad,cinsiyet);
    if found then 
        return 1;
    else 
        return 0;
    end if;
END;
$$;


ALTER FUNCTION public.hastaekle(tc bigint, ad character varying, soyad character varying, cinsiyet character) OWNER TO postgres;

--
-- Name: ilacsil(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.ilacsil(ilac character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$ 
BEGIN
    DELETE from "Ilac" WHERE "ilacAdi" = ilac;
    if found then 
        return 1;
    else 
        return 0;
    end if;
END;
$$;


ALTER FUNCTION public.ilacsil(ilac character varying) OWNER TO postgres;

--
-- Name: maasode(integer, bigint, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.maasode(miktar integer, tc bigint, mesai integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
begin
	INSERT into "Maas" ("miktar", "personelTC", "mesai")
    VALUES(miktar,tc, mesai);
	
	
end;
$$;


ALTER FUNCTION public.maasode(miktar integer, tc bigint, mesai integer) OWNER TO postgres;

--
-- Name: toplammaas(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.toplammaas() RETURNS integer
    LANGUAGE plpgsql
    AS $$
declare
	toplam integer;
begin
	toplam:=(select sum("miktar") from "Maas");
	return toplam;
end;
$$;


ALTER FUNCTION public.toplammaas() OWNER TO postgres;

--
-- Name: toplammesai(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.toplammesai() RETURNS integer
    LANGUAGE plpgsql
    AS $$
declare
	toplam integer;
begin
	toplam:=(select sum(mesai) from "Maas");
	return toplam;
end;
$$;


ALTER FUNCTION public.toplammesai() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: Ameliyathane; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Ameliyathane" (
    "ameliyathaneNo" integer NOT NULL,
    "ameliyatTarihi" date
);


ALTER TABLE public."Ameliyathane" OWNER TO postgres;

--
-- Name: Hasta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Hasta" (
    "TC" bigint NOT NULL,
    ad character varying,
    soyad character varying,
    sifre character varying,
    cinsiyet character(1),
    telno integer
);


ALTER TABLE public."Hasta" OWNER TO postgres;

--
-- Name: Hastane; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Hastane" (
    "hastaneNo" integer NOT NULL,
    "hastaneAdi" character varying,
    "odaSayisi" integer
);


ALTER TABLE public."Hastane" OWNER TO postgres;

--
-- Name: HastaneMal; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."HastaneMal" (
    "malzemeId" integer NOT NULL,
    "malzemeAdi" character varying,
    miktar integer
);


ALTER TABLE public."HastaneMal" OWNER TO postgres;

--
-- Name: Ilac; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Ilac" (
    "ilacId" integer NOT NULL,
    "ilacAdi" character varying
);


ALTER TABLE public."Ilac" OWNER TO postgres;

--
-- Name: Klinik; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Klinik" (
    "klinikNo" integer NOT NULL,
    "klinikAdi" character varying
);


ALTER TABLE public."Klinik" OWNER TO postgres;

--
-- Name: Maas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Maas" (
    "ucretNo" integer NOT NULL,
    miktar integer,
    "personelTC" bigint,
    mesai integer
);


ALTER TABLE public."Maas" OWNER TO postgres;

--
-- Name: Muayene; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Muayene" (
    "muayeneNo" integer NOT NULL,
    "hastaTC" bigint,
    "doktorTC" bigint
);


ALTER TABLE public."Muayene" OWNER TO postgres;

--
-- Name: Muayene_muayeneNo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Muayene_muayeneNo_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Muayene_muayeneNo_seq" OWNER TO postgres;

--
-- Name: Muayene_muayeneNo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Muayene_muayeneNo_seq" OWNED BY public."Muayene"."muayeneNo";


--
-- Name: Nakil; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Nakil" (
    "nakilId" integer NOT NULL,
    "hastaTC" bigint
);


ALTER TABLE public."Nakil" OWNER TO postgres;

--
-- Name: Personel; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Personel" (
    "TC" bigint NOT NULL,
    ad character varying,
    soyad character varying,
    sifre character varying,
    mesai integer,
    durum character varying,
    "klinikNo" integer
);


ALTER TABLE public."Personel" OWNER TO postgres;

--
-- Name: Randevu; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Randevu" (
    "randevuNo" integer NOT NULL,
    "hastaTC" bigint,
    "randevuTarih" date
);


ALTER TABLE public."Randevu" OWNER TO postgres;

--
-- Name: Randevu_randevuNo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Randevu_randevuNo_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Randevu_randevuNo_seq" OWNER TO postgres;

--
-- Name: Randevu_randevuNo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Randevu_randevuNo_seq" OWNED BY public."Randevu"."randevuNo";


--
-- Name: Recete; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Recete" (
    "receteNo" integer NOT NULL,
    "doktorTC" bigint,
    "hastaTC" bigint,
    "ilacId" integer
);


ALTER TABLE public."Recete" OWNER TO postgres;

--
-- Name: Recete_Ilac; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Recete_Ilac" (
    "ilacId" integer NOT NULL,
    "receteNo" integer NOT NULL
);


ALTER TABLE public."Recete_Ilac" OWNER TO postgres;

--
-- Name: TaburcuOlanlar; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."TaburcuOlanlar" (
    "taburcuId" integer NOT NULL,
    "hastaTC" bigint
);


ALTER TABLE public."TaburcuOlanlar" OWNER TO postgres;

--
-- Name: TaburcuOlanlar_taburcuId_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."TaburcuOlanlar_taburcuId_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."TaburcuOlanlar_taburcuId_seq" OWNER TO postgres;

--
-- Name: TaburcuOlanlar_taburcuId_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."TaburcuOlanlar_taburcuId_seq" OWNED BY public."TaburcuOlanlar"."taburcuId";


--
-- Name: YatanHastalar; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."YatanHastalar" (
    "yatanNo" integer NOT NULL,
    "klinikNo" integer,
    "yatisTarihi" date,
    "hastaTC" bigint
);


ALTER TABLE public."YatanHastalar" OWNER TO postgres;

--
-- Name: YatanHastalar_yatanNo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."YatanHastalar_yatanNo_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."YatanHastalar_yatanNo_seq" OWNER TO postgres;

--
-- Name: YatanHastalar_yatanNo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."YatanHastalar_yatanNo_seq" OWNED BY public."YatanHastalar"."yatanNo";


--
-- Name: Muayene muayeneNo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Muayene" ALTER COLUMN "muayeneNo" SET DEFAULT nextval('public."Muayene_muayeneNo_seq"'::regclass);


--
-- Name: Randevu randevuNo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Randevu" ALTER COLUMN "randevuNo" SET DEFAULT nextval('public."Randevu_randevuNo_seq"'::regclass);


--
-- Name: TaburcuOlanlar taburcuId; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."TaburcuOlanlar" ALTER COLUMN "taburcuId" SET DEFAULT nextval('public."TaburcuOlanlar_taburcuId_seq"'::regclass);


--
-- Name: YatanHastalar yatanNo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."YatanHastalar" ALTER COLUMN "yatanNo" SET DEFAULT nextval('public."YatanHastalar_yatanNo_seq"'::regclass);


--
-- Data for Name: Ameliyathane; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Ameliyathane" ("ameliyathaneNo", "ameliyatTarihi") VALUES (1, '2021-09-24');
INSERT INTO public."Ameliyathane" ("ameliyathaneNo", "ameliyatTarihi") VALUES (2, '2021-10-15');
INSERT INTO public."Ameliyathane" ("ameliyathaneNo", "ameliyatTarihi") VALUES (3, '2021-12-12');


--
-- Data for Name: Hasta; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Hasta" ("TC", ad, soyad, sifre, cinsiyet, telno) VALUES (12345678916, 'rüveyda
', 'namlı', '756', 'k', 44455577);
INSERT INTO public."Hasta" ("TC", ad, soyad, sifre, cinsiyet, telno) VALUES (12345678917, 'kaya', 'demirci', '159', 'e', 11335566);
INSERT INTO public."Hasta" ("TC", ad, soyad, sifre, cinsiyet, telno) VALUES (12345678918, 'ceyda', 'taş', '152', 'k', 1125448);
INSERT INTO public."Hasta" ("TC", ad, soyad, sifre, cinsiyet, telno) VALUES (12345678919, 'nuri', 'açık', NULL, 'e', NULL);
INSERT INTO public."Hasta" ("TC", ad, soyad, sifre, cinsiyet, telno) VALUES (12345678915, 'zey', 'kapkara', '789', 'k', 55522245);
INSERT INTO public."Hasta" ("TC", ad, soyad, sifre, cinsiyet, telno) VALUES (12345678921, 'merve', 'Unal', NULL, 'k', NULL);


--
-- Data for Name: Hastane; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Hastane" ("hastaneNo", "hastaneAdi", "odaSayisi") VALUES (1, 'Ankara şehir hastanesi', 550);


--
-- Data for Name: HastaneMal; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."HastaneMal" ("malzemeId", "malzemeAdi", miktar) VALUES (1, 'eldiven', 100);
INSERT INTO public."HastaneMal" ("malzemeId", "malzemeAdi", miktar) VALUES (2, 'maske', 105);
INSERT INTO public."HastaneMal" ("malzemeId", "malzemeAdi", miktar) VALUES (3, 'dezenfektan', 25);
INSERT INTO public."HastaneMal" ("malzemeId", "malzemeAdi", miktar) VALUES (4, 'pamuk', 500);


--
-- Data for Name: Ilac; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Ilac" ("ilacId", "ilacAdi") VALUES (1, 'asprin');
INSERT INTO public."Ilac" ("ilacId", "ilacAdi") VALUES (2, 'majezik');
INSERT INTO public."Ilac" ("ilacId", "ilacAdi") VALUES (3, 'parol');
INSERT INTO public."Ilac" ("ilacId", "ilacAdi") VALUES (4, 'dolorex');
INSERT INTO public."Ilac" ("ilacId", "ilacAdi") VALUES (5, 'xyz');
INSERT INTO public."Ilac" ("ilacId", "ilacAdi") VALUES (6, 'abc');


--
-- Data for Name: Klinik; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Klinik" ("klinikNo", "klinikAdi") VALUES (1, 'kulak burun boğaz');
INSERT INTO public."Klinik" ("klinikNo", "klinikAdi") VALUES (2, 'diş');
INSERT INTO public."Klinik" ("klinikNo", "klinikAdi") VALUES (3, 'dahiliye');
INSERT INTO public."Klinik" ("klinikNo", "klinikAdi") VALUES (4, 'genel cerrahi');
INSERT INTO public."Klinik" ("klinikNo", "klinikAdi") VALUES (5, 'kalp');


--
-- Data for Name: Maas; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Maas" ("ucretNo", miktar, "personelTC", mesai) VALUES (1, 10000, 12345678910, 50);
INSERT INTO public."Maas" ("ucretNo", miktar, "personelTC", mesai) VALUES (2, 15000, 12345678911, 60);


--
-- Data for Name: Muayene; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Muayene" ("muayeneNo", "hastaTC", "doktorTC") VALUES (1, 12345678915, 12345678910);
INSERT INTO public."Muayene" ("muayeneNo", "hastaTC", "doktorTC") VALUES (2, 12345678916, 12345678911);


--
-- Data for Name: Nakil; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Nakil" ("nakilId", "hastaTC") VALUES (1, 12345678915);
INSERT INTO public."Nakil" ("nakilId", "hastaTC") VALUES (2, 12345678916);


--
-- Data for Name: Personel; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Personel" ("TC", ad, soyad, sifre, mesai, durum, "klinikNo") VALUES (12345678910, 'ahmet', 'uysal', '123', 50, 'doktor', 1);
INSERT INTO public."Personel" ("TC", ad, soyad, sifre, mesai, durum, "klinikNo") VALUES (12345678911, 'mahmut', 'demir', '124', 45, 'doktor', 2);
INSERT INTO public."Personel" ("TC", ad, soyad, sifre, mesai, durum, "klinikNo") VALUES (12345678912, 'fatma', 'yazar', '456', 60, 'yönetici', 3);


--
-- Data for Name: Randevu; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Randevu" ("randevuNo", "hastaTC", "randevuTarih") VALUES (1, 12345678918, '2021-12-25');
INSERT INTO public."Randevu" ("randevuNo", "hastaTC", "randevuTarih") VALUES (2, 12345678917, '2021-12-29');
INSERT INTO public."Randevu" ("randevuNo", "hastaTC", "randevuTarih") VALUES (3, 12345678916, '2021-12-12');


--
-- Data for Name: Recete; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Recete" ("receteNo", "doktorTC", "hastaTC", "ilacId") VALUES (1, 12345678910, 12345678915, 1);
INSERT INTO public."Recete" ("receteNo", "doktorTC", "hastaTC", "ilacId") VALUES (2, 12345678911, 12345678916, 2);
INSERT INTO public."Recete" ("receteNo", "doktorTC", "hastaTC", "ilacId") VALUES (3, 12345678911, 12345678917, 2);
INSERT INTO public."Recete" ("receteNo", "doktorTC", "hastaTC", "ilacId") VALUES (4, 12345678910, 12345678915, 4);
INSERT INTO public."Recete" ("receteNo", "doktorTC", "hastaTC", "ilacId") VALUES (7, 12345678911, 12345678916, 1);
INSERT INTO public."Recete" ("receteNo", "doktorTC", "hastaTC", "ilacId") VALUES (8, 12345678911, 12345678917, 2);
INSERT INTO public."Recete" ("receteNo", "doktorTC", "hastaTC", "ilacId") VALUES (5, 12345678910, 12345678917, 3);


--
-- Data for Name: Recete_Ilac; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: TaburcuOlanlar; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."TaburcuOlanlar" ("taburcuId", "hastaTC") VALUES (1, 12345678915);
INSERT INTO public."TaburcuOlanlar" ("taburcuId", "hastaTC") VALUES (2, 12345678917);


--
-- Data for Name: YatanHastalar; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."YatanHastalar" ("yatanNo", "klinikNo", "yatisTarihi", "hastaTC") VALUES (1, 1, '2021-12-12', 12345678915);
INSERT INTO public."YatanHastalar" ("yatanNo", "klinikNo", "yatisTarihi", "hastaTC") VALUES (2, 2, '2021-12-13', 12345678916);


--
-- Name: Muayene_muayeneNo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Muayene_muayeneNo_seq"', 2, true);


--
-- Name: Randevu_randevuNo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Randevu_randevuNo_seq"', 3, true);


--
-- Name: TaburcuOlanlar_taburcuId_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."TaburcuOlanlar_taburcuId_seq"', 2, true);


--
-- Name: YatanHastalar_yatanNo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."YatanHastalar_yatanNo_seq"', 2, true);


--
-- Name: Ameliyathane Ameliyathane_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Ameliyathane"
    ADD CONSTRAINT "Ameliyathane_pkey" PRIMARY KEY ("ameliyathaneNo");


--
-- Name: Hasta Hasta_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Hasta"
    ADD CONSTRAINT "Hasta_pkey" PRIMARY KEY ("TC");


--
-- Name: HastaneMal HastaneMal_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."HastaneMal"
    ADD CONSTRAINT "HastaneMal_pkey" PRIMARY KEY ("malzemeId");


--
-- Name: Hastane Hastane_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Hastane"
    ADD CONSTRAINT "Hastane_pkey" PRIMARY KEY ("hastaneNo");


--
-- Name: Ilac Ilac_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Ilac"
    ADD CONSTRAINT "Ilac_pkey" PRIMARY KEY ("ilacId");


--
-- Name: Klinik Klinik_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Klinik"
    ADD CONSTRAINT "Klinik_pkey" PRIMARY KEY ("klinikNo");


--
-- Name: Maas Maas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Maas"
    ADD CONSTRAINT "Maas_pkey" PRIMARY KEY ("ucretNo");


--
-- Name: Muayene Muayene_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Muayene"
    ADD CONSTRAINT "Muayene_pkey" PRIMARY KEY ("muayeneNo");


--
-- Name: Nakil Nakil_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Nakil"
    ADD CONSTRAINT "Nakil_pkey" PRIMARY KEY ("nakilId");


--
-- Name: Personel Personel_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Personel"
    ADD CONSTRAINT "Personel_pkey" PRIMARY KEY ("TC");


--
-- Name: Randevu Randevu_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Randevu"
    ADD CONSTRAINT "Randevu_pkey" PRIMARY KEY ("randevuNo");


--
-- Name: Recete_Ilac Recete_Ilac_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Recete_Ilac"
    ADD CONSTRAINT "Recete_Ilac_pkey" PRIMARY KEY ("ilacId", "receteNo");


--
-- Name: Recete Recete_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Recete"
    ADD CONSTRAINT "Recete_pkey" PRIMARY KEY ("receteNo");


--
-- Name: TaburcuOlanlar TaburcuOlanlar_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."TaburcuOlanlar"
    ADD CONSTRAINT "TaburcuOlanlar_pkey" PRIMARY KEY ("taburcuId");


--
-- Name: YatanHastalar YatanHastalar_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."YatanHastalar"
    ADD CONSTRAINT "YatanHastalar_pkey" PRIMARY KEY ("yatanNo");


--
-- Name: Maas Maas_personelTC_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Maas"
    ADD CONSTRAINT "Maas_personelTC_fkey" FOREIGN KEY ("personelTC") REFERENCES public."Personel"("TC");


--
-- Name: Muayene Muayene_doktorTC_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Muayene"
    ADD CONSTRAINT "Muayene_doktorTC_fkey" FOREIGN KEY ("doktorTC") REFERENCES public."Personel"("TC");


--
-- Name: Muayene Muayene_hastaTC_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Muayene"
    ADD CONSTRAINT "Muayene_hastaTC_fkey" FOREIGN KEY ("hastaTC") REFERENCES public."Hasta"("TC");


--
-- Name: Nakil Nakil_hastaTC_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Nakil"
    ADD CONSTRAINT "Nakil_hastaTC_fkey" FOREIGN KEY ("hastaTC") REFERENCES public."Hasta"("TC");


--
-- Name: Personel Personel_klinikNo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Personel"
    ADD CONSTRAINT "Personel_klinikNo_fkey" FOREIGN KEY ("klinikNo") REFERENCES public."Klinik"("klinikNo");


--
-- Name: Randevu Randevu_hastaTC_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Randevu"
    ADD CONSTRAINT "Randevu_hastaTC_fkey" FOREIGN KEY ("hastaTC") REFERENCES public."Hasta"("TC");


--
-- Name: Recete_Ilac Recete_Ilac_ilacId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Recete_Ilac"
    ADD CONSTRAINT "Recete_Ilac_ilacId_fkey" FOREIGN KEY ("ilacId") REFERENCES public."Ilac"("ilacId");


--
-- Name: Recete_Ilac Recete_Ilac_receteNo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Recete_Ilac"
    ADD CONSTRAINT "Recete_Ilac_receteNo_fkey" FOREIGN KEY ("receteNo") REFERENCES public."Recete"("receteNo");


--
-- Name: Recete Recete_doktorTC_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Recete"
    ADD CONSTRAINT "Recete_doktorTC_fkey" FOREIGN KEY ("doktorTC") REFERENCES public."Personel"("TC");


--
-- Name: Recete Recete_hastaTC_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Recete"
    ADD CONSTRAINT "Recete_hastaTC_fkey" FOREIGN KEY ("hastaTC") REFERENCES public."Hasta"("TC");


--
-- Name: Recete Recete_ilacId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Recete"
    ADD CONSTRAINT "Recete_ilacId_fkey" FOREIGN KEY ("ilacId") REFERENCES public."Ilac"("ilacId");


--
-- Name: TaburcuOlanlar TaburcuOlanlar_hastaTC_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."TaburcuOlanlar"
    ADD CONSTRAINT "TaburcuOlanlar_hastaTC_fkey" FOREIGN KEY ("hastaTC") REFERENCES public."Hasta"("TC");


--
-- Name: YatanHastalar YatanHastalar_hastaTC_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."YatanHastalar"
    ADD CONSTRAINT "YatanHastalar_hastaTC_fkey" FOREIGN KEY ("hastaTC") REFERENCES public."Hasta"("TC");


--
-- Name: YatanHastalar YatanHastalar_klinikNo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."YatanHastalar"
    ADD CONSTRAINT "YatanHastalar_klinikNo_fkey" FOREIGN KEY ("klinikNo") REFERENCES public."Klinik"("klinikNo");


--
-- PostgreSQL database dump complete
--

