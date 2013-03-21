package Crumbs::Model::Database;
use strict;
use warnings;

our $VERSION = '0.01';

use DBI		qw//;

sub new {
	my $class = shift;

	my $self = bless {
		@_,
	}, $class;

	$self
}

# --- DATA LINK METHODS ---

sub prepare {
	my ($self, $query) = @_;

	$self->dbi->prepare($query)
}

sub dbi {
	my $self = shift;

	return $self->{'dbi'} if defined $self->{'dbi'};

	$self->{'dbi'} = DBI->connect($self->_dsn, $self->cfgvar('user'), $self->cfgvar('password'))
}


sub _dsn {
	my $self = shift;

	# XXX : do I really give a shit?
	#if ($self->{'dsn'}) {
	#	return $self->{'dsn'};
	#}

	#$self->{'dsn'} = $self->cfgvar('dsn') || (
	$self->cfgvar('dsn') || (
		'dbi:' . $self->cfgvar('dsn_driver') . ':' .
		join ';', map {
			my $v = $self->cfgvar("dsn_$_");
			$v ? "$_=$v" : ()
		} qw/ host port dbname /
	)
}

# --- CONFIG METHODS ---

sub cfgvar {
	my ($self, $var) = @_;

	$self->{'cfg'}->{'database'}->{$var}
}

=head1 AUTHOR

Dan Church S<E<lt>h3xx@gmx.comE<gt>>

=head1 COPYRIGHT

Copyright 2013 Dan Church.

This program is free software; you can redistribute it and/or modify it under the same terms as Perl itself.

The full text of the license can be found in the LICENSE file included with this module.

=cut

1;
