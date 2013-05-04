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

my $r = ['123456','123457','abcdef'];

print &encode_json($r);
