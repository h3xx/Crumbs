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
<title>User Sign-Up Form</title>
<link rel="stylesheet" href="css/jquery-ui-1.10.1.css" type="text/css" media="screen" />
<script type="text/javascript" src="js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="js/jquery-ui-1.10.1.min.js"></script>
<script type="text/javascript" src="js/signup.js"></script>
<link rel="stylesheet" type="text/css" href="css/userform.css" />
</head>
<body>
<h1>User Sign-Up Form</h1>
<form>
<div>
<input id="name" type="text" name="name" placeholder="Desired user name" />
</div>
<div>
<input id="email" type="text" name="email" placeholder="Email address" />
</div>
<div>
<input id="pass" type="password" name="pass" placeholder="Password" />
<input id="passv" type="password" name="passv" placeholder="Verify password" />
</div>
<input id="usub" type="submit" name="usub" value="Submit" />
</form>
<div id="progressbar"></div>
<div id="result"></div>
</body>
</html>
EOF
;
