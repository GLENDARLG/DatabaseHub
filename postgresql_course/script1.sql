CREATE DATABASE transporte;


CREATE TABLE public.pasajero
(
    id serial NOT NULL,
    nombre character varying(50) NOT NULL,
    direccion character varying(100),
    PRIMARY KEY (id)
);

ALTER TABLE IF EXISTS public.pasajero
    OWNER to grlg;

CREATE TABLE public.tren
(
    id serial NOT NULL,
    modelo character varying(50) NOT NULL,
    capacidad integer NOT NULL,
    CONSTRAINT tren_pkey PRIMARY KEY (id)
);

ALTER TABLE IF EXISTS public.tren
    OWNER to grlg;


CREATE TABLE public.estacion
(
    id serial NOT NULL,
    nombre character varying(150) NOT NULL,
    direccion character varying(250) NOT NULL,
    CONSTRAINT estacio_pkey PRIMARY KEY (id)
);

ALTER TABLE IF EXISTS public.estacion
    OWNER to grlg;	



CREATE TABLE public.trayecto
(
    id serial NOT NULL,
    id_estacion integer NOT NULL,
    id_tren integer NOT NULL,
    nombre character varying(100) NOT NULL,
    CONSTRAINT trayecto_pkey PRIMARY KEY (id),
    CONSTRAINT id_estacion_fkey FOREIGN KEY (id_estacion)
        REFERENCES public.estacion (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT id_tren_fkey FOREIGN KEY (id_tren)
        REFERENCES public.tren (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
);

ALTER TABLE IF EXISTS public.trayecto
    OWNER to grlg;