-- Function: crumb_dist(character varying, point)
--
-- Database engine: PostgreSQL 9.2
-- Dependencies: `earthdistance' extension
--
-- Determine how far away a crumb is.
--
-- @author: Dan Church <h3xx@gmx.com>
-- @license: GPL v3.0

-- DROP FUNCTION crumb_dist(character varying, real, real);

CREATE OR REPLACE FUNCTION crumb_dist(_crumb_id character varying, _user_lat real, _user_lon real)
  RETURNS float8 AS
$BODY$

-- deprecated?
declare
	_crumb_lat	real;
	_crumb_lon	real;

begin

	select
		into _crumb_lat, _crumb_lon
		"crumb"."lat", "crumb"."lon"
		from "crumb"
		where
			"crumb_id" = _crumb_id and
			"active";

	if not found then
		--raise exception 'Crumb not found.';
		return null;
	end if;

	return earth_distance(ll_to_earth(_user_lat, _user_lon), ll_to_earth(_crumb_lat, _crumb_lon));
end;

$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
