--
-- PostgreSQL database dump
--

-- Dumped from database version 17rc1
-- Dumped by pg_dump version 17rc1

-- Started on 2024-11-06 18:20:48 EST

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
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
-- TOC entry 219 (class 1259 OID 16587)
-- Name: department; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.department (
    dname character varying(15) NOT NULL,
    dnumber integer NOT NULL,
    mgr_ssn character(9) NOT NULL
);


ALTER TABLE public.department OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16582)
-- Name: dependent; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dependent (
    essn character(9) NOT NULL,
    dependent_name character varying(12) NOT NULL,
    sex character(1) NOT NULL,
    bdate date NOT NULL,
    relationship character varying(10) NOT NULL
);


ALTER TABLE public.dependent OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16594)
-- Name: dept_location; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dept_location (
    dnumber integer NOT NULL,
    dlocation character varying(15) NOT NULL
);


ALTER TABLE public.dept_location OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16575)
-- Name: employee; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.employee (
    fname character varying(10) NOT NULL,
    minit character(1) NOT NULL,
    lname character varying(10) NOT NULL,
    ssn character(9) NOT NULL,
    address character varying(15) NOT NULL,
    sex character(1) NOT NULL,
    salary integer NOT NULL,
    super_ssn character(9) NOT NULL,
    dno integer NOT NULL,
    bdate date,
    empdate date
);


ALTER TABLE public.employee OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16599)
-- Name: project; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.project (
    pname character varying(15) NOT NULL,
    pnumber integer NOT NULL,
    plocation character varying(15) NOT NULL,
    dnum integer NOT NULL
);


ALTER TABLE public.project OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 16612)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    username character varying(50) NOT NULL,
    password character varying(255) NOT NULL,
    role character varying(20) NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16611)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- TOC entry 3648 (class 0 OID 0)
-- Dependencies: 223
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 222 (class 1259 OID 16606)
-- Name: works_on; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.works_on (
    essn character(9) NOT NULL,
    pno integer NOT NULL,
    hours numeric(4,1) NOT NULL
);


ALTER TABLE public.works_on OWNER TO postgres;

--
-- TOC entry 3467 (class 2604 OID 16615)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 3637 (class 0 OID 16587)
-- Dependencies: 219
-- Data for Name: department; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.department (dname, dnumber, mgr_ssn) VALUES ('Headquarters', 1, '888665555');
INSERT INTO public.department (dname, dnumber, mgr_ssn) VALUES ('Marketing', 2, '444555777');
INSERT INTO public.department (dname, dnumber, mgr_ssn) VALUES ('Administration', 4, '987654321');
INSERT INTO public.department (dname, dnumber, mgr_ssn) VALUES ('Research', 5, '333445555');
INSERT INTO public.department (dname, dnumber, mgr_ssn) VALUES ('Finance', 7, '353467409');
INSERT INTO public.department (dname, dnumber, mgr_ssn) VALUES ('Engineering', 11, '359624751');
INSERT INTO public.department (dname, dnumber, mgr_ssn) VALUES ('Model', 24, '123456789');


