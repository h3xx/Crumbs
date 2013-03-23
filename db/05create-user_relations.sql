-- Table: user_relations

-- DROP TABLE user_relations;

CREATE TABLE user_relations
(
  who integer NOT NULL, -- Who feels this way.
  about integer NOT NULL, -- Where these feelings are directed.
  feeling user_feeling NOT NULL, -- The type of feeling.
  CONSTRAINT user_relations_pkey PRIMARY KEY (who, about),
  CONSTRAINT user_relations_about_fkey FOREIGN KEY (about)
      REFERENCES "user" (user_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT user_relations_who_fkey FOREIGN KEY (who)
      REFERENCES "user" (user_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT user_relations_check CHECK (who <> about)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE user_relations
  OWNER TO odbc;
COMMENT ON TABLE user_relations
  IS 'Information about how users feel about each other (blocking, following, etc.)';
COMMENT ON COLUMN user_relations.who IS 'Who feels this way.';
COMMENT ON COLUMN user_relations.about IS 'Where these feelings are directed.';
COMMENT ON COLUMN user_relations.feeling IS 'The type of feeling.';
