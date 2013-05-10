-- Function: crumb_can_reply(integer, character varying, real, real)
--
-- Database engine: PostgreSQL 9.2
-- Dependencies: `earthdistance' extension
--
-- Determine whether a user can reply to a given crumb.
--
-- @author: Dan Church <h3xx@gmx.com>
-- @license: GPL v3.0

-- DROP FUNCTION crumb_can_reply(integer, character varying, real, real);

CREATE OR REPLACE FUNCTION crumb_can_reply(_who integer, _crumb_id character varying, _user_lat real, _user_lon real)
  RETURNS boolean AS
$BODY$

declare
	_owner		integer;
	_crumb_lat	real;
	_crumb_lon	real;
	_locked		boolean;
	_dist		float8;
	_dist_lim	float8	:= 50; -- FIXME : move to config somehow

begin

	select
		into _crumb_lat, _crumb_lon, _owner
		"crumb"."lat", "crumb"."lon", "crumb"."owner"
		from "crumb"
		left join (
			select "about" from "user_block" where "who" = _who
		) as "blk" on ("crumb"."owner" = "blk"."about")
		where
			"crumb_id" = _crumb_id and
			"blk"."about" is null and 
			"active";

	if not found then
		--raise exception 'Crumb not found.';
		return null;
	end if;

	-- users can always reply to their own posts
	if _who = _owner then
		return true;
	end if;

	/*
	_locked := true; -- XXX : crumbs are always locked to remote replies

	-- not restricted in any way
	if not _locked then
		return true;
	end if;
	*/

	-- if we're within limit, okay
	_dist := earth_distance(ll_to_earth(_user_lat, _user_lon), ll_to_earth(_crumb_lat, _crumb_lon));
	if _dist > _dist_lim then
		return false;
	end if;

	return true;

end;

$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
