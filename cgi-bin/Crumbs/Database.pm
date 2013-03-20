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

	$self
}


sub dbi {
	my $self = shift;

}

sub cfgvar {
	my ($self, $var) = @_;

	$self->{'cfg'}->{'database'}->{$var}
}

sub dsn {
	my $self = shift;

	# XXX : do I really give a shit?
#	if ($self->{'dsn'}) {
#		return $self->{'dsn'};
#	}

#	$self->{'dsn'} = $self->cfgvar('dsn') || (
	$self->cfgvar('dsn') || (
		'dbi:' . $self->cfgvar('dsn_driver') . ':' .
		join ';', map {
			my $v = $self->cfgvar("dsn_$_");
			$v ? "$_=$v" : ()
		} qw/ host port dbname /
	)
}

1;
