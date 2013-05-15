#!/usr/bin/perl -w
#!C:\xampp\perl\bin\perl.exe -w
use strict;

use lib '..', '../third_party';

use CGI::Carp 'fatalsToBrowser';
require CGI::Simple;
require Crumbs;

my $cgi = CGI::Simple->new;
my $c = Crumbs->new(
	'content-type'	=> 'text/html',
	'cgi'		=> $cgi,
	'rcfile'	=> '../../global.conf',
);

print $c->header;

require Crumbs::View::CrumbForms::Post;
my $f = Crumbs::View::CrumbForms::Post->new(
	'cgi'		=> $cgi,
	'parent'	=> $c,
	'session'	=> $c->session,
);

print $f->content;
