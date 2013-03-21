package Crumbs::Controller;
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

# --- INITIALIZER METHODS ---

sub user {
	my $self = shift;
	use Crumbs::Controller::User;

	$self->{'user'} || (
		$self->{'user'} = Crumbs::Controller::User->new(
			'cgi'	=> $self->{'cgi'},
			'model'	=> $self->{'model'},
			'session'=> $self->{'session'},
		)
	);
}

=head1 AUTHOR

Dan Church S<E<lt>h3xx@gmx.comE<gt>>

=head1 COPYRIGHT

Copyright 2013 Dan Church.

This program is free software; you can redistribute it and/or modify it under the same terms as Perl itself.

The full text of the license can be found in the LICENSE file included with this module.

=cut

1;

