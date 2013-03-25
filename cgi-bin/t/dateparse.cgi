#!/usr/bin/perl -w
use strict;

use CGI::Carp 'fatalsToBrowser';
use CGI::Simple;
use CGI::Session;
use JSON::PP	qw/ encode_json /;
use Date::Parse	qw/ strptime /;

my $cgi = CGI::Simple->new;
my $session = CGI::Session->load(undef, $cgi, undef);
$session->new unless defined $session->id;

if ($cgi->http or $cgi->https) {
	print $cgi->header(
		'-type'		=> 'text/html',
		'-charset'	=> 'utf8',
		'-cookie'	=> $session->cookie,
	);
}

my $datestring = $cgi->param('d');

my $r = [&strptime($datestring)];

print &encode_json($r);
