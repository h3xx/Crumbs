-- Function: adduser(character varying, text, character varying)
--
-- Database engine: PostgreSQL 9.2
--
-- Add a user without having to go through the verification steps.
--
-- @author: Dan Church <h3xx@gmx.com>
-- @license: GPL v3.0

-- DROP FUNCTION adduser(character varying, text, character varying);

CREATE OR REPLACE FUNCTION adduser(_name character varying, _pass text, _email character varying)
  RETURNS boolean AS
$BODY$

declare
	_verify_string	character varying;

begin

	_verify_string := user_new_login(_name, _email, _pass);

	perform user_verify(_name, _verify_string);

	return true;
end;

$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