--
-- TOC entry 3636 (class 0 OID 16582)
-- Dependencies: 218
-- Data for Name: dependent; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.dependent (essn, dependent_name, sex, bdate, relationship) VALUES ('123456789', 'Alice', 'F', '2008-12-31', 'Daughter');
INSERT INTO public.dependent (essn, dependent_name, sex, bdate, relationship) VALUES ('123456789', 'Elizabeth', 'F', '1987-05-05', 'Spouse');
INSERT INTO public.dependent (essn, dependent_name, sex, bdate, relationship) VALUES ('123456789', 'Michael', 'M', '2008-01-01', 'Son');
INSERT INTO public.dependent (essn, dependent_name, sex, bdate, relationship) VALUES ('231456456', 'Delilah', 'F', '1968-05-13', 'Spouse');
INSERT INTO public.dependent (essn, dependent_name, sex, bdate, relationship) VALUES ('268268702', 'Minnie', 'F', '1978-08-11', 'Spouse');
INSERT INTO public.dependent (essn, dependent_name, sex, bdate, relationship) VALUES ('268268702', 'Pluto', 'M', '1988-07-31', 'Son');
INSERT INTO public.dependent (essn, dependent_name, sex, bdate, relationship) VALUES ('321400789', 'Julia', 'F', '1973-05-05', 'Spouse');
INSERT INTO public.dependent (essn, dependent_name, sex, bdate, relationship) VALUES ('321456789', 'Angus', 'M', '1995-01-08', 'Son');
INSERT INTO public.dependent (essn, dependent_name, sex, bdate, relationship) VALUES ('321456789', 'Francine', 'F', '1968-05-07', 'Spouse');
INSERT INTO public.dependent (essn, dependent_name, sex, bdate, relationship) VALUES ('321456789', 'Tracey', 'F', '1998-12-12', 'Daughter');
INSERT INTO public.dependent (essn, dependent_name, sex, bdate, relationship) VALUES ('333445555', 'Alice', 'F', '2006-04-05', 'Daughter');
INSERT INTO public.dependent (essn, dependent_name, sex, bdate, relationship) VALUES ('333445555', 'Joy', 'F', '1985-05-03', 'Spouse');
INSERT INTO public.dependent (essn, dependent_name, sex, bdate, relationship) VALUES ('333445555', 'Theodore', 'M', '2003-10-25', 'Son');
INSERT INTO public.dependent (essn, dependent_name, sex, bdate, relationship) VALUES ('444555777', 'Emily', 'F', '1978-05-26', 'Spouse');
INSERT INTO public.dependent (essn, dependent_name, sex, bdate, relationship) VALUES ('453422453', 'Emma', 'F', '2005-04-06', 'Daughter');
INSERT INTO public.dependent (essn, dependent_name, sex, bdate, relationship) VALUES ('453422453', 'Thomas', 'M', '2003-10-03', 'Son');
INSERT INTO public.dependent (essn, dependent_name, sex, bdate, relationship) VALUES ('515821234', 'James', 'M', '1992-04-14', 'Son');
INSERT INTO public.dependent (essn, dependent_name, sex, bdate, relationship) VALUES ('550561234', 'Yuri', 'M', '1993-12-25', 'Spouse');
INSERT INTO public.dependent (essn, dependent_name, sex, bdate, relationship) VALUES ('666258951', 'Halle', 'F', '1999-11-05', 'Daughter');
INSERT INTO public.dependent (essn, dependent_name, sex, bdate, relationship) VALUES ('666258951', 'Maximus', 'M', '2007-01-09', 'Son');
INSERT INTO public.dependent (essn, dependent_name, sex, bdate, relationship) VALUES ('666258951', 'Megan', 'F', '1987-01-21', 'Spouse');
INSERT INTO public.dependent (essn, dependent_name, sex, bdate, relationship) VALUES ('987654001', 'Charlotte', 'F', '1963-02-25', 'Spouse');
INSERT INTO public.dependent (essn, dependent_name, sex, bdate, relationship) VALUES ('987654321', 'Abner', 'M', '1992-02-29', 'Spouse');
INSERT INTO public.dependent (essn, dependent_name, sex, bdate, relationship) VALUES ('100040001', 'Harry', 'M', '2020-12-31', 'Son');
INSERT INTO public.dependent (essn, dependent_name, sex, bdate, relationship) VALUES ('111111111', 'Richard', 'M', '2020-05-05', 'Son');
INSERT INTO public.dependent (essn, dependent_name, sex, bdate, relationship) VALUES ('111222333', 'William', 'M', '2008-01-01', 'Son');
INSERT INTO public.dependent (essn, dependent_name, sex, bdate, relationship) VALUES ('198782427', 'Leonard', 'M', '2020-05-13', 'Son');
INSERT INTO public.dependent (essn, dependent_name, sex, bdate, relationship) VALUES ('199098293', 'Shuchi', 'F', '2020-08-11', 'Daughter');
INSERT INTO public.dependent (essn, dependent_name, sex, bdate, relationship) VALUES ('199171129', 'Melissa', 'F', '2020-07-31', 'Daughter');
INSERT INTO public.dependent (essn, dependent_name, sex, bdate, relationship) VALUES ('199196331', 'Josiah', 'M', '2018-05-05', 'Son');
INSERT INTO public.dependent (essn, dependent_name, sex, bdate, relationship) VALUES ('199302835', 'Mohammad', 'M', '2018-01-08', 'Son');
INSERT INTO public.dependent (essn, dependent_name, sex, bdate, relationship) VALUES ('199489442', 'Bonnie', 'F', '2018-05-07', 'Daughter');
INSERT INTO public.dependent (essn, dependent_name, sex, bdate, relationship) VALUES ('199608611', 'Carmel', 'F', '2018-12-12', 'Daughter');
INSERT INTO public.dependent (essn, dependent_name, sex, bdate, relationship) VALUES ('199685000', 'Khadijah', 'F', '2016-04-05', 'Daughter');
INSERT INTO public.dependent (essn, dependent_name, sex, bdate, relationship) VALUES ('199705791', 'Rachel', 'F', '2016-05-03', 'Daughter');
INSERT INTO public.dependent (essn, dependent_name, sex, bdate, relationship) VALUES ('200002511', 'Daniela', 'F', '2016-10-25', 'Daughter');
INSERT INTO public.dependent (essn, dependent_name, sex, bdate, relationship) VALUES ('200178650', 'Leonard', 'M', '2016-05-26', 'Son');
INSERT INTO public.dependent (essn, dependent_name, sex, bdate, relationship) VALUES ('200243095', 'Shuchi', 'F', '2016-04-06', 'Daughter');
INSERT INTO public.dependent (essn, dependent_name, sex, bdate, relationship) VALUES ('200352295', 'Melissa', 'M', '2014-10-03', 'Son');
INSERT INTO public.dependent (essn, dependent_name, sex, bdate, relationship) VALUES ('200493155', 'Josiah', 'F', '2014-04-14', 'Daughter');
INSERT INTO public.dependent (essn, dependent_name, sex, bdate, relationship) VALUES ('200587814', 'Mohammad', 'M', '2014-12-25', 'Son');
INSERT INTO public.dependent (essn, dependent_name, sex, bdate, relationship) VALUES ('200626576', 'Bonnie', 'F', '2014-11-05', 'Daughter');
INSERT INTO public.dependent (essn, dependent_name, sex, bdate, relationship) VALUES ('200757441', 'Carmel', 'F', '2012-01-09', 'Daughter');
INSERT INTO public.dependent (essn, dependent_name, sex, bdate, relationship) VALUES ('201052043', 'Khadijah', 'F', '2012-01-21', 'Daughter');
INSERT INTO public.dependent (essn, dependent_name, sex, bdate, relationship) VALUES ('201073976', 'Rachel', 'F', '2012-02-25', 'Daughter');
INSERT INTO public.dependent (essn, dependent_name, sex, bdate, relationship) VALUES ('201165466', 'Daniela', 'F', '2012-02-29', 'Daughter');
INSERT INTO public.dependent (essn, dependent_name, sex, bdate, relationship) VALUES ('201443758', 'Leonard', 'M', '2020-12-31', 'Son');
INSERT INTO public.dependent (essn, dependent_name, sex, bdate, relationship) VALUES ('201450220', 'Anne', 'F', '2020-05-05', 'Daughter');
INSERT INTO public.dependent (essn, dependent_name, sex, bdate, relationship) VALUES ('201739519', 'Melissa', 'M', '2008-01-01', 'Son');
INSERT INTO public.dependent (essn, dependent_name, sex, bdate, relationship) VALUES ('444444444', 'Josiah', 'F', '2020-05-13', 'Daughter');
INSERT INTO public.dependent (essn, dependent_name, sex, bdate, relationship) VALUES ('449721234', 'Mohammad', 'M', '2020-08-11', 'Son');
INSERT INTO public.dependent (essn, dependent_name, sex, bdate, relationship) VALUES ('453453453', 'Bonnie', 'F', '2020-07-31', 'Daughter');
INSERT INTO public.dependent (essn, dependent_name, sex, bdate, relationship) VALUES ('460836586', 'Carmel', 'F', '2018-05-05', 'Daughter');
INSERT INTO public.dependent (essn, dependent_name, sex, bdate, relationship) VALUES ('546031234', 'Khadijah', 'F', '2018-01-08', 'Daughter');
INSERT INTO public.dependent (essn, dependent_name, sex, bdate, relationship) VALUES ('546546877', 'Rachel', 'F', '2018-05-07', 'Daughter');
INSERT INTO public.dependent (essn, dependent_name, sex, bdate, relationship) VALUES ('560123563', 'Daniela', 'F', '2018-12-12', 'Daughter');
INSERT INTO public.dependent (essn, dependent_name, sex, bdate, relationship) VALUES ('566879301', 'Carmel', 'F', '2016-04-05', 'Daughter');
INSERT INTO public.dependent (essn, dependent_name, sex, bdate, relationship) VALUES ('607465254', 'Khadijah', 'F', '2016-05-03', 'Daughter');
INSERT INTO public.dependent (essn, dependent_name, sex, bdate, relationship) VALUES ('629568526', 'Rachel', 'F', '2016-10-25', 'Daughter');
INSERT INTO public.dependent (essn, dependent_name, sex, bdate, relationship) VALUES ('629575266', 'Daniela', 'F', '2016-05-26', 'Daughter');


