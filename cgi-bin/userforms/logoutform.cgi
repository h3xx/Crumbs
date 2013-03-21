#!/usr/bin/perl -w
#!C:\xampp\perl\bin\perl.exe -w
use strict;

use CGI;

my $cgi = CGI->new;

print $cgi->header(
	'-type'		=> 'text/html',
	'-charset'	=> 'utf8',
);

print <<EOF
<!DOCTYPE html>
<html>
<head>
<title>Logout</title>
<link rel="stylesheet" href="css/jquery-ui-1.10.1.css" type="text/css" media="screen" />
<script type="text/javascript" src="js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="js/jquery-ui-1.10.1.min.js"></script>
<script type="text/javascript" src="js/logoutform.js"></script>
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
</html>
EOF
;
