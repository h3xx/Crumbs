#!C:\xampp\perl\bin\perl.exe -w
#!/usr/bin/perl -w
use strict;

#use CGI::Carp 'fatalsToBrowser';
use CGI::Simple;
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

my $r = $c->controller->user->login($cgi->param('u'), $cgi->param('p'));

print &encode_json($r);
