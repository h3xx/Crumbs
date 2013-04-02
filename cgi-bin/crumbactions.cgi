#!/usr/bin/perl -w
#!C:\xampp\perl\bin\perl.exe -w
use strict;

use lib '.', 'third_party';

use CGI::Carp 'fatalsToBrowser'; # XXX : turn off when in production
use CGI::Simple;
use Crumbs;
use JSON::PP	qw/ encode_json /;

my $cgi = CGI::Simple->new;

my $c = Crumbs->new(
	'cgi'		=> $cgi,
	'rcfile'	=> '../global.conf',
);

if ($cgi->http or $cgi->https) {
	print $c->header;
}

my ($a, $r) = ($cgi->param('a'));

unless (defined $a) {
	$r = {
		'result'=> 0,
		'msg'	=> 'No action specified.',
	};
} elsif ($a eq 'get') {
	# lat, lon, from_user, stickpole, limit
	$r = $c->controller->crumb->get(map {$cgi->param($_)} qw/ lat lon un sp l /);
} elsif ($a eq 'put') {
	# lat, lon, from_user, stickpole, limit
	$r = $c->controller->crumb->put(map {$cgi->param($_)} qw/ lat lon sp /);
} elsif ($a eq 'del') {
	# crumb_id
	$r = $c->controller->crumb->del($cgi->param('cid'));
} elsif ($a eq 'read') {
	# crumb_id
	$r = $c->controller->crumb->read($cgi->param('cid'));
} else {
	$r = {
		'result'=> 0,
		'msg'	=> 'Invalid action.',
	};
}

print &encode_json($r);
