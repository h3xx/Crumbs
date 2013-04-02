-- Function: crumb_can_pole_post(integer, character varying, real, real);
--
-- Database engine: PostgreSQL 9.2
--
-- Determine whether a user can post on a given pole.
--
-- @author: Dan Church <h3xx@gmx.com>
-- @license: GPL v3.0

-- DROP FUNCTION crumb_can_pole_post(integer, character varying, real, real);

CREATE OR REPLACE FUNCTION crumb_can_pole_post(_who integer, _pole_id character varying, _user_lat real, _user_lon real)
  RETURNS boolean AS
$BODY$

declare
	_owner		integer;
	_pole_lat	real;
	_pole_lon	real;
	_pole_locked	boolean;
	_pole_distlimit	double precision;
	_dist		float8;

begin

	-- TODO : implement private sticking poles

	select
		into _pole_lat, _pole_lon, _pole_locked, _pole_distlimit, _owner
		"pole"."lat", "pole"."lon", "pole"."locked_post", "pole"."post_distlimit", "pole"."owner"
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
	_dist := earth_distance(ll_to_earth(_user_lat, _user_lon), ll_to_earth(_pole_lat, _pole_lon));
	if _dist > _pole_distlimit then
		return false;
	end if;

	return true;

end;

$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

