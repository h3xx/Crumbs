-- Function: crumb_mark_read(integer, character varying)
--
-- Database engine: PostgreSQL 9.2
--
-- Mark a crumb as read [by you].
--
-- @author: Dan Church <h3xx@gmx.com>
-- @license: GPL v3.0

-- DROP FUNCTION crumb_mark_read(integer, character varying)

CREATE OR REPLACE FUNCTION crumb_mark_read(_who integer, _crumb_id character varying)
  RETURNS boolean AS
$BODY$

begin

	insert into "read"
		("user_id", "crumb_id")
		values (_who, _crumb_id);

	return true;

exception
when others then
	return false;
end;

$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
