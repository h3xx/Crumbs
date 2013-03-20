-- Function: user_set_reset(integer)
--
-- Database engine: PostgreSQL 9.2
-- Dependencies: `pgcrypto' extension
--
-- Put a password reset request into the database.
--
-- Returns the reset string.
--
-- @author: Dan Church <h3xx@gmx.com>
-- @license: GPL v3.0

-- DROP FUNCTION user_set_reset(integer);

CREATE OR REPLACE FUNCTION user_set_reset(_user_id integer)
  RETURNS character varying AS
$BODY$

declare
	rst	character varying;
	expire	interval		:= '7 days';

begin

	update
		into rst
		"user"
		set
			"reset_expire" = now() + expire,
			"reset_string" = encode(gen_random_bytes(64), 'hex'::text)

		where
			"user_id" = _user_id

		returning "reset_string";

	return rst;
end;

$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
