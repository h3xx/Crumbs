#!/usr/bin/perl -w
#!C:\xampp\perl\bin\perl.exe -w
use strict;

use CGI;
use Crumbs;

my $cgi = CGI->new;


my $c = Crumbs->new(
	'cgi'		=> $cgi,
	'rcfile'	=> '../global.conf',
);

if ($cgi->http or $cgi->https) {
	print $c->header;
}

#my $cdb = $c->{'db'};

{use Data::Dumper; print STDOUT Data::Dumper->Dump([$c->sessvar('poop')]);}


print "Hello world\n";
