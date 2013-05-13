#!/usr/bin/perl -w
use strict;

use CGI::Carp 'fatalsToBrowser';
require CGI::Simple;
use JSON::PP	qw/ encode_json /;

my $cgi = CGI::Simple->new;

if ($cgi->http or $cgi->https) {
	print $cgi->header(
		'-type'		=> 'application/json',
		'-charset'	=> 'utf8',
	);
}

my $r = {
	"list"	=> [
		["edNukBT6xnpEjL0","h3xx","1","1"],
		["GBIs9yI729HaQKw","h3xx","1","1.1"],
		["ZQKURRk8jHFuXoP","h3xx","1","1.2"]
	],

	"result"=> 1,
};

print &encode_json($r);
