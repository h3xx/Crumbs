#!/usr/bin/perl -w
#!C:\xampp\perl\bin\perl.exe -w
use strict;

use CGI;
use Crumbs::Database;

my $cgi = CGI->new;

if ($cgi->http or $cgi->https) {
	print $cgi->header(
		'-type'		=> 'text/plain',
		'-charset'	=> 'utf8',
	);
}

my $cdb = Crumbs::Database->new(
	'rcfile'	=> '../global.conf',
);


{use Data::Dumper; print STDOUT Data::Dumper->Dump([$cdb->dsn]);}

print "Hello world\n";
