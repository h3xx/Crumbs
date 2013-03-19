-- Function: user_verify(integer, character varying)
--
-- Database engine: PostgreSQL 9.2
--
-- Set a user as verified.
--
-- @author: Dan Church <h3xx@gmx.com>
-- @license: GPL v3.0

-- DROP FUNCTION user_verify(integer, character varying);

CREATE OR REPLACE FUNCTION user_verify(_user_id integer, _verify_string character varying)
  RETURNS boolean AS
$BODY$

begin

	update "user"
		set
			"verified" = true,
			"verify_string" = null
		where
			"user_id" = _user_id and
			"verify_string" = _verify_string;

	if not found then
		return false;
	end if;

	return true;
end;

$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
