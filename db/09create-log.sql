-- Table: log

-- DROP TABLE log;

CREATE TABLE log
(
  log_time timestamp without time zone NOT NULL DEFAULT now(),
  log_id serial NOT NULL,
  log_type character varying(10) NOT NULL DEFAULT 'misc'::character varying,
  log_msg character varying(1024) NOT NULL,
  CONSTRAINT log_pkey PRIMARY KEY (log_id)
)
WITH (
  OIDS=FALSE
);
COMMENT ON TABLE log
  IS 'Logging table (for monitoring).';
