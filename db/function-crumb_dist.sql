-- Function: crumb_dist(character varying, point)
--
-- Database engine: PostgreSQL 9.2
-- Dependencies: `earthdistance' extension
--
-- Determine how far away a crumb is.
--
-- @author: Dan Church <h3xx@gmx.com>
-- @license: GPL v3.0

-- DROP FUNCTION crumb_dist(character varying, point);

CREATE OR REPLACE FUNCTION crumb_dist(_crumb_id character varying, _pos point)
  RETURNS float8 AS
$BODY$

-- deprecated?
declare
	_crumb_pos	point;
	_pole_pos	point;

begin

	select
		into _crumb_pos, _pole_pos
		"crumb"."pos", "pole"."pos"
		from "crumb"
		left join "pole" on ("crumb"."pole_id" = "pole"."pole_id")
		where
			"crumb_id" = _crumb_id and
			"active";

	if not found then
		--raise exception 'Crumb not found.';
		return null;
	end if;

	-- pole position supercedes individual crumb position
	if _pole_pos is null then
		return geo_distance(_pos, _crumb_pos);
	else
		return geo_distance(_pos, _pole_pos);
	end if;
end;

$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
