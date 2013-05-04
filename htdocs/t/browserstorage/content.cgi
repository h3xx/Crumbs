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

my %table = (
	'123456'	=> 'foo bar',
	'123457'	=> 'baz wotsit',
	'abcdef'	=> 'lorem ipsum',
);

my $r = [
	$table{$cgi->param('id') || ''}
];

print &encode_json($r);
