#!/usr/bin/perl -w
#!C:\xampp\perl\bin\perl.exe
use strict;

use CGI;

my $cgi = CGI->new;

if ($cgi->http or $cgi->https) {
	print $cgi->header(
		'-type'		=> 'text/plain',
		'-charset'	=> 'utf8',
	);
}

print $cgi->user_agent, "\n";
