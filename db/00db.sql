-- Database: crumbs

-- DROP DATABASE crumbs;

CREATE DATABASE crumbs
  WITH
       ENCODING = 'UTF8'
       TABLESPACE = pg_default
       LC_COLLATE = 'C'
       LC_CTYPE = 'C'
       CONNECTION LIMIT = -1;

create extension pgcrypto;
create extension cube;
create extension earthdistance;
