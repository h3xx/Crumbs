#!/usr/bin/perl -w
#!C:\xampp\perl\bin\perl.exe -w
use strict;

use lib '.', 'third_party';

use CGI::Carp 'fatalsToBrowser'; # XXX : turn off when in production
require CGI::Simple;
require Crumbs;
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
	$r = $c->view->crumb->get($cgi->param('id'));
} elsif ($a eq 'list') {
	# lat, lon, from_user, limit
	$r = $c->view->crumb->list(map {scalar $cgi->param($_)} qw/ lat lon un l /);
} elsif ($a eq 'put') {
	# lat, lon, from_user, stickpole, limit
	$r = $c->controller->crumb->put(map {scalar $cgi->param($_)} qw/ lat lon /);
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
