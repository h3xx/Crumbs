-- Function: crumb_post(text, text)
--
-- Database engine: PostgreSQL 9.2
--
-- Returns the crumb_id, or null if something went wrong.
--
-- @author: Dan Church <h3xx@gmx.com>
-- @license: GPL v3.0

-- DROP FUNCTION crumb_post(text, text);

CREATE OR REPLACE FUNCTION crumb_post(_locked_read boolean, _posted_time timestamp without time zone, _owner integer, _message character varying, _reply_to character varying, _lat real, _lon real)
  RETURNS character varying AS
$BODY$

declare
	_crumb_id	character varying;
	i		integer := 0;

begin

	-- make sure crumbs have users
	if _owner is null then
		raise exception 'Crumbs must have owners.';
	else
		perform
			"user_id"
			from "user"
			where
				"user_id" = _owner and
				"verified";

		if not found then
			raise exception 'Invalid owner.';
		end if;
	end if;

	-- use now() if time is unspecified
	if _posted_time is null then
		_posted_time := now();
	end if;

	-- if it's a reply, make sure the crumb they can reply to it
	if _reply_to is not null then
		if not crumb_can_reply(_owner, _reply_to, _lat, _lon) then
			--raise exception 'Cannot reply to that crumb.';
			return null;
		end if;
	end if;

	-- try 100 times to insert a crumb
	for i in 1..100 loop
		begin
		insert
			into "crumb"
			into _crumb_id
			("locked_read", "posted_time", "owner", "message", "reply_to", "lat", "lon")
			values(_locked_read, _posted_time, _owner, _message, _reply_to, _lat, _lon)
			returning "crumb_id";
		exception
		when others then
			perform log_collision('Crumb insertion collision: ' || i);
		end;

		if _crumb_id is not null then
			return _crumb_id;
		end if;
	end loop;

	perform log_failure('Failed to insert crumb; 100 consecutive collisions');
	raise exception 'Failed to insert crumb; 100 consecutive collisions';
end;

$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
