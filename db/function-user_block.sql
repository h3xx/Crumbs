-- Function: user_block(integer, character varying)
--
-- Database engine: PostgreSQL 9.2
--
-- Block a user.
--
-- @author: Dan Church <h3xx@gmx.com>
-- @license: GPL v3.0

-- DROP FUNCTION user_block(integer, character varying, text);

CREATE OR REPLACE FUNCTION user_block(_who integer, _block character varying)
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

	begin
		insert
			into "user_block"
			("who", "about")
			values (_who, _block_id);
	exception
		when others then
			return false;
	end;

	return true;

end;

$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
