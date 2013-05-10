-- Table: crumb

-- DROP TABLE crumb;

CREATE TABLE crumb
(
  crumb_id character varying(15) NOT NULL DEFAULT random_string(15),
  locked_read boolean NOT NULL DEFAULT false, -- Whether reading this crumb is locked to users in the area.
  posted_time timestamp without time zone NOT NULL DEFAULT now(), -- When the crumb was posted.
  owner integer NOT NULL, -- Who owns this crumb.
  message character varying(1024), -- The crumb's payload.
  reply_to character varying(15), -- The crumb this is a reply to (if any).
  lat real NOT NULL, -- Where the crumb is located (latitude).
  lon real NOT NULL, -- Where the crumb is located (longitude).
  active boolean NOT NULL DEFAULT true, -- Whether this crumb hasn't been deleted yet.
  CONSTRAINT crumb_pkey PRIMARY KEY (crumb_id),
  CONSTRAINT crumb_owner_fkey FOREIGN KEY (owner)
      REFERENCES "user" (user_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT crumb_reply_to_fkey FOREIGN KEY (reply_to)
      REFERENCES crumb (crumb_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
COMMENT ON TABLE crumb
  IS 'Crumbs.';
COMMENT ON COLUMN crumb.locked_read IS 'Whether reading this crumb is locked to users in the area.';
COMMENT ON COLUMN crumb.posted_time IS 'When the crumb was posted.';
COMMENT ON COLUMN crumb.owner IS 'Who owns this crumb.';
COMMENT ON COLUMN crumb.message IS 'The crumb''s payload.';
COMMENT ON COLUMN crumb.reply_to IS 'The crumb this is a reply to (if any).';
COMMENT ON COLUMN crumb.active IS 'Whether this crumb hasn''t been deleted yet.';
COMMENT ON COLUMN crumb.lat IS 'Where the crumb is located (latitude).';
COMMENT ON COLUMN crumb.lon IS 'Where the crumb is located (longitude).';

-- Index: crumb_lat_idx

-- DROP INDEX crumb_lat_idx;

CREATE INDEX crumb_lat_idx
  ON crumb
  USING btree
  (lat);

-- Index: crumb_lon_idx

-- DROP INDEX crumb_lon_idx;

CREATE INDEX crumb_lon_idx
  ON crumb
  USING btree
  (lon);

