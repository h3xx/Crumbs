#!/usr/bin/perl -w
use strict;

use CGI::Carp 'fatalsToBrowser';
require CGI::Simple;
use JSON::PP	qw/ encode_json /;

my $cgi = CGI::Simple->new;

if ($cgi->http or $cgi->https) {
	print $cgi->header(
		'-type'		=> 'application/json',
		'-charset'	=> 'utf8',
	);
}

my %table = (
	GBIs9yI729HaQKw	=> 'bar',
	edNukBT6xnpEjL0	=> 'hello world',
	ZQKURRk8jHFuXoP	=> 'foo',
);

my $id = $cgi->param('id') || '';
my $msg = $table{$id};

my $r;

unless (defined $msg) {
	$r = {
		'msg'	=> 'No such crumb.',
		'result'=> 0,
	};
} else {
	$r = {
		'msg'	=> $msg,
		'id'	=> $id,
		'result'=> 1,
	};
}

print &encode_json($r);
