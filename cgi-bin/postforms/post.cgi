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

print $cgi->header(
	'-type'		=> 'text/html',
	'-charset'	=> 'utf8',
	'-cookie'	=> $session->cookie,
);

require Crumbs::View::CrumbForms::Post;
my $c = Crumbs::View::CrumbForms::Post->new(
	'cgi'	=> $cgi,
	'session'=> $session,
);

print $c->content;
