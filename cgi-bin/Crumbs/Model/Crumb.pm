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

	return 0 unless defined $uid and defined $lat and defined $lon;

#	my $q = $self->{'db'}->prepare('select user_verify(?,?)');

}

=head1 AUTHOR

Dan Church S<E<lt>h3xx@gmx.comE<gt>>

=head1 COPYRIGHT

Copyright 2013 Dan Church.

This program is free software; you can redistribute it and/or modify it under the same terms as Perl itself.

The full text of the license can be found in the LICENSE file included with this module.

=cut

1;
