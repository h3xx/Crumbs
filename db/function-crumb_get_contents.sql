-- Function: crumb_get_contents(integer, character varying)
--
-- Database engine: PostgreSQL 9.2
--
-- Gets the contents of a single crumb.
--
-- @author: Dan Church <h3xx@gmx.com>
-- @license: GPL v3.0

-- DROP FUNCTION crumb_get_contents(integer, character varying)

CREATE OR REPLACE FUNCTION crumb_get_contents(_who integer, _crumb_id character varying)
  RETURNS table (
  	"id"		character varying,
	"user"		character varying,
	"lat"		real,
	"lon"		real,
	"msg"		character varying
  ) AS
$BODY$

begin

	return query
	select
		"crumb"."crumb_id" as "id",
		"user"."user_name" as "user",
		"crumb"."lat", "crumb"."lon",
		"crumb"."message" as "msg"
		from "crumb"
		left join "user" on ("crumb"."owner" = "user"."user_id")
		where
			"active" and
			"crumb_id" = _crumb_id;

	-- Naaah...
	--perform crumb_mark_read(_who, _crumb_id);

end;

$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
