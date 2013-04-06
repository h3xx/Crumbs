#!/usr/bin/perl -w
#!C:\xampp\perl\bin\perl.exe -w
use strict;

use lib '..', '../third_party';

use CGI::Carp 'fatalsToBrowser';
use CGI::Simple;
use CGI::Session;

my $cgi = CGI::Simple->new;
my $session = CGI::Session->new(undef, $cgi, undef);

if ($cgi->http or $cgi->https) {
	print $cgi->header(
		'-type'		=> 'text/html',
		'-charset'	=> 'utf8',
		'-cookie'	=> $session->cookie,
		'-expires'	=> '+3d',
	);
}

print q%<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="js/jq/jquery-1.9.1.min.js"></script>
<script type="text/javascript">
$(document).ready(function () {
	var d = new Date();
	$('#output').text(d.toISOString());
});
</script>
</head>
<body>
<div id="output"></div>
</body>
</html>%;
