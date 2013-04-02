-- Function: user_unblock(integer, character varying)
--
-- Database engine: PostgreSQL 9.2
--
-- Unblock a user.
--
-- @author: Dan Church <h3xx@gmx.com>
-- @license: GPL v3.0

-- DROP FUNCTION user_unblock(integer, character varying, text);

CREATE OR REPLACE FUNCTION user_unblock(_who integer, _block character varying)
  RETURNS boolean AS
$BODY$

declare
	_block_id	integer;

begin

	select
		into _block_id
		"user_id"
		from	"user"
		where
			"user_name" = _block;

	if not found then
		return false;
	end if;

	delete
		from "user_block"
		where "who" = _who and "about" = _block_id;

	if not found then
		return false;
	end if;

	return true;

end;

$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
