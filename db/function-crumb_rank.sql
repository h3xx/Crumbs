-- Function: 
--
-- Database engine: PostgreSQL 9.2
-- Dependencies: `earthdistance' extension
--
-- Simple function to determine crumb ranking (for sorting).
--
-- Ranking is a function of age and distance.
--
-- NO selects.
--
-- @author: Dan Church <h3xx@gmx.com>
-- @license: GPL v3.0

-- DROP FUNCTION 

CREATE OR REPLACE FUNCTION crumb_rank(_when timestamp without time zone, _crumb_lat real, _crumb_lon real, _user_lat real, _user_lon real)
  RETURNS real AS
$BODY$

begin

	return crumb_rank(_when, ll_to_earth(_crumb_lat, _crumb_lon), ll_to_earth(_user_lat, _user_lon));

end;

$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

CREATE OR REPLACE FUNCTION crumb_rank(_when timestamp without time zone, _crumb_pos earth, _user_pos earth)
  RETURNS real AS
$BODY$

begin

	return earth_distance(_crumb_pos, _user_pos) / 1000 * extract(epoch from now() - _when);

end;

$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
