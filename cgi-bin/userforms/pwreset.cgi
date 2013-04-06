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

my @scripts_always = qw[
	js/jq/jquery-1.9.1.min.js
];

my @scripts_nonmob = qw[
	js/jq/jquery-ui-1.10.2.min.js
	js/pwreset.js
];

my @scripts_mob = qw[
	js/pwreset.mobile.js
	js/jq/jquery.mobile-1.3.0.min.js
];

my @styles_always = qw[
];

my @styles_nonmob = qw[
	css/userform.css
	css/jquery-ui-1.10.2.min.css
];

my @styles_mob = qw[
	css/userform.mobile.css
	css/jquery.mobile-1.3.0.min.css
];

my @scripts = @scripts_always;
push @scripts, (defined $cgi->param('m') ? @scripts_mob : @scripts_nonmob);

my @styles = @styles_always;
push @styles, (defined $cgi->param('m') ? @styles_mob : @styles_nonmob);

print q%<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>Password Reset</title>%;

printf '<link rel="stylesheet" type="text/css" href="%s" />', $_ for @styles;
printf '<script type="text/javascript" src="%s"></script>', $_ for @scripts;

print q%</head>
<body>
<div data-role="header"><h1>Password Reset</h1></div>
<div data-role="content">
<div id="progressbar"></div>
<div id="result"></div>
<div id="okbtn"><a href="/m" data-role="button" data-theme="b">OK</a></div>
<form id="pwresetform" action="/u" method="get">
<input type="hidden" name="a" value="setpw" />%;

printf '<input id="u" type="hidden" name="u" value="%s" />',
	$cgi->escapeHTML($cgi->param('u') || '');
printf '<input id="r" type="hidden" name="r" value="%s" />',
	$cgi->escapeHTML($cgi->param('r') || '');

print q%<input id="newpw" type="password" name="p" placeholder="Enter a new password" />
<input id="newpwv" type="password" name="pv" placeholder="Verify password" />
<input id="pwsub" type="submit" value="Change" data-rel="back" data-theme="b" data-inline="true" />
<input id="cancel" type="button" name="cancel" value="Cancel" data-rel="back" data-theme="c" data-inline="true" />
</form>
</div>
<div id="linkbar" data-role="footer">
<a href="#" onclick="history.back();" id="gobacklink" data-role="button" data-inline="true">Go back</a>
</div>
</body>
</html>%;
