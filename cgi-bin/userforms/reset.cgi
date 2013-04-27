#!/usr/bin/perl -w
#!C:\xampp\perl\bin\perl.exe -w
use strict;

use lib '..', '../third_party';

use CGI::Simple;
use Crumbs::Session;
use Crumbs::View::UserForms::Reset;

my $cgi = CGI::Simple->new;
my $session = Crumbs::Session->new(
	'cgi'	=> $cgi,
	'rcfile'=> '../../global.conf',
);

print $cgi->header(
	'-type'		=> 'text/html',
	'-charset'	=> 'utf8',
	'-cookie'	=> $session->cookie,
);

my $c = Crumbs::View::UserForms::Reset->new(
	'cgi'	=> $cgi,
	'session'=> $session,
);

print $c->content;
