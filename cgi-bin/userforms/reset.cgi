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
<title>Password Reset Request Form</title>
<link rel="stylesheet" href="css/jquery-ui-1.10.1.css" type="text/css" media="screen" />
<script type="text/javascript" src="js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="js/jquery-ui-1.10.1.min.js"></script>
<script type="text/javascript" src="js/reset.js"></script>
<link rel="stylesheet" type="text/css" href="css/userform.css" />
</head>
<body>
<h1>Password Reset Request Form</h1>
<form>
<input id="email" type="text" name="email" placeholder="Enter your email address" />
<input id="emsub" type="submit" name="emsub" value="Submit" />
</form>
<div id="progressbar"></div>
<div id="result"></div>
</body>
</html>
EOF
;
