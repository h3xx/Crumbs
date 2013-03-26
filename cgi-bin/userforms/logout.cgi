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

print q%<!DOCTYPE html>
<html>
<head>
<title>Logout</title>
<link rel="stylesheet" href="css/jquery-ui-1.10.2.min.css" type="text/css" media="screen" />
<script type="text/javascript" src="js/jq/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="js/jq/jquery-ui-1.10.2.min.js"></script>
<script type="text/javascript" src="js/logout.js"></script>
<link rel="stylesheet" type="text/css" href="css/userform.css" />
</head>
<body>
<h1>Logout</h1>
<form>
<div id="loggedinas"></div>
<input id="logout" type="submit" name="logout" value="Logout" />
</form>
<div id="gotologin"><a href="loginform" id="loginlink">Log in again</a></div>
<div id="progressbar"></div>
<div id="result"></div>
</body>
</html>%;
