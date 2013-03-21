#!/usr/bin/perl -w
#!C:\xampp\perl\bin\perl.exe -w
use strict;

use CGI;
use CGI::Session;
use JSON::PP	qw/ encode_json /;

my $cgi = CGI->new;
my $session = CGI::Session->load(undef, $cgi, undef);
$session->new unless defined $session->id;

print $cgi->header(
	'-type'		=> 'application/json',
	'-charset'	=> 'utf8',
	'-cookie'	=> $session->cookie,
);

my $uid = $session->param('user_id');
my $un = $session->param('user_name');

my $r =
	(defined $uid) ?
		{'result'=> 1,'name'=>$un,'id'=>$uid} :
		{'result'=> 0,'msg'=>'You are not logged in.'};

print &encode_json($r);
