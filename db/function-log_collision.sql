-- Function: log_collision(character varying)
--
-- Database engine: PostgreSQL 9.2
--
-- Log a random string collision.
--
-- @author: Dan Church <h3xx@gmx.com>
-- @license: GPL v3.0

-- DROP FUNCTION log_collision(character varying);

CREATE OR REPLACE FUNCTION log_collision(_msg character varying)
  RETURNS boolean AS
$BODY$

begin

	insert
		into "log"
		("log_type", "log_msg")
		values('collision', _msg);

	return true;
end;

$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
