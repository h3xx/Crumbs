#!/usr/bin/perl -w
#!C:\xampp\perl\bin\perl.exe -w
use strict;

use CGI::Simple;

my $cgi = CGI::Simple->new;

print $cgi->header(
	'-type'		=> 'text/html',
	'-charset'	=> 'utf8',
);

print q%<!DOCTYPE html>
<html>
<head>
<title>Verify Your Email</title>
<link rel="stylesheet" href="css/jquery-ui-1.10.2.css" type="text/css" media="screen" />
<script type="text/javascript" src="js/jq/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="js/jq/jquery-ui-1.10.2.min.js"></script>
<script type="text/javascript" src="js/verify.js"></script>
<link rel="stylesheet" type="text/css" href="css/userform.css" />
</head>
<body>
<h1>Verify Your Email</h1>
<form>%;

printf '<input id="u" type="hidden" name="u" value="%s" />',
	$cgi->escapeHTML($cgi->param('u') || '');
printf '<input id="v" type="hidden" name="v" value="%s" />',
	$cgi->escapeHTML($cgi->param('v') || '');

print q%</form>
<div id="progressbar"></div>
<div id="result"></div>
</body>
</html>%;
