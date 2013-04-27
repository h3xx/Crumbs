#!/usr/bin/perl -w
use strict;

use lib '..', '../third_party';

use CGI::Carp 'fatalsToBrowser';
use CGI::Simple;
use Crumbs::Session;
use JSON::PP	qw/ encode_json /;
use Date::Parse	qw/ strptime /;

my $cgi = CGI::Simple->new;
my $session = Crumbs::Session->new(
	'cgi'	=> $cgi,
	'rcfile'=> '../../global.conf',
);

if ($cgi->http or $cgi->https) {
	print $cgi->header(
		'-type'		=> 'text/html',
		'-charset'	=> 'utf8',
		'-cookie'	=> $session->cookie,
	);
}

my $datestring = $cgi->param('d');

my $r;
if (defined $datestring) {
	$r = [&strptime($datestring)];
} else {
	$r = ['No `d` parameter'];
}

print &encode_json($r);
