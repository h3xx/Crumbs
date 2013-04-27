#!/usr/bin/perl -w
#!C:\xampp\perl\bin\perl.exe -w
use strict;

use lib '..', '../third_party';

use CGI::Carp 'fatalsToBrowser';
require CGI::Simple;
require Crumbs::Session;

my $cgi = CGI::Simple->new;
my $session = Crumbs::Session->new(
	'cgi'	=> $cgi,
	'rcfile'=> '../../global.conf',
);

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
