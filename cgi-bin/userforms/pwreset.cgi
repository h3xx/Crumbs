#!/usr/bin/perl -w
#!C:\xampp\perl\bin\perl.exe -w
use strict;

use CGI::Simple;

my $cgi = CGI::Simple->new;

print $cgi->header(
	'-type'		=> 'text/html',
	'-charset'	=> 'utf8',
);

print <<EOF
<!DOCTYPE html>
<html>
<head>
<title>Password Reset Form</title>
<link rel="stylesheet" href="css/jquery-ui-1.10.1.css" type="text/css" media="screen" />
<script type="text/javascript" src="js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="js/jquery-ui-1.10.1.min.js"></script>
<script type="text/javascript" src="js/pwreset.js"></script>
<link rel="stylesheet" type="text/css" href="css/userform.css" />
</head>
<body>
<h1>Password Reset Form</h1>
<form>
EOF
;

printf '<input id="u" type="hidden" name="u" value="%s" />',
	$cgi->escapeHTML($cgi->param('u') || '');
printf '<input id="r" type="hidden" name="r" value="%s" />',
	$cgi->escapeHTML($cgi->param('r') || '');

print <<EOF
<input id="newpw" type="password" name="newpw" placeholder="Enter a new password" />
<input id="newpwv" type="password" name="newpw" placeholder="Verify password" />
<input id="pwsub" type="submit" name="pwsub" value="Change" />
</form>
<div id="progressbar"></div>
<div id="result"></div>
</body>
</html>
EOF
;
