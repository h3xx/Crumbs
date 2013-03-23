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
		'-expires'	=> '+3d',
	);
}

print q%<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="js/geo.js"></script>
<script type="text/javascript">
$(document).ready(function () {
	if (!window.geo) {
		alert('Fail');
	}
	window.geo.get(
		function (last) {
			for (var i in last) {
				$('#output').append(
					$('<div></div>').text(i + ': ' + window.geo.last[i])
				);
			}
		},
		function (errorStr) {
			alert(errorStr);
		}
	);
});
</script>
</head>
<body>
<div id="output"></div>
</body>
</html>%;
