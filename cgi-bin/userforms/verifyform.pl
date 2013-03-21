#!/usr/bin/perl -w
#!C:\xampp\perl\bin\perl.exe -w
use strict;

use CGI;
use HTML::Entities	qw/ encode_entities /;

my $cgi = CGI->new;

print $cgi->header(
	'-type'		=> 'text/html',
	'-charset'	=> 'utf8',
);

print <<EOF
<!DOCTYPE html>
<html>
<head>
<title>Verify Your Email</title>
<link rel="stylesheet" href="css/jquery-ui-1.10.1.css" type="text/css" media="screen" />
<script type="text/javascript" src="js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="js/jquery-ui-1.10.1.min.js"></script>
<script type="text/javascript" src="js/verifyform.js"></script>
<link rel="stylesheet" type="text/css" href="css/userform.css" />
</head>
<body>
<h1>Verify Your Email</h1>
<form>
EOF
;

printf '<input id="u" type="hidden" name="u" value="%s" />',
	&encode_entities($cgi->param('u') || '');
printf '<input id="v" type="hidden" name="v" value="%s" />',
	&encode_entities($cgi->param('v') || '');

print <<EOF
</form>
<div id="progressbar"></div>
<div id="result"></div>
</body>
</html>
EOF
;
