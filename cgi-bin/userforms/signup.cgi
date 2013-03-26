#!/usr/bin/perl -w
#!C:\xampp\perl\bin\perl.exe -w
use strict;

use lib '..', '../third_party';

use CGI::Simple;

my $cgi = CGI::Simple->new;

print $cgi->header(
	'-type'		=> 'text/html',
	'-charset'	=> 'utf8',
);

my @scripts = qw[
	js/jq/jquery-1.9.1.min.js
	js/jq/jquery-ui-1.10.2.min.js
	js/signup.js
];

my @styles = qw[
	css/jquery-ui-1.10.2.min.css
	css/userform.css
];

print q%<!DOCTYPE html>
<html>
<head>
<title>Sign-Up</title>%;

printf '<link rel="stylesheet" type="text/css" href="%s" />', $_ for @styles;
printf '<script type="text/javascript" src="%s"></script>', $_ for @scripts;

print q%</head>
<body>
<h1>Sign-Up</h1>
<form>
<div>%;

printf '<input id="name" type="text" name="name" placeholder="Desired user name" value="%s" />',
	$cgi->escapeHTML($cgi->param('name') || '');

print q%</div>
<div>%;

printf '<input id="email" type="text" name="email" placeholder="Email address" value="%s" />',
	$cgi->escapeHTML($cgi->param('email') || '');

print q%</div>
<div>%;

printf
	'<input id="pass" type="password" name="pass" placeholder="Password" value="%s" />'.
	'<input id="passv" type="password" name="passv" placeholder="Verify password" value="%s" />',
	$cgi->escapeHTML($cgi->param('pass') || ''),
	$cgi->escapeHTML($cgi->param('passv') || '');

print q%</div>
<input id="usub" type="submit" name="usub" value="Submit" />
</form>
<div id="progressbar"></div>
<div id="result"></div>
</body>
</html>%;
