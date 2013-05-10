-- Function: crumb_list(integer, real, real)
--
-- Database engine: PostgreSQL 9.2
-- Dependencies: `earthdistance' extension
--
-- List crumbs in area, given that:
--
-- * The user hasn't ignored the user who posted.
--
-- @author: Dan Church <h3xx@gmx.com>
-- @license: GPL v3.0

-- DROP FUNCTION crumb_list(integer, real, real, integer);

CREATE OR REPLACE FUNCTION crumb_list(_who integer, _user_lat real, _user_lon real, _lim integer)
  RETURNS table (
  	"crumb_id"	character varying,
	"user"		character varying,
	"lat"		real,
	"lon"		real
  ) AS
$BODY$

begin

	if _lim is null then
		_lim := 50;
	elsif _lim < 1 then
		_lim := 1;
	elsif _lim > 100 then
		_lim := 100;
	end if;

	-- and not a fuck was given that day
	if _who is null then
		return query
		select
			"crumb"."crumb_id",
			"user"."user_name",
			"crumb"."lat", "crumb"."lon"
			from "crumb"
			left join "user" on ("crumb"."owner" = "user"."user_id")
			where
				"crumb"."active" and
				"crumb"."lat" > _user_lat - 1 and
				"crumb"."lat" < _user_lat + 1 and
				"crumb"."lon" > _user_lon - 1 and
				"crumb"."lon" < _user_lon + 1
				
				order by crumb_rank("crumb"."posted_time", "crumb"."lat", "crumb"."lon", _user_lat, _user_lon)

				limit _lim;
	else

		return query
		select
			"crumb"."crumb_id",
			"user"."user_name",
			"crumb"."lat", "crumb"."lon"
			from "crumb"
			left join "user" on ("crumb"."owner" = "user"."user_id")
			left join (
				select "about" from "user_block" where "who" = _who
			) as "blk" on ("crumb"."owner" = "blk"."about")
			where
				"crumb"."active" and
				"blk"."about" is null and 
				"crumb"."lat" > _user_lat - 1 and
				"crumb"."lat" < _user_lat + 1 and
				"crumb"."lon" > _user_lon - 1 and
				"crumb"."lon" < _user_lon + 1

				order by crumb_rank("crumb"."posted_time", "crumb"."lat", "crumb"."lon", _user_lat, _user_lon)

				limit _lim;
	end if;

end;

$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
