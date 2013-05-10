package Crumbs::Model::Crumb;
use strict;
use warnings;

our $VERSION = '0.01';

sub new {
	my $class = shift;

	my $self = bless {
		@_,
	}, $class;

	$self
}

sub add_crumb {
	my ($self, $uid, $lat, $lon, $time) = @_;

	return undef unless defined $uid and defined $lat and defined $lon;

	# FIXME
#	my $q = $self->{'db'}->prepare('select user_verify(?,?)');

}

sub get_contents {
	my ($self, $uid, $crumb_id) = @_;

	return undef unless defined $crumb_id;

	my $q = $self->{'db'}->prepare('select crumb_get_contents(?,?)');

	return undef unless $q->execute($uid, $crumb_id);

	($q->fetchrow_array)[0]
}

sub list_crumbs {
	my ($self, $uid, $lat, $lon, $limit) = @_;

	# and not a fuck was given that day (defined $uid and)
	return undef unless defined $lat and defined $lon;

	# note: using `select crumb_list' instead of `select * from crumb_list'
	#	will return a list of concatenated tuples ala
	#	"(edNukBT6xnpEjL0,h3xx,1,1)" because crumb_list returns a table
	my $q = $self->{'db'}->prepare('select * from crumb_list(?,?,?,?)');

	return undef unless $q->execute($uid, $lat, $lon, $limit);

	$q->fetchall_arrayref
}

sub delete_crumb {
	my ($self, $uid, $crumb_id) = @_;

	return undef unless defined $uid and defined $crumb_id;

	my $q = $self->{'db'}->prepare('select crumb_delete(?,?)');

	return undef unless $q->execute($uid, $crumb_id);

	($q->fetchrow_array)[0]
}

sub mark_read {
	my ($self, $uid, $crumb_id) = @_;

	return undef unless defined $uid and defined $crumb_id;

	my $q = $self->{'db'}->prepare('select crumb_mark_read(?,?)');

	return undef unless $q->execute($uid, $crumb_id);

	($q->fetchrow_array)[0]
}

=head1 AUTHOR

Dan Church S<E<lt>h3xx@gmx.comE<gt>>

=head1 COPYRIGHT

Copyright 2013 Dan Church.

This program is free software; you can redistribute it and/or modify it under the same terms as Perl itself.

The full text of the license can be found in the LICENSE file included with this module.

=cut

1;
