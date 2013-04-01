#!/usr/bin/perl -w
use strict;

use CGI::Carp 'fatalsToBrowser';
use CGI::Simple;
use CGI::Session;
use DBI;

use constant DBFILE	=> '/tmp/cgisess.db';

# open database
(my $dbh = DBI->connect('dbi:SQLite:dbname=' . DBFILE, '', '', {'sqlite_unicode' => 1})
	or die 'connect to database failed')
	->begin_work;

# incredibly inefficient, but who cares, this is just a demo
$dbh->do(q%
	create table if not exists sess (
		id	text	primary key not null,
		data	text
	)
%);

my $cgi = CGI::Simple->new;
my $session = CGI::Session->new('driver:sqlite', $cgi, {
		Handle	=> $dbh,
		TableName => 'sess',
		IdColName => 'id',
		DataColName => 'data',
	});
#$session->new unless defined $session->id;

if ($cgi->http or $cgi->https) {
	print $cgi->header(
		'-type'		=> 'text/html',
		'-charset'	=> 'utf8',
		'-cookie'	=> $session->cookie,
	);
}

if (defined $cgi->param('delete')) {
	$session->delete;
} elsif (defined $cgi->param('k')) {
	$session->param($cgi->param('k'), $cgi->param('v'));
}

print '<pre>';
print "id:",$session->id,"\n";
{use Data::Dumper; print Data::Dumper->Dump([$session]);}

$dbh->commit;
