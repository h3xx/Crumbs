#!/usr/bin/perl -w
#!C:\xampp\perl\bin\perl.exe -w
use strict;

use lib '.', 'third_party';

use CGI::Carp 'fatalsToBrowser';
require CGI::Simple;
require Crumbs;

my $cgi = CGI::Simple->new;

my $c = Crumbs->new(
	'cgi'		=> $cgi,
	'rcfile'	=> '../global.conf',
	'content-type'	=> 'text/html',
);

if ($cgi->http or $cgi->https) {
	print $c->header;
}

my @scripts = qw[
	js/jq/jquery.min.js
	js/geo.js
	js/map.js
	js/mobile.js
	js/mapscreen.js
	js/jq/jquery.mobile.min.js
];

my @styles = qw[
	css/jquery.mobile.min.css
	css/mobile.css
];

push @scripts,
	sprintf '//maps.googleapis.com/maps/api/js?v=3&key=%s&sensor=true',
	$c->cfgvar('googlemaps', 'apikey');

print q%<!DOCTYPE html>
<html>
<head>
<title>Crumbs</title>
<meta name="viewport" content="width=device-width, initial-scale=1" />%;

printf '<link rel="stylesheet" type="text/css" href="%s" />',
	$cgi->escapeHTML($_)
	for @styles;
printf '<script type="text/javascript" src="%s"></script>',
	$cgi->escapeHTML($_)
	for @scripts;

print q%</head>
<body>%;

printf '<input type="hidden" id="uid" name="uid" value="%s" />'.
	'<input type="hidden" id="un" name="un" value="%s" />',
	$cgi->escapeHTML($c->sessvar('user_id') || ''),
	$cgi->escapeHTML($c->sessvar('user_name') || '');

print q%<div id="mobsite">
</div>
</body>
</html>%;
