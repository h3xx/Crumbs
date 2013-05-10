-- Function: crumb_get_contents(integer, character varying)
--
-- Database engine: PostgreSQL 9.2
--
-- Gets the contents of a single crumb.
--
-- @author: Dan Church <h3xx@gmx.com>
-- @license: GPL v3.0

-- DROP FUNCTION crumb_get_contents(integer, character varying)

CREATE OR REPLACE FUNCTION crumb_get_contents(_who integer, _crumb_id character varying)
  RETURNS character varying AS
$BODY$

declare
	_message	character varying;

begin

	select
		into _message
		"message"
		from "crumb"
		where
			"active" and
			"crumb_id" = _crumb_id;

	return _message;

	-- Naaah...
	--perform crumb_mark_read(_who, _crumb_id);

end;

$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
