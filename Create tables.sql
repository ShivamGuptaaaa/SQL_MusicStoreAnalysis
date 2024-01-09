-- 1. Album
CREATE TABLE album(
album_id character varying(50) NOT NULL,
    title character varying(120),
    artist_id character varying(30)
	)
-- Export values from excel files


-- 2. Artist
CREATE TABLE artist(
    artist_id character varying(50) NOT NULL,
    name character varying(120)
)
-- Export values from excel files


-- 3. Customer
CREATE TABLE customer(
	customer_id integer NOT NULL,
    first_name character(50),
    last_name character(50),
    company character varying(120),
    address character varying(120),
    city character varying(50),
    state character varying(50),
    country character varying(50),
    postal_code character varying(50),
    phone character varying(50),
    fax character varying(50),
    email character varying(50),
    support_rep_id integer
)
-- Export Values from excel files


-- 4. Employee
CREATE TABLE employee(
    employee_id character varying(50) NOT NULL,
    last_name character(50),
    first_name character(50),
    title character varying(50),
    reports_to character varying(30),
    levels character varying(10),
    birthdate timestamp without time zone,
    hire_date timestamp without time zone,
    address character varying(120),
    city character varying(50),
    state character varying(50),
    country character varying(30),
    postal_code character varying(30),
    phone character varying(30),
    fax character varying(30),
    email character varying(30)
);
-- Export values from excel files


-- 5. Genre
CREATE TABLE genre(
    genre_id character varying(50) NOT NULL,
    name character varying(120)
)
-- Export values from excel file


-- 6. Ivoice
CREATE TABLE invoice(
	invoice_id integer NOT NULL,
    customer_id integer,
    invoice_date timestamp without time zone,
    billing_address character varying(120),
    billing_city character varying(30),
    billing_state character varying(30),
    billing_country character varying(30),
    billing_postal character varying(30),
    total double precision
)
-- Export values from excel files



-- 7. Invocie_line
CREATE TABLE invoice_line(
	invoice_line_id character varying(50) NOT NULL,
    invoice_id integer,
    track_id integer,
    unit_price double precision,
    quantity double precision
)
-- Export values from excel file



-- 8.Media_type
CREATE TABLE media_type (
    media_type_id character varying(50) NOT NULL,
    name character varying(120)
);
-- Export values from excel files


-- 9. Playlist
CREATE TABLE playlist (
    playlist_id character varying(50) NOT NULL,
    name character varying(120)
);
-- Export values from excel files


-- 10. Playlist track
CREATE TABLE public.playlist_track (
    playlist_id character varying(50),
    track_id integer
	);
-- Export values from excel files

-- 11. Track
CREATE TABLE public.track (
    track_id integer NOT NULL,
    name character varying(150),
    album_id character varying(50),
    media_type_id character varying(50),
    genre_id character varying(50),
    composer character varying(190),
    milliseconds integer,
    bytes integer,
    unit_price double precision
);
-- Export values from excel files
