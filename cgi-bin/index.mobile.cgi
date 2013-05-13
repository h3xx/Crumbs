#!/usr/bin/perl -w
#!C:\xampp\perl\bin\perl.exe -w
use strict;

use lib '.', 'third_party';

use CGI::Carp 'fatalsToBrowser';
require CGI::Simple;
require Crumbs::Session;

my $cgi = CGI::Simple->new;
my $session = Crumbs::Session->new(
	'cgi'	=> $cgi,
	'rcfile'=> '../global.conf',
);

if ($cgi->http or $cgi->https) {
	print $cgi->header(
		'-type'		=> 'text/html',
		'-charset'	=> 'utf8',
		'-cookie'	=> $session->cookie,
	);
}

my @scripts = qw[
	js/jq/jquery.min.js
	js/mobile.js
	js/jq/jquery.mobile.min.js
];

my @styles = qw[
	css/jquery.mobile.min.css
	css/mobile.css
];

print q%<!DOCTYPE html>
<html>
<head>
<title>Crumbs</title>
<meta name="viewport" content="width=device-width, initial-scale=1" />%;

printf '<link rel="stylesheet" type="text/css" href="%s" />', $_ for @styles;
printf '<script type="text/javascript" src="%s"></script>', $_ for @scripts;

print q%</head>
<body>%;

printf '<input type="hidden" id="uid" name="uid" value="%s" />'.
	'<input type="hidden" id="un" name="un" value="%s" />',
	$cgi->escapeHTML($session->param('user_id') || ''),
	$cgi->escapeHTML($session->param('user_name') || '');

print q%<div id="mobsite">
</div>
</body>
</html>%;