--
-- TOC entry 3638 (class 0 OID 16594)
-- Dependencies: 220
-- Data for Name: dept_location; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.dept_location (dnumber, dlocation) VALUES (1, 'Houston');
INSERT INTO public.dept_location (dnumber, dlocation) VALUES (2, 'Redmond');
INSERT INTO public.dept_location (dnumber, dlocation) VALUES (4, 'Stafford');
INSERT INTO public.dept_location (dnumber, dlocation) VALUES (5, 'Bellaire');
INSERT INTO public.dept_location (dnumber, dlocation) VALUES (7, 'Guelph');
INSERT INTO public.dept_location (dnumber, dlocation) VALUES (5, 'Houston');
INSERT INTO public.dept_location (dnumber, dlocation) VALUES (11, 'Houston');
INSERT INTO public.dept_location (dnumber, dlocation) VALUES (24, 'Guelph');
INSERT INTO public.dept_location (dnumber, dlocation) VALUES (5, 'Sugarland');


--
-- TOC entry 3635 (class 0 OID 16575)
-- Dependencies: 217
-- Data for Name: employee; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.employee (fname, minit, lname, ssn, address, sex, salary, super_ssn, dno, bdate, empdate) VALUES ('Mary', 'J', 'Hind', '100040001', 'Dundas, ON', 'F', 333000, '333445555', 5, '1997-01-19', '2018-05-25');
INSERT INTO public.employee (fname, minit, lname, ssn, address, sex, salary, super_ssn, dno, bdate, empdate) VALUES ('Harry', 'O', 'Potter', '105947378', 'London,, On', 'M', 43000, '460836586', 1, '1993-06-10', '2014-07-01');
INSERT INTO public.employee (fname, minit, lname, ssn, address, sex, salary, super_ssn, dno, bdate, empdate) VALUES ('Sebastian', 'T', 'Kuras', '111111111', 'Houston, TX', 'M', 90000, '999999999', 5, '1965-05-19', '1985-09-14');
INSERT INTO public.employee (fname, minit, lname, ssn, address, sex, salary, super_ssn, dno, bdate, empdate) VALUES ('Alex', 'E', 'Vermeulen', '111222333', 'Dundas, ON', 'F', 150000, '888665555', 5, '1992-04-01', '2014-09-29');
INSERT INTO public.employee (fname, minit, lname, ssn, address, sex, salary, super_ssn, dno, bdate, empdate) VALUES ('John', 'B', 'Smith', '123456789', 'Houston, TX', 'M', 60000, '333445555', 5, '1980-09-01', '2004-11-06');
INSERT INTO public.employee (fname, minit, lname, ssn, address, sex, salary, super_ssn, dno, bdate, empdate) VALUES ('Victoria', 'J', 'Smith', '198782427', 'Guelph, ON', 'F', 127000, '444555777', 2, '1987-06-14', '2007-08-30');
INSERT INTO public.employee (fname, minit, lname, ssn, address, sex, salary, super_ssn, dno, bdate, empdate) VALUES ('Tamara', 'E', 'Walters', '198928552', 'Hamilton, ON', 'F', 980000, '888665555', 4, '1967-11-17', '1989-07-20');
INSERT INTO public.employee (fname, minit, lname, ssn, address, sex, salary, super_ssn, dno, bdate, empdate) VALUES ('Jessica', 'A', 'Jonesboro', '199098293', 'Guelph, ON', 'F', 164000, '460836586', 11, '1969-06-12', '1993-09-10');
INSERT INTO public.employee (fname, minit, lname, ssn, address, sex, salary, super_ssn, dno, bdate, empdate) VALUES ('Keane', 'W', 'Saunders', '199171129', 'London, ON', 'F', 180000, '333445555', 5, '1993-07-09', '2016-09-24');
INSERT INTO public.employee (fname, minit, lname, ssn, address, sex, salary, super_ssn, dno, bdate, empdate) VALUES ('Samuel', 'C', 'Anderson', '199196331', 'Paris, ON', 'M', 240000, '925468826', 24, '1999-12-19', '2020-08-29');
INSERT INTO public.employee (fname, minit, lname, ssn, address, sex, salary, super_ssn, dno, bdate, empdate) VALUES ('Andrea', 'R', 'Austin', '199302835', 'Hamilton, ON', 'M', 160000, '333445555', 5, '1963-08-30', '1983-12-03');
INSERT INTO public.employee (fname, minit, lname, ssn, address, sex, salary, super_ssn, dno, bdate, empdate) VALUES ('Fahad', 'Y', 'Selles', '199305628', 'Guelph, ON', 'M', 40000, '999999999', 5, '1974-01-11', '1996-04-11');
INSERT INTO public.employee (fname, minit, lname, ssn, address, sex, salary, super_ssn, dno, bdate, empdate) VALUES ('Jack', 'U', 'Nicholson', '199489442', 'Guelph, ON', 'M', 80000, '888665555', 5, '1994-05-31', '2019-02-25');
INSERT INTO public.employee (fname, minit, lname, ssn, address, sex, salary, super_ssn, dno, bdate, empdate) VALUES ('Robert', 'I', 'De Niro', '199608611', 'Hamilton, ON', 'M', 100000, '987654321', 4, '1976-08-26', '2000-07-10');
INSERT INTO public.employee (fname, minit, lname, ssn, address, sex, salary, super_ssn, dno, bdate, empdate) VALUES ('Jennifer', 'X', 'Armstrong', '199685000', 'Guelph, ON', 'F', 130000, '888665555', 7, '1993-08-06', '2017-10-14');
INSERT INTO public.employee (fname, minit, lname, ssn, address, sex, salary, super_ssn, dno, bdate, empdate) VALUES ('Rajan', 'C', 'Patel', '199705791', 'Paris, ON', 'M', 164000, '888665555', 11, '1982-12-02', '2006-12-17');
INSERT INTO public.employee (fname, minit, lname, ssn, address, sex, salary, super_ssn, dno, bdate, empdate) VALUES ('Emily', 'V', 'Asher', '199923690', 'London, ON', 'F', 10000, '999999999', 5, '1985-04-22', '2006-01-30');
INSERT INTO public.employee (fname, minit, lname, ssn, address, sex, salary, super_ssn, dno, bdate, empdate) VALUES ('Elizabeth', 'N', 'Asling', '200002511', 'Hamilton, ON', 'F', 227000, '444555777', 2, '1975-08-02', '1997-03-14');
INSERT INTO public.employee (fname, minit, lname, ssn, address, sex, salary, super_ssn, dno, bdate, empdate) VALUES ('Claire', 'D', 'Atkins', '200178650', 'Guelph, ON', 'M', 27000, '444555777', 2, '1997-08-21', '2022-07-03');
INSERT INTO public.employee (fname, minit, lname, ssn, address, sex, salary, super_ssn, dno, bdate, empdate) VALUES ('Al', 'F', 'Pacino', '200243095', 'Hamilton, ON', 'M', 150000, '333445555', 5, '1989-04-15', '2010-03-18');
INSERT INTO public.employee (fname, minit, lname, ssn, address, sex, salary, super_ssn, dno, bdate, empdate) VALUES ('Tom', 'E', 'Hanks', '200352295', 'Paris, ON', 'M', 197000, '807844760', 4, '1977-10-29', '1998-11-07');
INSERT INTO public.employee (fname, minit, lname, ssn, address, sex, salary, super_ssn, dno, bdate, empdate) VALUES ('Dustin', 'Y', 'Hoffman', '200369792', 'Guelph, ON', 'M', 50000, '333445555', 5, '1987-03-03', '2010-12-14');
INSERT INTO public.employee (fname, minit, lname, ssn, address, sex, salary, super_ssn, dno, bdate, empdate) VALUES ('Brad', 'A', 'Pitt', '200493155', 'London, ON', 'M', 97000, '444555777', 2, '1982-01-19', '2002-11-06');
INSERT INTO public.employee (fname, minit, lname, ssn, address, sex, salary, super_ssn, dno, bdate, empdate) VALUES ('Anthony', 'S', 'Hopkins', '200587814', 'Hamilton, ON', 'M', 170000, '444555777', 2, '1977-07-20', '2000-04-20');
INSERT INTO public.employee (fname, minit, lname, ssn, address, sex, salary, super_ssn, dno, bdate, empdate) VALUES ('Marlon', 'X', 'Brando', '200626576', 'Guelph, ON', 'F', 56000, '359624751', 11, '1970-11-26', '1992-09-20');
INSERT INTO public.employee (fname, minit, lname, ssn, address, sex, salary, super_ssn, dno, bdate, empdate) VALUES ('Jessica', 'C', 'Austin', '200757441', 'Guelph, ON', 'F', 123000, '444555777', 2, '1998-03-09', '2019-08-21');
INSERT INTO public.employee (fname, minit, lname, ssn, address, sex, salary, super_ssn, dno, bdate, empdate) VALUES ('Matthew', 'V', 'Austin', '200802224', 'Hamilton, ON', 'M', 200000, '333445555', 5, '1985-08-05', '2007-07-06');
INSERT INTO public.employee (fname, minit, lname, ssn, address, sex, salary, super_ssn, dno, bdate, empdate) VALUES ('Lauren', 'J', 'Baldwin', '201052043', 'Paris, ON', 'F', 890000, '359624751', 11, '1992-07-07', '2014-10-01');
INSERT INTO public.employee (fname, minit, lname, ssn, address, sex, salary, super_ssn, dno, bdate, empdate) VALUES ('Angelika', 'H', 'Ayers', '201073976', 'Guelph, ON', 'F', 56000, '202058568', 11, '1971-01-26', '1995-10-09');
INSERT INTO public.employee (fname, minit, lname, ssn, address, sex, salary, super_ssn, dno, bdate, empdate) VALUES ('Jared', 'K', 'Aziz', '201165466', 'London, ON', 'M', 50000, '987654321', 4, '1990-12-15', '2011-05-20');
INSERT INTO public.employee (fname, minit, lname, ssn, address, sex, salary, super_ssn, dno, bdate, empdate) VALUES ('Emma', 'L', 'Azizi', '201272287', 'Hamilton, ON', 'F', 40000, '123456789', 24, '1988-10-03', '2013-05-11');
INSERT INTO public.employee (fname, minit, lname, ssn, address, sex, salary, super_ssn, dno, bdate, empdate) VALUES ('Kelly', 'W', 'Barham', '201443758', 'Hamilton, ON', 'F', 140000, '843025296', 24, '1989-03-06', '2009-07-15');
INSERT INTO public.employee (fname, minit, lname, ssn, address, sex, salary, super_ssn, dno, bdate, empdate) VALUES ('Charlotte', 'Q', 'Balahura', '201450220', 'Guelph, ON', 'F', 65000, '629575266', 24, '1990-12-03', '2012-05-26');
INSERT INTO public.employee (fname, minit, lname, ssn, address, sex, salary, super_ssn, dno, bdate, empdate) VALUES ('Colin', 'R', 'Baroey', '201654020', 'Guelph, ON', 'M', 70000, '444555777', 2, '1988-03-09', '2013-03-02');
INSERT INTO public.employee (fname, minit, lname, ssn, address, sex, salary, super_ssn, dno, bdate, empdate) VALUES ('Ashley', 'V', 'Barta', '201739519', 'London, ON', 'F', 72000, '333445555', 1, '1967-02-08', '1988-05-02');
INSERT INTO public.employee (fname, minit, lname, ssn, address, sex, salary, super_ssn, dno, bdate, empdate) VALUES ('MacKenzie', 'A', 'Barsky', '201774583', 'Paris, ON', 'M', 99000, '987654321', 4, '1986-06-29', '2008-01-01');
INSERT INTO public.employee (fname, minit, lname, ssn, address, sex, salary, super_ssn, dno, bdate, empdate) VALUES ('Catherine', 'B', 'Bartlett', '201941078', 'Hamilton, ON', 'F', 80000, '315565726', 24, '1990-10-15', '2012-07-05');
INSERT INTO public.employee (fname, minit, lname, ssn, address, sex, salary, super_ssn, dno, bdate, empdate) VALUES ('Catherine', 'I', 'Bartley', '201959328', 'Guelph, ON', 'F', 150000, '315565726', 24, '1990-04-07', '2014-07-04');
INSERT INTO public.employee (fname, minit, lname, ssn, address, sex, salary, super_ssn, dno, bdate, empdate) VALUES ('Richard', 'T', 'Ramla', '202058568', 'Houston,, TX', 'M', 90000, '296045397', 5, '1993-04-24', '2016-07-10');
INSERT INTO public.employee (fname, minit, lname, ssn, address, sex, salary, super_ssn, dno, bdate, empdate) VALUES ('Sarah', 'A', 'Walters', '202176619', 'Hamilton, ON', 'F', 132000, '296045397', 11, '1989-12-14', '2011-08-16');
INSERT INTO public.employee (fname, minit, lname, ssn, address, sex, salary, super_ssn, dno, bdate, empdate) VALUES ('Denzel', 'O', 'Washington', '202185616', 'Guelph, ON', 'M', 150000, '202058568', 11, '1965-05-06', '1986-01-31');
INSERT INTO public.employee (fname, minit, lname, ssn, address, sex, salary, super_ssn, dno, bdate, empdate) VALUES ('Cassandra', 'D', 'Jonesboro', '202247633', 'Guelph, ON', 'F', 80000, '987654321', 4, '1983-04-06', '2006-06-25');
INSERT INTO public.employee (fname, minit, lname, ssn, address, sex, salary, super_ssn, dno, bdate, empdate) VALUES ('Kaitlyn', 'G', 'Anderson', '202428993', 'Paris, ON', 'F', 84000, '888665555', 1, '1996-05-16', '2016-11-15');
INSERT INTO public.employee (fname, minit, lname, ssn, address, sex, salary, super_ssn, dno, bdate, empdate) VALUES ('Aaron', 'Z', 'Austin', '202561262', 'Guelph, ON', 'M', 86000, '888665555', 24, '1988-07-22', '2011-07-08');
INSERT INTO public.employee (fname, minit, lname, ssn, address, sex, salary, super_ssn, dno, bdate, empdate) VALUES ('Tony', 'W', 'Saunders', '202561319', 'Hamilton, ON', 'M', 86000, '333445555', 4, '1993-10-05', '2017-01-24');
INSERT INTO public.employee (fname, minit, lname, ssn, address, sex, salary, super_ssn, dno, bdate, empdate) VALUES ('Emily', 'S', 'Nicholson', '202744742', 'London, ON', 'F', 50000, '987654321', 4, '1971-03-10', '1995-08-14');
INSERT INTO public.employee (fname, minit, lname, ssn, address, sex, salary, super_ssn, dno, bdate, empdate) VALUES ('Karly', 'A', 'Selles', '202785848', 'Paris, ON', 'F', 100000, '987654321', 4, '1974-09-22', '1998-04-21');
INSERT INTO public.employee (fname, minit, lname, ssn, address, sex, salary, super_ssn, dno, bdate, empdate) VALUES ('Laurence', 'C', 'De Niro', '202860324', 'Hamilton, ON', 'M', 40000, '999999999', 5, '1977-10-20', '1999-11-15');
INSERT INTO public.employee (fname, minit, lname, ssn, address, sex, salary, super_ssn, dno, bdate, empdate) VALUES ('Valentine', 'X', 'Muravyov', '218167890', 'Waldorf, MD', 'M', 80000, '444555777', 2, '1997-09-07', '2020-06-15');
INSERT INTO public.employee (fname, minit, lname, ssn, address, sex, salary, super_ssn, dno, bdate, empdate) VALUES ('Tushar', 'L', 'Dobhal', '222222222', 'Houston, TX', 'M', 70000, '999999999', 5, '1999-12-03', '2022-03-06');
INSERT INTO public.employee (fname, minit, lname, ssn, address, sex, salary, super_ssn, dno, bdate, empdate) VALUES ('James', 'O', 'Bond', '231456456', 'London, On', 'M', 25000, '888665555', 1, '1993-11-04', '2013-11-11');
INSERT INTO public.employee (fname, minit, lname, ssn, address, sex, salary, super_ssn, dno, bdate, empdate) VALUES ('William', 'M', 'Rawson', '232171234', 'Herndon, WV', 'M', 60000, '444555777', 2, '1989-10-30', '2010-05-24');
INSERT INTO public.employee (fname, minit, lname, ssn, address, sex, salary, super_ssn, dno, bdate, empdate) VALUES ('Michael', 'M', 'Monroe', '268268702', 'Toronto, On', 'M', 54000, '359624751', 11, '1993-12-15', '2016-03-04');
INSERT INTO public.employee (fname, minit, lname, ssn, address, sex, salary, super_ssn, dno, bdate, empdate) VALUES ('Leonard', 'K', 'Carnes', '295501234', 'Convoy, OH', 'M', 127000, '444555777', 2, '1973-08-06', '1996-02-13');
INSERT INTO public.employee (fname, minit, lname, ssn, address, sex, salary, super_ssn, dno, bdate, empdate) VALUES ('Shuchi', 'A', 'Pandit', '296045397', 'Guelph,, ON', 'F', 980000, '888665555', 4, '1985-05-06', '2007-10-29');
INSERT INTO public.employee (fname, minit, lname, ssn, address, sex, salary, super_ssn, dno, bdate, empdate) VALUES ('Melissa', 'K', 'Iv', '306737594', 'Toronto,, On', 'F', 164000, '460836586', 11, '1994-06-03', '2017-02-11');
INSERT INTO public.employee (fname, minit, lname, ssn, address, sex, salary, super_ssn, dno, bdate, empdate) VALUES ('Heidi', 'N', 'Klum', '315565726', 'Guelph, ON', 'F', 240000, '925468826', 24, '1974-08-23', '1998-06-27');
INSERT INTO public.employee (fname, minit, lname, ssn, address, sex, salary, super_ssn, dno, bdate, empdate) VALUES ('Karen', 'T', 'Winters', '321400789', 'Houston, TX', 'F', 180000, '333445555', 5, '1973-07-03', '1993-09-09');
INSERT INTO public.employee (fname, minit, lname, ssn, address, sex, salary, super_ssn, dno, bdate, empdate) VALUES ('Jean', 'C', 'Taylor', '321456789', 'Houston, TX', 'M', 160000, '333445555', 5, '1997-03-06', '2020-07-30');
INSERT INTO public.employee (fname, minit, lname, ssn, address, sex, salary, super_ssn, dno, bdate, empdate) VALUES ('Alex', 'Q', 'Gaijic', '333333333', 'Houston, TX', 'M', 40000, '999999999', 5, '1964-06-21', '1987-04-25');
INSERT INTO public.employee (fname, minit, lname, ssn, address, sex, salary, super_ssn, dno, bdate, empdate) VALUES ('Frank', 'T', 'Wong', '333445555', 'Houston, TX', 'M', 80000, '888665555', 5, '1997-06-26', '2020-10-28');
INSERT INTO public.employee (fname, minit, lname, ssn, address, sex, salary, super_ssn, dno, bdate, empdate) VALUES ('Trevor', 'T', 'Davis', '338888555', 'Almonte, ON', 'M', 100000, '987654321', 4, '1996-03-24', '2020-11-28');
INSERT INTO public.employee (fname, minit, lname, ssn, address, sex, salary, super_ssn, dno, bdate, empdate) VALUES ('Josiah', 'H', 'Timmins', '353467409', 'Guelph, ON', 'M', 130000, '888665555', 7, '1983-09-21', '2008-05-18');
INSERT INTO public.employee (fname, minit, lname, ssn, address, sex, salary, super_ssn, dno, bdate, empdate) VALUES ('Cindy', 'H', 'Crawford', '359624751', 'Toronto, On', 'F', 164000, '888665555', 11, '1986-02-21', '2009-12-25');
INSERT INTO public.employee (fname, minit, lname, ssn, address, sex, salary, super_ssn, dno, bdate, empdate) VALUES ('Mohammad', 'P', 'Ali', '444444444', 'Houston, TX', 'M', 10000, '999999999', 5, '1995-10-03', '2019-05-15');
INSERT INTO public.employee (fname, minit, lname, ssn, address, sex, salary, super_ssn, dno, bdate, empdate) VALUES ('Jean', 'J', 'Lansing', '444555777', 'Milwaukee, WI', 'F', 227000, 'null     ', 2, '1982-01-27', '2002-04-29');
INSERT INTO public.employee (fname, minit, lname, ssn, address, sex, salary, super_ssn, dno, bdate, empdate) VALUES ('Bonnie', 'Z', 'Baker', '449721234', 'Richardson, TX', 'F', 27000, '444555777', 2, '1998-08-12', '2022-07-16');
INSERT INTO public.employee (fname, minit, lname, ssn, address, sex, salary, super_ssn, dno, bdate, empdate) VALUES ('Joyce', 'A', 'Roberts', '453422453', 'Houston, TX', 'F', 150000, '333445555', 5, '1996-03-16', '2018-07-28');
INSERT INTO public.employee (fname, minit, lname, ssn, address, sex, salary, super_ssn, dno, bdate, empdate) VALUES ('Joyce', 'A', 'English', '453453453', 'Houston, TX', 'F', 50000, '333445555', 5, '1963-06-28', '1987-10-15');
INSERT INTO public.employee (fname, minit, lname, ssn, address, sex, salary, super_ssn, dno, bdate, empdate) VALUES ('Carmel', 'D', 'Schembri', '460836586', 'Guelph,, On', 'M', 197000, '807844760', 4, '1992-05-29', '2012-07-05');
INSERT INTO public.employee (fname, minit, lname, ssn, address, sex, salary, super_ssn, dno, bdate, empdate) VALUES ('Paula', 'J', 'Krach', '515821234', 'Elk City, KS', 'F', 67000, '444555777', 2, '1972-04-19', '1992-08-26');
INSERT INTO public.employee (fname, minit, lname, ssn, address, sex, salary, super_ssn, dno, bdate, empdate) VALUES ('Shannon', 'C', 'Page', '546031234', 'Redmond, WA', 'M', 170000, '444555777', 2, '1992-01-05', '2015-05-02');
INSERT INTO public.employee (fname, minit, lname, ssn, address, sex, salary, super_ssn, dno, bdate, empdate) VALUES ('Pamela', 'A', 'English', '546546877', 'Guelph, On', 'F', 56000, '359624751', 11, '1984-08-02', '2005-11-01');
INSERT INTO public.employee (fname, minit, lname, ssn, address, sex, salary, super_ssn, dno, bdate, empdate) VALUES ('Khadijah', 'L', 'Sabbagh', '550561234', 'Arroyo, CA', 'F', 123000, '444555777', 2, '1972-03-02', '1993-06-08');
INSERT INTO public.employee (fname, minit, lname, ssn, address, sex, salary, super_ssn, dno, bdate, empdate) VALUES ('Scott', 'A', 'Dougan', '558181999', 'Midland, ON', 'M', 200000, '333445555', 5, '1987-09-08', '2010-07-24');
INSERT INTO public.employee (fname, minit, lname, ssn, address, sex, salary, super_ssn, dno, bdate, empdate) VALUES ('Rachel', 'A', 'Castillo', '560123563', 'Guelph,, On', 'F', 56000, '202058568', 11, '1964-01-22', '1986-05-24');
INSERT INTO public.employee (fname, minit, lname, ssn, address, sex, salary, super_ssn, dno, bdate, empdate) VALUES ('Donald', 'F', 'Regan', '566879301', 'Toronto, On', 'M', 890000, '359624751', 11, '1998-10-08', '2022-06-28');
INSERT INTO public.employee (fname, minit, lname, ssn, address, sex, salary, super_ssn, dno, bdate, empdate) VALUES ('Delores', 'E', 'Patterson', '606088000', 'Orangeville, ON', 'F', 50000, '987654321', 4, '1988-04-04', '2008-06-12');
INSERT INTO public.employee (fname, minit, lname, ssn, address, sex, salary, super_ssn, dno, bdate, empdate) VALUES ('Rosie', 'N', 'Jones', '607465254', 'Fredericton, NB', 'F', 40000, '123456789', 24, '1966-01-08', '1988-02-07');
INSERT INTO public.employee (fname, minit, lname, ssn, address, sex, salary, super_ssn, dno, bdate, empdate) VALUES ('Daniela', 'N', 'Pestova', '629568526', 'St. Johns, NF', 'F', 65000, '629575266', 24, '1990-11-28', '2013-01-30');
INSERT INTO public.employee (fname, minit, lname, ssn, address, sex, salary, super_ssn, dno, bdate, empdate) VALUES ('Brooklyn', 'N', 'Decker', '629575266', 'Guelph, ON', 'F', 140000, '843025296', 24, '1965-11-27', '1985-11-30');
INSERT INTO public.employee (fname, minit, lname, ssn, address, sex, salary, super_ssn, dno, bdate, empdate) VALUES ('Carolyn', 'D', 'Dattilo', '631541234', 'Redmond, WA', 'F', 70000, '444555777', 2, '1991-12-10', '2015-01-10');
INSERT INTO public.employee (fname, minit, lname, ssn, address, sex, salary, super_ssn, dno, bdate, empdate) VALUES ('Imran', 'Z', 'Kanji', '666258951', 'Guelph, On', 'M', 99000, '987654321', 4, '1966-12-08', '1991-01-31');


