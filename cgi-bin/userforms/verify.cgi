#!/usr/bin/perl -w
#!C:\xampp\perl\bin\perl.exe -w
use strict;

use lib '..', '../third_party';

require CGI::Simple;
require Crumbs::Session;

my $cgi = CGI::Simple->new;
my $session = Crumbs::Session->new(
	'cgi'	=> $cgi,
	'rcfile'=> '../../global.conf',
);

print $cgi->header(
	'-type'		=> 'text/html',
	'-charset'	=> 'utf8',
	'-cookie'	=> $session->cookie,
);

print q%<!DOCTYPE html>
<html>
<head>
<title>Verify Your Email</title>
<meta name="viewport" content="width=device-width, initial-scale=1" />
<link rel="stylesheet" href="css/jquery-ui-1.10.2.min.css" type="text/css" media="screen" />
<script type="text/javascript" src="js/jq/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="js/jq/jquery-ui-1.10.2.min.js"></script>
<script type="text/javascript" src="js/verify.js"></script>
<link rel="stylesheet" type="text/css" href="css/userform.css" />
</head>
<body>
<h1>Verify Your Email</h1>
<form id="verifyform" action="/u" method="get">
<input type="hidden" name="a" value="verify" />%.

(sprintf '<input id="u" type="hidden" name="u" value="%s" />'.
	'<input id="v" type="hidden" name="v" value="%s" />',
	$cgi->escapeHTML($cgi->param('u') || ''),
	$cgi->escapeHTML($cgi->param('v') || '')
).

q%</form>
<div id="progressbar"></div>
<div id="result"></div>
</body>
</html>%;
