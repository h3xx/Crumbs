-- Function: random_string(integer)
--
-- Makes a random alphanumeric string.
--
-- Source: http://stackoverflow.com/questions/3970795/how-do-you-create-a-random-string-in-postgresql#3972983
--
-- @author: Szymon Guz

-- DROP FUNCTION random_string(integer);

CREATE OR REPLACE FUNCTION random_string(length integer)
  RETURNS text AS
$BODY$

declare
	chars text[] := '{0,1,2,3,4,5,6,7,8,9,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z}';
	result text := '';
	i integer := 0;

begin
	if length < 0 then
		raise exception 'Given length cannot be less than 0';
	end if;

	for i in 1..length loop
		result := result || chars[1+random()*(array_length(chars, 1)-1)];
	end loop;
	return result;
end;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
