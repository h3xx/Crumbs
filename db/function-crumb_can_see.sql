-- Function: crumb_can_see(integer, character varying, point)
--
-- Database engine: PostgreSQL 9.2
-- Dependencies: `earthdistance' extension
--
-- Determine whether a user can see a given crumb.
--
-- @author: Dan Church <h3xx@gmx.com>
-- @license: GPL v3.0

-- DROP FUNCTION crumb_can_see(integer, character varying, point);

CREATE OR REPLACE FUNCTION crumb_can_see(_who integer, _crumb_id character varying, _user_pos point)
  RETURNS boolean AS
$BODY$

declare
	_owner		integer;
	_crumb_pos	point;
	_pole_pos	point;
	_crumb_locked	boolean;
	_pole_locked	boolean;
	_pole_distlimit	double precision;
	_pos		point;
	_locked		boolean;
	_dist		float8;
	_dist_lim	float8	:= 50; -- FIXME : move to config somehow

begin

	-- TODO : implement private sticking poles

	select
		into _crumb_pos, _pole_pos, _crumb_locked, _pole_locked, _pole_distlimit, _owner
		"crumb"."pos", "pole"."pos", "crumb"."locked_read", "pole"."locked_read", "pole"."read_distlimit", "crumb"."owner"
		from "crumb"
		left join "pole" on ("crumb"."pole_id" = "pole"."pole_id")
		where
			"crumb_id" = _crumb_id and
			"active";

	if not found then
		--raise exception 'Crumb not found.';
		return null;
	end if;

	-- users can always see their own posts
	if _who = _owner then
		return true;
	end if;

	-- pole settings supercedes individual crumb settings
	if _pole_pos is not null then
		_pos := _pole_pos;
		_locked := _pole_locked;
		_dist_lim := _pole_distlimit;
	else
		_pos := _crumb_pos;
		_locked := _crumb_locked;
	end if;

	-- not restricted in any way
	if not _locked then
		return true;
	end if;

	-- if we're within limit, okay
	_dist := geo_distance(_user_pos, _pos);
	if _dist > _dist_lim then
		return false;
	end if;

	return true;

end;

$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
