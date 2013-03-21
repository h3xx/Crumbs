-- Function: user_take_reset(character varying, character varying, text)
--
-- Database engine: PostgreSQL 9.2
-- Dependencies: `pgcrypto' extension
--
-- Reset a password.
--
-- Has the side effect of verifying the account.
--
-- @author: Dan Church <h3xx@gmx.com>
-- @license: GPL v3.0

-- DROP FUNCTION user_take_reset(character varying, character varying, text);

CREATE OR REPLACE FUNCTION user_take_reset(_name character varying, _reset_string character varying, password_plain text)
  RETURNS integer AS
$BODY$

declare
	_hash	character varying;
	_salt	character varying;
	_user_id	integer;

begin

	perform
		"user_id"
		from "user"
		where
		"user_name" = _name and
		"reset_string" = _reset_string and
		"reset_expire" > now();

	if not found then
		-- no such user - can't continue
		return null;
	end if;

	-- blowfish salt = 128 bits = 16 characters
	select into _salt gen_salt('bf');
	select into _hash encode(digest(crypt(password_plain, _salt), 'sha1'), 'hex');

	update
		into _user_id
		"user"
		set
			"login_hash" = _hash,
			"login_salt" = _salt,
			"reset_string" = null,
			"reset_expire" = null,
			"verified" = true

		where
			"user_name" = _name

		returning "user_id";

	return _user_id;
end;

$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
