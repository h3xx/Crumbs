-- Function: user_new_login(character varying, character varying, text)
--
-- Database engine: PostgreSQL 9.2
-- Dependencies: `pgcrypto' extension
--
-- Insert a new hashed login.
--
-- @author: Dan Church <h3xx@gmx.com>
-- @license: GPL v3.0

-- DROP FUNCTION user_new_login(character varying, character varying, text);

CREATE OR REPLACE FUNCTION user_new_login(_name character varying, _email character varying, password_plain text)
  RETURNS character varying AS
$BODY$

declare
	_hash		text;
	_salt		text;
	_verify_string	character varying;

begin
	perform
		"user_id"
		from	"user"
		where
			"user_name" = _name or
			"user_email" = _email;

	if found then
		-- already exists; can't create
		--raise exception 'User already exists.';
		-- return verification string instead
		select
			into _verify_string
			"verify_string"
			from	"user"
			where
				"user_name" = _name and
				not "verified";

		if not found then
			raise exception 'User already exists.';
		end if;

		return _verify_string;
	end if;

	-- blowfish salt = 128 bits = 16 characters
	select into _salt gen_salt('bf');
	select into _hash encode(digest(crypt(password_plain, _salt), 'sha1'), 'hex');

	insert
		into "user"
		into _verify_string
		("user_name", "user_email", "login_hash", "login_salt")
		values(_name, _email, _hash, _salt)
		returning "verify_string";

	return _verify_string;
end;

$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
