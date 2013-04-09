#!/usr/bin/perl -w
#!C:\xampp\perl\bin\perl.exe -w
use strict;

use lib '..', '../third_party';

use CGI::Simple;
use CGI::Session;
use Crumbs::View::UserForms::Login;

my $cgi = CGI::Simple->new;
my $session = CGI::Session->new(undef, $cgi, undef);

print $cgi->header(
	'-type'		=> 'text/html',
	'-charset'	=> 'utf8',
	'-cookie'	=> $session->cookie,
);

my $c = Crumbs::View::UserForms::Login->new(
	'cgi'	=> $cgi,
	'session'=> $session,
);

print $c->content;
