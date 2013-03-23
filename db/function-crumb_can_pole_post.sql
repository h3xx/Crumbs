-- Function: crumb_can_pole_post(integer, character varying, point);
--
-- Database engine: PostgreSQL 9.2
-- Dependencies: `earthdistance' extension
--
-- Determine whether a user can post on a given pole.
--
-- @author: Dan Church <h3xx@gmx.com>
-- @license: GPL v3.0

-- DROP FUNCTION crumb_can_pole_post(integer, character varying, point);

CREATE OR REPLACE FUNCTION crumb_can_pole_post(_who integer, _pole_id character varying, _user_pos point)
  RETURNS boolean AS
$BODY$

declare
	_owner		integer;
	_pole_pos	point;
	_pole_locked	boolean;
	_pole_distlimit	double precision;
	_dist		float8;

begin

	-- TODO : implement private sticking poles

	select
		into _pole_pos, _pole_locked, _pole_distlimit, _owner
		"pole"."pos", "pole"."locked_post", "pole"."post_distlimit", "pole"."owner"
		from "pole"
		where
			"pole_id" = _pole_id;

	if not found then
		raise exception 'Pole not found.';
		--return null;
	end if;

	-- users can always reply to their own posts
	if _who = _owner then
		return true;
	end if;

	-- not restricted in any way
	if not _pole_locked then
		return true;
	end if;

	-- if we're within limit, okay
	_dist := geo_distance(_user_pos, _pole_pos);
	if _dist > _pole_distlimit then
		return false;
	end if;

	return true;

end;

$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

