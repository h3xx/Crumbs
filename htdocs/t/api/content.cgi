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
	GBIs9yI729HaQKw	=> {
		"msg"	=> 'bar',
		"lat"	=> "1",
		"user"	=> "h3xx",
		"lon"	=> "1.1",
	},
	edNukBT6xnpEjL0	=> {
		"msg"	=> "hello world",
		"lat"	=> "1",
		"user"	=> "h3xx",
		"lon"	=> "1",
	},
	ZQKURRk8jHFuXoP	=> {
		"msg"	=> 'foo',
		"lat"	=> "1",
		"user"	=> "h3xx",
		"lon"	=> "1.2",
	},
);

my $id = $cgi->param('id') || '';
my $r = $table{$id};

unless (defined $r) {
	$r = {
		'msg'	=> 'No such crumb.',
		'result'=> 0,
	};
} else {
	$r->{'result'} = 1;
	$r->{'id'} = $id;
}

print &encode_json($r);
