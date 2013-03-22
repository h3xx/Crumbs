#!/usr/bin/perl -w
#!C:\xampp\perl\bin\perl.exe -w
use strict;

use CGI;
use CGI::Session;
use HTML::Entities	qw/ encode_entities /;

my $cgi = CGI->new;
my $session = CGI::Session->load(undef, $cgi, undef);
$session->new unless defined $session->id;

print $cgi->header(
	'-type'		=> 'text/html',
	'-charset'	=> 'utf8',
	'-cookie'	=> $session->cookie,
);

print <<EOF
<!DOCTYPE html>
<html>
<head>
<title>Login Form</title>
<link rel="stylesheet" href="css/jquery-ui-1.10.1.css" type="text/css" media="screen" />
<script type="text/javascript" src="js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="js/jquery-ui-1.10.1.min.js"></script>
<script type="text/javascript" src="js/login.js"></script>
<link rel="stylesheet" type="text/css" href="css/userform.css" />
</head>
<body>
<h1>Login Form</h1>
<form>
<div id="loggedinas"></div>
EOF
;

printf '<input id="logname" type="text" name="logname" placeholder="Username" value="%s" />',
	&encode_entities($session->param('user_name') || '');

print <<EOF
<input id="pw" type="password" name="pw" placeholder="Password" />
<input id="login" type="submit" name="login" value="Login" />
</form>
<span id="gotoreset"><a href="resetform" id="resetlink">Reset your password</a></span> &middot;
<span id="gotosignup"><a href="signupform" id="signuplink">Sign up</a></span>
<div id="progressbar"></div>
<div id="result"></div>
</body>
</html>
EOF
;
