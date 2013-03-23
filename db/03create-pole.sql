-- Table: pole
-- Dependencies: `earthdistance' extension

-- DROP TABLE pole;

CREATE TABLE pole
(
  pole_id character varying(10) NOT NULL DEFAULT random_string(10),
  pole_name character varying(128), -- The name of the place. E.g. "Joe's Diner".
  pos point NOT NULL, -- Where the sticking pole is located.
  locked_post boolean NOT NULL DEFAULT false, -- Whether posting to this sticking pole is locked to users in the area.
  locked_read boolean NOT NULL DEFAULT false, -- Whether reading posts at this sticking pole is locked to users in the area.
  post_distlimit double precision NOT NULL DEFAULT 50, -- How far away users can post to this sticking pole.
  read_distlimit double precision NOT NULL DEFAULT 150, -- How far away users can read from this sticking pole.
  owner integer NOT NULL, -- Who owns this sticking pole.
  private_post boolean NOT NULL DEFAULT false, -- Whether posting crumbs to this sticking pole is limited to a set of users.
  private_read boolean NOT NULL DEFAULT false, -- Whether reading crumbs from this sticking pole is limited to a set of users.
  CONSTRAINT pole_pkey PRIMARY KEY (pole_id),
  CONSTRAINT pole_owner_fkey FOREIGN KEY (owner)
      REFERENCES "user" (user_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
  CONSTRAINT pole_post_distlimit_check CHECK (post_distlimit > 0::double precision)
  CONSTRAINT pole_read_distlimit_check CHECK (read_distlimit > 0::double precision)
)
WITH (
  OIDS=FALSE
);
COMMENT ON TABLE pole
  IS 'Sticking poles.';
COMMENT ON COLUMN pole.pole_name IS 'The name of the place. E.g. "Joe''s Diner".';
COMMENT ON COLUMN pole.pos IS 'Where the sticking pole is located.';
COMMENT ON COLUMN pole.locked_post IS 'Whether posting to this sticking pole is locked to users in the area.';
COMMENT ON COLUMN pole.locked_read IS 'Whether reading crumbs at this sticking pole is locked to users in the area.';
COMMENT ON COLUMN pole.post_distlimit IS 'How far away users can post to this sticking pole.';
COMMENT ON COLUMN pole.read_distlimit IS 'How far away users can read from this sticking pole.';
COMMENT ON COLUMN pole.owner IS 'Who owns this sticking pole.';
COMMENT ON COLUMN pole.private_post IS 'Whether posting crumbs to this sticking pole is limited to a set of users.';
COMMENT ON COLUMN pole.private_read IS 'Whether reading crumbs from this sticking pole is limited to a set of users.';
