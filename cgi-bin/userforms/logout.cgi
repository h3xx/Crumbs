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
	js/logout.js
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
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>Logout</title>%;

printf '<link rel="stylesheet" type="text/css" href="%s" />', $_ for @styles;
printf '<script type="text/javascript" src="%s"></script>', $_ for @scripts;

print q%</head>
<body>%;

# XXX : HACK! - makes this work as a dialog box
print '<script type="text/javascript" src="js/logout.mobile.js"></script>'
	if defined $cgi->param('m');

print q%<div data-role="header"><h1>Logout</h1></div>
<div data-role="content">
<div id="progressbar"></div>
<div id="result"></div>
<div id="okbtn"><a href="/m" data-role="button" data-theme="b">OK</a></div>
<form id="logoutform" action="/u" method="get">
<input type="hidden" name="a" value="logout" />%;

printf '<div id="loggedinas">%s</div>',
	$cgi->escapeHTML(
		defined $session->param('user_id') ?
			'You are logged in as ' . $session->param('user_name') :
			'You are not logged in.'
	);

print q%<input id="logout" type="submit" value="Logout" data-role="back" data-theme="b" data-inline="true" />
<input id="cancel" type="button" name="cancel" value="Cancel" data-rel="back" data-theme="c" data-inline="true" onclick="history.back();" />
</form>
</div>
<div id="linkbar" data-role="footer">%;

printf '<div id="gotologin"><a href="login%s" id="loginlink" data-role="button" data-inline="true">Log in again</a></div>',
	(defined $cgi->param('m') ? '?m=' : '');

print q%</div>
</body>
</html>%;
