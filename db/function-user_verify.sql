-- Function: user_verify(character varying, character varying)
--
-- Database engine: PostgreSQL 9.2
--
-- Set a user as verified.
--
-- @author: Dan Church <h3xx@gmx.com>
-- @license: GPL v3.0

-- DROP FUNCTION user_verify(character varying, character varying);

CREATE OR REPLACE FUNCTION user_verify(_name character varying, _verify_string character varying)
  RETURNS integer AS
$BODY$

declare
	_user_id	integer;

begin

	update
		into _user_id
		"user"
		set
			"verified" = true,
			"verify_string" = null
		where
			"user_name" = _name and
			"verify_string" = _verify_string

		returning "user_id";

	if not found then
		return null;
	end if;

	return _user_id;
end;

$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
