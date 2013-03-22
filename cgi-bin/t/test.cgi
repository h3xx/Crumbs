#!/usr/bin/perl -w
use strict;

use CGI::Carp 'fatalsToBrowser';
use CGI::Simple;
use CGI::Session;

#use URI::Escape	qw/ uri_escape_utf8 /;
#use HTML::Entities	qw/ encode_entities /;

my $cgi = CGI::Simple->new;
my $session = CGI::Session->load(undef, $cgi, undef);
$session->new unless defined $session->id;

if ($cgi->http or $cgi->https) {
	print $cgi->header(
		'-type'		=> 'text/html',
		'-charset'	=> 'utf8',
		'-cookie'	=> $session->cookie,
	);
}

{use Data::Dumper; print Data::Dumper->Dump([\%ENV]);}
print "Hello world\n";
