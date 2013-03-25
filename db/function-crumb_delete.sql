-- Function: crumb_delete(integer, character varying)
--
-- Database engine: PostgreSQL 9.2
-- Dependencies: `earthdistance' extension
--
-- Determine whether a user can reply to a given crumb.
--
-- @author: Dan Church <h3xx@gmx.com>
-- @license: GPL v3.0

-- DROP FUNCTION crumb_delete(integer, character varying);

CREATE OR REPLACE FUNCTION crumb_delete(_who integer, _crumb_id character varying)
  RETURNS boolean AS
$BODY$

begin

	if not crumb_can_delete(_who, _crumb_id) then
		return false;
	end if;

	update "crumb"
		set
		"active" = false
		where
			"crumb_id" = _crumb_id;

	if not found then
		--raise exception 'Crumb not found.';
		return null;
	end if;

	return true;

end;

$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
