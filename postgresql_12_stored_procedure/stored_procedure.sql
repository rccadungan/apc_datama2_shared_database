

CREATE TABLE "MI182_rccadungan".form (
    id integer NOT NULL,
    fran_id integer NOT NULL
);


--
-- TOC entry 204 (class 1259 OID 16437)
-- Name: form_id_seq; Type: SEQUENCE; Schema: MI182_rccadungan; Owner: -
--

CREATE SEQUENCE "MI182_rccadungan".form_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2841 (class 0 OID 0)
-- Dependencies: 204
-- Name: form_id_seq; Type: SEQUENCE OWNED BY; Schema: MI182_rccadungan; Owner: -
--

ALTER SEQUENCE "MI182_rccadungan".form_id_seq OWNED BY "MI182_rccadungan".form.id;


--
-- TOC entry 203 (class 1259 OID 16423)
-- Name: franchisee; Type: TABLE; Schema: MI182_rccadungan; Owner: -
--

CREATE TABLE "MI182_rccadungan".franchisee (
    id integer NOT NULL,
    fran_fname character varying(20) NOT NULL,
    fran_lname character varying(20) NOT NULL,
    fran_bday date NOT NULL,
    fran_address character varying(50) NOT NULL,
    fran_salary integer NOT NULL,
    fran_email character varying(50) NOT NULL,
    fran_phonenum integer NOT NULL,
    fran_id integer NOT NULL
);


--
-- TOC entry 206 (class 1259 OID 16462)
-- Name: franchisee_form; Type: VIEW; Schema: MI182_rccadungan; Owner: -
--

CREATE VIEW "MI182_rccadungan".franchisee_form AS
 SELECT franchisee.fran_id,
    form.id,
    franchisee.fran_fname,
    franchisee.fran_lname,
    franchisee.fran_salary,
    franchisee.fran_email
   FROM ("MI182_rccadungan".franchisee
     JOIN "MI182_rccadungan".form ON ((franchisee.fran_id = form.fran_id)))
  WHERE (franchisee.fran_salary > 80000);


--
-- TOC entry 202 (class 1259 OID 16421)
-- Name: franchisee_id_seq; Type: SEQUENCE; Schema: MI182_rccadungan; Owner: -
--

CREATE SEQUENCE "MI182_rccadungan".franchisee_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2842 (class 0 OID 0)
-- Dependencies: 202
-- Name: franchisee_id_seq; Type: SEQUENCE OWNED BY; Schema: MI182_rccadungan; Owner: -
--

ALTER SEQUENCE "MI182_rccadungan".franchisee_id_seq OWNED BY "MI182_rccadungan".franchisee.id;


--
-- TOC entry 2698 (class 2604 OID 16442)
-- Name: form id; Type: DEFAULT; Schema: MI182_rccadungan; Owner: -
--

ALTER TABLE ONLY "MI182_rccadungan".form ALTER COLUMN id SET DEFAULT nextval('"MI182_rccadungan".form_id_seq'::regclass);


--
-- TOC entry 2697 (class 2604 OID 16426)
-- Name: franchisee id; Type: DEFAULT; Schema: MI182_rccadungan; Owner: -
--

ALTER TABLE ONLY "MI182_rccadungan".franchisee ALTER COLUMN id SET DEFAULT nextval('"MI182_rccadungan".franchisee_id_seq'::regclass);


--
-- TOC entry 2834 (class 0 OID 16439)
-- Dependencies: 205
-- Data for Name: form; Type: TABLE DATA; Schema: MI182_rccadungan; Owner: -
--

INSERT INTO "MI182_rccadungan".form (id, fran_id) VALUES (1, 123);
INSERT INTO "MI182_rccadungan".form (id, fran_id) VALUES (2, 124);


--
-- TOC entry 2832 (class 0 OID 16423)
-- Dependencies: 203
-- Data for Name: franchisee; Type: TABLE DATA; Schema: MI182_rccadungan; Owner: -
--

INSERT INTO "MI182_rccadungan".franchisee (id, fran_fname, fran_lname, fran_bday, fran_address, fran_salary, fran_email, fran_phonenum, fran_id) VALUES (123, 'May', 'Sy', '1988-10-11', 'Makati City', 75000, 'ms@gmail,com', 404, 123);
INSERT INTO "MI182_rccadungan".franchisee (id, fran_fname, fran_lname, fran_bday, fran_address, fran_salary, fran_email, fran_phonenum, fran_id) VALUES (124, 'Chris', 'Paul', '1984-07-01', 'Taguig City', 100000, 'cp@gmail,com', 911, 124);


--
-- TOC entry 2843 (class 0 OID 0)
-- Dependencies: 204
-- Name: form_id_seq; Type: SEQUENCE SET; Schema: MI182_rccadungan; Owner: -
--

SELECT pg_catalog.setval('"MI182_rccadungan".form_id_seq', 1, false);


--
-- TOC entry 2844 (class 0 OID 0)
-- Dependencies: 202
-- Name: franchisee_id_seq; Type: SEQUENCE SET; Schema: MI182_rccadungan; Owner: -
--

SELECT pg_catalog.setval('"MI182_rccadungan".franchisee_id_seq', 1, false);


--
-- TOC entry 2702 (class 2606 OID 16444)
-- Name: form form_pkey; Type: CONSTRAINT; Schema: MI182_rccadungan; Owner: -
--

ALTER TABLE ONLY "MI182_rccadungan".form
    ADD CONSTRAINT form_pkey PRIMARY KEY (id);


--
-- TOC entry 2700 (class 2606 OID 16428)
-- Name: franchisee franchisee_pkey; Type: CONSTRAINT; Schema: MI182_rccadungan; Owner: -
--

ALTER TABLE ONLY "MI182_rccadungan".franchisee
    ADD CONSTRAINT franchisee_pkey PRIMARY KEY (id);


--
-- TOC entry 2703 (class 2606 OID 16445)
-- Name: form form_fran_id_fkey; Type: FK CONSTRAINT; Schema: MI182_rccadungan; Owner: -
--

ALTER TABLE ONLY "MI182_rccadungan".form
    ADD CONSTRAINT form_fran_id_fkey FOREIGN KEY (fran_id) REFERENCES "MI182_rccadungan".franchisee(id);


-- Completed on 2019-11-14 14:06:47

--
-- PostgreSQL database dump complete
--


CREATE OR REPLACE PROCEDURE transfer(INT, INT, DEC)
LANGUAGE plpgsql    
AS $$
BEGIN
    -- subtracting the amount from the sender's account 
    UPDATE "MI182_rccadungan".franchisee
    SET fran_salary = fran_salary - $3
    WHERE id = $1;
 
    -- adding the amount to the receiver's account
    UPDATE "MI182_rccadungan".franchisee  
    SET fran_salary = fran_salary + $3
    WHERE id = $2;
 
    COMMIT;
END;
$$;


CALL transfer(1,2,1000);

SELECT * FROM franchisee;