#!/usr/bin/perl -w
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
	);
}

require Crumbs::View::UserForms::Reset;

my $c = Crumbs::View::UserForms::Reset->new(
	'cgi'	=> $cgi,
	'session'	=> $session,
);

print $c->content;
