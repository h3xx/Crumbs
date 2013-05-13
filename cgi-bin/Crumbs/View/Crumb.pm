package Crumbs::View::Crumb;
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

# query crumb ids in the area
sub list {
	my ($self, $lat, $lon, $from_user, $limit) = @_;

	# get position
	require Crumbs::Tools;
	my $pos = &Crumbs::Tools::pos($lat, $lon, @{$self}{qw/ parent cgi session /});
	unless (defined $pos) {
		return {
			'result'=> 0,
			'msg'	=> 'Failed to determine your position.',
		};
	}

	my $uid = $self->{'session'}->param('user_id');

	my $listing = $self->{'model'}->crumb->list_crumbs($uid, @$pos, $limit);

	unless (defined $listing) {
		return {
			'result'=> 0,
			'msg'	=> 'No crumbs in area.',
		};
	}

	return {
		'result'=> 1,
		'list'	=> $listing,
	};
}

sub get {
	my ($self, $cid) = @_;

	# XXX : is this really necessary?
	my $uid = $self->{'session'}->param('user_id');
	# (idgaf if you're logged in)

	my $buff = $self->{'model'}->crumb->get_contents($uid, $cid);

	unless (defined $buff) {
		return {
			'result'=> 0,
			'msg'	=> 'No such crumb.',
		};
	}

	$buff->{'result'} = 1;

	return $buff;
}

=head1 AUTHOR

Dan Church S<E<lt>h3xx@gmx.comE<gt>>

=head1 COPYRIGHT

Copyright 2013 Dan Church.

This program is free software; you can redistribute it and/or modify it under the same terms as Perl itself.

The full text of the license can be found in the LICENSE file included with this module.

=cut

1;
