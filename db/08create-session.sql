-- Table: session

-- DROP TABLE session;

CREATE TABLE session
(
  id character varying(40) NOT NULL, -- Session id.
  data character varying(4096), -- Session data.
  CONSTRAINT session_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
COMMENT ON TABLE session
  IS 'Session variables.';
COMMENT ON COLUMN session.id IS 'Session id.';
COMMENT ON COLUMN session.data IS 'Session data.';
