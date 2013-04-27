#!/usr/bin/perl -w
#!C:\xampp\perl\bin\perl.exe -w
use strict;

use lib '.', 'third_party';

use CGI::Carp 'fatalsToBrowser'; # XXX : turn off when in production
require CGI::Simple;
require Crumbs;
use JSON::PP	qw/ encode_json /;

my $cgi = CGI::Simple->new;

my $c = Crumbs->new(
	'cgi'		=> $cgi,
	'rcfile'	=> '../global.conf',
);

if ($cgi->http or $cgi->https) {
	print $c->header;
}

my ($a, $r) = ($cgi->param('a'));

unless (defined $a) {
	$r = {
		'result'=> 0,
		'msg'	=> 'No action specified.',
	};
} elsif ($a eq 'whoami') {
	my $uid = $c->sessvar('user_id');
	my $un = $c->sessvar('user_name');
	$r =
		(defined $uid) ?
			{'result'=> 1,'name'=>$un,'id'=>$uid} :
			{'result'=> 0,'msg'=>'You are not logged in.'};
} elsif ($a eq 'login') {
	$r = $c->controller->user->login($cgi->param('u'), $cgi->param('p'));
} elsif ($a eq 'reset') {
	$r = $c->controller->user->reset($cgi->param('e'));
} elsif ($a eq 'signup') {
	$r = $c->controller->user->signup($cgi->param('u'), $cgi->param('e'), $cgi->param('p'));
} elsif ($a eq 'logout') {
	$r = $c->controller->user->logout;
} elsif ($a eq 'setpw') {
	$r = $c->controller->user->setpw($cgi->param('u'), $cgi->param('r'), $cgi->param('p'));
} elsif ($a eq 'verify') {
	$r = $c->controller->user->verify($cgi->param('u'), $cgi->param('v'));
} elsif ($a eq 'block') {
	$r = $c->controller->user->verify($cgi->param('b'));
} else {
	$r = {
		'result'=> 0,
		'msg'	=> 'Invalid action.',
	};
}

print &encode_json($r);
