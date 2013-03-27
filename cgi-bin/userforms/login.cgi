#!/usr/bin/perl -w
#!C:\xampp\perl\bin\perl.exe -w
use strict;

use lib '..', '../third_party';

use CGI::Simple;
use CGI::Session;

my $cgi = CGI::Simple->new;
my $session = CGI::Session->load(undef, $cgi, undef);
$session->new unless defined $session->id;

print $cgi->header(
	'-type'		=> 'text/html',
	'-charset'	=> 'utf8',
	'-cookie'	=> $session->cookie,
);

my @scripts_always = qw[
	js/jq/jquery-1.9.1.min.js
];

my @scripts_nonmob = qw[
	js/jq/jquery-ui-1.10.2.min.js
	js/login.js
];

my @scripts_mob = qw[
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
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Login</title>%;

printf '<link rel="stylesheet" type="text/css" href="%s" />', $_ for @styles;
printf '<script type="text/javascript" src="%s"></script>', $_ for @scripts;

print q%</head>
<body>%;

# XXX : HACK! - makes this work as a dialog box
print '<script type="text/javascript" src="js/login.mobile.js"></script>'
	if defined $cgi->param('m');

print q%<div data-role="header"><h1>Login</h1></div>
<div data-role="content">
<div id="progressbar"></div>
<div id="result"></div>
<div id="okbtn"><a href="/m" data-role="button" data-theme="b">OK</a></div>
<form id="loginform" action="/u" method="get">
<input type="hidden" name="a" value="login" />%;

printf '<div id="loggedinas">%s</div>',
	$cgi->escapeHTML(
		defined $session->param('user_id') ?
			'You are logged in as ' . $session->param('user_name') :
			'You are not logged in.'
	);

printf '<input id="logname" type="text" name="u" placeholder="Username" value="%s" />',
	$cgi->escapeHTML($cgi->param('u') || $session->param('user_name') || '');

printf '<input id="pw" type="password" name="p" placeholder="Password" value="%s" />',
	$cgi->escapeHTML($cgi->param('p') || '');

print q%<input id="loginsub" type="submit" value="Login" data-rel="back" data-theme="b" data-inline="true" />
<input id="cancel" type="button" name="cancel" value="Cancel" data-rel="back" data-theme="c" data-inline="true" onclick="history.back();" />
</form>
</div>
<div id="linkbar" data-role="footer">%;

printf '<span id="gotoreset"><a href="reset%s" id="resetlink" data-role="button" data-inline="true">Reset your password</a></span> &middot;'.
	'<span id="gotosignup"><a href="signup%s" id="signuplink" data-role="button" data-inline="true">Sign up</a></span>',
	(defined $cgi->param('m') ? '?m=' : '') x 2;

print q%</div>
</body>
</html>%;
