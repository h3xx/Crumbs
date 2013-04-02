-- Table: user_block

-- DROP TABLE user_block;

CREATE TABLE user_block
(
  who integer NOT NULL, -- Who is doing the blocking.
  about integer NOT NULL, -- Who is being blocked.
  CONSTRAINT block_pkey PRIMARY KEY (who, about),
  CONSTRAINT block_about_fkey FOREIGN KEY (about)
      REFERENCES "user" (user_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT block_who_fkey FOREIGN KEY (who)
      REFERENCES "user" (user_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE user_block
  OWNER TO odbc;
COMMENT ON TABLE user_block
  IS 'User block lists.';
COMMENT ON COLUMN user_block.who IS 'Who is doing the blocking.';
COMMENT ON COLUMN user_block.about IS 'Who is being blocked.';
