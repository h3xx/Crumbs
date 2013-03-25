-- Function: pole_new
--
-- Database engine: PostgreSQL 9.2
-- Dependencies: `earthdistance' extension
--
-- Returns the pole_id, or null if something went wrong.
--
-- @author: Dan Church <h3xx@gmx.com>
-- @license: GPL v3.0

-- DROP FUNCTION pole_new

CREATE OR REPLACE FUNCTION pole_new(_name character varying, _pos point, _locked_post boolean, _locked_read boolean, _post_distlimit double precision, _read_distlimit double precision, _owner integer, _private_post boolean, _private_read boolean)
  RETURNS character varying AS
$BODY$

declare
	_pole_id	character varying;
	i		integer := 0;

begin

	-- try 100 times to insert a pole
	for i in 1..100 loop
		begin
		insert
			into "pole"
			into _pole_id
			("pole_name",
			"pos",
			"locked_post",
			"locked_read",
			"post_distlimit",
			"read_distlimit",
			"owner",
			"private_post",
			"private_read")
			values(_name, _pos, _locked_post, _locked_read, _post_distlimit, _read_distlimit, _owner, _private_post, _private_read)
			returning "pole_id";

		exception
		when others then
			perform log_collision('Pole insertion collision: ' || i);
		end;
		if _pole_id is not null then
			return _pole_id;
		end if;
	end loop;

	perform log_failure('Failed to insert pole; 100 consecutive collisions');
	raise exception 'Failed to insert pole; 100 consecutive collisions';
end;

$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

CREATE OR REPLACE FUNCTION pole_new(_name character varying, _pos point, _owner integer)
  RETURNS character varying AS
$BODY$

declare
	_pole_id	character varying;
begin
	-- try 100 times to insert a pole
	for i in 1..100 loop
		begin
		insert
			into "pole"
			into _pole_id
			("pole_name",
			"pos",
			"owner")
			values(_name, _pos, _owner)
			returning "pole_id";

		exception
		when others then
			perform log_collision('Pole insertion collision: ' || i);
		end;

		if _pole_id is not null then
			return _pole_id;
		end if;
	end loop;

	perform log_failure('Failed to insert pole; 100 consecutive collisions');
	raise exception 'Failed to insert pole; 100 consecutive collisions';
end;

$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
