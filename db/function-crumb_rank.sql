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

CREATE OR REPLACE FUNCTION crumb_rank(_when timestamp without timezone, _where point, _pos point)
  RETURNS integer AS
$BODY$

declare
	_ago		integer;

begin

	_ago := extract(epoch from now() - _when);

	return (geo_distance(_where, _pos) * 1000 * _ago * _ago)::integer;

end;

$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
