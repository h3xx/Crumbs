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

-- DROP FUNCTION crumb_list(integer, real, real);

CREATE OR REPLACE FUNCTION crumb_list(_who integer, _user_lat real, _user_lon real)
  RETURNS table (
  	"crumb_id"	character varying,
	"user"		character varying,
	"lat"		real,
	"lon"		real,
  ) AS
$BODY$

begin

	return query
	select
		"crumb"."crumb_id",
		"user"."user_name",
		"crumb"."lat", "crumb"."lon",
		"pole"."pole_id",
		"pole"."lat", "pole"."lon"
		from "crumb"
		left join "pole" on ("crumb"."pole_id" = "pole"."pole_id")
		left join "user" on ("crumb"."owner" = "user"."user_id")
		left join (
			select "about" from "user_block" where "who" = _who
		) as "blk" on ("crumb"."owner" = "blk"."about")
		where
			"blk"."about" is null and 
			"crumb"."lat" > _user_lat - 1 and
			"crumb"."lat" < _user_lat + 1 and
			"crumb"."lon" > _user_lon - 1 and
			"crumb"."lon" < _user_lon + 1 and
			"crumb"."active";

end;

$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
