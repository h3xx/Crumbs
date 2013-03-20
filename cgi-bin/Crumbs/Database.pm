package Crumbs::Database;
use strict;
use warnings;

our $VERSION = '0.01';

use Config::General	qw//;

sub new {
	my $class = shift;

	my $self = bless {
		@_,
	}, $class;

	$self->_loadcfg;

	$self
}

sub _loadcfg {
	my $self = shift;
	my $rc = $self->{'rcfile'};

	die 'No configuration file specified.'
		unless $rc;

	#$self->{'cfg'} = Config::General->new($rc)->getall;
	my %cf = Config::General->new($rc)->getall;
	$self->{'cfg'} = \%cf;
}

sub cfgvar {
	my ($self, $var) = @_;

	$self->{'cfg'}->{'database'}->{$var}
}

sub dsn {
	my $self = shift;

	$self->cfgvar('dsn') || (
		'dbi:' . $self->cfgvar('dsn_driver') . ':' .
		join ';', map {
			my $v = $self->cfgvar("dsn_$_");
			$v ? "$_=$v" : ()
		} qw/ host port dbname /
	)
}

1;
