#!/usr/bin/perl -w
use strict;

use CGI::Carp 'fatalsToBrowser';
use CGI::Simple;
use CGI::Session;

my $cgi = CGI::Simple->new;
my $session = CGI::Session->load(undef, $cgi, undef);
$session->new unless defined $session->id;

if ($cgi->http or $cgi->https) {
	print $cgi->header(
		'-type'		=> 'text/html',
		'-charset'	=> 'utf8',
		'-cookie'	=> $session->cookie,
	);
}

print q%<!DOCTYPE html>
<html>
<head>
<title>Crumbs</title>
<link rel="stylesheet" type="text/css" href="css/jquery.mobile-1.3.0.min.css" />
<link rel="stylesheet" type="text/css" href="css/mobile.css" />
<script type="text/javascript" src="js/jq/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="js/jq/jquery.mobile-1.3.0.min.js"></script>
<script type="text/javascript" src="js/mobile.js"></script>
<script type="text/javascript" src="js/mobile.ui.loginpanel.js"></script>
</head>
<body>%;

printf '<input type="hidden" id="uid" name="uid" value="%s" />',
	$cgi->escapeHTML($session->param('user_id') || '');

printf '<input type="hidden" id="un" name="un" value="%s" />',
	$cgi->escapeHTML($session->param('user_name') || '');

print q%<div id="mobpage"></div>
</body>
</html>%;