--
-- TOC entry 3639 (class 0 OID 16599)
-- Dependencies: 221
-- Data for Name: project; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.project (pname, pnumber, plocation, dnum) VALUES ('ProductX', 1, 'Bellaire', 5);
INSERT INTO public.project (pname, pnumber, plocation, dnum) VALUES ('ProductY', 2, 'Sugarland', 5);
INSERT INTO public.project (pname, pnumber, plocation, dnum) VALUES ('ProductZ', 3, 'Houston', 5);
INSERT INTO public.project (pname, pnumber, plocation, dnum) VALUES ('Tesseract', 4, 'Redmond', 2);
INSERT INTO public.project (pname, pnumber, plocation, dnum) VALUES ('Computerization', 10, 'Stafford', 4);
INSERT INTO public.project (pname, pnumber, plocation, dnum) VALUES ('MancalaGame', 15, 'Sugarland', 5);
INSERT INTO public.project (pname, pnumber, plocation, dnum) VALUES ('Reorganization', 20, 'Houston', 1);
INSERT INTO public.project (pname, pnumber, plocation, dnum) VALUES ('VSecret', 24, 'Guelph', 24);
INSERT INTO public.project (pname, pnumber, plocation, dnum) VALUES ('Newbenefits', 30, 'Stafford', 4);
INSERT INTO public.project (pname, pnumber, plocation, dnum) VALUES ('Construction', 44, 'Sugarland', 5);
INSERT INTO public.project (pname, pnumber, plocation, dnum) VALUES ('Innovation', 117, 'Guelph', 11);
INSERT INTO public.project (pname, pnumber, plocation, dnum) VALUES ('Fraud', 118, 'Toronto', 11);


