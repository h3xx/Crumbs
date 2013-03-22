package Crumbs::Controller::Crumb;
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

sub get {
	my ($self, $lat, $lon, $from_user, $stickpole, $limit) = @_;

	require Crumbs::Tools;

	# record last position
	# make sure coords are numeric first
	if (&Crumbs::Tools::is_numeric($lat, $lon)) {
		$self->{'session'}->param('lastpos', [$lat,$lon]);
	}
}

sub put {
	my ($self, $lat, $lon, $stickpole) = @_;

	require Crumbs::Tools;

	# record last position
	if (&Crumbs::Tools::is_numeric($lat, $lon)) {
		$self->{'session'}->param('lastpos', [$lat,$lon]);
	} else {
		return {
			'result'=> 0,
			'msg'	=> 'FIXME : Figure out where you are.',
		};
	}

	return {
		'result'=> 1,
		'msg'	=> 'poop',
	};
}

=head1 AUTHOR

Dan Church S<E<lt>h3xx@gmx.comE<gt>>

=head1 COPYRIGHT

Copyright 2013 Dan Church.

This program is free software; you can redistribute it and/or modify it under the same terms as Perl itself.

The full text of the license can be found in the LICENSE file included with this module.

=cut

1;

