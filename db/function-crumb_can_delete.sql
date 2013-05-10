-- Function: crumb_can_delete(integer, character varying)
--
-- Database engine: PostgreSQL 9.2
--
-- Determine whether a user can delete a crumb.
--
-- @author: Dan Church <h3xx@gmx.com>
-- @license: GPL v3.0

-- DROP FUNCTION crumb_can_delete(integer, character varying)

CREATE OR REPLACE FUNCTION crumb_can_delete(_who integer, _crumb_id character varying)
  RETURNS boolean AS
$BODY$

begin

	perform
		"crumb_id"
		from "crumb"
		where
			"active" and
			"crumb_id" = _crumb_id and
			"crumb"."owner" = _who;

	if not found then
		return false;
	end if;

	return true;
end;

$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