--
-- TOC entry 3642 (class 0 OID 16612)
-- Dependencies: 224
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.users (id, username, password, role) VALUES (1, 'admin', 'scrypt:32768:8:1$eVxhamUwGe7F1hkW$7e666f206ed752448ffdc1da80995706d2cb9949f0892af17c597ed9b65b5dbf0eb2aad5db67c839dc6ccf61988a029acf63318a8ba03e5160fd63887ebd2e4c', 'admin');
INSERT INTO public.users (id, username, password, role) VALUES (2, 'user', 'scrypt:32768:8:1$EUrCLXTOuqAybK9F$ae5beb3474936da09dca98ddeaefe86190efd8b72627241d24034a38ef02f2a9cb2e7ca1d0b94478533acbe75e8e7e4928ac16fc3c81f84bf05ee3f8261542e8', 'user');


--
-- TOC entry 3640 (class 0 OID 16606)
-- Dependencies: 222
-- Data for Name: works_on; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.works_on (essn, pno, hours) VALUES ('100040001', 2, 6.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('111111111', 3, 20.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('111111111', 20, 20.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('111222333', 1, 6.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('111222333', 3, 15.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('123456789', 1, 33.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('123456789', 2, 8.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('198782427', 4, 40.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('198928552', 10, 20.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('198928552', 30, 20.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('199098293', 117, 40.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('199171129', 15, 20.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('199171129', 44, 20.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('199196331', 24, 35.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('199196331', 118, 5.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('199302835', 15, 25.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('199302835', 44, 15.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('199305628', 3, 23.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('199305628', 15, 15.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('199489442', 3, 5.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('199489442', 15, 15.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('199489442', 44, 20.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('199608611', 10, 18.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('199608611', 30, 22.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('199685000', 44, 40.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('199705791', 117, 40.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('199923690', 44, 35.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('200002511', 4, 37.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('200178650', 4, 40.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('200243095', 44, 39.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('200352295', 30, 40.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('200369792', 44, 40.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('200493155', 4, 35.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('200587814', 4, 37.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('200626576', 117, 40.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('200757441', 4, 39.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('200802224', 44, 40.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('201052043', 117, 35.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('201073976', 117, 40.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('201165466', 30, 37.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('201272287', 24, 40.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('201443758', 24, 40.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('201450220', 24, 39.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('201654020', 4, 40.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('201739519', 44, 37.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('201774583', 30, 35.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('201941078', 24, 40.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('201959328', 24, 39.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('202176619', 117, 40.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('202185616', 117, 40.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('202247633', 30, 35.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('202428993', 20, 37.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('202561262', 24, 39.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('202561319', 30, 40.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('202744742', 30, 40.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('202785848', 30, 40.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('202860324', 44, 35.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('218167890', 4, 20.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('222222222', 3, 35.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('222222222', 20, 5.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('231456456', 20, 12.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('268268702', 117, 35.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('315565726', 24, 33.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('321400789', 15, 10.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('321400789', 20, 3.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('321400789', 30, 5.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('321400789', 117, 2.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('321456789', 2, 7.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('321456789', 44, 33.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('333333333', 20, 40.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('333445555', 1, 3.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('333445555', 2, 6.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('333445555', 3, 7.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('333445555', 10, 10.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('333445555', 15, 10.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('333445555', 20, 3.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('333445555', 30, 5.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('333445555', 117, 2.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('338888555', 10, 11.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('359624751', 117, 25.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('359624751', 118, 15.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('444555777', 4, 18.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('453422453', 2, 20.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('453422453', 44, 20.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('453453453', 1, 20.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('453453453', 2, 20.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('515821234', 4, 20.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('546031234', 4, 5.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('546546877', 118, 40.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('558181999', 3, 35.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('566879301', 118, 40.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('606088000', 20, 17.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('607465254', 24, 33.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('629575266', 24, 33.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('631541234', 4, 10.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('666258951', 10, 40.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('666884444', 3, 40.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('681525266', 24, 33.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('888445555', 20, 15.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('888445555', 30, 20.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('891029345', 2, 5.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('891029345', 3, 7.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('891029345', 10, 10.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('891029345', 44, 3.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('925468826', 24, 33.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('987654001', 3, 40.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('987654001', 20, 15.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('987654001', 30, 20.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('987654321', 20, 15.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('987654321', 30, 20.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('987789987', 10, 35.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('987789987', 30, 5.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('987987987', 10, 35.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('987987987', 30, 5.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('999117777', 10, 10.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('999117777', 30, 30.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('999887777', 10, 10.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('999887777', 30, 30.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('999999999', 3, 20.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('999999999', 20, 20.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('105947378', 118, 32.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('202058568', 118, 33.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('232171234', 118, 20.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('295501234', 118, 33.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('296045397', 118, 23.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('306737594', 118, 18.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('353467409', 118, 38.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('444444444', 118, 22.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('449721234', 118, 34.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('460836586', 118, 26.0);
INSERT INTO public.works_on (essn, pno, hours) VALUES ('550561234', 118, 32.0);


--
-- TOC entry 3649 (class 0 OID 0)
-- Dependencies: 223
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 2, true);


--
-- TOC entry 3475 (class 2606 OID 16593)
-- Name: department department_dname_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.department
    ADD CONSTRAINT department_dname_key UNIQUE (dname);


--
-- TOC entry 3477 (class 2606 OID 16591)
-- Name: department department_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.department
    ADD CONSTRAINT department_pkey PRIMARY KEY (dnumber);


--
-- TOC entry 3473 (class 2606 OID 16586)
-- Name: dependent dependent_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dependent
    ADD CONSTRAINT dependent_pkey PRIMARY KEY (essn, dependent_name);


--
-- TOC entry 3479 (class 2606 OID 16598)
-- Name: dept_location dept_location_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dept_location
    ADD CONSTRAINT dept_location_pkey PRIMARY KEY (dnumber, dlocation);


--
-- TOC entry 3469 (class 2606 OID 16581)
-- Name: employee employee_fname_lname_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee
    ADD CONSTRAINT employee_fname_lname_key UNIQUE (fname, lname);


--
-- TOC entry 3471 (class 2606 OID 16579)
-- Name: employee employee_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee
    ADD CONSTRAINT employee_pkey PRIMARY KEY (ssn);


--
-- TOC entry 3481 (class 2606 OID 16603)
-- Name: project project_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.project
    ADD CONSTRAINT project_pkey PRIMARY KEY (pnumber);


--
-- TOC entry 3483 (class 2606 OID 16605)
-- Name: project project_pname_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.project
    ADD CONSTRAINT project_pname_key UNIQUE (pname);


--
-- TOC entry 3487 (class 2606 OID 16617)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 3489 (class 2606 OID 16619)
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- TOC entry 3485 (class 2606 OID 16610)
-- Name: works_on works_on_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.works_on
    ADD CONSTRAINT works_on_pkey PRIMARY KEY (essn, pno);


-- Completed on 2024-11-06 18:20:49 EST

--
-- PostgreSQL database dump complete
--

