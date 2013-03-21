#!/usr/bin/perl -w
#!C:\xampp\perl\bin\perl.exe -w
use strict;

use CGI;
use Crumbs;
use JSON::PP	qw/ encode_json /;

my $cgi = CGI->new;

my $c = Crumbs->new(
	'cgi'		=> $cgi,
	'rcfile'	=> '../../global.conf',
);

if ($cgi->http or $cgi->https) {
	print $c->header;
}

my $r = $c->controller->user->setpw($cgi->param('u'), $cgi->param('r'), $cgi->param('p'));

print &encode_json($r);
